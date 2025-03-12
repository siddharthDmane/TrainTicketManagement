package com.dao;

import com.model.Station;
import com.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StationDAO {
	// Method to add a new station to the database
	public void addStation(Station station) {
		String query = "INSERT INTO Station(stationName) VALUES (?)";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

			ps.setString(1, station.getStationName());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void deleteStationById(int stationId) {
	    // Queries
	    String findStationNameQuery = "SELECT stationName FROM Station WHERE stationId = ?";
	    String deleteTrainsQuery = "DELETE FROM Train WHERE fromStation = ? OR toStation = ?";
	    String deleteStationQuery = "DELETE FROM Station WHERE stationId = ?";

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement findStationNameStmt = conn.prepareStatement(findStationNameQuery);
	         PreparedStatement deleteTrainsStmt = conn.prepareStatement(deleteTrainsQuery);
	         PreparedStatement deleteStationStmt = conn.prepareStatement(deleteStationQuery)) {

	        // Fetch the station name using stationId
	        findStationNameStmt.setInt(1, stationId);
	        ResultSet rs = findStationNameStmt.executeQuery();

	        String stationName = null;
	        if (rs.next()) {
	            stationName = rs.getString("stationName");
	        }

	        // If station name is not found, the station doesn't exist
	        if (stationName == null) {
	            System.out.println("No station found with stationId: " + stationId);
	            return;
	        }

	        // Delete trains associated with this station
	        deleteTrainsStmt.setString(1, stationName);
	        deleteTrainsStmt.setString(2, stationName);
	        int trainsDeleted = deleteTrainsStmt.executeUpdate();
	        System.out.println(trainsDeleted + " train(s) deleted for station: " + stationName);

	        // Delete the station
	        deleteStationStmt.setInt(1, stationId);
	        int stationsDeleted = deleteStationStmt.executeUpdate();
	        System.out.println(stationsDeleted + " station(s) deleted with stationId: " + stationId);

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}



	// Method to retrieve all stations from the database
	public List<Station> getAllStations() {
		List<Station> stations = new ArrayList<>();
		String query = "SELECT * FROM Station";

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(query);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Station station = new Station();
				station.setStationId(rs.getInt("stationId"));
				station.setStationName(rs.getString("stationName"));
				stations.add(station);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return stations;
	}
}
