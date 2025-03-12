package com.servlet;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.dao.CustomerDAO;
import com.model.Customer;
import java.io.IOException;

@WebServlet("/userlogin")
public class UserLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve login credentials
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.loginCustomer(username, password);
        HttpSession session = request.getSession();

        if (customer != null) {
            // Set session attribute
		
			 if (!customer.isActivestatus()) { 
				 System.out.print("error1");
			 customer.setActivestatus(true); 
			 boolean statusUpdated = customerDAO.updateCustomerStatus(customer); 
			 if (!statusUpdated) {
			 System.out.print("error2"); 
			 response.sendRedirect("errorPage.jsp"); return; }
			 }
		
            session.setAttribute("usercred", customer);
            session.setAttribute("loginMessage", "Login successful!");

            // Redirect to home page
            response.sendRedirect("userHome.jsp");
        } else {
            // Redirect to error page
        	session.setAttribute("loginMessage", "Invalid credentials");

            response.sendRedirect("errorPage.jsp");
        }
    }
}
