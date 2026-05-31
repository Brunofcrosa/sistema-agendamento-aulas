package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Reserva;
import service.DocenteService;
import service.ReservaService;
import service.SalaService;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

@WebServlet("/reserva")
public class ReservaServlet extends HttpServlet {

    private ReservaService service = new ReservaService();
    private SalaService salaService = new SalaService();
    private DocenteService docenteService = new DocenteService();

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
                Reserva reserva = service.buscarPorId(id);
                req.setAttribute("reserva", reserva);
                tela = "novo";
            }

            if ("novo".equals(tela) && req.getAttribute("reserva") == null) {
                Reserva reserva = montarReservaPreenchida(req);
                req.setAttribute("reserva", reserva);
            }

            if ("cancelar".equals(acao)) {
                int id = Integer.parseInt(req.getParameter("id"));
                service.cancelar(id);
                resp.sendRedirect("reserva?tela=listar&msg=cancelada");
                return;
            }
        } catch (IllegalArgumentException e) {
            req.setAttribute("erro", e.getMessage());
        }

        if (tela == null || tela.isEmpty()) {
            tela = "listar";
        }

        carregarCombos(req);
        List<Reserva> lista = service.listar();
        req.setAttribute("reservas", lista);
        req.setAttribute("tela", tela);

        RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/pages/reservas.jsp");
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
        try {
            int salaId = Integer.parseInt(req.getParameter("salaId"));
            int docenteId = Integer.parseInt(req.getParameter("docenteId"));
            Date dataReserva = Date.valueOf(req.getParameter("dataReserva"));
            Time horaInicio = converterHorario(req.getParameter("horaInicio"));
            Time horaFim = converterHorario(req.getParameter("horaFim"));
            String finalidade = req.getParameter("finalidade");
            String status = "ATIVA";
            Reserva reserva = new Reserva(salaId, docenteId, dataReserva, horaInicio, horaFim, finalidade, status);

            if (idParam != null && !idParam.isEmpty() && !"0".equals(idParam)) {
                reserva.setId(Integer.parseInt(idParam));
                service.atualizar(reserva);
                resp.sendRedirect("reserva?tela=listar&msg=editada");
            } else {
                service.inserir(reserva);
                resp.sendRedirect("reserva?tela=listar&msg=salva");
            }
        } catch (IllegalArgumentException e) {
            req.setAttribute("erro", e.getMessage());
            req.setAttribute("reservas", service.listar());
            req.setAttribute("tela", "novo");
            carregarCombos(req);
            req.getRequestDispatcher("WEB-INF/pages/reservas.jsp").forward(req, resp);
        }
    }

    private void carregarCombos(HttpServletRequest req) {
        req.setAttribute("salas", salaService.listarAtivas());
        req.setAttribute("docentes", docenteService.listarAtivos());
    }

    private Time converterHorario(String horario) {
        if (horario == null || horario.trim().isEmpty()) {
            throw new IllegalArgumentException("Horário é obrigatório");
        }
        if (horario.length() == 5) {
            return Time.valueOf(horario + ":00");
        }
        return Time.valueOf(horario);
    }

    private Reserva montarReservaPreenchida(HttpServletRequest req) {
        Reserva reserva = new Reserva();
        String salaIdParam = req.getParameter("salaId");
        String horaInicioParam = req.getParameter("horaInicio");
        String horaFimParam = req.getParameter("horaFim");

        if (salaIdParam != null && !salaIdParam.isEmpty()) {
            reserva.setSalaId(Integer.parseInt(salaIdParam));
        }
        if (horaInicioParam != null && !horaInicioParam.isEmpty()) {
            reserva.setHoraInicio(converterHorario(horaInicioParam));
        }
        if (horaFimParam != null && !horaFimParam.isEmpty()) {
            reserva.setHoraFim(converterHorario(horaFimParam));
        }

        return reserva;
    }
}
