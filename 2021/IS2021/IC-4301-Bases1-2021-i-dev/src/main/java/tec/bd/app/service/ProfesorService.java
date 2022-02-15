package tec.bd.app.service;
import tec.bd.app.domain.Profesor;
import java.util.List;
import java.util.Optional;
public interface ProfesorService {

    List<Profesor> getAll();

    Optional<Profesor> getById(int id);

    void addNew(Profesor e);

    Optional<Profesor> updateProfesor(Profesor e);

    void deleteProfesor(int carne);

    List<Profesor> findByCity(String ciudad);
}
