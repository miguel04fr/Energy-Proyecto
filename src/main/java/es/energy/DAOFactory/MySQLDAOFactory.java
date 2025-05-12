package es.energy.DAOFactory;

import es.energy.DAO.DeporteDAO;
import es.energy.DAO.HorarioDAO;
import es.energy.DAO.IDeporteDAO;
import es.energy.DAO.IHorarioDAO;
import es.energy.DAO.IInscripcionDAO;
import es.energy.DAO.IReservasPistaDAO;
import es.energy.DAO.IUsuarioDAO;
import es.energy.DAO.InscripcionDAO;
import es.energy.DAO.ReservasPistaDAO;
import es.energy.DAO.UsuarioDAO;
import es.energy.DAO.ISalaDAO;
import es.energy.DAO.SalaDAO;


/**
 * Fábrica concreta para la fuente de datos MySQL
 *
 * @autor jesus
 */
public class MySQLDAOFactory extends DAOFactory {
    @Override
    public IUsuarioDAO getUsurioDAO() {
        return new UsuarioDAO();
    }
 

    @Override
    public IDeporteDAO getDeporteDAO() {
        return new DeporteDAO();
    }

    @Override
    public IHorarioDAO getHorarioDAO() {
        return new HorarioDAO();
    }
    
    @Override
    public IInscripcionDAO getInscripcionDAO() {
        return new InscripcionDAO();
    }

    @Override
    public ISalaDAO getSalaDAO() {
        return new SalaDAO();
    }
}
