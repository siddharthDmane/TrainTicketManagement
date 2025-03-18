package com.servlet;


import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import com.dao.TrainDAO;
import com.dao.TicketDAO;
import com.model.Train;
import com.model.Ticket;
import com.model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/bookTicket")
public class TicketBookServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usercred") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String trainIdStr = request.getParameter("trainId");
            if (trainIdStr != null) {
                int trainId = Integer.parseInt(trainIdStr);

                // Fetch train details
                TrainDAO trainDAO = new TrainDAO();
                Train train = trainDAO.getTrainById(trainId);

                if (train != null) {
                    request.setAttribute("train", train);
                } else {
                    request.setAttribute("error", "Train not found.");
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid train ID.");
        }

        request.getRequestDispatcher("bookTicket.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("getDetails".equals(action)) {
            handleGetDetails(request, response);
        } else {
            handleBooking(request, response);
        }
    }

    private void handleGetDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String trainIdStr = request.getParameter("trainIdDetails");
            if (trainIdStr == null || trainIdStr.isEmpty()) {
                throw new IllegalArgumentException("Train ID is required.");
            }

            int trainId = Integer.parseInt(trainIdStr);
            TrainDAO trainDAO = new TrainDAO();
            Train train = trainDAO.getTrainById(trainId);

            if (train != null) {
                request.setAttribute("train", train);
            } else {
                request.setAttribute("error", "Train not found.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid train ID format.");
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
        }

        request.getRequestDispatcher("bookTicket.jsp").forward(request, response);
    }

    private void handleBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usercred") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Customer customer = (Customer) session.getAttribute("usercred");
            String trainIdStr = request.getParameter("trainIdBooking");
            String trainName = request.getParameter("trainName");
            String fromStation = request.getParameter("fromStation");
            String toStation = request.getParameter("toStation");
            String seatCountStr = request.getParameter("seatCount");
            String fareStr = request.getParameter("fare");
            String dateTimeString = request.getParameter("bookingDate");
            
            LocalDateTime localDateTime = LocalDateTime.parse(dateTimeString);

            // Format it to "yyyy-MM-dd HH:mm:ss"
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String formattedDateTime = localDateTime.format(formatter);
            
            System.out.println(formattedDateTime);

            if (trainIdStr == null || trainName == null || fromStation == null || toStation == null || seatCountStr == null || fareStr == null || formattedDateTime == null) {
                throw new IllegalArgumentException("All fields are required.");
            }

            int trainId = Integer.parseInt(trainIdStr);
            int noOfSeats = Integer.parseInt(seatCountStr);
            int farePerSeat = Integer.parseInt(fareStr);
            int totalFare = noOfSeats * farePerSeat;

            String pnr = "PNR" + (int) (Math.random() * 1000000);

            Ticket ticket = new Ticket();
            ticket.setPnr(pnr);
            ticket.setTrainNumber(trainId);
            ticket.setTrainName(trainName);
            ticket.setFromStation(fromStation);
            ticket.setToStation(toStation);
            ticket.setSeatCount(noOfSeats);
            ticket.setTotalFare(totalFare);
            ticket.setBookingDate((Timestamp.valueOf(formattedDateTime)));
            ticket.setUserId(customer.getUserId());

            TicketDAO ticketDAO = new TicketDAO();
            boolean isBooked = ticketDAO.bookTicket(ticket);

            if (isBooked) {
            	// Decrease the available seats in the train
                TrainDAO trainDAO = new TrainDAO();
                boolean seatsUpdated = trainDAO.decreaseSeatCount(trainId, noOfSeats);

               
                if (seatsUpdated) {
                    response.sendRedirect("userHome.jsp?success=" + pnr);
                } else {
                    // Rollback the ticket booking if seat update fails
                    ticketDAO.cancelTicket(pnr);
                    request.setAttribute("error", "Failed to update train availability. Booking canceled.");
                    request.getRequestDispatcher("bookTicket.jsp").forward(request, response);
                }
                
            } else {
                response.sendRedirect("errorPage.jsp");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid number format. Please check your inputs.");
            request.getRequestDispatcher("bookTicket.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("bookTicket.jsp").forward(request, response);
        }
    }
}
