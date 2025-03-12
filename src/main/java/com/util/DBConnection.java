//package com.util;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.SQLException;
//
//public class DBConnection {
////    private static final String URL = "jdbc:derby:C:\\Users\\pro97\\MyDB;create=true";
//    //private static final String USER = "admin";
//    //private static final String PASSWORD = "admin";
//
//    public static Connection getConnection() throws SQLException {
//        try {
//            Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
//            return DriverManager.getConnection("jdbc:derby:C:\\Users\\pro97\\MyDB;create=true");
//        } catch (ClassNotFoundException e) {
//            System.out.println("Database Driver not found!");
//            e.printStackTrace();
//            throw new SQLException(e);
//        }
//    }
//}

package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public static Connection getConnection() {
        Connection con = null;
        try {
        	Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
        	System.out.println("Driver loaded successfully");
            con = DriverManager.getConnection("jdbc:derby:C:\\Users\\pro97\\MyDB;create=true");
        } catch (ClassNotFoundException e) {
            System.err.println("Database Driver not found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Failed to connect to the database!");
            e.printStackTrace();
        }
        return con;
    }
}

