package com.servlet;


import com.dao.AdminDAO;
import com.dao.CustomerDAO;

import com.model.Customer;
import com.util.PasswordUtil;
import com.model.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private CustomerDAO customerDAO = new CustomerDAO();
    private AdminDAO adminDAO = new AdminDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try{  if ("register".equals(action)) {
            String userName = request.getParameter("userName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String address = request.getParameter("address");
            String contactNumber = request.getParameter("contactNumber");
            String aadharNumber = request.getParameter("aadharNumber");

            Customer customer = new Customer();
            //customer.setUserId((int) (Math.random() * 10000));
            customer.setUserName(userName);
            customer.setEmail(email);
			customer.setPassword(PasswordUtil.encryptPassword(password));
/*            customer.setPassword(password);
*/            customer.setAddress(address);
            customer.setContactNumber(contactNumber);
            customer.setAadharNumber(aadharNumber);

            boolean isRegistered = customerDAO.registerCustomer(customer);
            if (isRegistered) {
                response.sendRedirect("login.jsp?message=Registration successful! Please login.");
            } else {
            	response.sendRedirect("errorPage.jsp");
            }
        }  else if("registerAdmin".equals(action)) {
            String uname = request.getParameter("uname");
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String phoneNo = request.getParameter("phoneNo");

            Admin admin = new Admin();
            admin.setUname(uname);
            admin.setName(name);
            admin.setPassword(password);
            admin.setEmail(email);
            admin.setPhoneNo(phoneNo);

            boolean isRegistered = adminDAO.registerAdmin(admin);
            if (isRegistered) {
            	response.sendRedirect("adminlogin.jsp");
            } else {
            	response.sendRedirect("errorPage.jsp");
            }
        } 
        
        
        } catch (Exception e) {
            // If any exception occurs, redirect to the error page
            e.printStackTrace();
            response.sendRedirect("errorPage.jsp");
        }
    }
}
