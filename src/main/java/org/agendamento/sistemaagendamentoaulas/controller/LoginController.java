package org.agendamento.sistemaagendamentoaulas.controller;

import jakarta.servlet.http.HttpSession;
import org.agendamento.sistemaagendamentoaulas.model.Usuario;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.agendamento.sistemaagendamentoaulas.service.LoginService;

@Controller
@RequestMapping("/login")
public class LoginController {

    private final LoginService service = new LoginService();

    @PostMapping
    public String autenticar(@RequestParam String email,
                             @RequestParam String senha,
                             HttpSession session,
                             Model model) {
        try {
            Usuario usuario = service.autenticar(email, senha);

            if (usuario != null) {
                session.setAttribute("usuario", usuario);
                return "redirect:/home";
            }

            model.addAttribute("erro", "Usuario ou senha invalidos");
            return "forward:/index.jsp";
        } catch (IllegalArgumentException e) {
            model.addAttribute("erro", e.getMessage());
            return "forward:/index.jsp";
        }
    }
}
