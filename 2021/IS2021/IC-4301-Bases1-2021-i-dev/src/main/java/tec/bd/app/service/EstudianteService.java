package tec.bd.app.service;

import tec.bd.app.domain.Estudiante;

import java.util.List;
import java.util.Optional;
import java.util.Date;

public interface EstudianteService {

    List<Estudiante> getAll();

    Optional<Estudiante> getById(int carne);

    void addNew(Estudiante e);

    Optional<Estudiante> updateStudent(Estudiante e);

    void deleteStudent(int carne);

    List<Estudiante> getStudentsSortedByLastName();

    List<Estudiante> getStudentsByLastName(String lastName);
}
