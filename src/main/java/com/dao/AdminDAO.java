package com.dao;


import com.model.Admin;
import com.util.DBConnection;

import java.sql.*;

public class AdminDAO {

    // Admin Registration
    public boolean registerAdmin(Admin admin) {
        String query = "INSERT INTO Admin(uname, name, password, email, phoneNo) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, admin.getUname());
            ps.setString(2, admin.getName());
            ps.setString(3, admin.getPassword());
            ps.setString(4, admin.getEmail());
            ps.setString(5, admin.getPhoneNo());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Admin Login
    public Admin loginAdmin(String username, String password) {
        String query = "SELECT * FROM Admin WHERE uname = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                System.err.println("Failed to establish a database connection.");
                return null; // or handle as needed
            }
            
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, username);
                ps.setString(2, password);

                ResultSet rs = ps.executeQuery();
                
                if (rs.next()) {
                    Admin admin = new Admin();
                    admin.setAdminId(rs.getInt("adminId"));
                    admin.setUname(rs.getString("uname"));
                    admin.setName(rs.getString("name"));
                    admin.setPassword(rs.getString("password"));
                    admin.setEmail(rs.getString("email"));
                    admin.setPhoneNo(rs.getString("phoneNo"));
                    return admin;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
