package org.agendamento.sistemaagendamentoaulas.service;

import org.agendamento.sistemaagendamentoaulas.dao.UsuarioDAO;
import org.agendamento.sistemaagendamentoaulas.model.Usuario;
import org.springframework.stereotype.Service;

@Service
public class UsuarioService {

    public boolean inserir(Usuario usuario) {
        if (usuario.getNome() == null || usuario.getNome().trim().isEmpty()) {
            throw new IllegalArgumentException("Nome Ã© obrigatÃ³rio");
        }
        if (usuario.getEmail() == null || usuario.getEmail().trim().isEmpty()) {
            throw new IllegalArgumentException("E-mail Ã© obrigatÃ³rio");
        }
        if (usuario.getSenha() == null || usuario.getSenha().trim().isEmpty()) {
            throw new IllegalArgumentException("Senha Ã© obrigatÃ³ria");
        }

        return new UsuarioDAO().inserir(usuario);
    }
}
