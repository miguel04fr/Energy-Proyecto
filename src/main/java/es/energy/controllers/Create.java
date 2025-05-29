/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package es.energy.controllers;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.sql.Time;
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
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;

import es.energy.DAO.IDeporteDAO;
import es.energy.DAO.IHorarioDAO;
import es.energy.DAO.IInscripcionDAO;
import es.energy.DAO.ISalaDAO;
import es.energy.DAO.IUsuarioDAO;
import es.energy.DAOFactory.DAOFactory;
import es.energy.beans.Deporte;
import es.energy.beans.Horario;
import es.energy.beans.Inscripcion;
import es.energy.beans.ReservasPista;
import es.energy.beans.Sala;
import es.energy.beans.Usuario;
import es.energy.converters.TimeConverter;
import es.energy.models.Utils;
import es.energy.utils.EmailUtil;


/**
 *
 * @author zapat
 */
@WebServlet(name = "Create", urlPatterns = {"/Create"})
public class Create extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
        String url = "."; // Valor por defecto
        DAOFactory daoFactory = DAOFactory.getDAOFactory();
        IUsuarioDAO usuarioDAO = daoFactory.getUsurioDAO();
        IDeporteDAO deporteDAO = daoFactory.getDeporteDAO();
        IHorarioDAO horarioDAO = daoFactory.getHorarioDAO();
        IInscripcionDAO inscripcionDAO = daoFactory.getInscripcionDAO();
        ISalaDAO salaDAO = daoFactory.getSalaDAO();
        Deporte deporte = new Deporte();
        Sala sala = new Sala();
        Horario horario = new Horario();
        Usuario usuario = new Usuario();
        Inscripcion inscripcion = new Inscripcion();
        ReservasPista reservaPista = new ReservasPista();
        List<Inscripcion> listaInscripciones = new ArrayList<>();
        List<Usuario> listaEntrenadores = new ArrayList<>();
        List<Horario> listaHorarios = new ArrayList<>();
        List<Sala> listaSalas = new ArrayList<>();
        List<Deporte> listaDeportes = new ArrayList<>();
        String telefono = request.getParameter("telefono");

        HttpSession session = request.getSession();
        try {
            // Si el parámetro "registro" está presente, se procesa el registro del usuario
            if (request.getParameter("registrase") != null || request.getParameter("crearCliente") != null) {
                DateConverter converter = new DateConverter();
                converter.setPattern("yyyy-MM-dd");
                ConvertUtils.register(converter, Date.class);
                usuario.setRol(Usuario.Rol.USUARIO);
                usuario.setActivo(false);
                BeanUtils.populate(usuario, request.getParameterMap());
                request.setAttribute("usuario", usuario);
                try {
                    // Verificar duplicados antes de insertar
                    if (usuarioDAO.existeEmail(usuario.getEmail())) {
                        request.setAttribute("tipoMensaje", "error");
                        request.setAttribute("error", "El email ya está registrado en el sistema");
                        url = "index.jsp";
                    } else if (usuarioDAO.existeDNI(usuario.getDni())) {
                        request.setAttribute("tipoMensaje", "error");
                        request.setAttribute("error", "El DNI ya está registrado en el sistema");
                        url = "index.jsp";
                    } else if (usuarioDAO.existeIBAN(usuario.getIban())) {
                        request.setAttribute("tipoMensaje", "error");
                        request.setAttribute("error", "El IBAN ya está registrado en el sistema");
                        url = "index.jsp";
                    } else {
                        request.setAttribute("success", "Usuario creado correctamente");
                        String asunto = "Confirmación de Inscripción - Energy";
                        String contenido = "Hola " + usuario.getNombre() + ",\n\n" +
                                         "Se ha creado una cuenta en Energy muchas gracias por su confianza\n" +
                                      
                                         "¡Gracias por elegir Energy!";
                        
                        EmailUtil.enviarCorreo(usuario.getEmail(), asunto, contenido);
                        // Encriptar la contraseña
                        usuario.setClave(Utils.md5(usuario.getClave()));
                        usuarioDAO.insertar(usuario);
                        url = "index.jsp";
                    }
                } catch (SQLException e) {
                    // Guardar el error y los datos del formulario en la sesión
                    request.setAttribute("tipoMensaje", "error");
                    request.setAttribute("error", e.getMessage());
                    url = "index.jsp";
                }
            } else if (request.getParameter("crearInscripcion") != null) {
                // Registrar convertidor para Time
                listaEntrenadores = usuarioDAO.obtenerUsuariosPorRolEntrenador();
                if(listaEntrenadores.isEmpty()){
                    request.setAttribute("errorMessage", "No hay entrenadores disponibles");
                    url = "JSP/admin/verHorario.jsp";
                }else{
                    ConvertUtils.register(new TimeConverter(), Time.class);
                    BeanUtils.populate(deporte, request.getParameterMap());
                    BeanUtils.populate(horario, request.getParameterMap());
                try {
                  
                    deporte = deporteDAO.obtenerDeportePorNombre(deporte.getNombreDeporte());
                    horario.setDeporteId(deporte.getId());
                    horario.setHora(Time.valueOf(request.getParameter("hora") + ":00"));
                    
                    horarioDAO.agregarHorario(horario);

                    listaHorarios = horarioDAO.obtenerTodosLosHorarios();
                for (Horario h : listaHorarios) {
                    h.setDeporte(deporteDAO.obtenerDeportePorId(h.getDeporteId()));
                    h.setUsuario(usuarioDAO.obtenerUsuarioPorId(h.getEntrenadorId()));
                }
                    request.setAttribute("listaHorarios", listaHorarios);
                    url= "JSP/admin/verHorario.jsp";
                } catch (SQLException ex) {
                        Logger.getLogger(Create.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

            } else if (request.getParameter("crearEntrenador") != null) {
                DateConverter converter = new DateConverter();
                converter.setPattern("yyyy-MM-dd");
                ConvertUtils.register(converter, Date.class);
                usuario.setRol(Usuario.Rol.ENTRENADOR);
                BeanUtils.populate(usuario, request.getParameterMap());
                try {
                    usuario.setClave(Utils.md5(usuario.getClave()));
                    usuarioDAO.insertar(usuario);
                    url = "JSP/admin/listarEntrenadores.jsp";
                } catch (SQLException e) {
                    request.setAttribute("error", e.getMessage());
                    url = "JSP/admin/crearEntrenador.jsp";
                }
                listaEntrenadores = usuarioDAO.obtenerUsuariosPorRolEntrenador();
                request.setAttribute("listaEntrenadores", listaEntrenadores);

            } else if (request.getParameter("confirmarInscripcion") != null) {
                BeanUtils.populate(inscripcion, request.getParameterMap());
                Usuario usuarioInscrito = (Usuario) session.getAttribute("usuarioLogueado");
                inscripcion.setUsuarioId(usuarioInscrito.getId());
                inscripcion.setFechaInscripcion(new java.sql.Date(new java.util.Date().getTime()));
                
                // Obtener información del usuario y el horario
                Horario horarioInscripcion = horarioDAO.obtenerHorarioPorId(inscripcion.getHorarioId());
                
                // Verificar si el usuario ya tiene una clase en el mismo horario
                List<Inscripcion> inscripcionesUsuario = inscripcionDAO.obtenerInscripcionesPorUsuario(usuarioInscrito.getId());
                boolean tieneClaseEnMismoHorario = false;
                
                for (Inscripcion insc : inscripcionesUsuario) {
                    if (insc != null) {
                        insc.setHorario(horarioDAO.obtenerHorarioPorId(insc.getHorarioId()));
                        if (insc.getHorario() != null && 
                            insc.getHorario().getDiaSemana() != null && 
                            insc.getHorario().getHora() != null &&
                            insc.getHorario().getDiaSemana().equals(horarioInscripcion.getDiaSemana()) && 
                            insc.getHorario().getHora().equals(horarioInscripcion.getHora())) {
                            tieneClaseEnMismoHorario = true;
                            break;
                        }
                    }
                }
                
                if (tieneClaseEnMismoHorario) {
                    request.setAttribute("errorMessage", "Ya tienes una clase programada en este horario");
                    url = "JSP/admin/verHorario.jsp";
                } else {
                    horarioInscripcion.setPlazasOcupadas(horarioInscripcion.getPlazasOcupadas() + 1);
                    horarioDAO.actualizarHorario(horarioInscripcion);
                    Deporte deporteInscripcion = deporteDAO.obtenerDeportePorId(horarioInscripcion.getDeporteId());
                    inscripcion.setDiaSemana(horarioInscripcion.getDiaSemana());
                    inscripcionDAO.agregarInscripcion(inscripcion);
                    // Enviar correo de confirmación
                    String asunto = "Confirmación de Inscripción - Energy";
                    String contenido = "Hola " + usuarioInscrito.getNombre() + ",\n\n" +
                                     "Tu inscripción ha sido confirmada:\n\n" +
                                     "Deporte: " + deporteInscripcion.getNombreDeporte() + "\n" +
                                     "Día: " + horarioInscripcion.getDiaSemana() + "\n" +
                                     "Hora: " + horarioInscripcion.getHora() + "\n" +
                                     "Sala: " + horarioInscripcion.getSalaId() + "\n\n" +
                                     "¡Gracias por elegir Energy!";
                    
                    EmailUtil.enviarCorreo(usuarioInscrito.getEmail(), asunto, contenido);
                    try {
                        listaInscripciones = inscripcionDAO.obtenerInscripcionesPorUsuario(usuarioInscrito.getId());
                        for (Inscripcion i : listaInscripciones) {
                            i.setHorario(horarioDAO.obtenerHorarioPorId(i.getHorarioId()));
                            i.setDeporte(deporteDAO.obtenerDeportePorId(i.getHorario().getDeporteId()));
                            i.setUsuario(usuarioDAO.obtenerUsuarioPorId(i.getHorario().getEntrenadorId()));
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(Create.class.getName()).log(Level.SEVERE, null, ex);
                    }   
                    request.setAttribute("listaInscripciones", listaInscripciones);
                    url = "JSP/usuario/listarInscripciones.jsp";
                }
            } else if (request.getParameter("crearGerenteAdmin") != null) {
                DateConverter converter = new DateConverter();
                converter.setPattern("yyyy-MM-dd");
                ConvertUtils.register(converter, Date.class);
                usuario.setRol(Usuario.Rol.GERENTE);
                BeanUtils.populate(usuario, request.getParameterMap());
                request.setAttribute("usuario", usuario);
                try {
                    // Encriptar la contraseña
                    usuario.setClave(Utils.md5(usuario.getClave()));
                    usuarioDAO.insertar(usuario);
                    url = "JSP/admin/indexAdmin.jsp";
                } catch (SQLException e) {
                    request.setAttribute("error", e.getMessage());
                    url = "JSP/admin/crearGerenteAdmin.jsp";
                }
            } else if (request.getParameter("crearSala") != null) {
                BeanUtils.populate(sala, request.getParameterMap());
                boolean existe = false;
                listaSalas = salaDAO.obtenerTodasLasSalas();
                request.setAttribute("listaSalas", listaSalas);

                for (Sala s : listaSalas) {
                    if (s.getIdSala() == sala.getIdSala()) {
                       request.setAttribute("mensajeErrorId", "La sala ya existe con el id " + sala.getIdSala());
                       existe = true;
                     
                    }
                }
                if(!existe){
                    salaDAO.insertar(sala);
                    listaSalas = salaDAO.obtenerTodasLasSalas();
                }
                request.setAttribute("listaSalas", listaSalas);

                url = "JSP/admin/modificarSalas.jsp";

            } else if (request.getParameter("crearDeporte") != null) {
               String nombreDeporte = request.getParameter("nombreDeporte");
               listaDeportes = deporteDAO.obtenerTodosLosDeportes();
                boolean existe = false;
                for(Deporte d : listaDeportes){
                    if(d.getNombreDeporte().equals(nombreDeporte)){
                        existe = true;
                    }
                }
                if(nombreDeporte.equals("") || existe){
                    request.setAttribute("mesajeErrorDeporte", "El nombre del deporte no puede estar vacío o ya existe");
                    request.setAttribute("listaDeportes", listaDeportes);
                    url = "JSP/admin/modificarDeportes.jsp";
                }else{
                    BeanUtils.populate(deporte, request.getParameterMap());
                    deporteDAO.agregarDeporte(deporte);
                    listaDeportes = deporteDAO.obtenerTodosLosDeportes();
                    request.setAttribute("listaDeportes", listaDeportes);
                    url = "JSP/admin/modificarDeportes.jsp";
                }
            } else {
                url = "errorPage.jsp";
            }
        } catch (IllegalAccessException | InvocationTargetException e) {
            // Si hubo un problema al acceder o invocar los métodos en BeanUtils
            Logger.getLogger(Create.class.getName()).log(Level.SEVERE, "Error al procesar los parámetros", e);
            url = "errorPage.jsp"; // Redirigimos a una página de error si ocurre una excepción
        } catch (SQLException ex) {
            Logger.getLogger(Create.class.getName()).log(Level.SEVERE, null, ex);
        }
        // Si ocurre un error con la base de datos
        // Redirigimos a una página de error si ocurre una excepción de SQL

        request.getRequestDispatcher(url).forward(request, response); // Redirigimos a la página correspondiente
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
