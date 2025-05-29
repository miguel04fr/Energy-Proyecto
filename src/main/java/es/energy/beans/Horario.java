/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package es.energy.beans;

import java.sql.Time;
import java.util.List;

/**
 *
 * @author zapat
 */
public class Horario {

    private int id;
    private int deporteId;
    private String diaSemana;
    private Time hora;
    private int salaId;
    private int entrenadorId;
    private int plazasOfertadas;
    private int plazasOcupadas;
    private Deporte deporte;
    private Usuario usuario;
    private Inscripcion inscripcion;
    private boolean tieneClaseEnMismoHorario;
    List<Inscripcion> inscripciones;

    public Horario() {
    }

    public Horario(int id, int deporteId, String diaSemana, Time hora, int salaId, int entrenadorId, int plazasOfertadas, int plazasOcupadas) {
        this.id = id;
        this.deporteId = deporteId;
        this.diaSemana = diaSemana;
        this.hora = hora;
        this.salaId = salaId;
        this.entrenadorId = entrenadorId;
        this.plazasOfertadas = plazasOfertadas;
        this.plazasOcupadas = plazasOcupadas;
    }

    public int getId() {
        return id;
    }

    
    public void setId(int id) {
        this.id = id;
    }

    public int getDeporteId() {
        return deporteId;
    }

    public void setDeporteId(int deporteId) {
        this.deporteId = deporteId;
    }

    public String getDiaSemana() {
        return diaSemana;
    }

    public void setDiaSemana(String diaSemana) {
        this.diaSemana = diaSemana;
    }

    public Time getHora() {
        return hora;
    }

    public void setHora(Time hora) {
        this.hora = hora;
    }

    public int getSalaId() {
        return salaId;
    }

    public void setSalaId(int salaId) {
        this.salaId = salaId;
    }

    public int getEntrenadorId() {
        return entrenadorId;
    }

    public void setEntrenadorId(int entrenadorId) {
        this.entrenadorId = entrenadorId;
    }

    public int getPlazasOfertadas() {
        return plazasOfertadas;
    }

    public void setPlazasOfertadas(int plazasOfertadas) {
        this.plazasOfertadas = plazasOfertadas;
    }

    public int getPlazasOcupadas() {
        return plazasOcupadas;
    }

    public void setPlazasOcupadas(int plazasOcupadas) {
        this.plazasOcupadas = plazasOcupadas;
    }

    public Deporte getDeporte() {
        return deporte;
    }

    public void setDeporte(Deporte deporte) {
        this.deporte = deporte;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
        }

    public Inscripcion getInscripcion() {
        return inscripcion;
    }

    public void setInscripcion(Inscripcion inscripcion) {
        this.inscripcion = inscripcion;
    }

    public boolean getTieneClaseEnMismoHorario() {
        return tieneClaseEnMismoHorario;
    }

    public void setTieneClaseEnMismoHorario(boolean tieneClaseEnMismoHorario) {
        this.tieneClaseEnMismoHorario = tieneClaseEnMismoHorario;
    }
    public List<Inscripcion> getInscripciones() {
        return inscripciones;
    }
    public void setInscripciones(List<Inscripcion> inscripciones) {
        this.inscripciones = inscripciones;
    }
}