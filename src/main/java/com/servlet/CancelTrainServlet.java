package com.servlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.dao.StationDAO;
import com.dao.TrainDAO;
import com.model.Admin;
import com.model.Station;

import java.io.IOException;

import jakarta.servlet.*;

@WebServlet("/cancelTrain")
public class CancelTrainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the train number to be canceled
        int trainNo = Integer.parseInt(request.getParameter("trainNo"));

        // Delete the train using the DAO
        TrainDAO trainDAO = new TrainDAO();
        trainDAO.deleteTrain(trainNo);

        // Redirect to the admin dashboard
        response.sendRedirect("adminDashboard");
    }
}

