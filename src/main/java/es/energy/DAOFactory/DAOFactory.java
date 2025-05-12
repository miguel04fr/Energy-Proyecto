package es.energy.DAOFactory;

import es.energy.DAO.IDeporteDAO;
import es.energy.DAO.IHorarioDAO;
import es.energy.DAO.IInscripcionDAO;
import es.energy.DAO.IReservasPistaDAO;
import es.energy.DAO.ISalaDAO;
import es.energy.DAO.IUsuarioDAO;

public abstract class DAOFactory {

    /**
     * Una clase abstracta por cada tabla de la base de datos
     *
     * @return Interface de las operaciones a realizar con la tabla
     */
    public abstract IUsuarioDAO getUsurioDAO();

    public abstract IDeporteDAO getDeporteDAO();

    public abstract IHorarioDAO getHorarioDAO();

    
    public abstract IInscripcionDAO getInscripcionDAO();


    public abstract ISalaDAO getSalaDAO();

    /**
     * Fábrica abstracta
     *
     * @return Objeto de la fábrica abstracta
     */
    public static DAOFactory getDAOFactory() {
        DAOFactory daof = null;
        daof = new MySQLDAOFactory();
        return daof;
    }
}
