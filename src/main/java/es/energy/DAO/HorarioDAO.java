package es.energy.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import es.energy.beans.Horario;

public class HorarioDAO implements IHorarioDAO {

    @Override
    public void agregarHorario(Horario horario) throws SQLException {
        String sql = "INSERT INTO horarios (DeporteId, DiaSemana, Hora, SalaId, EntrenadorId, PlazasOfertadas, PlazasOcupadas) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, horario.getDeporteId());
            stmt.setString(2, horario.getDiaSemana());
            stmt.setTime(3, horario.getHora());
            stmt.setInt(4, horario.getSalaId());
            stmt.setInt(5, horario.getEntrenadorId());
            stmt.setInt(6, horario.getPlazasOfertadas());
            stmt.setInt(7, horario.getPlazasOcupadas());

            stmt.executeUpdate();
        }
    }

    @Override
    public Horario obtenerHorarioPorIdDeporte(int id) throws SQLException {
        String sql = "SELECT * FROM horarios WHERE DeporteId = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToHorario(rs);
                }
            }
        }
        return null;
    }

    @Override
    public Horario obtenerHorarioPorId(int id) throws SQLException {
        String sql = "SELECT * FROM horarios WHERE Id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToHorario(rs);
                }
            }
        }
        return null;
    }

    @Override
    public List<Horario> obtenerHorariosPorDeporte(int deporteId) throws SQLException {
        List<Horario> horarios = new ArrayList<>();
        String sql = "SELECT * FROM horarios WHERE DeporteId = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, deporteId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    horarios.add(mapResultSetToHorario(rs));
                }
            }
        }
        return horarios;
    }

    @Override
    public void actualizarHorario(Horario horario) throws SQLException {
        String sql = "UPDATE horarios SET DeporteId = ?, DiaSemana = ?, Hora = ?, SalaId = ?, EntrenadorId = ?, PlazasOfertadas = ?, PlazasOcupadas = ? WHERE Id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, horario.getDeporteId());
            stmt.setString(2, horario.getDiaSemana());
            stmt.setTime(3, horario.getHora());
            stmt.setInt(4, horario.getSalaId());
            stmt.setInt(5, horario.getEntrenadorId());
            stmt.setInt(6, horario.getPlazasOfertadas());
            stmt.setInt(7, horario.getPlazasOcupadas());
            stmt.setInt(8, horario.getId());

            stmt.executeUpdate();
        }
    }

    @Override
    public void eliminarHorario(int id) throws SQLException {
        String sql = "DELETE FROM horarios WHERE Id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    @Override
    public List<Horario> obtenerTodosLosHorarios() throws SQLException {
        List<Horario> horarios = new ArrayList<>();
        String sql = "SELECT * FROM horarios";
        
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Horario horario = new Horario();
                horario.setId(rs.getInt("Id"));
                horario.setDeporteId(rs.getInt("DeporteId"));
                horario.setDiaSemana(rs.getString("DiaSemana"));
                horario.setHora(rs.getTime("Hora"));
                horario.setSalaId(rs.getInt("SalaId"));
                horario.setEntrenadorId(rs.getInt("EntrenadorId"));
                horario.setPlazasOfertadas(rs.getInt("PlazasOfertadas"));
                horario.setPlazasOcupadas(rs.getInt("PlazasOcupadas"));
                horarios.add(horario);
            }
        }
        
        return horarios;
    }

    @Override
    public List<Horario> obtenerHorariosPorEntrenador(int entrenadorId) throws SQLException {
        List<Horario> horarios = new ArrayList<>();
        String sql = "SELECT * FROM horarios WHERE EntrenadorId = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, entrenadorId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    horarios.add(mapResultSetToHorario(rs));
                }
            }
        }
        return horarios;
    }

    private Horario mapResultSetToHorario(ResultSet rs) throws SQLException {
        Horario horario = new Horario();
        horario.setId(rs.getInt("Id"));
        horario.setDeporteId(rs.getInt("DeporteId"));
        horario.setDiaSemana(rs.getString("DiaSemana"));
        horario.setHora(rs.getTime("Hora"));
        horario.setSalaId(rs.getInt("SalaId"));
        horario.setEntrenadorId(rs.getInt("EntrenadorId"));
        horario.setPlazasOfertadas(rs.getInt("PlazasOfertadas"));
        horario.setPlazasOcupadas(rs.getInt("PlazasOcupadas"));
        return horario;
    }
}
