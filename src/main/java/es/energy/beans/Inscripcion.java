package es.energy.beans;

import java.sql.Date;

/**
 *
 * @author zapat
 */
public class Inscripcion {
    private int id;
    private int usuarioId;
    private int horarioId;
    private Date fechaInscripcion;
    private Usuario usuario;
    private Horario horario;
    private Deporte deporte;
    public Inscripcion() {
    }

    public Inscripcion(int id, int usuarioId, int horarioId, Date fechaInscripcion) {
        this.id = id;
        this.usuarioId = usuarioId;
        this.horarioId = horarioId;
        this.fechaInscripcion = fechaInscripcion;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(int usuarioId) {
        this.usuarioId = usuarioId;
    }

    public int getHorarioId() {
        return horarioId;
    }

    public void setHorarioId(int horarioId) {
        this.horarioId = horarioId;
    }

    public Date getFechaInscripcion() {
        return fechaInscripcion;
    }

    public void setFechaInscripcion(Date fechaInscripcion) {
        this.fechaInscripcion = fechaInscripcion;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Horario getHorario() {
        return horario;
    }

    public void setHorario(Horario horario) {
        this.horario = horario;
        }

    public Deporte getDeporte() {
        return deporte;
    }

    public void setDeporte(Deporte deporte) {
        this.deporte = deporte;
    }

    
} 
