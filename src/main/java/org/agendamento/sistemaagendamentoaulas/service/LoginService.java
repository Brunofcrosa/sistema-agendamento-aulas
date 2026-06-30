package org.agendamento.sistemaagendamentoaulas.service;

import org.agendamento.sistemaagendamentoaulas.dao.UsuarioDAO;
import org.agendamento.sistemaagendamentoaulas.model.Usuario;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

    public Usuario autenticar(String email, String senha) {
        if (email == null || email.trim().isEmpty()) {
            throw new IllegalArgumentException("E-mail é obrigatório");
        }
        if (senha == null || senha.trim().isEmpty()) {
            throw new IllegalArgumentException("Senha é obrigatória");
        }

        return new UsuarioDAO().autenticar(email, senha);
    }
}
