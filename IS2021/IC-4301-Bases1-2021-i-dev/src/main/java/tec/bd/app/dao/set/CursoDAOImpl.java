package tec.bd.app.dao.set;

import tec.bd.app.dao.CursoDAO;
import tec.bd.app.database.set.Row;
import tec.bd.app.database.set.RowAttribute;
import tec.bd.app.database.set.SetDB;

import tec.bd.app.domain.Curso;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class CursoDAOImpl  extends GenericSetDAOImpl<Curso, Integer> implements CursoDAO {

    public CursoDAOImpl(SetDB setDB, Class<Curso> clazz) {
        super(setDB, clazz);
    }

    @Override
    public List<Curso> findByDepartment(String departamento) {

        /* -> Recolectamos en "estudiantes" la lista de estudiantes que exista.
         * -> Creamos un array para almacenar la lista de los distintos estudiantes con ese Apellido
         * -> Recorremos el List para preguntar si existen coincidencias de apellido, si lo hay, rellenamos el array.
         * -> Cuando el ciclo termine, retornames el array.
         */

        var cursos =  this.table.stream().map(this::rowToEntity).collect(Collectors.toList());
        ArrayList<Curso> listaPorCuros = new ArrayList<>();
        for (Curso actual : cursos) {
            if (actual.getDepartamento().equals(departamento)) {
                listaPorCuros.add(actual);
            }
        }
        return listaPorCuros.stream().collect(Collectors.toList());
    }

    @Override
    protected Curso rowToEntity(Row row) {
        // conversiones de Row a Curso
        var id = row.intAttributeValue("id");
        var nombre = row.stringAttributeValue("nombre");
        var creditos = row.intAttributeValue("creditos");
        var departamento = row.stringAttributeValue("departamento");
        return new Curso(id, nombre, creditos, departamento);
    }

    @Override
    protected Row entityToRow(Curso e) {
        // conversiones de Curso a Row
        return new Row(new RowAttribute[] {
                new RowAttribute("id", e.getId()),
                new RowAttribute("nombre", e.getNombre()),
                new RowAttribute("creditos", e.getCreditos()),
                new RowAttribute("departamento", e.getDepartamento())
        });
    }

}
