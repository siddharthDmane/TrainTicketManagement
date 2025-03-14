package com.dao;


import com.model.Ticket;
import com.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TicketDAO {


    // Add a new ticket to the database
    public boolean addTicket(Ticket ticket) {
        String query = "INSERT INTO ticket(pnr, trainNumber, trainName, fromStation, toStation, seatCount, totalFare, userId) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, ticket.getPnr());
            stmt.setLong(2, ticket.getTrainNumber());
            stmt.setString(3, ticket.getTrainName());
            stmt.setString(4, ticket.getFromStation());
            stmt.setString(5, ticket.getToStation());
            stmt.setInt(6, ticket.getSeatCount());
            stmt.setDouble(7, ticket.getTotalFare());
            stmt.setInt(8, ticket.getUserId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    //book cricket
    public boolean bookTicket(Ticket ticket) {
        String query = "INSERT INTO Ticket (pnr, trainnumber, trainName, fromStation, toStation, seatCount, totalFare, userId) "
                     + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, ticket.getPnr());
            preparedStatement.setLong(2, ticket.getTrainNumber());
            preparedStatement.setString(3, ticket.getTrainName());
            preparedStatement.setString(4, ticket.getFromStation());
            preparedStatement.setString(5, ticket.getToStation());
            preparedStatement.setInt(6, ticket.getSeatCount());
            preparedStatement.setDouble(7, ticket.getTotalFare());
            preparedStatement.setInt(8, ticket.getUserId());

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    // Retrieve a list of tickets for a specific user
    public List<Ticket> getTicketsByUserId(int userId) {
        String query = "SELECT * FROM ticket WHERE userId = ?";
        List<Ticket> tickets = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Ticket ticket = mapRowToTicket(rs);
                tickets.add(ticket);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tickets;
    }

    // Retrieve all tickets (for admin purposes)
    public List<Ticket> getAllTickets() {
        String query = "SELECT * FROM ticket";
        List<Ticket> tickets = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Ticket ticket = mapRowToTicket(rs);
                tickets.add(ticket);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tickets;
    }

    // Delete a ticket by its ID
    /*public boolean cancelTicket(String pnr) {
        String query = "DELETE FROM tickets WHERE pnr = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, pnr);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }*/
    
    public boolean cancelTicket(String pnr) {
        String query = "SELECT trainNumber,seatCount FROM ticket WHERE pnr = ?"; // First, retrieve the train number for the ticket
        int trainId = 0;
        int seatcount = 0;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, pnr);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                trainId = rs.getInt("trainNumber");
                seatcount = rs.getInt("seatCount");
                // Get the train number from the ticket
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (trainId != 0) {
            // Now proceed with the ticket cancellation and increasing the seat count
            String deleteTicketQuery = "DELETE FROM ticket WHERE pnr = ?"; // Delete the ticket

            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(deleteTicketQuery)) {

                stmt.setString(1, pnr);
                int rowsDeleted = stmt.executeUpdate();

                if (rowsDeleted > 0) {
                    // If the ticket was successfully deleted, increase the seat count
                    TrainDAO traindao = new TrainDAO();
                    traindao.increaseSeatCount(trainId, seatcount); // Increase seat by 1 for each canceled ticket
                    return true;
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return false;
    }
    
	/*
	 * public boolean cancelTicketsForUser(int userId) { String selectQuery =
	 * "SELECT trainNumber, COUNT(*) AS ticketCount FROM tickets WHERE userId = ? GROUP BY trainNumber"
	 * ; String deleteQuery = "DELETE FROM tickets WHERE userId = ?";
	 * 
	 * try (Connection connection = DBConnection.getConnection(); PreparedStatement
	 * selectStmt = connection.prepareStatement(selectQuery); PreparedStatement
	 * deleteStmt = connection.prepareStatement(deleteQuery)) {
	 * 
	 * // Step 1: Get the train numbers and ticket count for the user's tickets
	 * selectStmt.setInt(1, userId); ResultSet rs = selectStmt.executeQuery();
	 * 
	 * // Step 2: For each train, update the available seat count while (rs.next())
	 * { int trainId = rs.getInt("trainNumber"); int ticketsToCancel =
	 * rs.getInt("ticketCount");
	 * 
	 * // Increase the seat count for the respective train TrainDAO traindao = new
	 * TrainDAO(); traindao.increaseSeatCount(trainId, ticketsToCancel); }
	 * 
	 * // Step 3: Delete all tickets for the user deleteStmt.setInt(1, userId);
	 * return deleteStmt.executeUpdate() > 0;
	 * 
	 * } catch (SQLException e) { e.printStackTrace(); } return false; }
	 */
    
    public boolean cancelTicketsForUser(int userId) {
        String selectQuery = "SELECT trainNumber, SUM(seatCount) AS totalSeats FROM ticket WHERE userId = ? GROUP BY trainNumber";
        String deleteQuery = "DELETE FROM ticket WHERE userId = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement selectStmt = connection.prepareStatement(selectQuery);
             PreparedStatement deleteStmt = connection.prepareStatement(deleteQuery)) {

            // Step 1: Get the train numbers and total seats booked by the user for each train
            selectStmt.setInt(1, userId);
            ResultSet rs = selectStmt.executeQuery();

            // Step 2: For each train, update the available seat count
            TrainDAO trainDAO = new TrainDAO();
            while (rs.next()) {
                int trainId = rs.getInt("trainNumber");
                int totalSeatsToCancel = rs.getInt("totalSeats");

                // Increase the seat count for the respective train
                trainDAO.increaseSeatCount(trainId, totalSeatsToCancel);
            }

            // Step 3: Delete all tickets for the user
            deleteStmt.setInt(1, userId);
            return deleteStmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    // Update ticket details (optional, based on requirements)
    public boolean updateTicket(Ticket ticket) {
        String query = "UPDATE ticket SET trainNumber = ?, trainName = ?, fromStation = ?, toStation = ?, seatCount = ?, totalFare = ? " +
                       "WHERE ticketId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setLong(1, ticket.getTrainNumber());
            stmt.setString(2, ticket.getTrainName());
            stmt.setString(3, ticket.getFromStation());
            stmt.setString(4, ticket.getToStation());
            stmt.setInt(5, ticket.getSeatCount());
            stmt.setDouble(6, ticket.getTotalFare());
            stmt.setInt(7, ticket.getTicketId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Utility: Map a ResultSet row to a Ticket object
    private Ticket mapRowToTicket(ResultSet rs) throws SQLException {
        Ticket ticket = new Ticket();
        ticket.setTicketId(rs.getInt("ticketId"));
        ticket.setPnr(rs.getString("pnr"));
        ticket.setTrainNumber(rs.getLong("trainNumber"));
        ticket.setTrainName(rs.getString("trainName"));
        ticket.setFromStation(rs.getString("fromStation"));
        ticket.setToStation(rs.getString("toStation"));
        ticket.setSeatCount(rs.getInt("seatCount"));
        ticket.setTotalFare(rs.getDouble("totalFare"));
        ticket.setUserId(rs.getInt("userId"));
        ticket.setBookingDate(rs.getTimestamp("bookingDate"));
        return ticket;
    }
}
