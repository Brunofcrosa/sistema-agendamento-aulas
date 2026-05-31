package model;

import java.sql.Date;
import java.sql.Time;

public class Reserva {

    private int id;
    private int salaId;
    private int docenteId;
    private String salaNome;
    private String docenteNome;
    private Date dataReserva;
    private Time horaInicio;
    private Time horaFim;
    private String finalidade;
    private String status;

    public Reserva() {
    }

    public Reserva(int salaId, int docenteId, Date dataReserva, Time horaInicio, Time horaFim, String finalidade, String status) {
        this.salaId = salaId;
        this.docenteId = docenteId;
        this.dataReserva = dataReserva;
        this.horaInicio = horaInicio;
        this.horaFim = horaFim;
        this.finalidade = finalidade;
        this.status = status;
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getSalaId() {
        return salaId;
    }
    public void setSalaId(int salaId) {
        this.salaId = salaId;
    }
    public int getDocenteId() {
        return docenteId;
    }
    public void setDocenteId(int docenteId) {
        this.docenteId = docenteId;
    }
    public String getSalaNome() {
        return salaNome;
    }
    public void setSalaNome(String salaNome) {
        this.salaNome = salaNome;
    }
    public String getDocenteNome() {
        return docenteNome;
    }
    public void setDocenteNome(String docenteNome) {
        this.docenteNome = docenteNome;
    }
    public Date getDataReserva() {
        return dataReserva;
    }
    public void setDataReserva(Date dataReserva) {
        this.dataReserva = dataReserva;
    }
    public Time getHoraInicio() {
        return horaInicio;
    }
    public void setHoraInicio(Time horaInicio) {
        this.horaInicio = horaInicio;
    }
    public Time getHoraFim() {
        return horaFim;
    }
    public void setHoraFim(Time horaFim) {
        this.horaFim = horaFim;
    }
    public String getFinalidade() {
        return finalidade;
    }
    public void setFinalidade(String finalidade) {
        this.finalidade = finalidade;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
}
