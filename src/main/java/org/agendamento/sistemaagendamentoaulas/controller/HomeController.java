package org.agendamento.sistemaagendamentoaulas.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.agendamento.sistemaagendamentoaulas.service.DocenteService;
import org.agendamento.sistemaagendamentoaulas.service.ReservaService;
import org.agendamento.sistemaagendamentoaulas.service.SalaService;

@Controller
@RequestMapping("/home")
public class HomeController {

    private final DocenteService docenteService = new DocenteService();
    private final SalaService salaService = new SalaService();
    private final ReservaService reservaService = new ReservaService();

    @GetMapping
    public String home(HttpSession session, Model model) {
        if (session.getAttribute("usuario") == null) {
            return "redirect:/index.jsp";
        }

        model.addAttribute("totalDocentes", docenteService.listar().size());
        model.addAttribute("totalSalas", salaService.listar().size());
        model.addAttribute("totalReservas", reservaService.listar().size());

        return "home";
    }
}
