package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Sala;
import model.Docente;
import model.Reserva;
import service.SalaService;
import service.DocenteService;
import service.ReservaService;
import dao.ReservaDAO;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

@WebServlet("/sala")
public class SalaServlet extends HttpServlet {

    private SalaService service = new SalaService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect("index.jsp");
            return;
        }

        String acao = req.getParameter("acao");
        String tela = req.getParameter("tela");
        try {
            if ("editar".equals(acao)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Sala sala = service.buscarPorId(id);
                req.setAttribute("sala", sala);
                tela = "novo";
            }

            if ("excluir".equals(acao)) {
                int id = Integer.parseInt(req.getParameter("id"));
                service.excluir(id);
                resp.sendRedirect("sala?tela=listar&msg=excluido");
                return;
            }

            if ("reservarRapido".equals(acao)) {
                int salaId = Integer.parseInt(req.getParameter("salaId"));
                String diaSemana = req.getParameter("diaSemana");
                String horaInicioParam = req.getParameter("horaInicio");
                String horaFimParam = req.getParameter("horaFim");

                Date dataReserva = calcularProximaData(diaSemana);
                Time horaInicio = converterHorario(horaInicioParam);
                Time horaFim = converterHorario(horaFimParam);

                List<Docente> docentes = new DocenteService().listarAtivos();
                if (docentes.isEmpty()) {
                    throw new IllegalArgumentException("Nenhum docente ativo cadastrado. Cadastre um docente antes de fazer reservas.");
                }
                int docenteId = docentes.get(0).getId();

                Reserva reserva = new Reserva(salaId, docenteId, dataReserva, horaInicio, horaFim, "Agendamento Rápido", "ATIVA");
                new ReservaService().inserir(reserva);

                resp.sendRedirect("reserva?msg=sucesso");
                return;
            }
        } catch (IllegalArgumentException e) {
            req.setAttribute("erro", e.getMessage());
        }

        if (tela == null || tela.isEmpty()) {
            tela = "listar";
        }

        List<Sala> lista = service.listar();

        if ("encontrar".equals(tela)) {
            String diaSemana = req.getParameter("diaSemana");
            String horaInicioParam = req.getParameter("horaInicio");
            String horaFimParam = req.getParameter("horaFim");

            if (diaSemana != null && !diaSemana.isEmpty() &&
                horaInicioParam != null && !horaInicioParam.isEmpty() &&
                horaFimParam != null && !horaFimParam.isEmpty()) {

                try {
                    Date dataReserva = calcularProximaData(diaSemana);
                    Time horaInicio = converterHorario(horaInicioParam);
                    Time horaFim = converterHorario(horaFimParam);

                    if (dataReserva != null && horaInicio != null && horaFim != null) {
                        ReservaDAO reservaDAO = new ReservaDAO();
                        List<Sala> filtrada = new ArrayList<>();
                        for (Sala sala : lista) {
                            if (reservaDAO.isSalaDisponivel(sala.getId(), dataReserva, horaInicio, horaFim, 0)) {
                                filtrada.add(sala);
                            }
                        }
                        lista = filtrada;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        req.setAttribute("salas", lista);
        req.setAttribute("tela", tela);

        RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/pages/salas.jsp");
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect("index.jsp");
            return;
        }

        String idParam = req.getParameter("id");
        String nome = req.getParameter("nome");
        String bloco = req.getParameter("bloco");
        try {
            String recursos = req.getParameter("recursos");
            int capacidade = Integer.parseInt(req.getParameter("capacidade"));
            boolean ativa = "on".equals(req.getParameter("ativa"));
            Sala sala = new Sala(nome, bloco, capacidade, recursos, ativa);

            if (idParam != null && !idParam.isEmpty() && !"0".equals(idParam)) {
                sala.setId(Integer.parseInt(idParam));
                service.atualizar(sala);
                resp.sendRedirect("sala?tela=listar&msg=editado");
            } else {
                service.inserir(sala);
                resp.sendRedirect("sala?tela=listar&msg=salvo");
            }
        } catch (IllegalArgumentException e) {
            req.setAttribute("erro", e.getMessage());
            req.setAttribute("salas", service.listar());
            req.setAttribute("tela", "novo");
            req.getRequestDispatcher("WEB-INF/pages/salas.jsp").forward(req, resp);
        }
    }

    private Date calcularProximaData(String diaSemana) {
        if (diaSemana == null) return new Date(System.currentTimeMillis());

        Calendar cal = Calendar.getInstance();
        int targetDay = Calendar.MONDAY;

        String diaNorm = diaSemana.trim().toUpperCase()
                .replace("Á", "A").replace("É", "E").replace("Í", "I")
                .replace("Ó", "O").replace("Ú", "U").replace("Ç", "C");

        if (diaNorm.contains("SEGUNDA")) targetDay = Calendar.MONDAY;
        else if (diaNorm.contains("TERCA")) targetDay = Calendar.TUESDAY;
        else if (diaNorm.contains("QUARTA")) targetDay = Calendar.WEDNESDAY;
        else if (diaNorm.contains("QUINTA")) targetDay = Calendar.THURSDAY;
        else if (diaNorm.contains("SEXTA")) targetDay = Calendar.FRIDAY;

        int currentDay = cal.get(Calendar.DAY_OF_WEEK);
        int daysToAdd = (targetDay - currentDay + 7) % 7;
        
        cal.add(Calendar.DAY_OF_YEAR, daysToAdd);
        return new Date(cal.getTimeInMillis());
    }

    private Time converterHorario(String horario) {
        if (horario == null || horario.trim().isEmpty()) {
            return null;
        }
        if (horario.length() == 5) {
            return Time.valueOf(horario + ":00");
        }
        return Time.valueOf(horario);
    }
}
