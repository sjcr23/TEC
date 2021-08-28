package tec.bd.app.dao;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import tec.bd.app.dao.set.GenericSetDAOImpl;
import tec.bd.app.database.set.Row;
import tec.bd.app.database.set.RowAttribute;
import tec.bd.app.database.set.SetDB;
import tec.bd.app.domain.Entity;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import static org.assertj.core.api.Assertions.*;

public class GenericSetDAOImplTest {

    private GenericSetDAOImpl<Greeting, Integer> genericSetDAO;

    @BeforeEach
    public void setUp() {

        Set<Row> greetingTable = new HashSet<>() {{
            add(new Row(new RowAttribute[]{
                    new RowAttribute("id", 200),
                    new RowAttribute("message", "Hello World!")
            }));
            add(new Row(new RowAttribute[]{
                    new RowAttribute("id", 100),
                    new RowAttribute("message", "Good Morning")
            }));
            add(new Row(new RowAttribute[]{
                    new RowAttribute("id", 300),
                    new RowAttribute("message", "Good Evening")
            }));
        }};

        SetDB setDB = new SetDB(Map.of(Greeting.class, greetingTable));


        this.genericSetDAO = new GenericSetDAOImpl<>(setDB, Greeting.class) {

            @Override
            protected Greeting rowToEntity(Row row) {
                var id = row.intAttributeValue("id");
                var message = row.stringAttributeValue("message");
                return new Greeting(id, message);
            }

            @Override
            protected Row entityToRow(Greeting e) {
                RowAttribute[] attributes = new RowAttribute[] {
                        new RowAttribute("id", e.getId()),
                        new RowAttribute("message", e.getMessage())
                };
                return new Row(attributes);
            }
        };

    }

    @Test
    public void findAll() throws Exception {
        var greetings = this.genericSetDAO.findAll();

        assertThat(greetings).isNotEmpty();
        assertThat(greetings).hasSize(3);
    }

    @Test
    public void findById() throws Exception {
        var greeting = this.genericSetDAO.findById(200);
        assertThat(greeting.isPresent()).isTrue();
        assertThat(greeting.get().getId()).isEqualTo(200);
        assertThat(greeting.get().getMessage()).isEqualTo("Hello World!");
    }

    @Test
    public void save() throws Exception {
        this.genericSetDAO.save(new Greeting(400, "I'm new here"));
        var newGreeting = this.genericSetDAO.findById(400);
        assertThat(this.genericSetDAO.findAll()).hasSize(4);
        assertThat(newGreeting.isPresent()).isTrue();
        assertThat(newGreeting.get().getId()).isEqualTo(400);
        assertThat(newGreeting.get().getMessage()).isEqualTo("I'm new here");
    }

    @Test
    public void update() throws Exception {
        var current = this.genericSetDAO.findById(300);
        current.get().setMessage("New message here :)");
        var actual = this.genericSetDAO.update(current.get());
        assertThat(this.genericSetDAO.findAll()).hasSize(3);
        assertThat(actual.get().getId()).isEqualTo(300);
        assertThat(actual.get().getMessage()).isEqualTo("New message here :)");
    }

    @Test
    public void delete() throws Exception {
        this.genericSetDAO.delete(200);
        assertThat(this.genericSetDAO.findAll()).hasSize(2);
    }

    class Greeting implements Entity {

        private Integer id;
        private String message;

        public Greeting(Integer id, String message) {
            this.id = id;
            this.message = message;
        }

        public Integer getId() {
            return this.id;
        }

        public String getMessage() {
            return this.message;
        }

        public void setMessage(String message) {
            this.message = message;
        }

    }

}
