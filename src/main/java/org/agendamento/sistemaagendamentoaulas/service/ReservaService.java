package org.agendamento.sistemaagendamentoaulas.service;

import org.agendamento.sistemaagendamentoaulas.dao.ReservaDAO;
import org.agendamento.sistemaagendamentoaulas.model.Reserva;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReservaService {

    public List<Reserva> listar() {
        return new ReservaDAO().listar();
    }

    public boolean inserir(Reserva reserva) {
        validarReserva(reserva);
        if (!new ReservaDAO().isSalaDisponivel(reserva.getSalaId(), reserva.getDataReserva(), reserva.getHoraInicio(), reserva.getHoraFim(), 0)) {
            throw new IllegalArgumentException("Sala indisponÃ­vel para o horÃ¡rio informado");
        }
        return new ReservaDAO().inserir(reserva);
    }

    public void atualizar(Reserva reserva) {
        if (reserva.getId() <= 0) {
            throw new IllegalArgumentException("Reserva invÃ¡lida para atualizaÃ§Ã£o");
        }
        validarReserva(reserva);
        if (!new ReservaDAO().isSalaDisponivel(reserva.getSalaId(), reserva.getDataReserva(), reserva.getHoraInicio(), reserva.getHoraFim(), reserva.getId())) {
            throw new IllegalArgumentException("Sala indisponÃ­vel para o horÃ¡rio informado");
        }
        new ReservaDAO().atualizar(reserva);
    }

    public Reserva buscarPorId(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("Reserva invÃ¡lida para busca");
        }
        return new ReservaDAO().buscarPorId(id);
    }

    public void cancelar(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("Reserva invÃ¡lida para cancelamento");
        }
        new ReservaDAO().cancelar(id);
    }

    private void validarReserva(Reserva reserva) {
        if (reserva.getSalaId() <= 0) {
            throw new IllegalArgumentException("Sala Ã© obrigatÃ³ria");
        }
        if (reserva.getDocenteId() <= 0) {
            throw new IllegalArgumentException("Docente Ã© obrigatÃ³rio");
        }
        if (reserva.getDataReserva() == null) {
            throw new IllegalArgumentException("Data da reserva Ã© obrigatÃ³ria");
        }
        if (reserva.getHoraInicio() == null || reserva.getHoraFim() == null) {
            throw new IllegalArgumentException("HorÃ¡rios da reserva sÃ£o obrigatÃ³rios");
        }
        if (!reserva.getHoraInicio().before(reserva.getHoraFim())) {
            throw new IllegalArgumentException("HorÃ¡rio final deve ser maior que o inicial");
        }
        if (reserva.getFinalidade() == null || reserva.getFinalidade().trim().isEmpty()) {
            throw new IllegalArgumentException("Finalidade da reserva Ã© obrigatÃ³ria");
        }
    }
}
