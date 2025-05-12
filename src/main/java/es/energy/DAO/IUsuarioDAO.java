/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package es.energy.DAO;

import java.sql.SQLException;
import java.util.List;

import es.energy.beans.Usuario;

/**
 *
 * @author
 */
public interface IUsuarioDAO {

    // Método para insertar un usuario
    public void insertar(Usuario usuario) throws SQLException;

    // Método para obtener todos los usuarios
    public List<Usuario> obtenerTodos();

    // Método para actualizar un usuario
    public void actualizar(Usuario usuario);

    // Método para eliminar un usuario por su ID
    public void eliminar(int id);

    public Usuario getUsuarioByEmail(String email);

    public boolean existeEmail(String email);

    public Usuario obtenerUsuarioPorId(int id);

    public List<Usuario> obtenerUsuariosPorEntrenador(int entrenadorId) throws SQLException;

    public List<Usuario> obtenerUsuariosPorRolEntrenador() throws SQLException;

    public List<Usuario> obtenerUsuariosPorRolGerente() throws SQLException;
    public List<Usuario> obtenerUsuariosPorRolCliente() throws SQLException;
    public void cambiarEstado(int id, boolean activo) throws SQLException;
}
