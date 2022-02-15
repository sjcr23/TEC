package tec.bd.app.dao;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import tec.bd.app.dao.set.CursoDAOImpl;
import tec.bd.app.database.set.Row;
import tec.bd.app.database.set.RowAttribute;
import tec.bd.app.database.set.SetDB;
import tec.bd.app.domain.Curso;
import tec.bd.app.domain.Entity;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import static org.assertj.core.api.Assertions.*;


public class CursoDAOImplTest {

    private CursoDAOImpl cursoDAO;

    @BeforeEach
    public void setUp() throws Exception {

        var discretaId = new RowAttribute("id", 1);
        var discretaNombre = new RowAttribute("nombre", "MateDiscrta");
        var discretaCreditos = new RowAttribute("creditos", 4);
        var discretaDepartamento = new RowAttribute("departamento", "EscuelaDeMates");
        var discretaRow = new Row(new RowAttribute[]{ discretaId, discretaNombre, discretaCreditos, discretaDepartamento });

        var introID = new RowAttribute("id", 2);
        var introNombre = new RowAttribute("nombre", "IntroProgra");
        var introCreditos = new RowAttribute("creditos", 3);
        var introDepartamento = new RowAttribute("departamento", "EscuelaDeCompu");
        var introRow = new Row(new RowAttribute[]{ introID, introNombre, introCreditos, introDepartamento });

        var cdiID = new RowAttribute("id", 3);
        var cdiNombre = new RowAttribute("nombre", "CalculoDI");
        var cdiCreditos = new RowAttribute("creditos", 4);
        var cdiDepartamento = new RowAttribute("departamento", "EscuelaDeMates");
        var cdiRow = new Row(new RowAttribute[]{ cdiID, cdiNombre, cdiCreditos, cdiDepartamento });


        var tables = new HashMap<Class<? extends Entity>, Set<Row>>();
        tables.put(Curso.class, new HashSet<>() {{
            add(discretaRow);
            add(introRow);
            add(cdiRow);
        }});
        var setDB = new SetDB(tables);
        this.cursoDAO = new CursoDAOImpl(setDB, Curso.class);
    }

    @Test
    public void findAll() throws Exception {
        var actual = this.cursoDAO.findAll();
        assertThat(actual).hasSize(3);
    }

    @Test
    public void findById() throws Exception {
        var curso = this.cursoDAO.findById(1);
        assertThat(curso.get().getId()).isEqualTo(1);
        assertThat(curso.get().getNombre()).isEqualTo("MateDiscrta");
        assertThat(curso.get().getDepartamento()).isEqualTo("EscuelaDeMates");
        assertThat(curso.get().getCreditos()).isEqualTo(4);
    }

    @Test
    public void save() throws Exception {
        this.cursoDAO.save(new Curso(4, "Musica", 3, "Cultura"));
        var curso = this.cursoDAO.findById(4);
        assertThat(this.cursoDAO.findAll()).hasSize(4);
        assertThat(curso.isPresent()).isTrue();
        assertThat(curso.get().getId()).isEqualTo(4);
        assertThat(curso.get().getNombre()).isEqualTo("Musica");
        assertThat(curso.get().getDepartamento()).isEqualTo("Cultura");
        assertThat(curso.get().getCreditos()).isEqualTo(3);
    }

    @Test
    public void update() throws Exception {
        var current = this.cursoDAO.findById(3);
        current.get().setDepartamento("Servicio Social");
        current.get().setCreditos(1);
        var actual = this.cursoDAO.update(current.get());
        assertThat(this.cursoDAO.findAll()).hasSize(3);
        assertThat(actual.get().getId()).isEqualTo(3);
        assertThat(actual.get().getNombre()).isEqualTo("CalculoDI");
        assertThat(actual.get().getDepartamento()).isEqualTo("Servicio Social");
        assertThat(actual.get().getCreditos()).isEqualTo(1);
    }

    @Test
    public void delete() throws Exception {
        this.cursoDAO.delete(2);
        assertThat(this.cursoDAO.findAll()).hasSize(2);
    }
}