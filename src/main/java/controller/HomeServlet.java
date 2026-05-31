package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import service.DocenteService;
import service.ReservaService;
import service.SalaService;

import java.io.IOException;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private DocenteService docenteService = new DocenteService();
    private SalaService salaService = new SalaService();
    private ReservaService reservaService = new ReservaService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect("index.jsp");
            return;
        }

        req.setAttribute("totalDocentes", docenteService.listar().size());
        req.setAttribute("totalSalas", salaService.listar().size());
        req.setAttribute("totalReservas", reservaService.listar().size());

        RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/pages/home.jsp");
        rd.forward(req, resp);
    }
}
