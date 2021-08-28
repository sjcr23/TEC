package tec.bd.app.dao;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import tec.bd.app.dao.set.EstudianteDAOImpl;
import tec.bd.app.database.set.Row;
import tec.bd.app.database.set.RowAttribute;
import tec.bd.app.database.set.SetDB;
import tec.bd.app.domain.Entity;
import tec.bd.app.domain.Estudiante;

import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import static org.assertj.core.api.Assertions.*;

public class EstudianteDAOImplTest {

    private EstudianteDAOImpl estudianteDAO;

    @BeforeEach
    public void setUp() throws Exception {

        var juanId = new RowAttribute("id", 1);
        var juanNombre = new RowAttribute("nombre", "Juan");
        var juanApellido = new RowAttribute("apellido", "Perez");
        var juanEdad = new RowAttribute("edad", 20);
        var juanRow = new Row(new RowAttribute[]{ juanId, juanNombre, juanApellido, juanEdad });

        var mariaId = new RowAttribute("id", 3);
        var mariaNombre = new RowAttribute("nombre", "Maria");
        var mariaApellido = new RowAttribute("apellido", "Rojas");
        var mariaEdad = new RowAttribute("edad", 21);
        var mariaRow = new Row(new RowAttribute[]{ mariaId, mariaNombre, mariaApellido, mariaEdad });

        var pedroId = new RowAttribute("id", 2);
        var pedroNombre = new RowAttribute("nombre", "Pedro");
        var pedroApellido = new RowAttribute("apellido", "Infante");
        var pedroEdad = new RowAttribute("edad", 23);
        var pedroRow = new Row(new RowAttribute[]{ pedroId, pedroNombre, pedroApellido, pedroEdad });

        var tables = new HashMap<Class<? extends Entity>, Set<Row>>();
        tables.put(Estudiante.class, new HashSet<>() {{
            add(juanRow);
            add(mariaRow);
            add(pedroRow);
        }});
        var setDB = new SetDB(tables);
        this.estudianteDAO = new EstudianteDAOImpl(setDB, Estudiante.class);
    }

    @Test
    public void orderByLastName() throws Exception {

        var estudiantes = this.estudianteDAO.findAll();
        Comparator<Estudiante> comparator
                = (e1, e2) -> e1.getApellido().compareTo(e2.getApellido());

        estudiantes.sort(comparator);
    }

    @Test
    public void findAll() throws Exception {
        var actual = this.estudianteDAO.findAll();
        assertThat(actual).hasSize(3);
    }

    @Test
    public void findById() throws Exception {
        var student = this.estudianteDAO.findById(3);
        assertThat(student.get().getCarne()).isEqualTo(3);
        assertThat(student.get().getNombre()).isEqualTo("Maria");
        assertThat(student.get().getApellido()).isEqualTo("Rojas");
        assertThat(student.get().getEdad()).isEqualTo(21);
    }

    @Test
    public void save() throws Exception {
        this.estudianteDAO.save(new Estudiante(40, "Jorge", "Chacon", 27));
        var estudiante = this.estudianteDAO.findById(40);
        assertThat(this.estudianteDAO.findAll()).hasSize(4);
        assertThat(estudiante.isPresent()).isTrue();
        assertThat(estudiante.get().getCarne()).isEqualTo(40);
        assertThat(estudiante.get().getNombre()).isEqualTo("Jorge");
        assertThat(estudiante.get().getApellido()).isEqualTo("Chacon");
        assertThat(estudiante.get().getEdad()).isEqualTo(27);
    }

    @Test
    public void update() throws Exception {
        var current = this.estudianteDAO.findById(3);
        current.get().setApellido("Rodriguez");
        current.get().setEdad(30);
        var actual = this.estudianteDAO.update(current.get());
        assertThat(this.estudianteDAO.findAll()).hasSize(3);
        assertThat(actual.get().getCarne()).isEqualTo(3);
        assertThat(actual.get().getNombre()).isEqualTo("Maria");
        assertThat(actual.get().getApellido()).isEqualTo("Rodriguez");
        assertThat(actual.get().getEdad()).isEqualTo(30);
    }

    @Test
    public void delete() throws Exception {
        this.estudianteDAO.delete(2);
        assertThat(this.estudianteDAO.findAll()).hasSize(2);
    }
}