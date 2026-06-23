package org.agendamento.sistemaagendamentoaulas.controller;

import jakarta.servlet.http.HttpSession;
import org.agendamento.sistemaagendamentoaulas.model.Reserva;
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
import java.util.List;

@Controller
@RequestMapping("/reserva")
public class ReservaController {

    private final ReservaService service = new ReservaService();
    private final SalaService salaService = new SalaService();
    private final DocenteService docenteService = new DocenteService();

    @GetMapping
    public String listar(@RequestParam(required = false) String acao,
                         @RequestParam(required = false) String tela,
                         @RequestParam(required = false) Integer id,
                         @RequestParam(required = false) Integer salaId,
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
                Reserva reserva = service.buscarPorId(id);
                model.addAttribute("reserva", reserva);
                tela = "novo";
            }

            if ("novo".equals(tela) && !model.containsAttribute("reserva")) {
                Reserva reserva = montarReservaPreenchida(salaId, horaInicio, horaFim);
                model.addAttribute("reserva", reserva);
            }

            if ("cancelar".equals(acao) && id != null) {
                service.cancelar(id);
                redirectAttrs.addFlashAttribute("msg", "cancelada");
                return "redirect:/reserva?tela=listar";
            }
        } catch (IllegalArgumentException e) {
            model.addAttribute("erro", e.getMessage());
        }

        if (tela == null || tela.isEmpty()) {
            tela = "listar";
        }

        carregarCombos(model);
        List<Reserva> lista = service.listar();
        model.addAttribute("reservas", lista);
        model.addAttribute("tela", tela);
        return "reservas";
    }

    @PostMapping
    public String salvar(@RequestParam(required = false) String id,
                         @RequestParam int salaId,
                         @RequestParam int docenteId,
                         @RequestParam String dataReserva,
                         @RequestParam String horaInicio,
                         @RequestParam String horaFim,
                         @RequestParam String finalidade,
                         HttpSession session,
                         Model model,
                         RedirectAttributes redirectAttrs) {
        if (session.getAttribute("usuario") == null) {
            return "redirect:/index.jsp";
        }

        try {
            Reserva reserva = new Reserva(
                    salaId,
                    docenteId,
                    Date.valueOf(dataReserva),
                    converterHorario(horaInicio),
                    converterHorario(horaFim),
                    finalidade,
                    "ATIVA"
            );

            if (id != null && !id.isEmpty() && !"0".equals(id)) {
                reserva.setId(Integer.parseInt(id));
                service.atualizar(reserva);
                redirectAttrs.addFlashAttribute("msg", "editada");
                return "redirect:/reserva?tela=listar";
            }

            service.inserir(reserva);
            redirectAttrs.addFlashAttribute("msg", "salva");
            return "redirect:/reserva?tela=listar";
        } catch (IllegalArgumentException e) {
            model.addAttribute("erro", e.getMessage());
            model.addAttribute("reservas", service.listar());
            model.addAttribute("tela", "novo");
            carregarCombos(model);
            return "reservas";
        }
    }

    private void carregarCombos(Model model) {
        model.addAttribute("salas", salaService.listarAtivas());
        model.addAttribute("docentes", docenteService.listarAtivos());
    }

    private Time converterHorario(String horario) {
        if (horario == null || horario.trim().isEmpty()) {
            throw new IllegalArgumentException("Horario e obrigatorio");
        }
        if (horario.length() == 5) {
            return Time.valueOf(horario + ":00");
        }
        return Time.valueOf(horario);
    }

    private Reserva montarReservaPreenchida(Integer salaId, String horaInicio, String horaFim) {
        Reserva reserva = new Reserva();

        if (salaId != null) {
            reserva.setSalaId(salaId);
        }
        if (horaInicio != null && !horaInicio.isEmpty()) {
            reserva.setHoraInicio(converterHorario(horaInicio));
        }
        if (horaFim != null && !horaFim.isEmpty()) {
            reserva.setHoraFim(converterHorario(horaFim));
        }

        return reserva;
    }
}
