package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Usuario;
import service.UsuarioService;

import java.io.IOException;

@WebServlet("/usuario")
public class UsuarioServlet extends HttpServlet {

    private UsuarioService service = new UsuarioService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String nome = req.getParameter("nome");
        String email = req.getParameter("email");
        String senha = req.getParameter("senha");

        Usuario usuario = new Usuario(nome, email, senha, true);

        try {
            boolean sucesso = service.inserir(usuario);

            if (sucesso) {
                resp.sendRedirect("index.jsp");
            } else {
                req.setAttribute("erro", "Erro ao cadastrar usuário");
                req.getRequestDispatcher("WEB-INF/pages/cadastro.jsp").forward(req, resp);
            }
        } catch (IllegalArgumentException e) {
            req.setAttribute("erro", e.getMessage());
            req.getRequestDispatcher("WEB-INF/pages/cadastro.jsp").forward(req, resp);
        }
    }
}
