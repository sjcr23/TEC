package tec.bd.app.dao.set;

import tec.bd.app.dao.EstudianteDAO;
import tec.bd.app.database.set.Row;
import tec.bd.app.database.set.RowAttribute;
import tec.bd.app.database.set.SetDB;

import tec.bd.app.domain.Estudiante;

import java.util.*;

import java.util.stream.Collectors;



public class EstudianteDAOImpl extends GenericSetDAOImpl<Estudiante, Integer> implements EstudianteDAO {

    public EstudianteDAOImpl(SetDB setDB, Class<Estudiante> clazz) {
        super(setDB, clazz);
    }

    @Override
    public List<Estudiante> findByLastName(String apellido) {

        var estudiantes =  this.table.stream().map(this::rowToEntity).collect(Collectors.toList());
        ArrayList<Estudiante> listaPorApellidos = new ArrayList<>();
        for (Estudiante actual : estudiantes) {
            if (actual.getApellido().equals(apellido)) {
                listaPorApellidos.add(actual);
            }
        }

        if (estudiantes.isEmpty()){
            return Collections.emptyList();
        }
        else {
            return listaPorApellidos.stream().collect(Collectors.toList());
        }
    }
    @Override
    public List<Estudiante> findAllSortByLastName() {

        List<Estudiante> estudiantes = this.table.stream().map(this::rowToEntity).collect(Collectors.toList());

        Comparator<Estudiante> comparator = (e1, e2) -> e1.getApellido().compareTo(e2.getApellido());

        estudiantes.sort(comparator);

        return estudiantes;
    }


    @Override
    protected Estudiante rowToEntity(Row row) {
        // conversiones de Row a Estudiante
        var id = row.intAttributeValue("id");
        var nombre = row.stringAttributeValue("nombre");
        var apellido = row.stringAttributeValue("apellido");
        var fechaNacimiento = row.stringAttributeValue("fecha_nacimiento");
        var creditos = row.intAttributeValue("total_creditos");
        return new Estudiante(id, nombre, apellido, fechaNacimiento, creditos);
    }

    @Override
    protected Row entityToRow(Estudiante e) {
        // conversiones de Estudiante a Row
        return new Row(new RowAttribute[] {
                new RowAttribute("id", e.getId()),
                new RowAttribute("nombre", e.getNombre()),
                new RowAttribute("apellido", e.getApellido()),
                new RowAttribute("fecha_nacimiento", e.getFechaNacimiento()),
                new RowAttribute("total_creditos", e.getTotalCreditos()),
        });
    }
}