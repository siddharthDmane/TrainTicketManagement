package com.servlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.dao.StationDAO;
import com.dao.TrainDAO;
import com.model.Admin;
import com.model.Station;
import com.model.Train;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.*;

@WebServlet("/addTrainPage")
public class AddTrainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch station list
        	 StationDAO stationDAO=new StationDAO();
            List<Station> stationList = stationDAO.getAllStations();
            // Add to request scope
            request.setAttribute("stationList", stationList);
            // Forward to addTrain.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("addTrain.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorPage.jsp"); // Handle errors gracefully
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if the admin is logged in
        Admin admin = (Admin) request.getSession().getAttribute("admincred");
        if (admin == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }

        // Get the form parameters
        //int trainNo = (int) (Math.random() * 10000);
        String trainName = request.getParameter("trainName");
        String fromStation = request.getParameter("fromStation");
        String toStation = request.getParameter("toStation");
        int availableSeats = Integer.parseInt(request.getParameter("availableSeats"));
        int fare = Integer.parseInt(request.getParameter("fare"));

        // Create a Train object and insert it into the database
        Train train = new Train(trainName, fromStation, toStation, availableSeats, fare);
        TrainDAO trainDAO = new TrainDAO();
        trainDAO.addTrain(train);
        
        StationDAO stationDAO=new StationDAO();
		List<Station> stationList = stationDAO.getAllStations();
        // Add to request scope
        request.setAttribute("stationList", stationList);
        // Forward to addTrain.jsp
        //RequestDispatcher dispatcher = request.getRequestDispatcher("adminDashboard.jsp");
        //dispatcher.forward(request, response);
        response.sendRedirect("adminDashboard");

       
    }
}
