package com.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.dao.StationDAO;
import com.model.Admin;
import com.model.Station;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;



@WebServlet("/addStation")
public class AddStationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        StationDAO stationDAO = new StationDAO();
        List<Station> stations = stationDAO.getAllStations();
        request.setAttribute("stationList", stations);

        request.getRequestDispatcher("addStation.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String stationName = request.getParameter("stationName");

        // Create a new Station object
        Station station = new Station();
        station.setStationName(stationName);

        // Add the station to the database
        StationDAO stationDAO = new StationDAO();
        stationDAO.addStation(station);

        // Redirect to show the updated list of stations
        response.sendRedirect("addStation");
    }
}


