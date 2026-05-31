package service;

import dao.UsuarioDAO;
import model.Usuario;

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
