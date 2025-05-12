/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package es.energy.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
@WebServlet(name = "Delete", urlPatterns = {"/Delete"})
public class Delete extends HttpServlet {

   
   

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
        ISalaDAO salaDAO = daof.getSalaDAO();
        List<Horario> listaHorarios = new ArrayList<>();
        List<Sala> listaSalas = new ArrayList<>();
        List<Usuario> listaUsuarios = new ArrayList<>();
        List<Usuario> listaEntrenadores = new ArrayList<>();
        List<Deporte> listaDeportes = new ArrayList<>();
       
        if (request.getParameter("eliminarHorario") != null) {
            int horarioId = Integer.parseInt(request.getParameter("horarioId"));
            try {
                horarioDAO.eliminarHorario(horarioId);
                request.setAttribute("mensaje", "Horario eliminado correctamente");
                listaHorarios = horarioDAO.obtenerTodosLosHorarios();
                for (Horario h : listaHorarios) {
                    h.setDeporte(deporteDAO.obtenerDeportePorId(h.getDeporteId()));
                    h.setUsuario(usuarioDAO.obtenerUsuarioPorId(h.getEntrenadorId()));
                }
                request.setAttribute("listaHorarios", listaHorarios);
            } catch (SQLException ex) {
                Logger.getLogger(Delete.class.getName()).log(Level.SEVERE, null, ex);
            }

            url = "JSP/admin/verHorario.jsp";
        }
        if (request.getParameter("eliminarSala") != null) {
            int salaId = Integer.parseInt(request.getParameter("idSala"));
            try {
                salaDAO.eliminar(salaId);
                request.setAttribute("mensaje", "Sala eliminada correctamente");
                listaSalas = salaDAO.obtenerTodasLasSalas();
                request.setAttribute("listaSalas", listaSalas);
                url = "JSP/admin/modificarSalas.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(Delete.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        if (request.getParameter("eliminarGerente") != null) {
            int gerenteId = Integer.parseInt(request.getParameter("gerenteId"));
            usuarioDAO.eliminar(gerenteId);
            try {
                listaUsuarios = usuarioDAO.obtenerUsuariosPorRolGerente();
                request.setAttribute("listaGerentes", listaUsuarios);
                if (listaUsuarios.isEmpty()) {
                    request.setAttribute("error", "No hay mas gerentes para eliminar");
                    url = "JSP/admin/indexAdmin.jsp";
                } else {
                    url = "JSP/admin/eliminarGerente.jsp";
                }
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }
            url = "JSP/admin/eliminarGerente.jsp";
        }
      else  if (request.getParameter("eliminarDeporte") != null) {
            try {
                int idDeporte = Integer.parseInt(request.getParameter("id"));
                deporteDAO.eliminarDeporte(idDeporte);
                request.setAttribute("mensaje", "Deporte eliminado correctamente");
                listaDeportes = deporteDAO.obtenerTodosLosDeportes();
                request.setAttribute("listaDeportes", listaDeportes);
                url = "JSP/admin/modificarDeportes.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(Delete.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
       else if (request.getParameter("eliminarEntrenador") != null) {
            int entrenadorId = Integer.parseInt(request.getParameter("id"));
            usuarioDAO.eliminar(entrenadorId);
            try {
                listaEntrenadores = usuarioDAO.obtenerUsuariosPorRolEntrenador();
                request.setAttribute("listaEntrenadores", listaEntrenadores);
                url = "JSP/gerente/modificarEntrenadores.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(Delete.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
     else   if (request.getParameter("eliminarUsuario") != null) {
            int usuarioId = Integer.parseInt(request.getParameter("id"));
            usuarioDAO.eliminar(usuarioId);
            try {
                listaUsuarios = usuarioDAO.obtenerUsuariosPorRolCliente();
                request.setAttribute("listaUsuarios", listaUsuarios);
                url = "JSP/gerente/altaBajaUsuarios.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(Delete.class.getName()).log(Level.SEVERE, null, ex);
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
