package tec.bd.app.service;

import tec.bd.app.dao.CursoDAO;
import tec.bd.app.domain.Curso;


import java.util.List;
import java.util.Optional;

public class CursoServiceImpl implements  CursoService{

    private CursoDAO cursoDAO;

    public CursoServiceImpl (CursoDAO cursoDAO){
        this.cursoDAO = cursoDAO;
    }

    @Override
    public List<Curso> getAll() {
        return this.cursoDAO.findAll();
    }

    @Override
    public Optional<Curso> getById(int id) {

        //TODO: validar el carne > 0. Si no cumple con eso se devuelve Optional.empty()
        if(id < 0){
            return Optional.empty();
        }

        else{
            return this.cursoDAO.findById(id);
        }
    }

    @Override
    public void addNew(Curso e) {
        Optional<Curso> curso = this.cursoDAO.findById(e.getId());
        if(!curso.isPresent()) {
            this.cursoDAO.save(e);
        }
    }

    @Override
    public Optional<Curso> updateCurse(Curso e) {

        //TODO: validar que el ID exista en la BD. Si existe se actualiza
        var id = this.cursoDAO.findById(e.getId()).get().getId();
        if(e.getId() == id){
            return this.cursoDAO.update(e);
        }
        else{
             return Optional.empty();
        }
    }

    @Override
    public void deleteCurse(int id) {
        //TODO: validar que el ID exista en la BD. Si existe se borra

        if(id == this.cursoDAO.findById(id).get().getId()){
            this.cursoDAO.delete(id);
        }
        else{
            System.out.println("El estudiante no existe");
        }
    }

    @Override
    public List<Curso> getByDepartment(String department) {
        //TODO: implementarlo
        //validar que el department no sea nulo
        if(department != null){
            return this.cursoDAO.findByDepartment(department);
        }
        else{
            return null;
        }
    }
}