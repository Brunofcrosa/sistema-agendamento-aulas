package org.agendamento.sistemaagendamentoaulas.controller;

import jakarta.servlet.http.HttpSession;
import org.agendamento.sistemaagendamentoaulas.model.Docente;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.agendamento.sistemaagendamentoaulas.service.DocenteService;

import java.util.List;

@Controller
@RequestMapping("/docente")
public class DocenteController {

    private final DocenteService service;

    public DocenteController(DocenteService service) {
        this.service = service;
    }

    @GetMapping
    public String listar(@RequestParam(required = false) String acao,
                         @RequestParam(required = false) String tela,
                         @RequestParam(required = false) Integer id,
                         HttpSession session,
                         Model model,
                         RedirectAttributes redirectAttrs) {

        if (session.getAttribute("usuario") == null) {
            return "redirect:/login";
        }

        try {
            if ("editar".equals(acao) && id != null) {
                Docente docente = service.buscarPorId(id);
                model.addAttribute("docente", docente);
                tela = "novo";
            }

            if ("excluir".equals(acao) && id != null) {
                service.excluir(id);
                redirectAttrs.addFlashAttribute("msg", "excluido");
                return "redirect:/docente?tela=listar";
            }
        } catch (IllegalArgumentException e) {
            model.addAttribute("erro", e.getMessage());
        }

        if (tela == null || tela.isEmpty()) {
            tela = "listar";
        }

        List<Docente> lista = service.listar();
        model.addAttribute("docentes", lista);
        model.addAttribute("tela", tela);
        return "docentes";
    }

    @PostMapping
    public String salvar(@RequestParam(required = false) String id,
                         @RequestParam String matricula,
                         @RequestParam String nome,
                         HttpSession session,
                         Model model,
                         RedirectAttributes redirectAttrs) {

        if (session.getAttribute("usuario") == null) {
            return "redirect:/login";
        }

        Docente docente = new Docente(matricula, nome);

        try {
            if (id != null && !id.isEmpty() && !"0".equals(id)) {
                docente.setId(Integer.parseInt(id));
                service.atualizar(docente);
                redirectAttrs.addFlashAttribute("msg", "editado");
                return "redirect:/docente?tela=listar";
            }

            service.inserir(docente);
            redirectAttrs.addFlashAttribute("msg", "salvo");
            return "redirect:/docente?tela=listar";
        } catch (IllegalArgumentException e) {
            model.addAttribute("erro", e.getMessage());
            model.addAttribute("docente", docente);
            model.addAttribute("docentes", service.listar());
            model.addAttribute("tela", "novo");
            return "docentes";
        }
    }
}