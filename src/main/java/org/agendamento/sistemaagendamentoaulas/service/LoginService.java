package org.agendamento.sistemaagendamentoaulas.service;

import org.agendamento.sistemaagendamentoaulas.dao.UsuarioDAO;
import org.agendamento.sistemaagendamentoaulas.model.Usuario;

public class LoginService {

    public Usuario autenticar(String email, String senha) {
        if (email == null || email.trim().isEmpty()) {
            throw new IllegalArgumentException("E-mail Ã© obrigatÃ³rio");
        }
        if (senha == null || senha.trim().isEmpty()) {
            throw new IllegalArgumentException("Senha Ã© obrigatÃ³ria");
        }

        return new UsuarioDAO().autenticar(email, senha);
    }
}
