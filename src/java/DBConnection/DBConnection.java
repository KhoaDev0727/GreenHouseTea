/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DBConnection;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author le-minh-khoa
 */
public class DBConnection {

    public static Connection getConnection() {
        Connection conn;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String url = "jdbc:sqlserver://LEMINHKHOA:1433;databaseName=GreenHouseDB;user=sa;password=12345;encrypt=true;trustServerCertificate=true;";
            conn = DriverManager.getConnection(url);
        } catch (Exception ex) {
            conn = null;
        }
        return conn;
    }
}
