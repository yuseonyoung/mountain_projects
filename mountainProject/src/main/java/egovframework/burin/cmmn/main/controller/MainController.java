package egovframework.burin.cmmn.main.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
 
public class MainController {
    public static void main(String[] args) throws ClassNotFoundException {
        Class.forName("org.postgresql.Driver");  
        
        String     connurl  = "jdbc:postgresql://localhost/mountainProject";
        String     user     = "postgres";
        String     password = "7487";
 
        try (Connection connection = DriverManager.getConnection(connurl, user, password);) {
              Statement stmt = connection.createStatement();
              ResultSet rs = stmt.executeQuery("SELECT VERSION() AS version");
 
              while (rs.next()) {
                  String version = rs.getString("version");
                  
                  System.out.println(version);                  
              }           
            rs.close();
            stmt.close();
            connection.close();
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
    }
}