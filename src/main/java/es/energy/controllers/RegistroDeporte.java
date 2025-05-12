/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package es.energy.controllers;

import es.energy.DAO.IDeporteDAO;
import es.energy.DAO.IHorarioDAO;
import es.energy.DAO.IUsuarioDAO;
import es.energy.DAOFactory.DAOFactory;
import es.energy.beans.Deporte;
import es.energy.beans.Horario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author zapat
 */
@WebServlet(name = "RegistroDeporte", urlPatterns = {"/RegistroDeporte"})
public class RegistroDeporte extends HttpServlet {

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
        IDeporteDAO deporteDAO = daoFactory.getDeporteDAO();
        IHorarioDAO horarioDAO = daoFactory.getHorarioDAO();
        Deporte deporte = new Deporte();
        Horario horario = new Horario();
        if(request.getParameter("confirmarInscripcion")!=null){
            try {
                deporte= deporteDAO.obtenerDeportePorNombre(request.getParameter("selectedSport"));
                horario= horarioDAO.obtenerHorarioPorIdDeporte(deporte.getId());
                if(horario!=null){
                    request.setAttribute("horario", horario);
                    request.setAttribute("deporte", deporte);
                    request.setAttribute("deporte", deporte);
                    
                    url="JSP/formulario/inscripcion.jsp";
                }else{
                    request.setAttribute("DeportesVacios", "El deporte que se ha seleccionado no dispone horarios");
                }
            } catch (SQLException ex) {
                Logger.getLogger(RegistroDeporte.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
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
