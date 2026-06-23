package org.agendamento.sistemaagendamentoaulas.dao;

import org.agendamento.sistemaagendamentoaulas.model.Docente;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Repository
public class DocenteDAO {

    private Docente map(ResultSet rs) throws SQLException {
        Docente docente = new Docente();
        docente.setId(rs.getInt("id"));
        docente.setMatricula(rs.getString("matricula"));
        docente.setNome(rs.getString("nome"));
        return docente;
    }

    public boolean inserir(Docente docente) {
        String sql = "INSERT INTO docente (matricula, nome) VALUES (?, ?)";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, docente.getMatricula());
            stmt.setString(2, docente.getNome());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir docente", e);
        }
    }

    public List<Docente> listar() {
        String sql = "SELECT * FROM docente ORDER BY nome";
        List<Docente> lista = new ArrayList<>();

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                lista.add(map(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar docentes", e);
        }

        return lista;
    }

    public List<Docente> listarAtivos() {
        return listar();
    }

    public Docente buscarPorId(int id) {
        String sql = "SELECT * FROM docente WHERE id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar docente por ID", e);
        }

        return null;
    }

    public boolean atualizar(Docente docente) {
        String sql = "UPDATE docente SET matricula = ?, nome = ? WHERE id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, docente.getMatricula());
            stmt.setString(2, docente.getNome());
            stmt.setInt(3, docente.getId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar docente", e);
        }
    }

    public boolean excluir(int id) {
        String sql = "DELETE FROM docente WHERE id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao excluir docente", e);
        }
    }
}