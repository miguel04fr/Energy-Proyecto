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
import javax.servlet.http.HttpSession;

import es.energy.DAO.IDeporteDAO;
import es.energy.DAO.IHorarioDAO;
import es.energy.DAO.IInscripcionDAO;
import es.energy.DAO.ISalaDAO;
import es.energy.DAO.IUsuarioDAO;
import es.energy.DAOFactory.DAOFactory;
import es.energy.beans.Deporte;
import es.energy.beans.Horario;
import es.energy.beans.Inscripcion;
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
        HttpSession session = request.getSession();
        IHorarioDAO horarioDAO = daof.getHorarioDAO();
        IDeporteDAO deporteDAO = daof.getDeporteDAO();
        IUsuarioDAO usuarioDAO = daof.getUsurioDAO();
        IInscripcionDAO inscripcionDAO = daof.getInscripcionDAO();
        ISalaDAO salaDAO = daof.getSalaDAO();
        Horario horario = new Horario();
        List<Horario> listaHorarios = new ArrayList<>();
        List<Sala> listaSalas = new ArrayList<>();
        List<Usuario> listaUsuarios = new ArrayList<>();
        List<Usuario> listaEntrenadores = new ArrayList<>();
        List<Deporte> listaDeportes = new ArrayList<>();
        List<Inscripcion> listaInscripciones = new ArrayList<>();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");

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
            try {
                usuarioDAO.eliminar(gerenteId);
            } catch (SQLException ex) {
                Logger.getLogger(Delete.class.getName()).log(Level.SEVERE, null, ex);
            }
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
        } else if (request.getParameter("eliminarDeporte") != null) {
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
        } else if (request.getParameter("eliminarEntrenador") != null) {
            int entrenadorId = Integer.parseInt(request.getParameter("id"));
            try {
                usuarioDAO.eliminar(entrenadorId);
            } catch (SQLException ex) {
                Logger.getLogger(Delete.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                listaEntrenadores = usuarioDAO.obtenerUsuariosPorRolEntrenador();
                request.setAttribute("listaEntrenadores", listaEntrenadores);
                url = "JSP/gerente/modificarEntrenadores.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(Delete.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (request.getParameter("eliminarUsuario") != null) {
            int usuarioId = Integer.parseInt(request.getParameter("id"));
            try {
                usuarioDAO.eliminar(usuarioId);
            } catch (SQLException ex) {
                Logger.getLogger(Delete.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                listaUsuarios = usuarioDAO.obtenerUsuariosPorRolCliente();
                request.setAttribute("listaUsuarios", listaUsuarios);
                url = "JSP/gerente/altaBajaUsuarios.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(Delete.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        if (request.getParameter("cancelarInscripcion") != null) {
            int inscripcionId = Integer.parseInt(request.getParameter("inscripcionId"));
            int horarioId = Integer.parseInt(request.getParameter("horarioId"));
            try {
                inscripcionDAO.eliminarInscripcion(inscripcionId);
                request.setAttribute("mensaje", "Inscripción cancelada correctamente");
                listaInscripciones = inscripcionDAO.obtenerInscripcionesPorUsuario(usuario.getId());
                for (Inscripcion i : listaInscripciones) {
                    i.setHorario(horarioDAO.obtenerHorarioPorId(i.getHorarioId()));
                    i.setDeporte(deporteDAO.obtenerDeportePorId(i.getHorario().getDeporteId()));
                    i.setUsuario(usuarioDAO.obtenerUsuarioPorId(i.getHorario().getEntrenadorId()));
                }
                horario = horarioDAO.obtenerHorarioPorId(horarioId);
                horario.setPlazasOcupadas(horario.getPlazasOcupadas() - 1);
                horarioDAO.actualizarHorario(horario);
                request.setAttribute("listaInscripciones", listaInscripciones);
                url = "JSP/usuario/listarInscripciones.jsp";
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
