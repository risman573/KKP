package appcode.table;

import java.awt.Color;
import java.awt.Component;
import javax.swing.AbstractCellEditor;
import javax.swing.JTable;
import javax.swing.table.TableCellEditor;

public class TableActionCellEditor extends AbstractCellEditor implements TableCellEditor {

    private PanelAction actionPanel;
    private Object currentValue;

    private TableActionEvent event;

    public TableActionCellEditor(TableActionEvent event) {
        this.event = event;
    }

    @Override
    public Component getTableCellEditorComponent(JTable table, Object value, boolean isSelected, int row, int column) {
        actionPanel = new PanelAction();
        actionPanel.initEvent(event, row);
        if (isSelected) {
            actionPanel.setBackground(new Color(29, 86, 127)); // selected
        } else {
            actionPanel.setBackground(new Color(204, 204, 204)); // semua sama
        }
        this.currentValue = value;  // Simpan nilai asli (ID) jika perlu digunakan
        return actionPanel;
    }

    @Override
    public Object getCellEditorValue() {
        // Kembalikan nilai asli (misalnya ID) agar tidak jadi false/true
        return currentValue;
    }
}
