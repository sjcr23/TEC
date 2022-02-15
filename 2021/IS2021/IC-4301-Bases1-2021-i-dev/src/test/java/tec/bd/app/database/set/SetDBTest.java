package tec.bd.app.database.set;

import org.junit.jupiter.api.Test;
import tec.bd.app.domain.Estudiante;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import static org.mockito.BDDMockito.*;
import static org.assertj.core.api.Assertions.*;

public class SetDBTest {

    @Test
    public void getTableByClassName_whenClassNotSupported_thenEmptySet() throws Exception {
        Set<Row> estudianteTable = mock(Set.class);
        SetDB setDB = new SetDB(Map.of(Estudiante.class, estudianteTable));

        // Para probar esto se puede pasar un clase que se sabe que no es suportada por el metodo
        var actual = setDB.getTableByClassName(HashSet.class);

        assertThat(actual).isEmpty();
    }

    @Test
    public void getTableByClassName() throws Exception {

        Set<Row> estudianteTable = mock(Set.class);
        SetDB setDB = new SetDB(Map.of(Estudiante.class, estudianteTable));

        var actual = setDB.getTableByClassName(Estudiante.class);

        assertThat(actual).isSameAs(estudianteTable);
    }
}
