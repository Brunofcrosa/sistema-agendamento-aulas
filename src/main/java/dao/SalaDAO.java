package dao;

import model.Sala;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SalaDAO {

    private Sala map(ResultSet rs) throws SQLException {
        Sala sala = new Sala();
        sala.setId(rs.getInt("id"));
        sala.setNome(rs.getString("nome"));
        sala.setBloco(rs.getString("bloco"));
        sala.setCapacidade(rs.getInt("capacidade"));
        sala.setRecursos(rs.getString("recursos"));
        sala.setAtiva(rs.getBoolean("ativa"));
        return sala;
    }

    public boolean inserir(Sala sala) {
        String sql = "INSERT INTO sala (nome, bloco, capacidade, recursos, ativa) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, sala.getNome());
            stmt.setString(2, sala.getBloco());
            stmt.setInt(3, sala.getCapacidade());
            stmt.setString(4, sala.getRecursos());
            stmt.setBoolean(5, sala.isAtiva());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir sala", e);
        }
    }

    public List<Sala> listar() {
        String sql = "SELECT * FROM sala ORDER BY nome";
        List<Sala> lista = new ArrayList<>();

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                lista.add(map(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar salas", e);
        }

        return lista;
    }

    public List<Sala> listarAtivas() {
        String sql = "SELECT * FROM sala WHERE ativa = true ORDER BY nome";
        List<Sala> lista = new ArrayList<>();

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                lista.add(map(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar salas ativas", e);
        }

        return lista;
    }

    public Sala buscarPorId(int id) {
        String sql = "SELECT * FROM sala WHERE id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return map(rs);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar sala", e);
        }

        return null;
    }

    public void atualizar(Sala sala) {
        String sql = "UPDATE sala SET nome=?, bloco=?, capacidade=?, recursos=?, ativa=? WHERE id=?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, sala.getNome());
            stmt.setString(2, sala.getBloco());
            stmt.setInt(3, sala.getCapacidade());
            stmt.setString(4, sala.getRecursos());
            stmt.setBoolean(5, sala.isAtiva());
            stmt.setInt(6, sala.getId());

            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar sala", e);
        }
    }

    public void excluir(int id) {
        String sql = "DELETE FROM sala WHERE id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao excluir sala", e);
        }
    }
}
