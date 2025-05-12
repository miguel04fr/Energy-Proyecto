package es.energy.DAO;

import java.sql.SQLException;
import java.util.List;

import es.energy.beans.Sala;

public interface ISalaDAO {
    public List<Sala> obtenerTodasLasSalas() throws SQLException;
    public Sala obtenerSalaPorId(int id) throws SQLException;
    public void insertar(Sala sala) throws SQLException;
    public void actualizar(Sala sala) throws SQLException;
    public void eliminar(int id) throws SQLException;
} 