/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package es.energy.DAO;

import java.sql.SQLException;
import java.util.List;

import es.energy.beans.Deporte;

/**
 *
 * @author
 */
public interface IDeporteDAO {

    void agregarDeporte(Deporte deporte) throws SQLException;

    void actualizarDeporte(Deporte deporte) throws SQLException;

    void eliminarDeporte(int id) throws SQLException;

    public Deporte obtenerDeportePorNombre(String nombre) throws SQLException;

    List<Deporte> obtenerTodosLosDeportes() throws SQLException;
    
    Deporte obtenerDeportePorId(int id) throws SQLException;

}
