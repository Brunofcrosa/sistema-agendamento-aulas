package dao;

import model.Reserva;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservaDAO {

    private Reserva map(ResultSet rs) throws SQLException {
        Reserva reserva = new Reserva();
        reserva.setId(rs.getInt("id"));
        reserva.setSalaId(rs.getInt("sala_id"));
        reserva.setDocenteId(rs.getInt("docente_id"));
        reserva.setSalaNome(rs.getString("sala_nome"));
        reserva.setDocenteNome(rs.getString("docente_nome"));
        reserva.setDataReserva(rs.getDate("data_reserva"));
        reserva.setHoraInicio(rs.getTime("hora_inicio"));
        reserva.setHoraFim(rs.getTime("hora_fim"));
        reserva.setFinalidade(rs.getString("finalidade"));
        reserva.setStatus(rs.getString("status"));
        return reserva;
    }

    public boolean inserir(Reserva reserva) {
        String sql = "INSERT INTO reserva (sala_id, docente_id, data_reserva, hora_inicio, hora_fim, finalidade, status) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, reserva.getSalaId());
            stmt.setInt(2, reserva.getDocenteId());
            stmt.setDate(3, reserva.getDataReserva());
            stmt.setTime(4, reserva.getHoraInicio());
            stmt.setTime(5, reserva.getHoraFim());
            stmt.setString(6, reserva.getFinalidade());
            stmt.setString(7, reserva.getStatus());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir reserva", e);
        }
    }

    public List<Reserva> listar() {
        String sql = "SELECT r.*, s.nome AS sala_nome, d.nome AS docente_nome FROM reserva r INNER JOIN sala s ON s.id = r.sala_id INNER JOIN docente d ON d.id = r.docente_id WHERE r.status = 'ATIVA' ORDER BY r.data_reserva, r.hora_inicio";
        List<Reserva> lista = new ArrayList<>();

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                lista.add(map(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar reservas", e);
        }

        return lista;
    }

    public Reserva buscarPorId(int id) {
        String sql = "SELECT r.*, s.nome AS sala_nome, d.nome AS docente_nome FROM reserva r INNER JOIN sala s ON s.id = r.sala_id INNER JOIN docente d ON d.id = r.docente_id WHERE r.id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return map(rs);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar reserva", e);
        }

        return null;
    }

    public boolean isSalaDisponivel(int salaId, Date dataReserva, Time horaInicio, Time horaFim, int reservaIgnoradaId) {
        String sql = "SELECT COUNT(*) FROM reserva WHERE sala_id = ? AND data_reserva = ? AND status = 'ATIVA' AND id <> ? AND hora_inicio < ? AND hora_fim > ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, salaId);
            stmt.setDate(2, dataReserva);
            stmt.setInt(3, reservaIgnoradaId);
            stmt.setTime(4, horaFim);
            stmt.setTime(5, horaInicio);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) == 0;
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao verificar disponibilidade da sala", e);
        }

        return false;
    }

    public void atualizar(Reserva reserva) {
        String sql = "UPDATE reserva SET sala_id=?, docente_id=?, data_reserva=?, hora_inicio=?, hora_fim=?, finalidade=?, status=? WHERE id=?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, reserva.getSalaId());
            stmt.setInt(2, reserva.getDocenteId());
            stmt.setDate(3, reserva.getDataReserva());
            stmt.setTime(4, reserva.getHoraInicio());
            stmt.setTime(5, reserva.getHoraFim());
            stmt.setString(6, reserva.getFinalidade());
            stmt.setString(7, reserva.getStatus());
            stmt.setInt(8, reserva.getId());

            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar reserva", e);
        }
    }

    public void cancelar(int id) {
        String sql = "UPDATE reserva SET status = 'CANCELADA' WHERE id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao cancelar reserva", e);
        }
    }
}
