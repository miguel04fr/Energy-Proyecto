package es.energy.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import es.energy.DAO.IHorarioDAO;
import es.energy.DAO.IUsuarioDAO;
import es.energy.DAOFactory.DAOFactory;
import es.energy.beans.Horario;
import es.energy.beans.Usuario;

@WebServlet(name = "HorarioAjaxController", urlPatterns = {"/HorarioAjaxController"})
public class HorarioAjaxController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        String salaId = request.getParameter("salaId");
        String diaSemana = request.getParameter("diaSemana");
        String entrenadorId = request.getParameter("entrenadorId");
        String hora = request.getParameter("hora");
        
        try {
            DAOFactory daof = DAOFactory.getDAOFactory();
            IHorarioDAO horarioDAO = daof.getHorarioDAO();
            IUsuarioDAO usuarioDAO = daof.getUsurioDAO();
            List<Horario> horarios = horarioDAO.obtenerTodosLosHorarios();
            
            if ("validarHorario".equals(action)) {
                boolean horarioDisponible = true;
                String mensaje = "";
                
                // Verificar si ya existe un horario con el mismo entrenador, día y hora
                for (Horario h : horarios) {
                    if (h.getEntrenadorId() == Integer.parseInt(entrenadorId) && 
                        h.getDiaSemana().equals(diaSemana) && 
                        h.getHora().toString().equals(hora + ":00")) {
                        horarioDisponible = false;
                        mensaje = "El entrenador ya tiene una clase asignada en este horario";
                        break;
                    }
                }
                
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("disponible", horarioDisponible);
                jsonResponse.addProperty("mensaje", mensaje);
                response.getWriter().write(new Gson().toJson(jsonResponse));
                
            } else if ("getDiasDisponibles".equals(action)) {
                List<String> diasDisponibles = new ArrayList<>();
                String[] diasSemana = {"Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"};
                for (String dia : diasSemana) {
                    diasDisponibles.add(dia);
                }
                response.getWriter().write(new Gson().toJson(diasDisponibles));
                
            } else if ("getHorasDisponibles".equals(action)) {
                Set<String> horasOcupadas = new HashSet<>();
                
                // Verificar horarios ocupados por sala
                for (Horario h : horarios) {
                    if (h.getSalaId() == Integer.parseInt(salaId) && h.getDiaSemana().equals(diaSemana)) {
                        String horaInicio = h.getHora().toString();
                        int horaInicioInt = Integer.parseInt(horaInicio.split(":")[0]);
                        horasOcupadas.add(String.format("%02d:00", horaInicioInt));
                        horasOcupadas.add(String.format("%02d:00", horaInicioInt + 1));
                    }
                }
                
                // Verificar horarios ocupados por entrenador
                if (entrenadorId != null && !entrenadorId.isEmpty()) {
                    for (Horario h : horarios) {
                        if (h.getEntrenadorId() == Integer.parseInt(entrenadorId) && h.getDiaSemana().equals(diaSemana)) {
                            String horaInicio = h.getHora().toString();
                            int horaInicioInt = Integer.parseInt(horaInicio.split(":")[0]);
                            horasOcupadas.add(String.format("%02d:00", horaInicioInt));
                            horasOcupadas.add(String.format("%02d:00", horaInicioInt + 1));
                        }
                    }
                }
                
                List<String> horasDisponibles = new ArrayList<>();
                for (int horaActual = 8; horaActual <= 22; horaActual++) {
                    String horaStr = String.format("%02d:00", horaActual);
                    if (!horasOcupadas.contains(horaStr)) {
                        horasDisponibles.add(horaStr);
                    }
                }
                
                response.getWriter().write(new Gson().toJson(horasDisponibles));
            } else if ("getEntrenadoresActivos".equals(action)) {
                List<Usuario> entrenadoresActivos = usuarioDAO.obtenerEntrenadoresActivos();
                response.getWriter().write(new Gson().toJson(entrenadoresActivos));
            }
            
        } catch (SQLException | NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }
} 