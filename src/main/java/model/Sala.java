package model;

public class Sala {

    private int id;
    private String nome;
    private String bloco;
    private int capacidade;
    private String recursos;
    private boolean ativa;

    public Sala() {
    }

    public Sala(String nome, String bloco, int capacidade, String recursos, boolean ativa) {
        this.nome = nome;
        this.bloco = bloco;
        this.capacidade = capacidade;
        this.recursos = recursos;
        this.ativa = ativa;
    }

    public Sala(int id, String nome, String bloco, int capacidade, String recursos, boolean ativa) {
        this.id = id;
        this.nome = nome;
        this.bloco = bloco;
        this.capacidade = capacidade;
        this.recursos = recursos;
        this.ativa = ativa;
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }
    public String getBloco() {
        return bloco;
    }
    public void setBloco(String bloco) {
        this.bloco = bloco;
    }
    public int getCapacidade() {
        return capacidade;
    }
    public void setCapacidade(int capacidade) {
        this.capacidade = capacidade;
    }
    public String getRecursos() {
        return recursos;
    }
    public void setRecursos(String recursos) {
        this.recursos = recursos;
    }
    public boolean isAtiva() {
        return ativa;
    }
    public void setAtiva(boolean ativa) {
        this.ativa = ativa;
    }
}
