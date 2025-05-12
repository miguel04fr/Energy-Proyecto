/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package es.energy.beans;

import java.io.Serializable;

/**
 *
 * @author zapat
 */


public class Deporte implements Serializable {
    private int id;
    private String nombreDeporte;
    private String descripcion;

    // Constructor vacío
    public Deporte() {}

    // Constructor con parámetros
    public Deporte(int id, String nombre, String descripcion) {
        this.id = id;
        this.nombreDeporte = nombre;
        this.descripcion = descripcion;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombreDeporte() {
        return nombreDeporte;
    }

    public void setNombreDeporte(String nombreDeporte) {
        this.nombreDeporte = nombreDeporte;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @Override
    public String toString() {
        return "Deporte{" + "id=" + id + ", nombre='" + nombreDeporte + '\'' + '}';
    }
}
