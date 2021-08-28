package tec.bd.app.dao.set;

import tec.bd.app.dao.ProfesorDAO;
import tec.bd.app.database.set.Row;
import tec.bd.app.database.set.RowAttribute;
import tec.bd.app.database.set.SetDB;

import tec.bd.app.domain.Profesor;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

public class ProfesorDAOImpl  extends  GenericSetDAOImpl<Profesor, Integer> implements ProfesorDAO {

    public ProfesorDAOImpl(SetDB setDB, Class<Profesor> clazz) {
        super(setDB, clazz);
    }

    @Override
    public List<Profesor> findByCity(String ciudad) {

        var profesores =  this.table.stream().map(this::rowToEntity).collect(Collectors.toList());

        ArrayList<Profesor> listaPorCiudad = new ArrayList<>();

        for (Profesor actual : profesores) {
            if (actual.getCiudad().equals(ciudad)) {
                listaPorCiudad.add(actual);
            }
        }
        if (listaPorCiudad.isEmpty()){
            return Collections.emptyList();
        }
        else{
            return listaPorCiudad.stream().collect(Collectors.toList());
        }
    }

    @Override
    protected Profesor rowToEntity(Row row) {
        // conversiones de Row a Curso
        var id = row.intAttributeValue("id");
        var nombre = row.stringAttributeValue("nombre");
        var apellido = row.stringAttributeValue("apellido");
        var ciudad = row.stringAttributeValue("ciudad");
        return new Profesor(id, nombre, apellido, ciudad);
    }

    @Override
    protected Row entityToRow(Profesor e) {
        // conversiones de Profesor a Row
        return new Row(new RowAttribute[] {
                new RowAttribute("id", e.getId()),
                new RowAttribute("nombre", e.getNombre()),
                new RowAttribute("apellido", e.getApellido()),
                new RowAttribute("ciudad", e.getCiudad())
        });
    }

}
