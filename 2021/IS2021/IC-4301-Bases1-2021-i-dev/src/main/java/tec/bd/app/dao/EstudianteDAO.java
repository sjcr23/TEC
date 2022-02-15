package tec.bd.app.dao;
import tec.bd.app.domain.Estudiante;
import java.util.Date;
import java.util.List;

public interface EstudianteDAO extends GenericDAO<Estudiante, Integer> {

    List<Estudiante> findByLastName(String lastName);

    List<Estudiante> findAllSortByLastName();
}