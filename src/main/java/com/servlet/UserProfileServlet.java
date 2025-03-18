package com.servlet;

import com.dao.CustomerDAO;
import com.model.Customer;
import com.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/userprofile")
public class UserProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Check if user is logged in
		HttpSession session = request.getSession(false);
		Customer customer = (Customer) session.getAttribute("usercred");

		if (customer == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		// Forward to user profile JSP
		request.setAttribute("customer", customer);
		request.getRequestDispatcher("userprofile.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		Customer customer = (Customer) session.getAttribute("usercred");

		if (customer == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		// Retrieve updated fields
		String newUsername = request.getParameter("username");
		String newEmail = request.getParameter("email");
		String newPhone = request.getParameter("phone");
		String newAddress = request.getParameter("address");
		String newAadhar = request.getParameter("aadhar");
		// String newPassword = request.getParameter("newPassword");
		String oldPassword = request.getParameter("oldPassword");

		CustomerDAO customerDAO = new CustomerDAO();

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		// Verify old password
		if (!customer.getPassword().equals( PasswordUtil.encryptPassword(oldPassword))) {
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Incorrect password');");
			out.println("window.location = 'userprofile';");
			out.println("</script>");
			return;
		}

		// Update the profile
		customer.setUserName(newUsername);
		customer.setEmail(newEmail);
		customer.setContactNumber(newPhone);
		customer.setAddress(newAddress);
		customer.setAadharNumber(newAadhar);
		// customer.setPassword(newPassword);

		boolean isUpdated = customerDAO.updateCustomerProfile(customer);

		if (isUpdated) {
			session.setAttribute("usercred", customer); // Update session data
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Details updated successfully');");
			out.println("window.location = 'searchTrain';");
			out.println("</script>");
		} else {
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Failed to update profile');");
			out.println("window.location = 'userprofile';");
			out.println("</script>");
		}
	}
}
