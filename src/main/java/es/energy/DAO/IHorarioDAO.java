/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package es.energy.DAO;

import java.sql.SQLException;
import java.util.List;

import es.energy.beans.Horario;

/**
 *
 * @author
 */
public interface IHorarioDAO {

    public Horario obtenerHorarioPorIdDeporte(int id) throws SQLException;

    void agregarHorario(Horario horario) throws SQLException;

    Horario obtenerHorarioPorId(int id) throws SQLException;

    List<Horario> obtenerHorariosPorDeporte(int deporteId) throws SQLException;

    List<Horario> obtenerTodosLosHorarios() throws SQLException;

    void actualizarHorario(Horario horario) throws SQLException;

    void eliminarHorario(int id) throws SQLException;
    
    List<Horario> obtenerHorariosPorEntrenador(int entrenadorId) throws SQLException;
}
