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
import es.energy.utils.EmailUtil;

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
        Horario horario = new Horario();
        Inscripcion inscripcion = new Inscripcion();

        if (request.getParameter("crearInscripcion") != null) {

            try {
                listaEntrenadores = usuarioDAO.obtenerEntrenadoresActivos();
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
        } else if (request.getParameter("boletinFooter") != null) {
            String email = request.getParameter("emailFooter");
            String asunto = "Oferta de Energy";
            String contenido = "Hola,\n\n" +
                             "Gracias por suscribirte a nuestro boletín de noticias.\n\n" +
                             "En breve recibirás información sobre nuestros productos y servicios.\n\n" +
                             "¡Gracias por elegir Energy!";
            
            EmailUtil.enviarCorreo(email, asunto, contenido);
        } else if (request.getParameter("crearEntrenador") != null) {
            try {
                listaDeportes = deporteDAO.obtenerTodosLosDeportes();
                request.setAttribute("listaDeportes", listaDeportes);
                url = "JSP/admin/crearEntrenador.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }

        } else if (request.getParameter("inicio") != null) {
            try {
                listaDeportes = deporteDAO.obtenerTodosLosDeportes();
                session.setAttribute("listaDeportes", listaDeportes);
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }
            url = "index.jsp";
        } else if (request.getParameter("inicioAdmin") != null) {
            try {
                listaDeportes = deporteDAO.obtenerTodosLosDeportes();
                session.setAttribute("listaDeportes", listaDeportes);
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (request.getParameter("selectedSport") != null) {

            String nombreDeporte = request.getParameter("selectedSport");
            
            if (usuario!=null){
                try {
                    deporte = deporteDAO.obtenerDeportePorNombre(nombreDeporte);
    
                     listaHorarios = horarioDAO.obtenerHorariosPorDeporte(deporte.getId());
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
                    }
            }else{
                request.setAttribute("mensajeInicioSesion", "Debes iniciar sesión para ver los horarios de este deporte");
                request.setAttribute("error", "Tienes que iniciar sesion para ver los horarios");
                url= "index.jsp";
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
                usuario.setNumeroInscripcion(0);
                listaHorarios = horarioDAO.obtenerTodosLosHorarios();
                listaInscripciones = inscripcionDAO.obtenerInscripcionesPorUsuario(usuario.getId());
                for (Inscripcion i : listaInscripciones) {
                    usuario.setNumeroInscripcion(usuario.getNumeroInscripcion() + 1);
                }
                
                // Obtener todas las inscripciones del usuario para verificar horarios
                List<Inscripcion> inscripcionesUsuario = new ArrayList<>();
                if (session.getAttribute("usuarioLogueado") != null) {
                    Usuario usuarioActual = (Usuario) session.getAttribute("usuarioLogueado");
                    inscripcionesUsuario = inscripcionDAO.obtenerInscripcionesPorUsuario(usuarioActual.getId());
                    // Cargar los horarios para cada inscripción
                    for (Inscripcion insc : inscripcionesUsuario) {
                        if (insc != null) {
                            insc.setHorario(horarioDAO.obtenerHorarioPorId(insc.getHorarioId()));
                        }
                    }
                }
                
                for (Horario h : listaHorarios) {
                    h.setDeporte(deporteDAO.obtenerDeportePorId(h.getDeporteId()));
                    h.setUsuario(usuarioDAO.obtenerUsuarioPorId(h.getEntrenadorId()));

                    // Verificar si el usuario tiene una clase en el mismo día y hora
                    boolean tieneClaseEnMismoHorario = false;
                    if (session.getAttribute("usuarioLogueado") != null) {
                        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioLogueado");
                        for (Inscripcion insc : inscripcionesUsuario) {
                            if (insc != null && insc.getHorario() != null && 
                                insc.getHorario().getDiaSemana() != null && 
                                insc.getHorario().getHora() != null &&
                                insc.getHorario().getDiaSemana().equals(h.getDiaSemana()) && 
                                insc.getHorario().getHora().equals(h.getHora())) {
                                tieneClaseEnMismoHorario = true;
                                break;
                            }
                        }
                    }
                    h.setTieneClaseEnMismoHorario(tieneClaseEnMismoHorario);

                    // Obtener la inscripción específica para este horario
                    if (session.getAttribute("usuarioLogueado") != null) {
                        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioLogueado");
                        inscripcion = inscripcionDAO.obtenerInscripcionPorUsuarioYHorario(usuarioActual.getId(), h.getId());
                        if(inscripcion != null) {
                            inscripcion.setHorario(h);
                        }
                        h.setInscripcion(inscripcion);
                    }
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
                for (Horario h : listaHorarios) {
                    h.setDeporte(deporteDAO.obtenerDeportePorId(h.getDeporteId()));
                    h.setInscripciones(inscripcionDAO.obtenerInscripcionesPorHorario(h.getId()));
                }
                
                request.setAttribute("listaHorarios", listaHorarios);
                url = "JSP/entrenador/misHorarios.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (request.getParameter("misAlumnos") != null) {
            try {
                listaUsuarios= usuarioDAO.obtenerUsuariosPorEntrenador(usuario.getId());
            
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
                if (listaEntrenadores.isEmpty()) {
                    request.setAttribute("error", "No hay entrenadores para modificar");
                    url = "index.jsp";
                } else {
                    url = "JSP/gerente/modificarEntrenadores.jsp";
                }
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
        }else if (request.getParameter("verPerfil") != null){
            try {
                usuario = usuarioDAO.obtenerUsuarioPorId(usuario.getId());
                request.setAttribute("usuario", usuario);
                url = "JSP/usuario/perfil.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }else if (request.getParameter("verAlumnos") != null){
            int idhorario = Integer.parseInt(request.getParameter("idhorario"));
            try {
                listaInscripciones = inscripcionDAO.obtenerInscripcionesPorHorario(idhorario);
                for (Inscripcion i : listaInscripciones) {
                    i.setUsuario(usuarioDAO.obtenerUsuarioPorId(i.getUsuarioId()));
                    listaUsuarios.add(i.getUsuario());
                }
                request.setAttribute("listaUsuarios", listaUsuarios);
                url = "JSP/entrenador/verAlumnos.jsp";
            } catch (SQLException ex) {
                Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }else if (request.getParameter("crearCliente") != null){
            url = "JSP/gerente/crearCliente.jsp";
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
