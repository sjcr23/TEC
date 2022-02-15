package tec.bd.app.dao.mysql.routine;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import tec.bd.app.dao.EstudianteDAO;
import tec.bd.app.dao.mysql.GenericMySqlDAOImpl;
import tec.bd.app.database.mysql.DBProperties;
import tec.bd.app.domain.Estudiante;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;


public class EstudianteMySqlDAOImpl extends GenericMySqlDAOImpl<Estudiante, Integer> implements EstudianteDAO {

    private static final Logger LOG = LoggerFactory.getLogger(EstudianteMySqlDAOImpl.class);

    private final DBProperties dbProperties;

    private static final String ver_todos_los_estudiantes = "call ver_todos_los_estudiantes();";
    private static final String estudiante_por_id = "call estudiante_por_id(?);";
    private static final String agregar_estudiante = "call agregar_estudiante(?, ?, ?, ?, ?);";
    private static final String actualizar_estudiante = "call actualizar_estudiante(?, ?, ?, ?, ?);";
    private static final String eliminar_estudiante = "call eliminar_estudiante(?);";
    private static final String estudiantes_por_apellido = "call estudiantes_por_apellido(?);";
    private static final String estudiantes_ordenados_apellido = "SELECT id, nombre, apellido, fecha_nacimiento, total_creditos FROM estudiante ORDER BY apellido;";


    public EstudianteMySqlDAOImpl(DBProperties dbProperties) {
        this.dbProperties = dbProperties;
    }

    @Override
    public List<Estudiante> findAll() {

        ResultSet rs;

        try(Connection connection = this.dbProperties.getConnection();
            CallableStatement stmt = connection.prepareCall(ver_todos_los_estudiantes)){
            rs = stmt.executeQuery();
            return resultSetToList(rs);
        }

        catch (SQLException e) {
            System.out.println(e.getMessage());
            LOG.error("Error when running {}", ver_todos_los_estudiantes, e);
        }
        return Collections.emptyList();
    }

    @Override
    public Optional<Estudiante> findById(Integer id) {

        ResultSet rs;

        try(Connection connection = this.dbProperties.getConnection();

            CallableStatement stmt = connection.prepareCall(estudiante_por_id)){
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            return resultSetToList(rs).stream().findFirst();

        }
        catch (SQLException e) {
            System.out.println(e.getMessage());
            LOG.error("Error when running {}", estudiante_por_id, e);
        }
        return Optional.empty();
    }

    @Override
    public void save(Estudiante estudiante) {

        try(Connection connection = this.dbProperties.getConnection();
            CallableStatement stmt = connection.prepareCall(agregar_estudiante)){

            stmt.setInt(1, estudiante.getId());
            stmt.setString(2, estudiante.getNombre());
            stmt.setString(3, estudiante.getApellido());
            stmt.setString(4, estudiante.getFechaNacimiento());
            stmt.setInt(5, estudiante.getTotalCreditos());

            stmt.executeUpdate();
        }

        catch (SQLException e) {
            System.out.println(e.getMessage());
            LOG.error("Error when running {}", agregar_estudiante, e);
        }
    }

    @Override
    public Optional<Estudiante> update(Estudiante estudiante) {

        try(Connection connection = this.dbProperties.getConnection();
            CallableStatement stmt = connection.prepareCall(actualizar_estudiante)){

            stmt.setInt(1, estudiante.getId());
            stmt.setString(2, estudiante.getNombre());
            stmt.setString(3, estudiante.getApellido());
            stmt.setString(4, estudiante.getFechaNacimiento());
            stmt.setInt(5, estudiante.getTotalCreditos());

            stmt.executeUpdate();
            return Optional.of(estudiante);
        }

        catch (SQLException e) {
            System.out.println(e.getMessage());
            LOG.error("Error when running {}", actualizar_estudiante, e);
        }
        return Optional.empty();
    }

    @Override
    public void delete(Integer id) {

        try(Connection connection = this.dbProperties.getConnection();
            CallableStatement stmt = connection.prepareCall(eliminar_estudiante)) {

            stmt.setInt(1, id);

            stmt.executeUpdate();
        }

        catch (SQLException e) {
            System.out.println(e.getMessage());
            LOG.error("Error when running {}", eliminar_estudiante, e);
        }
    }

    @Override
    public List<Estudiante> findByLastName(String apellido) {

        ResultSet rs;

        try(Connection connection = this.dbProperties.getConnection();
            CallableStatement stmt = connection.prepareCall(estudiantes_por_apellido)){

            stmt.setString(1, apellido);
            rs = stmt.executeQuery();

            return  resultSetToList(rs);
        }

        catch (SQLException e) {
            System.out.println(e.getMessage());
            LOG.error("Error when running {}", estudiantes_por_apellido, e);
        }
        return Collections.emptyList();
    }

    @Override
    public List<Estudiante> findAllSortByLastName(){

        ResultSet rs;

        try(Connection connection = this.dbProperties.getConnection();
            CallableStatement stmt = connection.prepareCall(estudiantes_ordenados_apellido)){

            rs = stmt.executeQuery();

            return  resultSetToList(rs);
        }

        catch (SQLException e) {
            System.out.println(e.getMessage());
            LOG.error("Error when running {}", estudiantes_ordenados_apellido, e);
        }
        return Collections.emptyList();
    }

    @Override
    protected Estudiante resultSetToEntity(ResultSet resultSet) throws SQLException {
        var id = resultSet.getInt("id");
        var nombre = resultSet.getString("nombre");
        var apellido = resultSet.getString("apellido");
        var fechaNacimiento = resultSet.getString("fecha_nacimiento");
        var totalCreditos = resultSet.getInt("total_creditos");
        return new Estudiante(id, nombre, apellido, fechaNacimiento, totalCreditos);
    }

    @Override
    protected List<Estudiante> resultSetToList(ResultSet resultSet) throws SQLException {
        List<Estudiante> estudiantes = new ArrayList<>();
        while(resultSet.next()) {
            estudiantes.add(this.resultSetToEntity(resultSet));
        }
        return estudiantes;
    }
}