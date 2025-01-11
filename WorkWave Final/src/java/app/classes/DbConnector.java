package app.classes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DbConnector {
    private static final String URL = "jdbc:mysql://localhost:3306/workwave";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private static final String DRIVER = "com.mysql.jdbc.Driver";
    
    public static Connection getConnection() {
        Connection con = null;
            
        try {
            
            Class.forName(DRIVER);
            con=DriverManager.getConnection(URL, USER, PASSWORD); 
            
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DbConnector.class.getName()).log(Level.SEVERE, null, ex);
        }
        return con;
    }
}
