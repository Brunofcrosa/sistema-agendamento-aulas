package service;

import dao.ReservaDAO;
import model.Reserva;

import java.util.List;

public class ReservaService {

    public List<Reserva> listar() {
        return new ReservaDAO().listar();
    }

    public boolean inserir(Reserva reserva) {
        validarReserva(reserva);
        if (!new ReservaDAO().isSalaDisponivel(reserva.getSalaId(), reserva.getDataReserva(), reserva.getHoraInicio(), reserva.getHoraFim(), 0)) {
            throw new IllegalArgumentException("Sala indisponível para o horário informado");
        }
        return new ReservaDAO().inserir(reserva);
    }

    public void atualizar(Reserva reserva) {
        if (reserva.getId() <= 0) {
            throw new IllegalArgumentException("Reserva inválida para atualização");
        }
        validarReserva(reserva);
        if (!new ReservaDAO().isSalaDisponivel(reserva.getSalaId(), reserva.getDataReserva(), reserva.getHoraInicio(), reserva.getHoraFim(), reserva.getId())) {
            throw new IllegalArgumentException("Sala indisponível para o horário informado");
        }
        new ReservaDAO().atualizar(reserva);
    }

    public Reserva buscarPorId(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("Reserva inválida para busca");
        }
        return new ReservaDAO().buscarPorId(id);
    }

    public void cancelar(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("Reserva inválida para cancelamento");
        }
        new ReservaDAO().cancelar(id);
    }

    private void validarReserva(Reserva reserva) {
        if (reserva.getSalaId() <= 0) {
            throw new IllegalArgumentException("Sala é obrigatória");
        }
        if (reserva.getDocenteId() <= 0) {
            throw new IllegalArgumentException("Docente é obrigatório");
        }
        if (reserva.getDataReserva() == null) {
            throw new IllegalArgumentException("Data da reserva é obrigatória");
        }
        if (reserva.getHoraInicio() == null || reserva.getHoraFim() == null) {
            throw new IllegalArgumentException("Horários da reserva são obrigatórios");
        }
        if (!reserva.getHoraInicio().before(reserva.getHoraFim())) {
            throw new IllegalArgumentException("Horário final deve ser maior que o inicial");
        }
        if (reserva.getFinalidade() == null || reserva.getFinalidade().trim().isEmpty()) {
            throw new IllegalArgumentException("Finalidade da reserva é obrigatória");
        }
    }
}
