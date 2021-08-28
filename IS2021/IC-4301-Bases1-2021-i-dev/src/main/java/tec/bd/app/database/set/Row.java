package tec.bd.app.database.set;

import java.util.stream.Stream;

public class Row {

    private RowAttribute[] attributes;

    public Row(RowAttribute[] attributes) {
        this.attributes = attributes;
    }

    public RowAttribute[] getAttributes() {
        return attributes;
    }

    public void setAttributes(RowAttribute[] attributes) {
        this.attributes = attributes;
    }

    public RowAttribute attribute(String name) {
        return Stream.of(this.attributes).filter(r -> r.getName().equals(name)).findFirst().get();
    }

    public Integer intAttributeValue(String name) {
        return (Integer) this.attribute(name).getValue();
    }

    public String stringAttributeValue(String name) {
        return (String) this.attribute(name).getValue();
    }

    public Long longAttributeValue(String name) {
        return (Long) this.attribute(name).getValue();
    }
}
