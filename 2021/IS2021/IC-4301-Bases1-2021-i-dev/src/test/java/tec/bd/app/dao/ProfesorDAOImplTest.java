package tec.bd.app.dao;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import tec.bd.app.dao.set.ProfesorDAOImpl;
import tec.bd.app.database.set.Row;
import tec.bd.app.database.set.RowAttribute;
import tec.bd.app.database.set.SetDB;
import tec.bd.app.domain.Entity;
import tec.bd.app.domain.Profesor;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;

public class ProfesorDAOImplTest {

    private ProfesorDAOImpl profesorDAO;

    @BeforeEach
    public void setUp() throws Exception {

        var profe1Id = new RowAttribute("id", 1);
        var profe1Nombre = new RowAttribute("nombre", "Aurelio");
        var profe1Creditos = new RowAttribute("apellido", "Sanabri");
        var profe1Departamento = new RowAttribute("ciudad", "LaCangreja");
        var profe1Row = new Row(new RowAttribute[]{ profe1Id, profe1Nombre, profe1Creditos, profe1Departamento });

        var profe2ID = new RowAttribute("id", 2);
        var profe2Nombre = new RowAttribute("nombre", "Arnoldo");
        var profe2Creditos = new RowAttribute("apellido", "Ramos");
        var profe2Departamento = new RowAttribute("ciudad", "Curridabat");
        var profe2Row = new Row(new RowAttribute[]{ profe2ID, profe2Nombre, profe2Creditos, profe2Departamento });

        var profe3ID = new RowAttribute("id", 3);
        var profe3Nombre = new RowAttribute("nombre", "Eddy");
        var profe3Creditos = new RowAttribute("apellido", "Ramirez");
        var profe3Departamento = new RowAttribute("ciudad", "SantoDomingo");
        var profe3Row = new Row(new RowAttribute[]{ profe3ID, profe3Nombre, profe3Creditos, profe3Departamento });


        var tables = new HashMap<Class<? extends Entity>, Set<Row>>();
        tables.put(Profesor.class, new HashSet<>() {{
            add(profe1Row);
            add(profe2Row);
            add(profe3Row);

        }});
        var setDB = new SetDB(tables);
        this.profesorDAO = new ProfesorDAOImpl(setDB, Profesor.class);
    }


    @Test
    public void findAll() throws Exception {
        var actual = this.profesorDAO.findAll();
        assertThat(actual).hasSize(3);
    }

    @Test
    public void findById() throws Exception {
        var profesor = this.profesorDAO.findById(3);
        assertThat(profesor.get().getId()).isEqualTo(3);
        assertThat(profesor.get().getNombre()).isEqualTo("Eddy");
        assertThat(profesor.get().getApellido()).isEqualTo("Ramirez");
        assertThat(profesor.get().getCiudad()).isEqualTo("SantoDomingo");
    }

    @Test
    public void save() throws Exception {
        this.profesorDAO.save(new Profesor(6, "Martin", "Flores", "Heredia"));
        var profesor = this.profesorDAO.findById(6);
        assertThat(this.profesorDAO.findAll()).hasSize(4);
        assertThat(profesor.isPresent()).isTrue();
        assertThat(profesor.get().getId()).isEqualTo(6);
        assertThat(profesor.get().getNombre()).isEqualTo("Martin");
        assertThat(profesor.get().getApellido()).isEqualTo("Flores");
        assertThat(profesor.get().getCiudad()).isEqualTo("Heredia");
    }

    @Test
    public void update() throws Exception {

        var profesor = this.profesorDAO.findById(3);
        profesor.get().setApellido("Rodriguez");
        profesor.get().setCiudad("Perez Zeledon");
        var actual = this.profesorDAO.update(profesor.get());
        assertThat(actual.get().getId()).isEqualTo(3);
        assertThat(actual.get().getNombre()).isEqualTo("Eddy");
        assertThat(actual.get().getApellido()).isEqualTo("Rodriguez");
        assertThat(actual.get().getCiudad()).isEqualTo("Perez Zeledon");
    }

    @Test
    public void delete() throws Exception {
        this.profesorDAO.delete(2);
        assertThat(this.profesorDAO.findAll()).hasSize(2);
    }
}
