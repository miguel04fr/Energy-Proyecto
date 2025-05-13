package es.energy.DAO;

import java.sql.SQLException;
import java.util.List;

import es.energy.beans.Inscripcion;

/**
 *
 * @author zapat
 */
public interface IInscripcionDAO {
    void agregarInscripcion(Inscripcion inscripcion) throws SQLException;
    void actualizarInscripcion(Inscripcion inscripcion) throws SQLException;
    void eliminarInscripcion(int id) throws SQLException;
    Inscripcion obtenerInscripcionPorId(int id) throws SQLException;
    List<Inscripcion> obtenerTodasLasInscripciones() throws SQLException;
    List<Inscripcion> obtenerInscripcionesPorUsuario(int usuarioId) throws SQLException;
    List<Inscripcion> obtenerInscripcionesPorHorario(int horarioId) throws SQLException;
    Inscripcion obtenerInscripcionPorUsuarioYHorario(int usuarioId, int horarioId) throws SQLException;
} 