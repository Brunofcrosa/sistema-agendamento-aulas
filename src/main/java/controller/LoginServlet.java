package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Usuario;
import service.LoginService;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private LoginService service = new LoginService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String senha = req.getParameter("senha");

        try {
            Usuario usuario = service.autenticar(email, senha);

            if (usuario != null) {
                HttpSession session = req.getSession();
                session.setAttribute("usuario", usuario);

                resp.sendRedirect("home");
            } else {
                req.setAttribute("erro", "Usuário ou senha inválidos");
                req.getRequestDispatcher("index.jsp").forward(req, resp);
            }
        } catch (IllegalArgumentException e) {
            req.setAttribute("erro", e.getMessage());
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        }
    }
}
