package tec.bd.app.dao.mysql.routine;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import tec.bd.app.dao.CursoDAO;
import tec.bd.app.dao.mysql.GenericMySqlDAOImpl;
import tec.bd.app.database.mysql.DBProperties;
import tec.bd.app.domain.Curso;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;


public class CursoMySqlDAOImpl extends GenericMySqlDAOImpl<Curso, Integer> implements CursoDAO {

    private static final Logger LOG = LoggerFactory.getLogger(CursoMySqlDAOImpl.class);

    private final DBProperties dbProperties;

    // Procesos almacenados
    private static final String ver_todos_los_cursos = "call ver_todos_los_cursos();";
    private static final String curso_por_id = "call curso_por_id(?);";
    private static final String agregar_curso = "call agregar_curso(?, ?, ?, ?);";
    private static final String actualizar_curso = "call actualizar_curso(?, ?, ?, ?);";
    private static final String eliminar_curso = "call eliminar_curso(?);";
    private static final String curso_por_departamento = "call curso_por_departamento(?);";

    public CursoMySqlDAOImpl(DBProperties dbProperties) {
        this.dbProperties = dbProperties;
    }

    @Override
    public List<Curso> findAll() {

        ResultSet rs;

        try(Connection connection = this.dbProperties.getConnection();
            CallableStatement stmt = connection.prepareCall(ver_todos_los_cursos)){
            rs = stmt.executeQuery();
            return resultSetToList(rs);
        }

        catch (SQLException e) {
            System.out.println(e.getMessage());
            LOG.error("Error when running {}", ver_todos_los_cursos, e);
        }
        return Collections.emptyList();
    }

    @Override
    public Optional<Curso> findById(Integer id) {

        ResultSet rs;

        try(Connection connection = this.dbProperties.getConnection();

            CallableStatement stmt = connection.prepareCall(curso_por_id)){
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            return resultSetToList(rs).stream().findFirst();
        }
        catch (SQLException e) {
            System.out.println(e.getMessage());
            LOG.error("Error when running {}", curso_por_id, e);
        }
        return Optional.empty();
    }

    @Override
    public void save(Curso curso) {

        try(Connection connection = this.dbProperties.getConnection();
            CallableStatement stmt = connection.prepareCall(agregar_curso)){

            stmt.setInt(1, curso.getId());
            stmt.setString(2, curso.getNombre());
            stmt.setInt(3, curso.getCreditos());
            stmt.setString(4, curso.getDepartamento());

            stmt.executeUpdate();
        }

        catch (SQLException e) {
            System.out.println(e.getMessage());
            LOG.error("Error when running {}", agregar_curso, e);
        }
    }

    @Override
    public Optional<Curso> update(Curso curso) {

        try(Connection connection = this.dbProperties.getConnection();
            CallableStatement stmt = connection.prepareCall(actualizar_curso)){

            stmt.setInt(1, curso.getId());
            stmt.setString(2, curso.getNombre());
            stmt.setInt(3, curso.getCreditos());
            stmt.setString(4, curso.getDepartamento());

            stmt.executeUpdate();
            return Optional.of(curso);
        }

        catch (SQLException e) {
            System.out.println(e.getMessage());
            LOG.error("Error when running {}", actualizar_curso, e);
        }
        return Optional.empty();
    }

    @Override
    public void delete(Integer id) {

        try(Connection connection = this.dbProperties.getConnection();
            CallableStatement stmt = connection.prepareCall(eliminar_curso)) {

            stmt.setInt(1, id);

            stmt.executeQuery();
        }

        catch (SQLException e) {
            System.out.println(e.getMessage());
            LOG.error("Error when running {}", eliminar_curso, e);
        }
    }

    @Override
    public List<Curso> findByDepartment(String departamento) {

        ResultSet rs;

        try(Connection connection = this.dbProperties.getConnection();
            CallableStatement stmt = connection.prepareCall(curso_por_departamento)){

            stmt.setString(1, departamento);
            rs = stmt.executeQuery();

            return  resultSetToList(rs);
        }

        catch (SQLException e) {
            System.out.println(e.getMessage());
            LOG.error("Error when running {}", curso_por_departamento, e);
        }
        return Collections.emptyList();
    }

    @Override
    protected Curso resultSetToEntity(ResultSet resultSet) throws SQLException {
        var id = resultSet.getInt("id");
        var nombre = resultSet.getString("nombre");
        var creditos = resultSet.getInt("creditos");
        var departamento = resultSet.getString("departamento");

        return new Curso(id, nombre, creditos,departamento);
    }

    @Override
    protected List<Curso> resultSetToList(ResultSet resultSet) throws SQLException {
        List<Curso> cursos = new ArrayList<>();
        while(resultSet.next()) {
            cursos.add(this.resultSetToEntity(resultSet));
        }
        return cursos;
    }
}