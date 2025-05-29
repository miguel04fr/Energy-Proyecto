package es.energy.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import es.energy.beans.Usuario;

public class UsuarioDAO implements IUsuarioDAO {
// Insertar un usuario

    @Override
    public void insertar(Usuario usuario) throws SQLException {
        String sql = "INSERT INTO usuarios (Dni, FechaNacimiento, Nombre, Apellido, Email, Clave, Telefono, Rol, IBAN, Activo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection con = null;
        try {
            con = ConnectionFactory.getConnection();
            con.setAutoCommit(false);
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, usuario.getDni());
                stmt.setDate(2, new java.sql.Date(usuario.getFechaNacimiento().getTime()));
                stmt.setString(3, usuario.getNombre());
                stmt.setString(4, usuario.getApellido());
                stmt.setString(5, usuario.getEmail());
                stmt.setString(6, usuario.getClave());
                stmt.setString(7, usuario.getTelefono());
                stmt.setString(8, usuario.getRol().toString());
                stmt.setString(9, usuario.getIban());
                stmt.setBoolean(10, usuario.isActivo());
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
            String message = e.getMessage();
            if (message.contains("Duplicate entry") && message.contains("usuarios.Dni")) {
                String dni = message.split("'")[1];
                throw new SQLException("El DNI " + dni + " ya está registrado en el sistema.", e);
            } else if (message.contains("Duplicate entry") && message.contains("usuarios.Email")) {
                String email = message.split("'")[1];
                throw new SQLException("El email " + email + " ya está registrado en el sistema.", e);
            } else if (message.contains("Duplicate entry") && message.contains("usuarios.IBAN")) {
                String iban = message.split("'")[1];
                throw new SQLException("El IBAN " + iban + " ya está registrado en el sistema.", e);
            } else {
                throw new SQLException("Error al insertar el usuario: " + e.getMessage(), e);
            }
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

    // Actualizar un usuario
    @Override
    public void actualizar(Usuario usuario) throws SQLException {
        String sql = "UPDATE usuarios SET Dni = ?, FechaNacimiento = ?, Nombre = ?, Apellido = ?, Email = ?, Clave = ?, Telefono = ?, IBAN = ?, Activo = ? WHERE Id = ?";
        Connection con = null;
        try {
            con = ConnectionFactory.getConnection();
            con.setAutoCommit(false);
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, usuario.getDni());
                stmt.setDate(2, new java.sql.Date(usuario.getFechaNacimiento().getTime()));
                stmt.setString(3, usuario.getNombre());
                stmt.setString(4, usuario.getApellido());
                stmt.setString(5, usuario.getEmail());
                stmt.setString(6, usuario.getClave());
                stmt.setString(7, usuario.getTelefono());
                stmt.setString(8, usuario.getIban());
                stmt.setBoolean(9, usuario.isActivo());
                stmt.setInt(10, usuario.getId());
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

    // Eliminar un usuario
    @Override
    public void eliminar(int id) throws SQLException {
        String sql = "DELETE FROM usuarios WHERE Id = ?";
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

    @Override
    public List<Usuario> obtenerTodos() {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuarios";
        try (Connection con = ConnectionFactory.getConnection(); PreparedStatement stmt = con.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("Id"));
                usuario.setDni(rs.getString("Dni"));
                usuario.setFechaNacimiento(rs.getDate("FechaNacimiento"));
                usuario.setNombre(rs.getString("Nombre"));
                usuario.setApellido(rs.getString("Apellido"));
                usuario.setEmail(rs.getString("Email"));
                usuario.setClave(rs.getString("Clave"));
                usuario.setTelefono(rs.getString("Telefono"));
                usuario.setIban(rs.getString("IBAN"));
                usuario.setRol(Usuario.Rol.valueOf(rs.getString("Rol").toUpperCase()));
                usuario.setActivo(rs.getBoolean("Activo"));
                usuarios.add(usuario);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuarios;
    }

    public boolean existeEmail(String email) {
        boolean existe = false;
        String sql = "SELECT COUNT(*) FROM usuarios WHERE Email = ?";

        try (Connection con = ConnectionFactory.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    existe = rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return existe;
    }

    public boolean existeDNI(String dni) {
        boolean existe = false;
        String sql = "SELECT COUNT(*) FROM usuarios WHERE Dni = ?";

        try (Connection con = ConnectionFactory.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, dni);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    existe = rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return existe;
    }

    public boolean existeIBAN(String iban) {
        boolean existe = false;
        String sql = "SELECT COUNT(*) FROM usuarios WHERE IBAN = ?";

        try (Connection con = ConnectionFactory.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, iban);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    existe = rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return existe;
    }

    public Usuario getUsuarioByEmail(String email) {
        Usuario usuario = null;
        String sql = "SELECT * FROM usuarios WHERE Email = ?";

        try (Connection con = ConnectionFactory.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setId(rs.getInt("Id"));
                    usuario.setDni(rs.getString("Dni"));
                    usuario.setFechaNacimiento(rs.getDate("FechaNacimiento"));
                    usuario.setNombre(rs.getString("Nombre"));
                    usuario.setApellido(rs.getString("Apellido"));
                    usuario.setEmail(rs.getString("Email"));
                    usuario.setClave(rs.getString("Clave"));
                    usuario.setTelefono(rs.getString("Telefono"));
                    usuario.setIban(rs.getString("IBAN"));
                    usuario.setRol(Usuario.Rol.valueOf(rs.getString("Rol").toUpperCase()));
                    usuario.setActivo(rs.getBoolean("Activo"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Manejo de la excepción según sea necesario
        }

        return usuario;
    }

    public Usuario obtenerUsuarioPorId(int id) {
        Usuario usuario = null;
        String sql = "SELECT * FROM usuarios WHERE Id = ?";

        try (Connection con = ConnectionFactory.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setId(rs.getInt("Id"));
                    usuario.setDni(rs.getString("Dni"));
                    usuario.setFechaNacimiento(rs.getDate("FechaNacimiento"));
                    usuario.setNombre(rs.getString("Nombre"));
                    usuario.setApellido(rs.getString("Apellido"));
                    usuario.setEmail(rs.getString("Email"));
                    usuario.setClave(rs.getString("Clave"));
                    usuario.setTelefono(rs.getString("Telefono"));
                    usuario.setIban(rs.getString("IBAN"));
                    usuario.setRol(Usuario.Rol.valueOf(rs.getString("Rol").toUpperCase()));
                    usuario.setActivo(rs.getBoolean("Activo"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuario;
    }

    @Override
    public List<Usuario> obtenerUsuariosPorEntrenador(int entrenadorId) throws SQLException {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT DISTINCT u.* FROM usuarios u "
                + "JOIN inscripciones i ON u.Id = i.UsuarioId "
                + "JOIN horarios h ON i.HorarioId = h.Id "
                + "WHERE h.EntrenadorId = ?";

        try (Connection con = ConnectionFactory.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, entrenadorId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setId(rs.getInt("Id"));
                    usuario.setDni(rs.getString("Dni"));
                    usuario.setFechaNacimiento(rs.getDate("FechaNacimiento"));
                    usuario.setNombre(rs.getString("Nombre"));
                    usuario.setApellido(rs.getString("Apellido"));
                    usuario.setEmail(rs.getString("Email"));
                    usuario.setClave(rs.getString("Clave"));
                    usuario.setTelefono(rs.getString("Telefono"));
                    usuario.setIban(rs.getString("IBAN"));
                    usuario.setRol(Usuario.Rol.valueOf(rs.getString("Rol").toUpperCase()));
                    usuario.setActivo(rs.getBoolean("Activo"));
                    usuarios.add(usuario);
                }
            }
        }
        return usuarios;
    }

    public List<Usuario> obtenerUsuariosPorRolEntrenador() throws SQLException {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuarios WHERE Rol = 'entrenador'";
        try (Connection con = ConnectionFactory.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setId(rs.getInt("Id"));
                    usuario.setRol(Usuario.Rol.valueOf(rs.getString("Rol").toUpperCase()));
                    usuario.setNombre(rs.getString("Nombre"));
                    usuario.setApellido(rs.getString("Apellido"));
                    usuario.setEmail(rs.getString("Email"));
                    usuario.setClave(rs.getString("Clave"));
                    usuario.setTelefono(rs.getString("Telefono"));
                    usuario.setIban(rs.getString("IBAN"));
                    usuario.setDni(rs.getString("Dni"));
                    usuario.setFechaNacimiento(rs.getDate("FechaNacimiento"));
                    usuario.setActivo(rs.getBoolean("Activo"));
                    usuarios.add(usuario);
                }
            }
        }
        return usuarios;
    }

    public List<Usuario> obtenerUsuariosPorRolGerente() throws SQLException {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuarios WHERE Rol = 'gerente'";
        try (Connection con = ConnectionFactory.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setId(rs.getInt("Id"));
                    usuario.setRol(Usuario.Rol.valueOf(rs.getString("Rol").toUpperCase()));
                    usuario.setNombre(rs.getString("Nombre"));
                    usuario.setApellido(rs.getString("Apellido"));
                    usuario.setEmail(rs.getString("Email"));
                    usuario.setClave(rs.getString("Clave"));
                    usuario.setTelefono(rs.getString("Telefono"));
                    usuario.setIban(rs.getString("IBAN"));
                    usuario.setDni(rs.getString("Dni"));
                    usuario.setFechaNacimiento(rs.getDate("FechaNacimiento"));
                    usuario.setActivo(rs.getBoolean("Activo"));
                    usuarios.add(usuario);
                }
            }
        }
        return usuarios;
    }
    public List<Usuario> obtenerUsuariosPorRolCliente() throws SQLException {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuarios WHERE Rol = 'usuario'";
        try (Connection con = ConnectionFactory.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setId(rs.getInt("Id"));
                    usuario.setRol(Usuario.Rol.valueOf(rs.getString("Rol").toUpperCase()));
                    usuario.setNombre(rs.getString("Nombre"));
                    usuario.setApellido(rs.getString("Apellido"));
                    usuario.setEmail(rs.getString("Email"));
                    usuario.setClave(rs.getString("Clave"));
                    usuario.setTelefono(rs.getString("Telefono"));
                    usuario.setIban(rs.getString("IBAN"));
                    usuario.setDni(rs.getString("Dni"));
                    usuario.setFechaNacimiento(rs.getDate("FechaNacimiento"));
                    usuario.setActivo(rs.getBoolean("Activo"));
                    usuarios.add(usuario);
                }
            }
        }
        return usuarios;
    }
    public void cambiarEstado(int id, boolean activo) throws SQLException {
        String sql = "UPDATE usuarios SET Activo = ? WHERE Id = ?";
        try (Connection con = ConnectionFactory.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setBoolean(1, activo);
            stmt.setInt(2, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    @Override
    public List<Usuario> obtenerEntrenadoresActivos () throws SQLException {
        String sql = "SELECT * FROM usuarios WHERE Rol = 'entrenador' AND Activo = true";
        List<Usuario> entrenadoresActivos = new ArrayList<>();
        try (Connection con = ConnectionFactory.getConnection(); PreparedStatement stmt = con.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("Id"));
                usuario.setDni(rs.getString("Dni"));
                usuario.setFechaNacimiento(rs.getDate("FechaNacimiento"));
                usuario.setNombre(rs.getString("Nombre"));
                usuario.setApellido(rs.getString("Apellido"));
                usuario.setEmail(rs.getString("Email"));
                usuario.setClave(rs.getString("Clave"));
                usuario.setTelefono(rs.getString("Telefono"));
                usuario.setIban(rs.getString("IBAN"));
                usuario.setRol(Usuario.Rol.valueOf(rs.getString("Rol").toUpperCase()));
                usuario.setActivo(rs.getBoolean("Activo"));
                entrenadoresActivos.add(usuario);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return entrenadoresActivos;
    }
    
      
}
