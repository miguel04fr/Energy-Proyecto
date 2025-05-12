package es.energy.controllers;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;

import es.energy.DAO.IDeporteDAO;
import es.energy.DAO.IHorarioDAO;
import es.energy.DAO.ISalaDAO;
import es.energy.DAO.IUsuarioDAO;
import es.energy.DAOFactory.DAOFactory;
import es.energy.beans.Deporte;
import es.energy.beans.Horario;
import es.energy.beans.Sala;
import es.energy.beans.Usuario;
/**
 *
 * @author zapat
 */
@WebServlet(name = "Update", urlPatterns = {"/Update"})
public class Update extends HttpServlet {

   
   

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            String url = "index.jsp";
        DAOFactory daof = DAOFactory.getDAOFactory();
        IHorarioDAO horarioDAO = daof.getHorarioDAO();
        IDeporteDAO deporteDAO = daof.getDeporteDAO();
        IUsuarioDAO usuarioDAO = daof.getUsurioDAO();
        Deporte deporte = new Deporte();
        Sala sala = new Sala();
        Usuario usuario = new Usuario();
        List<Deporte> listaDeportes = new ArrayList<>();
        List<Usuario> listaUsuarios = new ArrayList<>();
        List<Sala> listaSalas = new ArrayList<>();
        ISalaDAO salaDAO = daof.getSalaDAO();
        List<Horario> listaHorarios = new ArrayList<>();
        List<Usuario> listaEntrenadores = new ArrayList<>();
        Usuario entrenador = new Usuario();

        if (request.getParameter("actualizarSala") != null) {
                try {
                    BeanUtils.populate(sala, request.getParameterMap());
                } catch (IllegalAccessException ex) {
                    Logger.getLogger(Update.class.getName()).log(Level.SEVERE, null, ex);
                } catch (InvocationTargetException ex) {
                    Logger.getLogger(Update.class.getName()).log(Level.SEVERE, null, ex);
                }
            try {
                salaDAO.actualizar(sala);
                request.setAttribute("mensaje", "Sala actualizada correctamente");
                listaSalas = salaDAO.obtenerTodasLasSalas();
                request.setAttribute("listaSalas", listaSalas);
                url = "JSP/admin/modificarSalas.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(Delete.class.getName()).log(Level.SEVERE, null, ex);
            }

            url = "JSP/admin/modificarSalas.jsp";
        }else   if (request.getParameter("actualizarDeporte") != null) {
            try {
                BeanUtils.populate(deporte, request.getParameterMap());
                deporteDAO.actualizarDeporte(deporte);
                request.setAttribute("mensaje", "Deporte actualizado correctamente");
                listaDeportes = deporteDAO.obtenerTodosLosDeportes();
                request.setAttribute("listaDeportes", listaDeportes);
                url = "JSP/admin/modificarDeportes.jsp";
            } catch (IllegalAccessException | InvocationTargetException | SQLException ex) {
                Logger.getLogger(Update.class.getName()).log(Level.SEVERE, null, ex);
            }
        }else if (request.getParameter("cambiarEstadoUsuario") != null) {
           int id = Integer.parseInt(request.getParameter("id"));
           boolean activo = Boolean.TRUE;
           String cambiarEstado = request.getParameter("cambiarEstadoUsuario");
           if(cambiarEstado.equals("true")){
            activo = Boolean.TRUE;
           }else{
             activo = Boolean.FALSE;
           }
           try {
            usuarioDAO.cambiarEstado(id, activo);
            request.setAttribute("mensaje", "Estado del usuario actualizado correctamente");
            listaUsuarios = usuarioDAO.obtenerUsuariosPorRolCliente();
            request.setAttribute("listaUsuarios", listaUsuarios);
            url = "JSP/gerente/altaBajaUsuarios.jsp";
           } catch (SQLException ex) {
            Logger.getLogger(Update.class.getName()).log(Level.SEVERE, null, ex);
           }
           
        }else if (request.getParameter("cambiarEstadoEntrenador") != null) {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean activo = Boolean.TRUE;
            String cambiarEstado = request.getParameter("cambiarEstadoEntrenador");
            if(cambiarEstado.equals("true")){
             activo = Boolean.TRUE;
            }else{
              activo = Boolean.FALSE;
            }
            try {
             usuarioDAO.cambiarEstado(id, activo);
             request.setAttribute("mensaje", "Estado del usuario actualizado correctamente");
             listaEntrenadores = usuarioDAO.obtenerUsuariosPorRolEntrenador();
             request.setAttribute("listaEntrenadores", listaEntrenadores);
             url = "JSP/gerente/modificarEntrenadores.jsp";
            } catch (SQLException ex) {
             Logger.getLogger(Update.class.getName()).log(Level.SEVERE, null, ex);
            }
            
         }else if (request.getParameter("editarEntrenador") != null) {
            int id = Integer.parseInt(request.getParameter("id"));
             entrenador = usuarioDAO.obtenerUsuarioPorId(id);
            request.setAttribute("entrenador", entrenador);
            url = "JSP/gerente/editarEntrenador.jsp";
         }else if (request.getParameter("guardarEntrenador") != null) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                entrenador = usuarioDAO.obtenerUsuarioPorId(id);
                DateConverter converter = new DateConverter();
                converter.setPattern("yyyy-MM-dd");
                ConvertUtils.register(converter, Date.class);
                BeanUtils.populate(entrenador, request.getParameterMap());
                usuarioDAO.actualizar(entrenador);
                request.setAttribute("mensaje", "Entrenador actualizado correctamente");
                listaEntrenadores = usuarioDAO.obtenerUsuariosPorRolEntrenador();
                request.setAttribute("listaEntrenadores", listaEntrenadores);
                url = "JSP/gerente/modificarEntrenadores.jsp";
            } catch (IllegalAccessException | InvocationTargetException ex) {
                Logger.getLogger(Update.class.getName()).log(Level.SEVERE, null, ex);
            }   catch (SQLException ex) {
                    Logger.getLogger(Update.class.getName()).log(Level.SEVERE, null, ex);
                }
         }
        request.getRequestDispatcher(url).forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
