package es.energy.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import es.energy.beans.Sala;

public class SalaDAO implements ISalaDAO {

    @Override
    public List<Sala> obtenerTodasLasSalas() throws SQLException {
        List<Sala> salas = new ArrayList<>();
        String sql = "SELECT * FROM salas";
        
        try (Connection con = ConnectionFactory.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Sala sala = new Sala();
                sala.setIdSala(rs.getInt("IdSala"));
                sala.setDescripcion(rs.getString("Descripcion"));
                salas.add(sala);
            }
        }
        return salas;
    }

    @Override
    public Sala obtenerSalaPorId(int id) throws SQLException {
        String sql = "SELECT * FROM salas WHERE IdSala = ?";
        Sala sala = null;
        
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    sala = new Sala();
                    sala.setIdSala(rs.getInt("IdSala"));
                    sala.setDescripcion(rs.getString("Descripcion"));
                }
            }
        }
        return sala;
    }

    @Override
    public void insertar(Sala sala) throws SQLException {
        String sql = "INSERT INTO salas (IdSala, Descripcion) VALUES (?, ?)";
        Connection con = null;
        try {
            con = ConnectionFactory.getConnection();
            con.setAutoCommit(false);
            try (PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, sala.getIdSala());
                stmt.setString(2, sala.getDescripcion());
                stmt.executeUpdate();
                con.commit();
                
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        sala.setIdSala(rs.getInt(1));
                    }
                }
            }
        } catch (SQLException e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    throw new SQLException("Error al hacer rollback: " + ex.getMessage());
                }
            }
            throw e;
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    public void actualizar(Sala sala) throws SQLException {
        String sql = "UPDATE salas SET Descripcion = ? WHERE IdSala = ?";
        Connection con = null;
        try {
            con = ConnectionFactory.getConnection();
            con.setAutoCommit(false);
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, sala.getDescripcion());
                stmt.setInt(2, sala.getIdSala());
                stmt.executeUpdate();
                con.commit();
            }
        } catch (SQLException e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    throw new SQLException("Error al hacer rollback: " + ex.getMessage());
                }
            }
            throw e;
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    public void eliminar(int id) throws SQLException {
        String sql = "DELETE FROM salas WHERE IdSala = ?";
        Connection con = null;
        try {
            con = ConnectionFactory.getConnection();
            con.setAutoCommit(false);
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setInt(1, id);
                stmt.executeUpdate();
                con.commit();
            }
        } catch (SQLException e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    throw new SQLException("Error al hacer rollback: " + ex.getMessage());
                }
            }
            throw e;
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
} 