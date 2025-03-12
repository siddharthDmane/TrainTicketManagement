package com.dao;


import com.model.Customer;
import com.util.DBConnection;
import com.util.PasswordUtil;

import java.sql.*;

public class CustomerDAO {

    public boolean registerCustomer(Customer customer) {
        String query = "INSERT INTO Customer(userName, email, password, address, contactNumber,aadharNumber) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            //ps.setInt(1, customer.getUserId());
            ps.setString(1, customer.getUserName());
            ps.setString(2, customer.getEmail());
            ps.setString(3, customer.getPassword());
            ps.setString(4, customer.getAddress());
            ps.setString(5, customer.getContactNumber());
            ps.setString(6, customer.getAadharNumber());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Customer loginCustomer(String username, String password) {
        String query = "SELECT * FROM Customer WHERE userName = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, username);
            ps.setString(2, PasswordUtil.encryptPassword(password));

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
				
				 String storedPassword = rs.getString("password"); // Encrypted password from
				 System.out.println(storedPassword+" " + password); 
				 if (PasswordUtil.verifyPassword(password, storedPassword)) {
                Customer customer = new Customer();
                customer.setUserId(rs.getInt("userId"));
                customer.setUserName(rs.getString("userName"));
                customer.setEmail(rs.getString("email"));
                customer.setPassword(rs.getString("password"));
                customer.setAddress(rs.getString("address"));
                customer.setContactNumber(rs.getString("contactNumber"));
                customer.setAadharNumber(rs.getString("aadharNumber"));
                return customer;
                
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
 // Update customer profile
    public boolean updateCustomerProfile(Customer customer) {
        String query = "UPDATE Customer SET username = ?, email = ?, contactNumber = ?, address = ?, aadhar = ? WHERE userId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, customer.getUserName());
            stmt.setString(2, customer.getEmail());
            stmt.setString(3, customer.getContactNumber());
            stmt.setString(4, customer.getAddress());
            stmt.setString(5, customer.getAadharNumber());
          //  stmt.setString(6, customer.getPassword());
            stmt.setInt(6, customer.getUserId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateCustomerStatus(Customer customer) {
        String query = "UPDATE Customer SET activestatus = ? WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setBoolean(1, customer.isActivestatus());
            ps.setInt(2, customer.getUserId());

            return ps.executeUpdate() > 0; // Return true if update succeeds
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
