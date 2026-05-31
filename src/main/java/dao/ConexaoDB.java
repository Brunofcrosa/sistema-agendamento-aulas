package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexaoDB {

    private static final String URL = "jdbc:postgresql://localhost:5432/sistema-agendamento-salas";
    private static final String USER = "postgres";
    private static final String PASSWORD = "postgres";

    public static Connection getConexao() {

        try {
            Class.forName("org.postgresql.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);

        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver do PostgreSQL não encontrado", e);

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao conectar no banco de dados", e);
        }
    }
}
