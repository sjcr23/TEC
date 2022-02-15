package tec.bd.app.dao.mysql.routine;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import tec.bd.app.dao.ProfesorDAO;
import tec.bd.app.dao.mysql.GenericMySqlDAOImpl;
import tec.bd.app.database.mysql.DBProperties;
import tec.bd.app.domain.Curso;
import tec.bd.app.domain.Profesor;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;


public class ProfesorMySqlDAOImpl extends GenericMySqlDAOImpl<Profesor, Integer> implements ProfesorDAO {

    private static final Logger LOG = LoggerFactory.getLogger(ProfesorMySqlDAOImpl.class);

    private final DBProperties dbProperties;

    // Procesos almacenados
    private static final String ver_todos_los_profesores = "call ver_todos_los_profesores();";
    private static final String profesor_por_id = "call profesor_por_id(?);";
    private static final String agregar_profesor = "call agregar_profesor(?, ?, ?, ?);";
    private static final String actualizar_profesor = "call actualizar_profesor(?, ?, ?, ?);";
    private static final String eliminar_profesor = "call eliminar_profesor(?);";
    private static final String profesores_por_ciudad = "call profesores_por_ciudad(?);";

    public ProfesorMySqlDAOImpl(DBProperties dbProperties) {
        this.dbProperties = dbProperties;
    }

    @Override
    public List<Profesor> findAll() {

        ResultSet rs;

        try(Connection connection = this.dbProperties.getConnection();
            CallableStatement stmt = connection.prepareCall(ver_todos_los_profesores)){
            rs = stmt.executeQuery();
            return resultSetToList(rs);
        }

        catch (SQLException e) {
            System.out.println(e.getMessage());
            LOG.error("Error when running {}", ver_todos_los_profesores, e);
        }
        return Collections.emptyList();
    }

    @Override
    public Optional<Profesor> findById(Integer id) {

        ResultSet rs;

        try(Connection connection = this.dbProperties.getConnection();

            CallableStatement stmt = connection.prepareCall(profesor_por_id)){
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            return resultSetToList(rs).stream().findFirst();
        }
        catch (SQLException e) {
            System.out.println(e.getMessage());
            LOG.error("Error when running {}", profesor_por_id, e);
        }
        return Optional.empty();
    }

    @Override
    public void save(Profesor profesor) {

        try(Connection connection = this.dbProperties.getConnection();
            CallableStatement stmt = connection.prepareCall(agregar_profesor)){

            stmt.setInt(1, profesor.getId());
            stmt.setString(2, profesor.getNombre());
            stmt.setString(3, profesor.getApellido());
            stmt.setString(4, profesor.getCiudad());

            // Ejecutamos la consulta
            stmt.executeQuery();
        }
        catch (SQLException e) {
            System.out.println(e.getMessage());
            LOG.error("Error when running {}", agregar_profesor, e);
        }
    }

    @Override
    public Optional<Profesor> update(Profesor profesor) {

        try(Connection connection = this.dbProperties.getConnection();
            CallableStatement stmt = connection.prepareCall(actualizar_profesor)){

            stmt.setInt(1, profesor.getId());
            stmt.setString(2, profesor.getNombre());
            stmt.setString(3, profesor.getApellido());
            stmt.setString(4, profesor.getCiudad());

            stmt.executeUpdate();
            return Optional.of(profesor);
        }
        catch (SQLException e) {
            System.out.println(e.getMessage());
            LOG.error("Error when running {}", actualizar_profesor, e);
        }
        return Optional.empty();
    }

    @Override
    public void delete(Integer id) {

        try(Connection connection = this.dbProperties.getConnection();
            CallableStatement stmt = connection.prepareCall(eliminar_profesor)) {

            stmt.setInt(1, id);

            stmt.executeQuery();
        }
        catch (SQLException e) {
            System.out.println(e.getMessage());
            LOG.error("Error when running {}", eliminar_profesor, e);
        }
    }

    @Override
    public List<Profesor> findByCity(String ciudad) {

        ResultSet rs;

        try(Connection connection = this.dbProperties.getConnection();
            CallableStatement stmt = connection.prepareCall(profesores_por_ciudad)){

            stmt.setString(1, ciudad);
            rs = stmt.executeQuery();

            return  resultSetToList(rs);
        }

        catch (SQLException e) {
            System.out.println(e.getMessage());
            LOG.error("Error when running {}", profesores_por_ciudad, e);
        }
        return Collections.emptyList();
    }

    @Override
    protected Profesor resultSetToEntity(ResultSet resultSet) throws SQLException {
        var id = resultSet.getInt("id");
        var nombre = resultSet.getString("nombre");
        var apellido = resultSet.getString("apellido");
        var ciudad = resultSet.getString("ciudad");

        return new Profesor(id, nombre, apellido, ciudad);
    }

    @Override
    protected List<Profesor> resultSetToList(ResultSet resultSet) throws SQLException {
        List<Profesor> profesores = new ArrayList<>();
        while(resultSet.next()) {
            profesores.add(this.resultSetToEntity(resultSet));
        }
        return profesores;
    }
}
