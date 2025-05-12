package es.energy.beans;

public class EntrenadorDeporte {

    private int entrenadorId;
    private int deporteId;

    public EntrenadorDeporte() {
    }

    public EntrenadorDeporte(int entrenadorId, int deporteId) {
        this.entrenadorId = entrenadorId;
        this.deporteId = deporteId;
    }

    public int getEntrenadorId() {
        return entrenadorId;
    }

    public void setEntrenadorId(int entrenadorId) {
        this.entrenadorId = entrenadorId;
    }

    public int getDeporteId() {
        return deporteId;
    }

    public void setDeporteId(int deporteId) {
        this.deporteId = deporteId;
    }

    @Override
    public String toString() {
        return "EntrenadorDeporte{" +
                "entrenadorId=" + entrenadorId +
                ", deporteId=" + deporteId +
                '}';
    }
}
