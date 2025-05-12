package es.energy.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import es.energy.beans.ReservasPista;

public class ReservasPistaDAO implements IReservasPistaDAO {

    @Override
    public void agregarReservaPista(ReservasPista reservaPista) throws SQLException {
        String sql = "INSERT INTO reservasPista (EntrenadorId, DeporteId, UsuarioId, SalaId, Hora, Dia) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, reservaPista.getEntrenadorId());
            stmt.setInt(2, reservaPista.getDeporteId());
            stmt.setInt(3, reservaPista.getUsuarioId());
            stmt.setInt(4, reservaPista.getIdSala());
            stmt.setString(5, reservaPista.getHora());
            stmt.setString(6, reservaPista.getDia());
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    reservaPista.setId(generatedKeys.getInt(1));
                }
            }
        }
    }

    @Override
    public ReservasPista obReservasPistaPorId(int id) throws SQLException {
        String sql = "SELECT * FROM reservasPista WHERE Id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    ReservasPista reserva = new ReservasPista();
                    reserva.setId(rs.getInt("Id"));
                    reserva.setEntrenadorId(rs.getInt("EntrenadorId"));
                    reserva.setDeporteId(rs.getInt("DeporteId"));
                    reserva.setUsuarioId(rs.getInt("UsuarioId"));
                    reserva.setIdSala(rs.getInt("SalaId"));
                    reserva.setHora(rs.getString("Hora"));
                    reserva.setDia(rs.getString("Dia"));
                    return reserva;
                }
            }
        }
        return null;
    }

    @Override
    public List<ReservasPista> obtenerTodasLasReservasPistas() throws SQLException {
        List<ReservasPista> reservas = new ArrayList<>();
        String sql = "SELECT * FROM reservasPista";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                ReservasPista reserva = new ReservasPista();
                reserva.setId(rs.getInt("Id"));
                reserva.setEntrenadorId(rs.getInt("EntrenadorId"));
                reserva.setDeporteId(rs.getInt("DeporteId"));
                reserva.setUsuarioId(rs.getInt("UsuarioId"));
                reserva.setIdSala(rs.getInt("SalaId"));
                reserva.setHora(rs.getString("Hora"));
                reserva.setDia(rs.getString("Dia"));
                reservas.add(reserva);
            }
        }
        return reservas;
    }

    @Override
    public void actualizarReservaPista(ReservasPista reservaPista) throws SQLException {
        String sql = "UPDATE reservasPista SET EntrenadorId = ?, DeporteId = ?, UsuarioId = ?, SalaId = ?, Hora = ?, Dia = ? WHERE Id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            stmt.setInt(1, reservaPista.getEntrenadorId());
            stmt.setInt(2, reservaPista.getDeporteId());
            stmt.setInt(3, reservaPista.getUsuarioId());
            stmt.setInt(4, reservaPista.getIdSala());
            stmt.setString(5, reservaPista.getHora());
            stmt.setString(6, reservaPista.getDia());
            stmt.setInt(7, reservaPista.getId());
            stmt.executeUpdate();
        }
    }

    @Override
    public void eliminarReservaPista(int id) throws SQLException {
        String sql = "DELETE FROM reservasPista WHERE Id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}
