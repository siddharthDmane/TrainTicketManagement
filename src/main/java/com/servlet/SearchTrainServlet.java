package com.servlet;


import com.dao.TrainDAO;
import com.model.Train;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/searchTrain")
public class SearchTrainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usercred") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String fromStation = request.getParameter("fromStation");
        String toStation = request.getParameter("toStation");

        TrainDAO trainDAO = new TrainDAO();
        List<Train> searchedTrains = trainDAO.searchTrains(fromStation, toStation);
        List<Train> allTrains = trainDAO.getAllTrains();

        request.setAttribute("trainList", searchedTrains);
        request.setAttribute("allTrains", allTrains);
        request.setAttribute("stationList", trainDAO.getAllStations());

        request.getRequestDispatcher("searchTrain.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
