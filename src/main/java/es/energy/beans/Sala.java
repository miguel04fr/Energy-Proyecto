package es.energy.beans;

import java.io.Serializable;

public class Sala implements Serializable {
   private int idSala;
   private String descripcion;

   public Sala() {}

   public Sala(int idSala, String descripcion) {
      this.idSala = idSala;
      this.descripcion = descripcion;
   }

   public int getIdSala() {
      return idSala;
   }

   public void setIdSala(int idSala) {
      this.idSala = idSala;
   }

   public String getDescripcion() {
      return descripcion;
   }

   public void setDescripcion(String descripcion) {
      this.descripcion = descripcion;
   }
   
}
