package com.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.dao.TicketDAO;

@WebServlet("/cancelTicket")
public class TicketCancel  extends HttpServlet{

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	  

	    
	        String pnr = request.getParameter("pnr");
	        if (pnr != null) {
	            TicketDAO ticketDAO = new TicketDAO();
	            boolean isCanceled = ticketDAO.cancelTicket(pnr);
	            
	            if (isCanceled) {
	            	 response.sendRedirect("userHome.jsp?sucess=" + pnr);
	            } else {
	                request.setAttribute("error", "Failed to cancel the ticket. Please try again.");
	            }
	        }
	        
	    }

}
