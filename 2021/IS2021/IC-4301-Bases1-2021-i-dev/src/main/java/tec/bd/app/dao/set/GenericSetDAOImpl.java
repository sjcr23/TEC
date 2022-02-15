package tec.bd.app.dao.set;


import tec.bd.app.dao.GenericDAO;
import tec.bd.app.database.set.Row;
import tec.bd.app.database.set.SetDB;

import java.io.Serializable;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

public abstract class GenericSetDAOImpl<T, ID extends Serializable> implements GenericDAO<T, ID> {

    protected Set<Row> table;
    protected Class<T> clazz;

    protected GenericSetDAOImpl(SetDB setDB, Class<T> clazz) {
        Objects.requireNonNull(setDB);
        Objects.requireNonNull(clazz);
        this.clazz = clazz;
        this.table = setDB.getTableByClassName(this.clazz);
    }

    @Override
    public List<T> findAll() {
        return this.table.stream().map(this::rowToEntity).collect(Collectors.toList());
    }

    @Override
    public Optional<T> findById(ID id) {
        return this.findRowById(id).map(this::rowToEntity);
    }

    @Override
    public void save(T e) {
        this.table.add(entityToRow(e));
    }

    @Override
    public Optional<T> update(T e) {
        var rowToUpdate = this.entityToRow(e);
        this.delete((ID)rowToUpdate.attribute("id").getValue());
        this.save(e);
        return Optional.of(e);
    }

    @Override
    public void delete(ID id) {
        var rowToDelete = this.findRowById(id);
        this.table.remove(rowToDelete.get());
    }

    protected Optional<Row> findRowById(ID id) {
        return this.table.stream().filter(row -> row.attribute("id").getValue().equals(id)).findFirst();
    }

    protected abstract T rowToEntity(Row row);

    protected abstract Row entityToRow(T e);
}
