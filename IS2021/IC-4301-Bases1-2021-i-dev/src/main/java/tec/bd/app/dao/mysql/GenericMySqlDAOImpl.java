package tec.bd.app.dao.mysql;

import tec.bd.app.dao.GenericDAO;
import tec.bd.app.domain.Entity;

import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public abstract class GenericMySqlDAOImpl<T extends Entity, ID extends Serializable> implements GenericDAO<T, ID> {

    protected abstract T resultSetToEntity(ResultSet resultSet) throws SQLException;

    protected abstract List<T> resultSetToList(ResultSet resultSet) throws SQLException;

}
