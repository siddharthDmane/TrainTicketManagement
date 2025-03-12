package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import com.model.Train;
import com.util.DBConnection;

public class TrainDAO {
	
	//User
	 public List<Train> searchTrains(String fromStation, String toStation) {
	        List<Train> trains = new ArrayList<>();
	        String query = "SELECT * FROM Train WHERE fromStation = ? AND toStation = ?";
	        
	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
	            preparedStatement.setString(1, fromStation);
	            preparedStatement.setString(2, toStation);
	            ResultSet rs = preparedStatement.executeQuery();

	            while (rs.next()) {
	                Train train = new Train();
	                train.setTrainNo(rs.getInt("trainNo"));
	                train.setTrainName(rs.getString("trainName"));
	                train.setFromStation(rs.getString("fromStation"));
	                train.setToStation(rs.getString("toStation"));
	                train.setAvailableSeats(rs.getInt("availableSeats"));
	                train.setFare(rs.getInt("fare"));
	                trains.add(train);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return trains;
	    }
	 //User
	 public Train getTrainById(int trainId) {
	        Train train = null;
	        String query = "SELECT * FROM train WHERE trainNo = ?";

	        try (Connection conn = DBConnection.getConnection();
	             PreparedStatement ps = conn.prepareStatement(query)) {
	            ps.setInt(1, trainId);
	            try (ResultSet rs = ps.executeQuery()) {
	                if (rs.next()) {
	                    train = new Train();
	                    train.setTrainNo(rs.getInt("trainNo"));
	                    train.setTrainName(rs.getString("trainname"));
	                    train.setFromStation(rs.getString("fromstation"));
	                    train.setToStation(rs.getString("tostation"));
	                    train.setAvailableSeats(rs.getInt("availableSeats"));
	                    train.setFare(rs.getInt("fare"));
	                }
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return train;
	    }
	 public List<String> getAllStations() {
	        List<String> stations = new ArrayList<>();
	        String query = "SELECT DISTINCT stationName FROM Station";

	        try (Connection connection = DBConnection.getConnection();
	             Statement statement = connection.createStatement();
	             ResultSet rs = statement.executeQuery(query)) {
	            while (rs.next()) {
	                stations.add(rs.getString("stationName"));
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return stations;
	    }

	    //decrease seats
	 public boolean decreaseSeatCount(int trainId, int seatsToDecrease) {
	        String query = "UPDATE train SET availableSeats = availableSeats - ? WHERE trainNo = ? AND availableSeats >= ?";
	        try (Connection conn = DBConnection.getConnection();
	             PreparedStatement pstmt = conn.prepareStatement(query)) {
	            
	            pstmt.setInt(1, seatsToDecrease);
	            pstmt.setInt(2, trainId);
	            pstmt.setInt(3, seatsToDecrease);
	            
	            int rowsUpdated = pstmt.executeUpdate();
	            return rowsUpdated > 0; // Return true if the update was successful
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return false;
	    }
	    
	    public boolean increaseSeatCount(int trainId, int seatsToIncrease) {
	        String query = "UPDATE train SET availableSeats = availableSeats + ? WHERE trainNo = ?";

	        try (Connection conn = DBConnection.getConnection();
	             PreparedStatement pstmt = conn.prepareStatement(query)) {

	            pstmt.setInt(1, seatsToIncrease);
	            pstmt.setInt(2, trainId);

	            int rowsUpdated = pstmt.executeUpdate();
	            return rowsUpdated > 0; // Return true if the update was successful
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return false;
	    }
	 //Admin


    public List<Train> getAllTrains() {
    	Scanner sc=new Scanner(System.in);
        List<Train> trains = new ArrayList<>();
        String query = "SELECT * FROM Train";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) { 
//            	System.out.printf("%-10d %-20s %-20s %-20s %-15d %-10d%n",rs.getInt("trainNo"),
//                        rs.getString("trainName"),
//                        rs.getString("fromStation"),
//                        rs.getString("toStation"),
//                        rs.getInt("availableSeats"),
//                        rs.getInt("fare"));
                Train train = new Train();
                train.setTrainNo(rs.getInt("trainNo"));
                train.setTrainName(rs.getString("trainName"));
                train.setFromStation(rs.getString("fromStation"));
                train.setToStation(rs.getString("toStation"));
                train.setAvailableSeats(rs.getInt("availableSeats"));
                train.setFare(rs.getInt("fare"));
                trains.add(train);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        sc.close();
        return trains;
    }

    public void addTrain(Train train) {
        String query = "INSERT INTO Train(trainName, fromStation, toStation, availableSeats, fare) VALUES ( ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {

            //ps.setInt(1, train.getTrainNo());
            ps.setString(1, train.getTrainName());
            ps.setString(2, train.getFromStation());
            ps.setString(3, train.getToStation());
            ps.setInt(4, train.getAvailableSeats());
            ps.setInt(5, train.getFare());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public boolean updateTrainDetails(Train train){
    	String query = "UPDATE Train SET trainName = ?, fromStation = ?, toStation = ?, availableSeats = ?, fare = ? WHERE trainNo = ?";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {

            //ps.setInt(1, train.getTrainNo());
            ps.setString(1, train.getTrainName());
            ps.setString(2, train.getFromStation());
            ps.setString(3, train.getToStation());
            ps.setInt(4, train.getAvailableSeats());
            ps.setInt(5, train.getFare());
            
            ps.setInt(6, train.getTrainNo());

            return ps.executeUpdate()>0;
        } catch (SQLException e) {
            e.printStackTrace();
        }    
        return false;
        }
    

    public void deleteTrain(int trainNo) {
        String query = "DELETE FROM Train WHERE trainNo = ?";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, trainNo);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
}
