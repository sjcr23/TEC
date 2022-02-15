package tec.bd.app.service;

import tec.bd.app.domain.Curso;

import java.util.List;
import java.util.Optional;

public interface CursoService {
    List<Curso> getAll();

    Optional<Curso> getById(int id);

    void addNew(Curso e);

    Optional<Curso> updateCurse(Curso e);

    void deleteCurse(int carne);

    List<Curso> getByDepartment(String department);

}