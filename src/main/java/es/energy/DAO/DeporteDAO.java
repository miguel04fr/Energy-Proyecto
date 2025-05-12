package es.energy.DAO;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import es.energy.beans.Deporte;

public class DeporteDAO implements IDeporteDAO {

    @Override
    public void agregarDeporte(Deporte deporte) throws SQLException {
        String sql = "INSERT INTO deportes (Nombre, Descripcion) VALUES (?, ?)";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, deporte.getNombreDeporte());
            stmt.setString(2, deporte.getDescripcion());
            stmt.executeUpdate();

            // Obtener ID generado automáticamente
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    deporte.setId(generatedKeys.getInt(1));
                }
            }
        }
    }

    @Override
    public void actualizarDeporte(Deporte deporte) throws SQLException {
        String sql = "UPDATE deportes SET Nombre = ?, Descripcion = ? WHERE Id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            stmt.setString(1, deporte.getNombreDeporte());
            stmt.setString(2, deporte.getDescripcion());
            stmt.setInt(3, deporte.getId());
            stmt.executeUpdate();
        }
    }

    @Override
    public void eliminarDeporte(int id) throws SQLException {
        String sql = "DELETE FROM deportes WHERE Id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

  @Override
public Deporte obtenerDeportePorNombre(String nombre) throws SQLException {
    String sql = "SELECT * FROM deportes WHERE Nombre = ?";
    try (Connection con = ConnectionFactory.getConnection();
         PreparedStatement stmt = con.prepareStatement(sql)) {
        
        stmt.setString(1, nombre);
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return new Deporte(rs.getInt("Id"), rs.getString("Nombre"), rs.getString("Descripcion"));
            }
        }
    }
    return null; // Retorna null si no encuentra el deporte
}

    @Override
    public Deporte obtenerDeportePorId(int id) throws SQLException {
        String sql = "SELECT * FROM deportes WHERE Id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Deporte(
                        rs.getInt("Id"),
                        rs.getString("Nombre"),
                        rs.getString("Descripcion")
                    );
                }
            }
        }
        return null;
    }

    @Override
    public List<Deporte> obtenerTodosLosDeportes() throws SQLException {
        List<Deporte> deportes = new ArrayList<>();
        String sql = "SELECT * FROM deportes";
        try (Connection con = ConnectionFactory.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                deportes.add(new Deporte(rs.getInt("Id"), rs.getString("Nombre"), rs.getString("Descripcion")));
            }
        }
        return deportes;
    }}
