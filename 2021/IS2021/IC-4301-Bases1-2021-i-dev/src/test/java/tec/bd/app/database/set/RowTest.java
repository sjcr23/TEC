package tec.bd.app.database.set;

import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.*;

public class RowTest {

    @Test
    public void getAttributeValue() throws Exception {
        RowAttribute att1 = new RowAttribute("id", 1000);
        RowAttribute att2 = new RowAttribute("name", "Juan");

        Row row = new Row(new RowAttribute[]{ att1, att2 });

        var actual = row.attribute("id");

        assertThat(actual.getName()).isEqualTo("id");
        assertThat(actual.getValue()).isEqualTo(1000);
    }

}
