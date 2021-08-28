package tec.bd.app.database.mysql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBProperties {

    private String connectionString;
    private String username;
    private String password;

    public DBProperties(String connectionString, String username, String password) {
        this.connectionString = connectionString;
        this.username = username;
        this.password = password;
    }

    public String getConnectionString() {
        return connectionString;
    }


    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(this.connectionString, this.username, this.password);
    }
}
