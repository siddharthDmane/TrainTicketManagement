package com.servlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.dao.AdminDAO;
import com.model.Admin;

import java.io.IOException;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/adminlogin")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get admin login details from the form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        AdminDAO adminDAO = new AdminDAO();
        Admin admin = adminDAO.loginAdmin(username, password);
        HttpSession session = request.getSession();

        // Check if admin exists
        if (admin != null) {
            session.setAttribute("admincred", admin);
            session.setAttribute("loginMessage", "Login successful!");
            response.sendRedirect("adminDashboard");
        } else {
            session.setAttribute("loginMessage", "Invalid credentials");
            response.sendRedirect("errorPage.jsp");
        }

    }
}
