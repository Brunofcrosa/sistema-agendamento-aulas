package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Docente;
import service.DocenteService;

import java.io.IOException;
import java.util.List;

@WebServlet("/docente")
public class DocenteServlet extends HttpServlet {

    private DocenteService service = new DocenteService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect("index.jsp");
            return;
        }

        String acao = req.getParameter("acao");
        String tela = req.getParameter("tela");
        try {
            if ("editar".equals(acao)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Docente docente = service.buscarPorId(id);
                req.setAttribute("docente", docente);
                tela = "novo";
            }

            if ("excluir".equals(acao)) {
                int id = Integer.parseInt(req.getParameter("id"));
                service.excluir(id);
                resp.sendRedirect("docente?tela=listar&msg=excluido");
                return;
            }
        } catch (IllegalArgumentException e) {
            req.setAttribute("erro", e.getMessage());
        }

        if (tela == null || tela.isEmpty()) {
            tela = "listar";
        }

        List<Docente> lista = service.listar();
        req.setAttribute("docentes", lista);
        req.setAttribute("tela", tela);

        RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/pages/docentes.jsp");
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect("index.jsp");
            return;
        }

        String idParam = req.getParameter("id");
        String matricula = req.getParameter("matricula");
        String nome = req.getParameter("nome");

        Docente docente = new Docente(matricula, nome);

        try {
            if (idParam != null && !idParam.isEmpty() && !"0".equals(idParam)) {
                docente.setId(Integer.parseInt(idParam));
                service.atualizar(docente);
                resp.sendRedirect("docente?tela=listar&msg=editado");
            } else {
                service.inserir(docente);
                resp.sendRedirect("docente?tela=listar&msg=salvo");
            }
        } catch (IllegalArgumentException e) {
            req.setAttribute("erro", e.getMessage());
            req.setAttribute("docente", docente);
            req.setAttribute("docentes", service.listar());
            req.setAttribute("tela", "novo");
            req.getRequestDispatcher("WEB-INF/pages/docentes.jsp").forward(req, resp);
        }
    }
}
