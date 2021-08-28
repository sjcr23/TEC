package tec.bd.app.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import tec.bd.app.dao.ProfesorDAO;
import org.mockito.junit.jupiter.MockitoExtension;
import tec.bd.app.domain.Profesor;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.mockito.BDDMockito.*;

import static org.assertj.core.api.Assertions.*;

@ExtendWith(MockitoExtension.class)
public class ProfesorServiceImplTest {

    @Mock
    private ProfesorDAO profesorDAO;

    @InjectMocks
    private ProfesorServiceImpl profesorService;


    @BeforeEach
    public void setUp() throws Exception {

    }

    @Test
    public void whenNoDataInDB_thenNoResult() throws Exception {

        given(this.profesorDAO.findAll()).willReturn(Collections.emptyList());

        var profesores = this.profesorService.getAll();

        verify(this.profesorDAO, times(1)).findAll();

        assertThat(profesores).hasSize(0);
    }

    @Test
    public void getAllTest() throws Exception {

        given(this.profesorDAO.findAll()).willReturn(List.of(
                mock(Profesor.class), mock(Profesor.class), mock(Profesor.class)
        ));

        var profesores = this.profesorService.getAll();

        verify(this.profesorDAO, times(1)).findAll();

        assertThat(profesores).hasSize(3);

    }

    @Test
    public void addNewProffesor() throws Exception {

        /*
        En la primera invocacion va a devolver una lista de 3 estudiantes. En la segunda una lista de 4
         */
        given(this.profesorDAO.findAll()).willReturn(
                List.of(mock(Profesor.class), mock(Profesor.class), mock(Profesor.class)),
                List.of(mock(Profesor.class), mock(Profesor.class), mock(Profesor.class), mock(Profesor.class))
        );

        var proffesorsBeforeSave = this.profesorService.getAll();

        var karol = new Profesor(2, "Karol", "Jimenez", "Montenegro");
        profesorService.addNew(karol);

        var proffesorsAfterSave = this.profesorService.getAll();

        verify(this.profesorDAO, times(1)).save(karol);
        assertThat(proffesorsAfterSave.size()).isGreaterThan(proffesorsBeforeSave.size());
    }

    @Test
    public void deleteProffesor() throws Exception {

        /*
        En la primera invocacion va a devolver una lista de 3 estudiantes. En la segunda una lista de 2
         */
        given(this.profesorDAO.findAll()).willReturn(
                List.of(mock(Profesor.class), mock(Profesor.class), mock(Profesor.class)),
                List.of(mock(Profesor.class), mock(Profesor.class))
        );

        given(this.profesorDAO.findById(anyInt())).willReturn(Optional.of(mock(Profesor.class)));

        var proffesorsBeforeSave = this.profesorService.getAll();

        profesorService.deleteProfesor(2);

        var proffesorsAfterSave = this.profesorService.getAll();

        verify(this.profesorDAO, times(1)).delete(2);
        assertThat(proffesorsAfterSave.size()).isLessThan(proffesorsBeforeSave.size());
    }

    @Test
    public void updateProffesor() throws Exception {

        /*
        En la primera invocacion va a devolver estudiante default y en la segunda invocacion el estudiante actualizado
         */
        var profesorActual = mock(Profesor.class);
        given(this.profesorDAO.findById(anyInt())).willReturn(
                Optional.of(profesorActual),
                Optional.of(mock(Profesor.class))
        );

        var proffesorBefore = this.profesorService.getById(2);

        var karol = new Profesor(2, "Karol", "Jimenez", "MonteSierra");
        profesorService.updateProfesor(karol);

        var proffesorAfter = this.profesorService.getById(2);

        verify(this.profesorDAO, times(1)).update(karol);
        assertThat(proffesorAfter).isNotSameAs(proffesorBefore);
    }
}