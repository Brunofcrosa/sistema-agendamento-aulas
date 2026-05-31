package service;

import dao.UsuarioDAO;
import model.Usuario;

public class UsuarioService {

    public boolean inserir(Usuario usuario) {
        if (usuario.getNome() == null || usuario.getNome().trim().isEmpty()) {
            throw new IllegalArgumentException("Nome é obrigatório");
        }
        if (usuario.getEmail() == null || usuario.getEmail().trim().isEmpty()) {
            throw new IllegalArgumentException("E-mail é obrigatório");
        }
        if (usuario.getSenha() == null || usuario.getSenha().trim().isEmpty()) {
            throw new IllegalArgumentException("Senha é obrigatória");
        }

        return new UsuarioDAO().inserir(usuario);
    }
}
