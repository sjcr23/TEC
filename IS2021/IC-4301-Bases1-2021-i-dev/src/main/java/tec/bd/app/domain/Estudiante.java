package tec.bd.app.domain;
import java.util.Date;

public class Estudiante implements Entity {

    private int id;
    private String nombre;
    private String apellido;
    private String fecha_nacimiento;
    private int total_creditos;

    public Estudiante(int id, String nombre, String apellido, String fecha_nacimiento, int total_creditos) {
        this.id = id;
        this.nombre = nombre;
        this.apellido = apellido;
        this.fecha_nacimiento = fecha_nacimiento;
        this.total_creditos = total_creditos;
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

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public static int compareByLastname(Estudiante estudiante, Estudiante estudiante1) {
        return 0;
    }

    public String getFechaNacimiento() {
        return fecha_nacimiento;
    }

    public void setFechaNacimiento(String fecha_nacimiento) {
        this.fecha_nacimiento = fecha_nacimiento;
    }

    public int getTotalCreditos() {
        return total_creditos;
    }

    public void setTotalCreditos(int total_creditos) {
        this.total_creditos = total_creditos;
    }
}
