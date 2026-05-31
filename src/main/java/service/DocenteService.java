package service;

import dao.DocenteDAO;
import model.Docente;

import java.util.List;

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
            throw new IllegalArgumentException("Docente inválido para exclusão");
        }
        new DocenteDAO().excluir(id);
    }

    public void atualizar(Docente docente) {
        if (docente.getId() <= 0) {
            throw new IllegalArgumentException("Docente inválido para atualização");
        }
        validarDocente(docente);
        new DocenteDAO().atualizar(docente);
    }

    public Docente buscarPorId(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("Docente inválido para busca");
        }
        return new DocenteDAO().buscarPorId(id);
    }

    private void validarDocente(Docente docente) {
        if (docente.getNome() == null || docente.getNome().trim().isEmpty()) {
            throw new IllegalArgumentException("Nome do docente é obrigatório");
        }
        if (docente.getMatricula() == null || docente.getMatricula().trim().isEmpty()) {
            throw new IllegalArgumentException("Matrícula do docente é obrigatória");
        }
    }
}
