package com.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.dao.TrainDAO;
import com.model.Train;

/**
 * Servlet implementation class UpdateTrainServlet
 */
@WebServlet("/UpdateTrainServlet")
public class UpdateTrainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("updateTrain.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int trainNo = Integer.parseInt(request.getParameter("trainNo"));
		String trainName = request.getParameter("trainName");
		String fromStation = request.getParameter("fromStation");
		String toStation = request.getParameter("toStation");
		int availableSeats = Integer.parseInt(request.getParameter("availableSeats"));
		int fare = Integer.parseInt(request.getParameter("fare"));
		
		Train train = new Train();
		train.setTrainNo(trainNo);
		train.setTrainName(trainName);
		train.setFromStation(fromStation);
		train.setToStation(toStation);
		train.setAvailableSeats(availableSeats);
		train.setFare(fare);
		
		TrainDAO traindao = new TrainDAO();
		boolean isUpdated = traindao.updateTrainDetails(train);
		if(isUpdated){
			request.setAttribute("success", "Train details updated successfully.");
		}else{
			request.setAttribute("error", "Failed to update train details.");
		}
		
		doGet(request,response);
		
	}

}
