package appcode.table;

import appcode.ScrollBarCustom;
import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.Font;
import java.util.HashMap;
import java.util.Map;
import javax.swing.BorderFactory;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.border.EmptyBorder;
import javax.swing.table.DefaultTableCellRenderer;

public class TableDark extends JTable {

    private TableDarkHeader header;
    private TableDarkCell cell;

    public TableDark() {
        header = new TableDarkHeader();
        cell = new TableDarkCell();
        getTableHeader().setDefaultRenderer(header);
        getTableHeader().setPreferredSize(new Dimension(0, 35));
        setDefaultRenderer(Object.class, cell);
        setRowHeight(30);
    }

    public void setColumnAlignment(int column, int align) {
        header.setAlignment(column, align);
    }

    public void setCellAlignment(int column, int align) {
        cell.setAlignment(column, align);
    }

    public void setColumnWidth(int column, int width) {
        getColumnModel().getColumn(column).setPreferredWidth(width);
        getColumnModel().getColumn(column).setMinWidth(width);
        getColumnModel().getColumn(column).setMaxWidth(width);
        getColumnModel().getColumn(column).setMinWidth(10);
        getColumnModel().getColumn(column).setMaxWidth(10000);
    }

    public void fixTable(JScrollPane scroll) {
        scroll.setVerticalScrollBar(new ScrollBarCustom());
        JPanel panel = new JPanel();
        panel.setBackground(new Color(102, 102, 102));
        scroll.setCorner(JScrollPane.UPPER_RIGHT_CORNER, panel);
        scroll.getViewport().setBackground(new Color(102, 102, 102));
        scroll.setBorder(BorderFactory.createLineBorder(new Color(60, 60, 60), 2));
    }

    private class TableDarkHeader extends DefaultTableCellRenderer {

        private Map<Integer, Integer> alignment = new HashMap<>();

        public void setAlignment(int column, int align) {
            alignment.put(column, align);
        }

        @Override
        public Component getTableCellRendererComponent(
                JTable table, Object value, boolean selected,
                boolean focus, int row, int column) {

            super.getTableCellRendererComponent(
                    table, value, selected, focus, row, column);

            setBackground(new Color(102, 102, 102)); // HEADER
            setForeground(Color.BLACK);
            setFont(getFont().deriveFont(Font.BOLD, 12));
            setBorder(new EmptyBorder(0, 5, 0, 5));

            setHorizontalAlignment(
                    alignment.getOrDefault(column, JLabel.LEFT)
            );

            return this;
        }
    }

    private class TableDarkCell extends DefaultTableCellRenderer {

        private Map<Integer, Integer> alignment = new HashMap<>();

        public void setAlignment(int column, int align) {
            alignment.put(column, align);
        }

        @Override
        public Component getTableCellRendererComponent(
                JTable table, Object value, boolean selected,
                boolean focus, int row, int column) {

            super.getTableCellRendererComponent(
                    table, value, selected, focus, row, column);

            if (selected) {
                setBackground(new Color(29, 86, 127)); // selected
            } else {
                setBackground(new Color(153, 153, 153)); // semua sama
            }

            setForeground(Color.BLACK);
            setBorder(new EmptyBorder(0, 5, 0, 5));

            setHorizontalAlignment(
                    alignment.getOrDefault(column, JLabel.LEFT)
            );

            return this;
        }
    }
}