package com.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.dao.CustomerDAO;
import com.dao.TicketDAO;
import com.model.Customer;

/**
 * Servlet implementation class DeactivateUserServlet
 */
@WebServlet("/DeactivateUserServlet")
public class DeactivateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Servlet is called hereeeeeeeeee");
		HttpSession session = request.getSession(false);
		Customer customer = (Customer)session.getAttribute("usercred");
		
		if(customer == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		
		CustomerDAO customerdao = new CustomerDAO();
		TicketDAO ticketdao = new TicketDAO();

		customer.setActivestatus(false);
		
		boolean isDeactivated = customerdao.updateCustomerStatus(customer);	
		boolean areTicketsUpdated = ticketdao.cancelTicketsForUser(customer.getUserId());
		
        if (isDeactivated && areTicketsUpdated) {
            session.invalidate(); // Log the user out
            response.sendRedirect("login.jsp?message=deactivated"); // Redirect to login page with a message
        } else {
            request.setAttribute("error", "Failed to deactivate your account or cancel bookings.");
            request.getRequestDispatcher("userprofile.jsp").forward(request, response);
        }
	}

}

