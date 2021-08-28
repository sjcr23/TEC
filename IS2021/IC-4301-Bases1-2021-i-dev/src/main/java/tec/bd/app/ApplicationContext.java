package tec.bd.app;

import tec.bd.app.dao.*;
import tec.bd.app.dao.mysql.routine.CursoMySqlDAOImpl;
import tec.bd.app.dao.mysql.routine.EstudianteMySqlDAOImpl;
import tec.bd.app.dao.mysql.routine.ProfesorMySqlDAOImpl;

import tec.bd.app.database.mysql.DBProperties;
import tec.bd.app.database.set.Row;
import tec.bd.app.database.set.RowAttribute;
import tec.bd.app.database.set.SetDB;
import tec.bd.app.domain.Curso;
import tec.bd.app.domain.Entity;
import tec.bd.app.domain.Estudiante;
import tec.bd.app.domain.Profesor;
import tec.bd.app.service.*;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;

public class ApplicationContext {

    private SetDB setDB;

    private EstudianteDAO estudianteDAO;
    private EstudianteService estudianteService;

    private CursoDAO cursoDAO;
    private CursoService cursoService;

    private ProfesorDAO profesorDAO;
    private ProfesorService profesorService;

    private static final String CONNECTION_STRING = "jdbc:mysql://localhost:3306/universidad";
    private static final String DB_USERNAME = "chino";
    private static final String DB_PASSWORD = "chino";
    private static final DBProperties DB_PROPERTIES = new DBProperties(CONNECTION_STRING, DB_USERNAME, DB_PASSWORD);

    private static final String DATABASE_PROPERTIES_FILE = "/database.properties";
    private static final String CONNECTION_STRING_PROP = "database.url";
    private static final String DB_USERNAME_PROP = "database.username";
    private static final String DB_PASSWORD_PROP = "database.password";

    private ApplicationContext() {

    }

    public static ApplicationContext init() {
        ApplicationContext applicationContext = new ApplicationContext();

        String dbPropertiesFilePath = applicationContext.getClass().getResource(DATABASE_PROPERTIES_FILE).getFile();
        DBProperties databaseProperties = initDBProperties(dbPropertiesFilePath);


        // Objetos que se conectan a MySQL
        applicationContext.cursoDAO = initCursoMysqlDAO(databaseProperties);
        applicationContext.estudianteDAO = initEstudianteMysqlDAO(databaseProperties);
        applicationContext.profesorDAO = initProfesorMysqlDAO(databaseProperties);

        applicationContext.cursoService = initCursoService(applicationContext.cursoDAO);
        applicationContext.estudianteService = initEstudianteService(applicationContext.estudianteDAO);
        applicationContext.profesorService = initProfesorService(applicationContext.profesorDAO);

        return applicationContext;
    }

