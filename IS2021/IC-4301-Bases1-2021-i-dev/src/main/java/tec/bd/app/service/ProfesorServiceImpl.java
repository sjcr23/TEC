package tec.bd.app.service;

import tec.bd.app.dao.ProfesorDAO;
import tec.bd.app.domain.Profesor;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

public class ProfesorServiceImpl implements ProfesorService{


    private ProfesorDAO profesorDAO;

    public ProfesorServiceImpl(ProfesorDAO profesorDAO){
        this.profesorDAO = profesorDAO;
    }

    @Override
    public List<Profesor> getAll() {
        return this.profesorDAO.findAll();
    }

    @Override
    public Optional<Profesor> getById(int id) {

        //TODO: validar el carne > 0. Si no cumple con eso se devuelve Optional.empty()

        if(id<0){
            return Optional.empty();
        }
        else{
            return this.profesorDAO.findById(id);
        }
    }

    public void addNew(Profesor e) {
        Optional<Profesor> profesor = this.profesorDAO.findById(e.getId());
        if(!profesor.isPresent()) {
            this.profesorDAO.save(e);
        }
    }

    public Optional<Profesor> updateProfesor(Profesor e) {

        //TODO: validar que el carne exista en la BD. Si existe se actualiza

        if(e.getId() == this.profesorDAO.findById(e.getId()).get().getId()){
            return this.profesorDAO.update(e);
        }
        else{
            return null;
        }
    }

    public void deleteProfesor(int id) {
        //TODO: validar que el carne exista en la BD. Si existe se borra

        if(id == this.profesorDAO.findById(id).get().getId()){
            this.profesorDAO.delete(id);
        }
        else{
            System.out.println("El estudiante no existe");
        }
    }

    @Override
    public List<Profesor> findByCity(String ciudad) {
        //TODO: implementarlo
        //validar que el lastName no sea nulo
        if(ciudad != null){
            return this.profesorDAO.findByCity(ciudad);
        }
        else{
            return Collections.emptyList();
        }
    }
}
