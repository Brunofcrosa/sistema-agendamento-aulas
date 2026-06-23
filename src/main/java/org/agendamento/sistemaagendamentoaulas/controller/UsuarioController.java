package org.agendamento.sistemaagendamentoaulas.controller;

import org.agendamento.sistemaagendamentoaulas.model.Usuario;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.agendamento.sistemaagendamentoaulas.service.UsuarioService;

@Controller
@RequestMapping("/usuario")
public class UsuarioController {

    private final UsuarioService service;
    public UsuarioController(UsuarioService service) {
        this.service = service;
    }

    @PostMapping
    public String cadastrar(@RequestParam String nome,
                            @RequestParam String email,
                            @RequestParam String senha,
                            Model model,
                            RedirectAttributes redirectAttrs) {
        Usuario usuario = new Usuario(nome, email, senha, true);

        try {
            boolean sucesso = service.inserir(usuario);

            if (sucesso) {
                redirectAttrs.addFlashAttribute("msg", "cadastrado");
                return "redirect:/login";
            }

            model.addAttribute("erro", "Erro ao cadastrar usuario");
            return "cadastro";
        } catch (IllegalArgumentException e) {
            model.addAttribute("erro", e.getMessage());
            return "cadastro";
        }
    }
}