    private static SetDB initSetDB() {
        // Registros de la tabla estudiante
        var juanId = new RowAttribute("id", 1);
        var juanNombre = new RowAttribute("nombre", "Juan");
        var juanApellido = new RowAttribute("apellido", "Perez");
        var juanEdad = new RowAttribute("edad", 20);
        var juanRow = new Row(new RowAttribute[]{ juanId, juanNombre, juanApellido, juanEdad });

        var mariaId = new RowAttribute("id", 3);
        var mariaNombre = new RowAttribute("nombre", "Maria");
        var mariaApellido = new RowAttribute("apellido", "Rojas");
        var mariaEdad = new RowAttribute("edad", 21);
        var mariaRow = new Row(new RowAttribute[]{ mariaId, mariaNombre, mariaApellido, mariaEdad });

        var pedroId = new RowAttribute("id", 2);
        var pedroNombre = new RowAttribute("nombre", "Pedro");
        var pedroApellido = new RowAttribute("apellido", "Infante");
        var pedroEdad = new RowAttribute("edad", 23);
        var pedroRow = new Row(new RowAttribute[]{ pedroId, pedroNombre, pedroApellido, pedroEdad });

        var raquelId = new RowAttribute("id", 10);
        var raquelNombre = new RowAttribute("nombre", "Raquel");
        var raquelApellido = new RowAttribute("apellido", "Arias");
        var raquelEdad = new RowAttribute("edad", 25);
        var raquelRow = new Row(new RowAttribute[]{ raquelId, raquelNombre, raquelApellido, raquelEdad });

        // ---------------------------------------------------------------
        // Registros de la tabla curso
        // ---------------------------------------------------------------

        var discretaId = new RowAttribute("id", 1);
        var discretaNombre = new RowAttribute("nombre", "MateDiscrta");
        var discretaCreditos = new RowAttribute("creditos", 4);
        var discretaDepartamento = new RowAttribute("departamento", "EscuelaDeMates");
        var discretaRow = new Row(new RowAttribute[]{ discretaId, discretaNombre, discretaCreditos, discretaDepartamento });

        var introID = new RowAttribute("id", 2);
        var introNombre = new RowAttribute("nombre", "IntroProgra");
        var introCreditos = new RowAttribute("creditos", 3);
        var introDepartamento = new RowAttribute("departamento", "EscuelaDeCompu");
        var introRow = new Row(new RowAttribute[]{ introID, introNombre, introCreditos, introDepartamento });

        var cdiID = new RowAttribute("id", 3);
        var cdiNombre = new RowAttribute("nombre", "CalculoDI");
        var cdiCreditos = new RowAttribute("creditos", 4);
        var cdiDepartamento = new RowAttribute("departamento", "EscuelaDeMates");
        var cdiRow = new Row(new RowAttribute[]{ cdiID, cdiNombre, cdiCreditos, cdiDepartamento });


        var fundaID = new RowAttribute("id", 4);
        var fundaNombre = new RowAttribute("nombre", "FundaProgra");
        var fundaCreditos = new RowAttribute("creditos", 4);
        var fundaDepartamento = new RowAttribute("departamento", "EscuelaDeCompu");
        var fundaRow = new Row(new RowAttribute[]{ fundaID, fundaNombre, fundaCreditos, fundaDepartamento });

        // Registros de la tabla profesor

        var profe1Id = new RowAttribute("id", 1);
        var profe1Nombre = new RowAttribute("nombre", "Aurelio");
        var profe1Creditos = new RowAttribute("apellido", "Sanabri");
        var profe1Departamento = new RowAttribute("ciudad", "Cartago");
        var profe1Row = new Row(new RowAttribute[]{ profe1Id, profe1Nombre, profe1Creditos, profe1Departamento });

        var profe2ID = new RowAttribute("id", 2);
        var profe2Nombre = new RowAttribute("nombre", "Arnoldo");
        var profe2Creditos = new RowAttribute("apellido", "Ramos");
        var profe2Departamento = new RowAttribute("ciudad", "Curridabat");
        var profe2Row = new Row(new RowAttribute[]{ profe2ID, profe2Nombre, profe2Creditos, profe2Departamento });

        var profe3ID = new RowAttribute("id", 3);
        var profe3Nombre = new RowAttribute("nombre", "Eddy");
        var profe3Creditos = new RowAttribute("apellido", "Ramirez");
        var profe3Departamento = new RowAttribute("ciudad", "SantoDomingo");
        var profe3Row = new Row(new RowAttribute[]{ profe3ID, profe3Nombre, profe3Creditos, profe3Departamento });

        var profe4ID = new RowAttribute("id", 4);
        var profe4Nombre = new RowAttribute("nombre", "Samanta");
        var profe4Creditos = new RowAttribute("apellido", "Ramijan");
        var profe4Departamento = new RowAttribute("ciudad", "Cartago");
        var profe4Row = new Row(new RowAttribute[]{ profe4ID, profe4Nombre, profe4Creditos, profe4Departamento });


        var tables = new HashMap<Class<? extends Entity>, Set<Row>>();
        tables.put(Estudiante.class, new HashSet<>() {{
            add(juanRow);
            add(mariaRow);
            add(pedroRow);
            add(raquelRow);
        }});

        tables.put(Curso.class, new HashSet<>() {{
            add(discretaRow);
            add(introRow);
            add(cdiRow);
            add(fundaRow);

        }})

        ;
        tables.put(Profesor.class, new HashSet<>() {{
            add(profe1Row);
            add(profe2Row);
            add(profe3Row);
            add(profe4Row);

        }});
        // Agregar las filas de curso y estudiante a tables
        // tables.put(Curso.class, new HashSet<>() {{ ... }}
        // tables.put(Profesor.class, new HashSet<>() {{ ... }}

        return new SetDB(tables);
    }

    private static DBProperties initDBProperties(String dbPropertiesFilePath) {
        try (InputStream propFileStream = new FileInputStream(dbPropertiesFilePath)) {
            Properties properties = new Properties();
            properties.load(propFileStream);
            return new DBProperties(
                    properties.getProperty(CONNECTION_STRING_PROP),
                    properties.getProperty(DB_USERNAME_PROP),
                    properties.getProperty(DB_PASSWORD_PROP)
            );
        } catch (IOException ex) {
            ex.printStackTrace();
            throw new RuntimeException("No se puede cargar el archivo de propiedades de la base de datos");
        }
    }

    // Clases

    private static EstudianteDAO initEstudianteMysqlDAO(DBProperties dbProperties) {
        return new EstudianteMySqlDAOImpl(dbProperties);
    }

    private static CursoDAO initCursoMysqlDAO(DBProperties dbProperties) {
        return new CursoMySqlDAOImpl(dbProperties);
    }

    private static ProfesorDAO initProfesorMysqlDAO(DBProperties dbProperties) {
        return new ProfesorMySqlDAOImpl(dbProperties);
    }


    //   Servicios

    private static EstudianteService initEstudianteService(EstudianteDAO estudianteDAO) {
        return new EstudianteServiceImpl(estudianteDAO);
    }

    private static ProfesorService initProfesorService(ProfesorDAO profesorDAO){
        return new ProfesorServiceImpl(profesorDAO);
    }

    private static CursoService initCursoService(CursoDAO cursoDAO){
        return new CursoServiceImpl(cursoDAO);
    }

//    private static EstudianteDAO initEstudianteSetDAO(SetDB setDB) {
//        return new EstudianteDAOImpl(setDB, Estudiante.class);
//    }
//    private static ProfesorDAO initProfesorSetDAO(SetDB setDB){
//        return new ProfesorDAOImpl(setDB, Profesor.class);
//    }
//    private static CursoDAO initCursoSetDAO(SetDB setDB){
//        return new CursoDAOImpl(setDB, Curso.class);
//    }

    public SetDB getSetDB() {
        return this.setDB;
    }

    public EstudianteDAO getEstudianteSetDAO() {
        return this.estudianteDAO;
    }

    public EstudianteService getEstudianteService() {
        return this.estudianteService;
    }

    public CursoService getCursoService() {
        return this.cursoService;
    }

    public ProfesorService getProfesorService() {
        return this.profesorService;
    }

}
