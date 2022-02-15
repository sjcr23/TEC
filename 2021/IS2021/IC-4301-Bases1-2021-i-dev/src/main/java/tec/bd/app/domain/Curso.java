package tec.bd.app.domain;

public class Curso implements Entity {

    private int id;
    private String nombre;
    private int creditos;
    private String departamento;

    public Curso(int id, String nombre, int creditos, String departamento) {
        this.id = id;
        this.nombre = nombre;
        this.creditos = creditos;
        this.departamento = departamento;
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDepartamento() {
        return departamento;
    }

    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }

    public int getCreditos() {
        return creditos;
    }

    public void setCreditos(int creditos) {
        this.creditos = creditos;
    }
}
