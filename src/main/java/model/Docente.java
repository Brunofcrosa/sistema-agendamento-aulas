package model;

public class Docente {

    private int id;
    private String matricula;
    private String nome;

    public Docente() {
    }

    public Docente(String matricula, String nome) {
        this.matricula = matricula;
        this.nome = nome;
    }

    public Docente(int id, String matricula, String nome) {
        this.id = id;
        this.matricula = matricula;
        this.nome = nome;
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getMatricula() {
        return matricula;
    }
    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }
}
