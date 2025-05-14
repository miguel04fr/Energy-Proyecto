/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package es.energy.controllers;

import java.io.IOException;
import java.sql.SQLException;
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
import es.energy.DAO.IUsuarioDAO;
import es.energy.DAOFactory.DAOFactory;
import es.energy.beans.Deporte;
import es.energy.beans.Usuario;
import es.energy.models.Utils;

/**
 *
 * @author zapat
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {


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
        
        
        String url = "index.jsp";
        DAOFactory daof = DAOFactory.getDAOFactory();
        IUsuarioDAO uDAO = daof.getUsurioDAO();
        HttpSession session = request.getSession();
        IDeporteDAO deporteDAO = daof.getDeporteDAO();
        List<Deporte> listaDeportes;

            //El boton para aceder se llama de name "boton"
        if (request.getParameter("login") != null) {
            String email = request.getParameter("email");
            String passwordIngresada = request.getParameter("password");

            // Encriptar la contraseña ingresada
            String passwordEncriptada = Utils.md5(passwordIngresada);
            boolean existe = false;
            try {
                existe = uDAO.existeEmail(email);
            } catch (SQLException ex) {
                Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
            }

            if (existe) {

                Usuario usuario = null;
                try {
                    usuario = uDAO.getUsuarioByEmail(email);
                } catch (SQLException ex) {
                    Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
                }
                
                // Comparar las contraseñas encriptadas
                if (usuario.getClave().equals(passwordEncriptada)) {
                    session.setAttribute("usuarioLogueado", usuario);
                    if (usuario.getRol().equals(Usuario.Rol.ADMIN)||usuario.getRol().equals(Usuario.Rol.ENTRENADOR)) {
                        url = "JSP/admin/indexAdmin.jsp";
                    }else{
                        try {
                            listaDeportes = deporteDAO.obtenerTodosLosDeportes();
                            session.setAttribute("listaDeportes", listaDeportes);
                        } catch (SQLException ex) {
                            Logger.getLogger(FrontController.class.getName()).log(Level.SEVERE, null, ex);
                        }
                        url="index.jsp";
                    } 
                } else {
                    // Contraseña incorrecta
                    request.setAttribute("error", "El contraseña es incorrecta. Por favor, inténtelo de nuevo.");
                    request.setAttribute("tipoMensaje", "error");
                    url = "index.jsp";
                }
            } else {
                // Si el correo no existe
                request.setAttribute("error", "El email es incorrecto. Por favor, inténtelo de nuevo.");
                request.setAttribute("tipoMensaje", "error");
                    url = "index.jsp";
            }
        }else if (request.getParameter("logaout")!= null){
            session.invalidate();
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
