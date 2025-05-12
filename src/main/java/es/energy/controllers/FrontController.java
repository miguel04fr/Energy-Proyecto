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
@WebServlet(name = "FrontController", urlPatterns = {"/FrontController"})
public class FrontController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "index.jsp";
        DAOFactory daof = DAOFactory.getDAOFactory();
        HttpSession session = request.getSession();
        IDeporteDAO deporteDAO = daof.getDeporteDAO();
        List<Deporte> listaDeportes;
        try {
            listaDeportes = deporteDAO.obtenerTodosLosDeportes();
            session.setAttribute("listaDeportes", listaDeportes);
        } catch (SQLException ex) {
            Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
        }
   
        request.getRequestDispatcher(url).forward(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "index.jsp";
        HttpSession session = request.getSession();
        DAOFactory daof = DAOFactory.getDAOFactory();
        List<Deporte> listaDeportes = new ArrayList<>();
        List<Usuario> listaEntrenadores = new ArrayList<>();
        List<Horario> listaHorarios = new ArrayList<>();
        List<Inscripcion> listaInscripciones = new ArrayList<>();
        List<Usuario> listaUsuarios = new ArrayList<>();
        List<Sala> listaSalas = new ArrayList<>();
        ISalaDAO salaDAO = daof.getSalaDAO();
        IHorarioDAO horarioDAO = daof.getHorarioDAO();
        IInscripcionDAO inscripcionDAO = daof.getInscripcionDAO();
        Deporte deporte = new Deporte();
        IDeporteDAO deporteDAO = daof.getDeporteDAO();
        IUsuarioDAO usuarioDAO = daof.getUsurioDAO();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");

        if (request.getParameter("crearInscripcion") != null) {

            try {
                listaEntrenadores = usuarioDAO.obtenerUsuariosPorRolEntrenador();
                listaDeportes = deporteDAO.obtenerTodosLosDeportes();
                request.setAttribute("listaDeportes", listaDeportes);
                request.setAttribute("listaEntrenadores", listaEntrenadores);
                listaSalas = salaDAO.obtenerTodasLasSalas();
                request.setAttribute("listaSalas", listaSalas);
                if (listaEntrenadores.isEmpty()) {
                    url = "notifay/notifay.jsp";

                } else {
                    url = "JSP/admin/crearInscripcion.jsp";

                }
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (request.getParameter("crearEntrenador") != null) {
            try {
                listaDeportes = deporteDAO.obtenerTodosLosDeportes();
                request.setAttribute("listaDeportes", listaDeportes);
                url = "JSP/admin/crearEntrenador.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }

        } else if (request.getParameter("inicio") != null) {
            url = "index.jsp";
        } else if (request.getParameter("consultarInscripcion") != null) {

            String nombreDeporte = request.getParameter("selectedSport");
            if (nombreDeporte.equals("Fútbol")) {
                url="JSP/usuario/reservarPista.jsp";
            } else {
                try {
                    deporte = deporteDAO.obtenerDeportePorNombre(request.getParameter("selectedSport"));
                    listaHorarios = horarioDAO.obtenerHorariosPorDeporte(deporte.getId());
                    for (Horario h : listaHorarios) {
                        h.setDeporte(deporte);
                        h.setUsuario(usuarioDAO.obtenerUsuarioPorId(h.getEntrenadorId()));
                    }
                    session.setAttribute("listaHorarios", listaHorarios);
                    session.setAttribute("deporte", deporte);
                    url = "JSP/inscripciones/confirmarInscripcion.jsp";
                } catch (SQLException ex) {
                    Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } else if (request.getParameter("listarDeportes") != null) {
            try {
                listaDeportes = deporteDAO.obtenerTodosLosDeportes();
                request.setAttribute("listaDeportes", listaDeportes);
                url = "JSP/admin/listarDeportes.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (request.getParameter("listarInscripciones") != null) {
            try {

                listaInscripciones = inscripcionDAO.obtenerInscripcionesPorUsuario(usuario.getId());
                for (Inscripcion i : listaInscripciones) {
                    i.setHorario(horarioDAO.obtenerHorarioPorId(i.getHorarioId()));
                    i.setDeporte(deporteDAO.obtenerDeportePorId(i.getHorario().getDeporteId()));
                    i.setUsuario(usuarioDAO.obtenerUsuarioPorId(i.getHorario().getEntrenadorId()));
                }
                request.setAttribute("listaInscripciones", listaInscripciones);
                url = "JSP/usuario/listarInscripciones.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (request.getParameter("listarHorarios") != null) {
            try {
                listaHorarios = horarioDAO.obtenerTodosLosHorarios();
                for (Horario h : listaHorarios) {
                    h.setDeporte(deporteDAO.obtenerDeportePorId(h.getDeporteId()));
                    h.setUsuario(usuarioDAO.obtenerUsuarioPorId(h.getEntrenadorId()));
                }
                request.setAttribute("listaHorarios", listaHorarios);
                url = "JSP/admin/verHorario.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (request.getParameter("listarEntrenadores") != null) {
            try {
                listaEntrenadores = usuarioDAO.obtenerUsuariosPorRolEntrenador();
                request.setAttribute("listaEntrenadores", listaEntrenadores);
                url = "JSP/admin/listarEntrenadores.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }

        } else if (request.getParameter("verHorario") != null) {
            try {
                listaHorarios = horarioDAO.obtenerTodosLosHorarios();
                // Cargar datos relacionados para cada horario
                for (Horario h : listaHorarios) {
                    if (h.getDeporteId() > 0) {
                        h.setDeporte(deporteDAO.obtenerDeportePorId(h.getDeporteId()));
                    }
                    if (h.getEntrenadorId() > 0) {
                        h.setUsuario(usuarioDAO.obtenerUsuarioPorId(h.getEntrenadorId()));
                    }
                }

                request.setAttribute("listaHorarios", listaHorarios);
                url = "JSP/admin/verHorario.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
                request.setAttribute("error", "Error al cargar los horarios: " + ex.getMessage());
                url = "JSP/error.jsp";
            }
        } else if (request.getParameter("cerrarSesion") != null) {
            session.invalidate();
            session = request.getSession();

            try {
                listaDeportes = deporteDAO.obtenerTodosLosDeportes();
                session.setAttribute("listaDeportes", listaDeportes);
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }
            url = "index.jsp";
        }  else if (request.getParameter("verHorariosEntrenador") != null) {
            try {
                Integer entrenadorId = Integer.parseInt(request.getParameter("verHorariosEntrenador"));
                listaHorarios = horarioDAO.obtenerHorariosPorEntrenador(entrenadorId);
                for (Horario h : listaHorarios) {
                    h.setDeporte(deporteDAO.obtenerDeportePorId(h.getDeporteId()));
                    h.setUsuario(usuarioDAO.obtenerUsuarioPorId(h.getEntrenadorId()));
                }
                request.setAttribute("listaHorarios", listaHorarios);
                url = "JSP/admin/verHorario.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (request.getParameter("editarDeporte") != null) {
            try {
                deporte = deporteDAO.obtenerDeportePorNombre(request.getParameter("selectedSport"));
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }
            url = "JSP/admin/editarDeporte.jsp";
        } else if (request.getParameter("crearGerenteAdmin") != null) {
            url = "JSP/admin/crearGerenteAdmin.jsp";
        } else if (request.getParameter("misHorarios") != null) {
            try {
                listaHorarios = horarioDAO.obtenerHorariosPorEntrenador(usuario.getId());
                request.setAttribute("listaHorarios", listaHorarios);
                url = "JSP/entrenador/verHorarios.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (request.getParameter("misAlumnos") != null) {
            try {
                listaUsuarios = usuarioDAO.obtenerUsuariosPorEntrenador(usuario.getId());
                request.setAttribute("listaUsuarios", listaUsuarios);
                url = "JSP/entrenador/verAlumnos.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (request.getParameter("modificarSalas") != null) {
            try {
                listaSalas = salaDAO.obtenerTodasLasSalas();
                request.setAttribute("listaSalas", listaSalas);
                url = "JSP/admin/modificarSalas.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (request.getParameter("eliminarGerente") != null) {
            try {
                listaUsuarios = usuarioDAO.obtenerUsuariosPorRolGerente();
                request.setAttribute("listaGerentes", listaUsuarios);
                if (listaUsuarios.isEmpty()) {
                    request.setAttribute("error", "No hay gerentes para eliminar");
                    url="JSP/admin/indexAdmin.jsp";
                } else {
                    url = "JSP/admin/eliminarGerente.jsp";
                }
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (request.getParameter("modificarDeportes") != null) {
            try {
                listaDeportes = deporteDAO.obtenerTodosLosDeportes();
                request.setAttribute("listaDeportes", listaDeportes);
                url = "JSP/admin/modificarDeportes.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }else if (request.getParameter("modificarEntrenadores") != null) {
            try {
                listaEntrenadores = usuarioDAO.obtenerUsuariosPorRolEntrenador();
                request.setAttribute("listaEntrenadores", listaEntrenadores);
                url = "JSP/gerente/modificarEntrenadores.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(request.getParameter("darAltaBaja") != null){
            try {
                listaUsuarios = usuarioDAO.obtenerUsuariosPorRolCliente();
                request.setAttribute("listaUsuarios", listaUsuarios);
                url = "JSP/gerente/altaBajaUsuarios.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
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
