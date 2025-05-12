package es.energy.DAO;

import java.sql.SQLException;
import java.util.List;

import es.energy.beans.ReservasPista;

public interface IReservasPistaDAO {
    void agregarReservaPista(ReservasPista reservaPista) throws SQLException;
    ReservasPista obReservasPistaPorId(int id) throws SQLException;
    List<ReservasPista> obtenerTodasLasReservasPistas() throws SQLException;
    void actualizarReservaPista(ReservasPista reservaPista) throws SQLException;
    void eliminarReservaPista(int id) throws SQLException;
}