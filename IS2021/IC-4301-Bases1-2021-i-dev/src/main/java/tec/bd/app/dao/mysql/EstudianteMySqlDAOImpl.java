package tec.bd.app.dao.mysql;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import tec.bd.app.dao.EstudianteDAO;
import tec.bd.app.database.mysql.DBProperties;
import tec.bd.app.domain.Estudiante;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

public class EstudianteMySqlDAOImpl extends GenericMySqlDAOImpl<Estudiante, Integer> implements EstudianteDAO {

    private static final Logger LOG = LoggerFactory.getLogger(EstudianteMySqlDAOImpl.class);

    private final DBProperties dbProperties;


    private static final String SQL_SELECT_ESTUDIANTES = "select id, nombre, apellido, fecha_nacimiento, total_creditos from estudiante;";
    private static final String SQL_SELECT_ESTUDIANTE_ID = "select id, nombre, apellido, fecha_nacimiento, total_creditos from estudiante where id = %d";
    private static final String SQL_INSERT_ESTUDIANTE = "insert into estudiante(id, nombre, apellido, fecha_nacimiento, total_creditos) values(%d, '%s', '%s', '%s', %d)";
    private static final String SQL_UPDATE_ESTUDIANTE = "update estudiante set nombre = '%s', apellido = '%s', fecha_nacimiento = '%s', total_creditos = %d where id = %d";
    private static final String SQL_DELETE_ESTUDIANTE = "delete from estudiante where id = %d";

    public EstudianteMySqlDAOImpl(DBProperties dbProperties) {
        this.dbProperties = dbProperties;
    }

    @Override
    public List<Estudiante> findByLastName(String lastName) {
        return null;
    }

    @Override
    public List<Estudiante> findAllSortByLastName() {
        return null;
    }

    @Override
    public List<Estudiante> findAll() {
        try {
            try (Connection connection = this.dbProperties.getConnection()) {
                LOG.info(SQL_SELECT_ESTUDIANTES);
                try (Statement stmt = connection.createStatement()) {
                    //execute query
                    try (ResultSet rs = stmt.executeQuery(SQL_SELECT_ESTUDIANTES)) {
                        return this.resultSetToList(rs);
                    }

                }
            }
        } catch (SQLException e) {
            LOG.error("Error when running {}", SQL_SELECT_ESTUDIANTES, e);
        }

        return Collections.emptyList();
    }

    @Override
    public Optional<Estudiante> findById(Integer id) {
        try {
            try (Connection connection = this.dbProperties.getConnection()) {
                try (Statement stmt = connection.createStatement()) {
                    //execute query
                    var sql = String.format(SQL_SELECT_ESTUDIANTE_ID, id);
                    LOG.info(sql);
                    try (ResultSet rs = stmt.executeQuery(sql)) {
                        return this.resultSetToList(rs).stream().findFirst();
                    }
                }
            }
        } catch (SQLException e) {
            LOG.error("Error when running {}", SQL_SELECT_ESTUDIANTES, e);
        }

        return Optional.empty();
    }

    @Override
    public void save(Estudiante estudiante) {
        try {
            try (Connection connection = this.dbProperties.getConnection()) {
                try (Statement stmt = connection.createStatement()) {
                    //execute query
                    var sql = String.format(SQL_INSERT_ESTUDIANTE,
                            estudiante.getId(),
                            estudiante.getNombre(),
                            estudiante.getApellido(),
                            estudiante.getFechaNacimiento(),
                            estudiante.getTotalCreditos()
                    );
                    LOG.info(sql);
                    int rowCount = stmt.executeUpdate(sql);
                    LOG.debug("{} fila agregada", rowCount);
                }
            }
        } catch (SQLException e) {
            LOG.error("Error when running {}", SQL_SELECT_ESTUDIANTES, e);
        }
    }

    @Override
    public Optional<Estudiante> update(Estudiante estudiante) {

        try {
            try (Connection connection = this.dbProperties.getConnection()) {
                try (Statement stmt = connection.createStatement()) {
                    //execute query
                    var sql = String.format(SQL_UPDATE_ESTUDIANTE,
                            estudiante.getNombre(),
                            estudiante.getApellido(),
                            estudiante.getFechaNacimiento(),
                            estudiante.getTotalCreditos(),
                            estudiante.getId()
                    );
                    LOG.info(sql);
                    int rowCount = stmt.executeUpdate(sql);
                    LOG.debug("{} fila actualizada", rowCount);
                    if(rowCount == 1) {
                        return Optional.of(estudiante);
                    }
                }
            }
        } catch (SQLException e) {
            LOG.error("Error when running {}", SQL_SELECT_ESTUDIANTES, e);
        }

        return Optional.empty();
    }


    @Override
    public void delete(Integer id) {
        try {
            try (Connection connection = this.dbProperties.getConnection()) {
                try (Statement stmt = connection.createStatement()) {
                    //execute query
                    var sql = String.format(SQL_DELETE_ESTUDIANTE, id);
                    LOG.info(sql);
                    int rowCount = stmt.executeUpdate(sql);
                    LOG.debug("{} fila borrada", rowCount);
                }
            }
        } catch (SQLException e) {
            LOG.error("Error when running {}", SQL_SELECT_ESTUDIANTES, e);
        }
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
