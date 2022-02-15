package tec.bd.app.service;

import tec.bd.app.dao.EstudianteDAO;
import tec.bd.app.domain.Estudiante;

import java.util.List;
import java.util.Optional;

public class EstudianteServiceImpl implements EstudianteService {

    private EstudianteDAO estudianteDAO;

    public EstudianteServiceImpl(EstudianteDAO estudianteDAO) {
        this.estudianteDAO = estudianteDAO;
    }

    @Override
    public List<Estudiante> getAll() {
        return this.estudianteDAO.findAll();
    }

    @Override
    public Optional<Estudiante> getById(int carne) {

        //TODO: validar el carne > 0. Si no cumple con eso se devuelve Optional.empty()
        var estudiante_buscado = this.estudianteDAO.findById(carne);

        if(carne > 0){
            return estudiante_buscado;
        }
        else{
            return Optional.empty();
        }
    }

    public void addNew(Estudiante e) {
        Optional<Estudiante> estudiante = this.estudianteDAO.findById(e.getId());
        if(!estudiante.isPresent()) {
            this.estudianteDAO.save(e);
        }
    }

    public Optional<Estudiante> updateStudent(Estudiante e) {

        //TODO: validar que el carne exista en la BD. Si existe se actualiza
        var id = this.estudianteDAO.findById(e.getId()).get().getId();
        if(e.getId() == id ){
            return this.estudianteDAO.update(e);
        }
        else{
            return Optional.empty();
        }
    }

    public void deleteStudent(int carne) {
        //TODO: validar que el carne exista en la BD. Si existe se borra

        if(carne == this.estudianteDAO.findById(carne).get().getId()){
            this.estudianteDAO.delete(carne);
        }
        else{
            System.out.println("El estudiante no existe");
        }
    }

    public List<Estudiante> getStudentsSortedByLastName() {
        return this.estudianteDAO.findAllSortByLastName();
    }

    @Override
    public List<Estudiante> getStudentsByLastName(String lastName) {
        //TODO: implementarlo
        //validar que el lastName no sea nulo
        if(lastName != null){
            return this.estudianteDAO.findByLastName(lastName);
        }
        else{
            return null;
        }
    }
}
