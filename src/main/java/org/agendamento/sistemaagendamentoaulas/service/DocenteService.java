package org.agendamento.sistemaagendamentoaulas.service;

import org.agendamento.sistemaagendamentoaulas.dao.DocenteDAO;
import org.agendamento.sistemaagendamentoaulas.model.Docente;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DocenteService {

    public List<Docente> listar() {
        return new DocenteDAO().listar();
    }

    public List<Docente> listarAtivos() {
        return new DocenteDAO().listarAtivos();
    }

    public boolean inserir(Docente docente) {
        validarDocente(docente);
        return new DocenteDAO().inserir(docente);
    }

    public void excluir(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("Docente invÃ¡lido para exclusÃ£o");
        }
        boolean excluiu = new DocenteDAO().excluir(id);
        if (!excluiu) {
            throw new IllegalArgumentException("Nao e possivel excluir um docente com reservas ativas.");
        }
    }

    public void atualizar(Docente docente) {
        if (docente.getId() <= 0) {
            throw new IllegalArgumentException("Docente invÃ¡lido para atualizaÃ§Ã£o");
        }
        validarDocente(docente);
        new DocenteDAO().atualizar(docente);
    }

    public Docente buscarPorId(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("Docente invÃ¡lido para busca");
        }
        return new DocenteDAO().buscarPorId(id);
    }

    private void validarDocente(Docente docente) {
        if (docente.getNome() == null || docente.getNome().trim().isEmpty()) {
            throw new IllegalArgumentException("Nome do docente Ã© obrigatÃ³rio");
        }
        if (docente.getMatricula() == null || docente.getMatricula().trim().isEmpty()) {
            throw new IllegalArgumentException("MatrÃ­cula do docente Ã© obrigatÃ³ria");
        }
    }
}
