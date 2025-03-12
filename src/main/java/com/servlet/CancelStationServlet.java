package com.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.dao.StationDAO;
import com.dao.TrainDAO;
import com.model.Station;

@WebServlet("/deleteStation")
public class CancelStationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	 String stationIdStr = request.getParameter("stationId");
         if (stationIdStr != null) {
             int stationId = Integer.parseInt(stationIdStr);

             // Delete the station by its ID
             StationDAO stationDAO = new StationDAO();
             stationDAO.deleteStationById(stationId);
         }

         // Redirect back to the station list page
         response.sendRedirect("addStation");
    }
}