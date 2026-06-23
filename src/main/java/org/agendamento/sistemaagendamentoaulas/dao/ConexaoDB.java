package org.agendamento.sistemaagendamentoaulas.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexaoDB {

    private static final String URL = "jdbc:postgresql://localhost:5432/sistema-agendamento-salas";
    private static final String USER = "postgres";
    private static final String PASSWORD = "postgres";

    private ConexaoDB() {
    }

    public static Connection getConexao() {
        try {
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao conectar no banco de dados", e);
        }
    }
}