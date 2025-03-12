package com.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.dao.CustomerDAO;
import com.model.Customer;

/**
 * Servlet implementation class ActivateUserServlet
 */
@WebServlet("/ActivateUserServlet")
public class ActivateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		Customer customer = (Customer)session.getAttribute("usercred");
		
		if(customer == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		
		CustomerDAO customerdao = new CustomerDAO();
		customer.setActivestatus(true);
        boolean isActivated = customerdao.updateCustomerStatus(customer); // Update `activestatus` in DB
        response.setContentType("application/json");
        response.getWriter().write("{\"status\":\"" + (isActivated ? "activated" : "failed") + "\"}");

		}

}

