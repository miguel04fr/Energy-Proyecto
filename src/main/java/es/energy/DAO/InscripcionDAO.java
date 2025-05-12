package es.energy.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import es.energy.beans.Inscripcion;

public class InscripcionDAO implements IInscripcionDAO {

    @Override
    public void agregarInscripcion(Inscripcion inscripcion) throws SQLException {
        String sql = "INSERT INTO inscripciones (UsuarioId, HorarioId, FechaInscripcion) VALUES (?, ?, ?)";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, inscripcion.getUsuarioId());
            stmt.setInt(2, inscripcion.getHorarioId());
            stmt.setDate(3, inscripcion.getFechaInscripcion());
            
            stmt.executeUpdate();
            
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    inscripcion.setId(generatedKeys.getInt(1));
                }
            }
        }
    }

    @Override
    public void actualizarInscripcion(Inscripcion inscripcion) throws SQLException {
        String sql = "UPDATE inscripciones SET UsuarioId = ?, HorarioId = ?, FechaInscripcion = ? WHERE Id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            stmt.setInt(1, inscripcion.getUsuarioId());
            stmt.setInt(2, inscripcion.getHorarioId());
            stmt.setDate(3, inscripcion.getFechaInscripcion());
            stmt.setInt(4, inscripcion.getId());
            
            stmt.executeUpdate();
        }
    }

    @Override
    public void eliminarInscripcion(int id) throws SQLException {
        String sql = "DELETE FROM inscripciones WHERE Id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    @Override
    public Inscripcion obtenerInscripcionPorId(int id) throws SQLException {
        String sql = "SELECT * FROM inscripciones WHERE Id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToInscripcion(rs);
                }
            }
        }
        return null;
    }

    @Override
    public List<Inscripcion> obtenerTodasLasInscripciones() throws SQLException {
        List<Inscripcion> inscripciones = new ArrayList<>();
        String sql = "SELECT * FROM inscripciones";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                inscripciones.add(mapResultSetToInscripcion(rs));
            }
        }
        return inscripciones;
    }

    @Override
    public List<Inscripcion> obtenerInscripcionesPorUsuario(int usuarioId) throws SQLException {
        List<Inscripcion> inscripciones = new ArrayList<>();
        String sql = "SELECT * FROM inscripciones WHERE UsuarioId = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            stmt.setInt(1, usuarioId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    inscripciones.add(mapResultSetToInscripcion(rs));
                }
            }
        }
        return inscripciones;
    }

    @Override
    public List<Inscripcion> obtenerInscripcionesPorHorario(int horarioId) throws SQLException {
        List<Inscripcion> inscripciones = new ArrayList<>();
        String sql = "SELECT * FROM inscripciones WHERE HorarioId = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            stmt.setInt(1, horarioId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    inscripciones.add(mapResultSetToInscripcion(rs));
                }
            }
        }
        return inscripciones;
    }

    private Inscripcion mapResultSetToInscripcion(ResultSet rs) throws SQLException {
        return new Inscripcion(
            rs.getInt("Id"),
            rs.getInt("UsuarioId"),
            rs.getInt("HorarioId"),
            rs.getDate("FechaInscripcion")
        );
    }
} 