package koneksi;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Koneksi {
    private Connection koneksi;
    public Connection connect(){
        try{
//            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("Berhasil Koneksi!");
        }catch(Exception ex){
            System.out.println("Gagal Koneksi ! "+ex);
        }
        
        String url = "jdbc:mysql://localhost/truck_queue_management";
        
        try{
            koneksi = (Connection) DriverManager.getConnection(url,"root","");
            System.out.println("Berhasil Koneksi Database!");
        }catch(SQLException ex){
            System.out.println("Gagal koneksi Database! "+ex);
        }
        
        return koneksi;    
    }
}
