package appcode.form;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

public class CustomImagePicker extends JPanel {

    private File selectedFile;      // file asli dari chooser
    private Image previewImage;

    private String placeholder = "Klik untuk pilih gambar…";
    private Color placeholderColor = new Color(200, 200, 200);
    private int borderRadius = 18;
    private Color borderColor = new Color(142, 142, 142);
    private Color borderFocusColor = new Color(4, 88, 167);

    // folder tempat copy file
    private File uploadsDir = new File("uploads");

    public CustomImagePicker() {
        setOpaque(false);
        setPreferredSize(new Dimension(200, 150));

        if (!uploadsDir.exists()) {
            uploadsDir.mkdirs(); // buat folder uploads jika belum ada
        }

        addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                chooseImage();
            }
        });
    }

    public File getSelectedFile() {
        return selectedFile;
    }

    /**
     * Ambil path relatif ke folder uploads
     */
    public String getRelativePath() {
        if (selectedFile != null) {
            return "uploads/" + selectedFile.getName();
        }
        return null;
    }

    public void clearImage() {
        selectedFile = null;
        previewImage = null;
        repaint();
    }

    /**
     * Set image dari file eksternal (misal saat load data dari DB)
     */
    public void setImage(File file) {
        if (file == null || !file.exists()) {
            clearImage();
            return;
        }

        selectedFile = file;

        // Load image
        Image img = new ImageIcon(file.getAbsolutePath()).getImage();

        // Resize proporsional
        int panelWidth = getWidth() - 20;
        int panelHeight = getHeight() - 20;
        float scale = Math.min((float) panelWidth / img.getWidth(null), (float) panelHeight / img.getHeight(null));
        int newWidth = Math.round(img.getWidth(null) * scale);
        int newHeight = Math.round(img.getHeight(null) * scale);

        previewImage = img.getScaledInstance(newWidth, newHeight, Image.SCALE_SMOOTH);
        repaint();
    }

    private void chooseImage() {
        JFileChooser chooser = new JFileChooser();
        chooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
        chooser.setAcceptAllFileFilterUsed(false);
        chooser.addChoosableFileFilter(new javax.swing.filechooser.FileNameExtensionFilter(
                "Image Files", "jpg", "jpeg", "png"
        ));

        int result = chooser.showOpenDialog(this);

        if (result == JFileChooser.APPROVE_OPTION) {
            File file = chooser.getSelectedFile();

            // Copy file ke folder uploads
            try {
                File destFile = new File(uploadsDir, file.getName());
                Files.copy(file.toPath(), destFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                setImage(destFile); // pakai method setImage untuk load preview
            } catch (IOException ex) {
                JOptionPane.showMessageDialog(this, "Gagal menyalin gambar: " + ex.getMessage());
                clearImage();
            }
        }
    }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);

        Graphics2D g2 = (Graphics2D) g.create();
        g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

        // background
        g2.setColor(new Color(60, 60, 60));
        g2.fillRoundRect(0, 0, getWidth(), getHeight(), borderRadius, borderRadius);

        // preview image
        if (previewImage != null) {
            int x = (getWidth() - previewImage.getWidth(null)) / 2;
            int y = (getHeight() - previewImage.getHeight(null)) / 2;
            g2.drawImage(previewImage, x, y, null);
        } else {
            g2.setColor(placeholderColor);
            FontMetrics fm = g2.getFontMetrics();
            int textWidth = fm.stringWidth(placeholder);
            g2.drawString(placeholder, (getWidth() - textWidth) / 2, getHeight() / 2);
        }

        // border
        g2.setStroke(new BasicStroke(2));
        g2.setColor(isFocusOwner() ? borderFocusColor : borderColor);
        g2.drawRoundRect(1, 1, getWidth() - 2, getHeight() - 2, borderRadius, borderRadius);

        g2.dispose();
    }
}
