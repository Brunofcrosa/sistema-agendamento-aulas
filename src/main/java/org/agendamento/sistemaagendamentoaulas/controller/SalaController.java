package org.agendamento.sistemaagendamentoaulas.controller;

import org.agendamento.sistemaagendamentoaulas.dao.ReservaDAO;
import jakarta.servlet.http.HttpSession;
import org.agendamento.sistemaagendamentoaulas.model.Docente;
import org.agendamento.sistemaagendamentoaulas.model.Reserva;
import org.agendamento.sistemaagendamentoaulas.model.Sala;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.agendamento.sistemaagendamentoaulas.service.DocenteService;
import org.agendamento.sistemaagendamentoaulas.service.ReservaService;
import org.agendamento.sistemaagendamentoaulas.service.SalaService;

import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

@Controller
@RequestMapping("/sala")
public class SalaController {

    private final SalaService service = new SalaService();

    @GetMapping
    public String listar(@RequestParam(required = false) String acao,
                         @RequestParam(required = false) String tela,
                         @RequestParam(required = false) Integer id,
                         @RequestParam(required = false) Integer salaId,
                         @RequestParam(required = false) String diaSemana,
                         @RequestParam(required = false) String horaInicio,
                         @RequestParam(required = false) String horaFim,
                         HttpSession session,
                         Model model,
                         RedirectAttributes redirectAttrs) {
        if (session.getAttribute("usuario") == null) {
            return "redirect:/index.jsp";
        }

        try {
            if ("editar".equals(acao) && id != null) {
                Sala sala = service.buscarPorId(id);
                model.addAttribute("sala", sala);
                tela = "novo";
            }

            if ("excluir".equals(acao) && id != null) {
                service.excluir(id);
                redirectAttrs.addFlashAttribute("msg", "excluido");
                return "redirect:/sala?tela=listar";
            }

            if ("reservarRapido".equals(acao) && salaId != null) {
                Date dataReserva = calcularProximaData(diaSemana);
                Time inicio = converterHorario(horaInicio);
                Time fim = converterHorario(horaFim);

                List<Docente> docentes = new DocenteService().listarAtivos();
                if (docentes.isEmpty()) {
                    throw new IllegalArgumentException("Nenhum docente ativo cadastrado. Cadastre um docente antes de fazer reservas.");
                }

                Reserva reserva = new Reserva(salaId, docentes.get(0).getId(), dataReserva, inicio, fim, "Agendamento Rapido", "ATIVA");
                new ReservaService().inserir(reserva);
                redirectAttrs.addFlashAttribute("msg", "sucesso");
                return "redirect:/reserva";
            }
        } catch (IllegalArgumentException e) {
            model.addAttribute("erro", e.getMessage());
        }

        if (tela == null || tela.isEmpty()) {
            tela = "listar";
        }

        List<Sala> lista = service.listar();

        if ("encontrar".equals(tela)) {
            lista = filtrarDisponiveis(lista, diaSemana, horaInicio, horaFim);
        }

        model.addAttribute("salas", lista);
        model.addAttribute("tela", tela);
        return "salas";
    }

    @PostMapping
    public String salvar(@RequestParam(required = false) String id,
                         @RequestParam String nome,
                         @RequestParam String bloco,
                         @RequestParam(required = false) String recursos,
                         @RequestParam int capacidade,
                         @RequestParam(required = false) String ativa,
                         HttpSession session,
                         Model model,
                         RedirectAttributes redirectAttrs) {
        if (session.getAttribute("usuario") == null) {
            return "redirect:/index.jsp";
        }

        try {
            Sala sala = new Sala(nome, bloco, capacidade, recursos, "on".equals(ativa));

            if (id != null && !id.isEmpty() && !"0".equals(id)) {
                sala.setId(Integer.parseInt(id));
                service.atualizar(sala);
                redirectAttrs.addFlashAttribute("msg", "editado");
                return "redirect:/sala?tela=listar";
            }

            service.inserir(sala);
            redirectAttrs.addFlashAttribute("msg", "salvo");
            return "redirect:/sala?tela=listar";
        } catch (IllegalArgumentException e) {
            model.addAttribute("erro", e.getMessage());
            model.addAttribute("salas", service.listar());
            model.addAttribute("tela", "novo");
            return "salas";
        }
    }

    private List<Sala> filtrarDisponiveis(List<Sala> salas, String diaSemana, String horaInicio, String horaFim) {
        if (diaSemana == null || diaSemana.isEmpty() || horaInicio == null || horaInicio.isEmpty() || horaFim == null || horaFim.isEmpty()) {
            return salas;
        }

        Date dataReserva = calcularProximaData(diaSemana);
        Time inicio = converterHorario(horaInicio);
        Time fim = converterHorario(horaFim);
        ReservaDAO reservaDAO = new ReservaDAO();
        List<Sala> filtrada = new ArrayList<>();

        for (Sala sala : salas) {
            if (reservaDAO.isSalaDisponivel(sala.getId(), dataReserva, inicio, fim, 0)) {
                filtrada.add(sala);
            }
        }

        return filtrada;
    }

    private Date calcularProximaData(String diaSemana) {
        if (diaSemana == null) {
            return new Date(System.currentTimeMillis());
        }

        Calendar cal = Calendar.getInstance();
        int targetDay = Calendar.MONDAY;

        String diaNorm = diaSemana.trim().toUpperCase()
                .replace("Ã", "A").replace("Ã‰", "E").replace("Ã", "I")
                .replace("Ã“", "O").replace("Ãš", "U").replace("Ã‡", "C");

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
