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

    private final DocenteService docenteService;
    private final SalaService salaService;
    private final ReservaService reservaService;

    public HomeController(DocenteService docenteService,
                          SalaService salaService,
                          ReservaService reservaService) {
        this.docenteService = docenteService;
        this.salaService = salaService;
        this.reservaService = reservaService;
    }

    @GetMapping
    public String home(HttpSession session, Model model) {
        if (session.getAttribute("usuario") == null) {
            return "redirect:/login";
        }

        model.addAttribute("totalDocentes", docenteService.listar().size());
        model.addAttribute("totalSalas", salaService.listar().size());
        model.addAttribute("totalReservas", reservaService.listar().size());

        return "home";
    }
}