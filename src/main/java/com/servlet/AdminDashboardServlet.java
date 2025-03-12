package com.servlet;

import jakarta.servlet.http.HttpServlet;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.dao.AdminDAO;
import com.dao.StationDAO;
import com.dao.TrainDAO;
import com.model.Admin;
import com.model.Station;
import com.model.Train;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    Scanner sc=new Scanner(System.in);
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if the admin is logged in (check the session)
        Admin admin = (Admin) request.getSession().getAttribute("admincred");

        if (admin == null) {
            // If no admin is logged in, redirect to login page
            response.sendRedirect("adminlogin.jsp");
            return;
        }

        // Fetch the list of trains and stations
        TrainDAO trainDAO = new TrainDAO();
        List<Train> trains = trainDAO.getAllTrains();

        StationDAO stationDAO = new StationDAO();
        List<Station> stations = stationDAO.getAllStations();

        // Set attributes for the JSP
        request.setAttribute("trainList", trains);
     
        request.setAttribute("stationList", stations);

        // Forward to the admin dashboard page
        request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
    }
}

