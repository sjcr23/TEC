package tec.bd.app.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import tec.bd.app.dao.EstudianteDAO;
import tec.bd.app.domain.Estudiante;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.mockito.BDDMockito.*;

import static org.assertj.core.api.Assertions.*;

@ExtendWith(MockitoExtension.class)
public class EstudianteServiceImplTest {

    @Mock
    private EstudianteDAO estudianteDAO;

    @InjectMocks
    private EstudianteServiceImpl estudianteService;


    @BeforeEach
    public void setUp() throws Exception {

    }

    @Test
    public void whenNoDataInDB_thenNoResult() throws Exception {

        given(this.estudianteDAO.findAll()).willReturn(Collections.emptyList());

        var estudiantes = this.estudianteService.getAll();

        verify(this.estudianteDAO, times(1)).findAll();

        assertThat(estudiantes).hasSize(0);
    }

    @Test
    public void getAllTest() throws Exception {

        given(this.estudianteDAO.findAll()).willReturn(List.of(
                mock(Estudiante.class), mock(Estudiante.class), mock(Estudiante.class)
        ));

        var estudiantes = this.estudianteService.getAll();

        verify(this.estudianteDAO, times(1)).findAll();

        assertThat(estudiantes).hasSize(3);

    }

    @Test
    public void addNewStudent() throws Exception {

        /*
        En la primera invocacion va a devolver una lista de 3 estudiantes. En la segunda una lista de 4
         */
        given(this.estudianteDAO.findAll()).willReturn(
                List.of(mock(Estudiante.class), mock(Estudiante.class), mock(Estudiante.class)),
                List.of(mock(Estudiante.class), mock(Estudiante.class), mock(Estudiante.class), mock(Estudiante.class))
        );

        var studentsBeforeSave = this.estudianteService.getAll();

        var karol = new Estudiante(2, "Karol", "Jimenez", 21);
        estudianteService.addNew(karol);

        var studentsAfterSave = this.estudianteService.getAll();

        verify(this.estudianteDAO, times(1)).save(karol);
        assertThat(studentsAfterSave.size()).isGreaterThan(studentsBeforeSave.size());
    }

    @Test
    public void deleteStudent() throws Exception {

        /*
        En la primera invocacion va a devolver una lista de 3 estudiantes. En la segunda una lista de 2
         */
        given(this.estudianteDAO.findAll()).willReturn(
                List.of(mock(Estudiante.class), mock(Estudiante.class), mock(Estudiante.class)),
                List.of(mock(Estudiante.class), mock(Estudiante.class))
        );

        given(this.estudianteDAO.findById(anyInt())).willReturn(Optional.of(mock(Estudiante.class)));

        var studentsBeforeSave = this.estudianteService.getAll();

        estudianteService.deleteStudent(2);

        var studentsAfterSave = this.estudianteService.getAll();

        verify(this.estudianteDAO, times(1)).delete(2);
        assertThat(studentsAfterSave.size()).isLessThan(studentsBeforeSave.size());
    }

    @Test
    public void updateStudent() throws Exception {

        /*
        En la primera invocacion va a devolver estudiante default y en la segunda invocacion el estudiante actualizado
         */
        given(this.estudianteDAO.findById(anyInt())).willReturn(
                Optional.of(mock(Estudiante.class)),
                Optional.of(mock(Estudiante.class))
        );

        var studentBefore = this.estudianteService.getById(2);

        var karol = new Estudiante(2, "Karol", "Jimenez", 21);
        estudianteService.updateStudent(karol);

        var studentAfter = this.estudianteService.getById(2);

        verify(this.estudianteDAO, times(1)).update(karol);
        assertThat(studentAfter).isNotSameAs(studentBefore);
    }

    @Test
    public void getStudentsSortedByLastName() throws Exception {
        //TODO: hay que implementarlo
    }

    @Test
    public void getStudentsByLastName() throws Exception {
        //TODO: hay que implementarlo
    }

}