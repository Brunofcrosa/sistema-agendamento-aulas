package org.agendamento.sistemaagendamentoaulas.service;

import org.agendamento.sistemaagendamentoaulas.dao.SalaDAO;
import org.agendamento.sistemaagendamentoaulas.model.Sala;

import java.util.List;

public class SalaService {

    public List<Sala> listar() {
        return new SalaDAO().listar();
    }

    public List<Sala> listarAtivas() {
        return new SalaDAO().listarAtivas();
    }

    public boolean inserir(Sala sala) {
        validarSala(sala);
        return new SalaDAO().inserir(sala);
    }

    public void excluir(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("Sala invÃ¡lida para exclusÃ£o");
        }
        new SalaDAO().excluir(id);
    }

    public void atualizar(Sala sala) {
        if (sala.getId() <= 0) {
            throw new IllegalArgumentException("Sala invÃ¡lida para atualizaÃ§Ã£o");
        }
        validarSala(sala);
        new SalaDAO().atualizar(sala);
    }

    public Sala buscarPorId(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("Sala invÃ¡lida para busca");
        }
        return new SalaDAO().buscarPorId(id);
    }

    private void validarSala(Sala sala) {
        if (sala.getNome() == null || sala.getNome().trim().isEmpty()) {
            throw new IllegalArgumentException("Nome da sala Ã© obrigatÃ³rio");
        }
        if (sala.getBloco() == null || sala.getBloco().trim().isEmpty()) {
            throw new IllegalArgumentException("Bloco da sala Ã© obrigatÃ³rio");
        }
        if (sala.getCapacidade() <= 0) {
            throw new IllegalArgumentException("Capacidade deve ser maior que zero");
        }
    }
}
