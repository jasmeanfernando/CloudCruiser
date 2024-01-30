package com.cs336.pkg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class FlightSystem
{
	/**
	 * Empty Constructor.
	 */
	public FlightSystem() {
	}
	
	/**
	 * Method that edit aircrafts.
	 * @param aircraftAction
	 * @param aircraftId
	 * @param aircraftAirline
	 * @param aircraftSeats
	 * @throws SQLException
	 */
	public void editAircraft(String aircraftAction, String aircraftId, String aircraftAirline, String aircraftSeats) throws SQLException {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
		String query = "";
		if (aircraftAction.equalsIgnoreCase("addAircraft")) {
			query = "INSERT INTO Aircraft (AircraftID, AirlineID, NumOfSeats) VALUES (?, ?, ?)";
		}
		else {
			query = "DELETE FROM Aircraft WHERE AircraftID = ? AND AirlineID = ? AND NumOfSeats = ?";
		}
		
		// Create SQL statement.
		PreparedStatement prepstmt = con.prepareStatement(query);
		prepstmt.setString(1, aircraftId);
		prepstmt.setString(2, aircraftAirline);
		prepstmt.setString(3, aircraftSeats);
		
		// Execute query.
		int resultset = prepstmt.executeUpdate();
	}
	
	/**
	 * Method that edit airports.
	 * @param airportAction
	 * @param airportId
	 * @param airportName
	 * @param airportCity
	 * @param airportState
	 * @param airportCountry
	 * @throws SQLException
	 */
	public void editAirport(String airportAction, String airportId, String airportName, String airportCity, String airportState, String airportCountry) throws SQLException {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
		String query = "";
		if (airportAction.equalsIgnoreCase("addAirport")) {
			query = "INSERT INTO Airport (AirportID, AirportName, City, State, Country) VALUES (?, ?, ?, ?, ?)";
		}
		else {
			query = "DELETE FROM Airport WHERE AirportID = ? AND AirportName = ? AND City = ? AND State = ? AND Country = ?";
		}
		
		// Create SQL statement.
		PreparedStatement prepstmt = con.prepareStatement(query);
		prepstmt.setString(1, airportId);
		prepstmt.setString(2, airportName);
		prepstmt.setString(3, airportCity);
		prepstmt.setString(4, airportState);
		prepstmt.setString(5, airportCountry);
		
		// Execute query.
		int resultset = prepstmt.executeUpdate();
	}
	
	/**
	 * Method that edit flights.
	 * @param flightAction
	 * @param flightAirline
	 * @param flightAircraft
	 * @param flightDepartureAirport
	 * @param flightDepartureDateTime
	 * @param flightArrivalAirport
	 * @param flightArrivalDateTime
	 * @param flightLayover
	 * @param flightInternational
	 * @param flightDuration
	 * @param flightPrice
	 * @throws SQLException
	 */
	public void editFlight(String flightAction, String flightAirline, String flightAircraft, String flightDepartureAirport, String flightDepartureDateTime, String flightArrivalAirport, String flightArrivalDateTime, String flightLayover, String flightInternational, String flightDuration, String flightPrice) throws SQLException {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
		String query = "";
		if (flightAction.equalsIgnoreCase("addFlight")) {
			query = "INSERT INTO Flight (AirlineID, AircraftID, DepartureAirportID, ArrivalAirportID, "
				+ "DepartureDateTime, ArrivalDateTime, FlightDuration, IsLayover, IsInternational, TotalPrice) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		}
		else {
			query = "DELETE FROM Flight WHERE AirlineID = ? AND AircraftID = ? AND DepartureAirportID = ? AND ArrivalAirportID = ? AND DepartureDateTime = ? AND ArrivalDateTime = ? AND FlightDuration = ? AND IsLayover = ? AND IsInternational = ? AND TotalPrice = ?";
		}
		
		// Create SQL statement.
		PreparedStatement prepstmt = con.prepareStatement(query);
		prepstmt.setString(1, flightAirline);
		prepstmt.setString(2, flightAircraft);
		prepstmt.setString(3, flightDepartureAirport);
		prepstmt.setString(4, flightArrivalAirport);
		prepstmt.setString(5, flightDepartureDateTime);
		prepstmt.setString(6, flightArrivalDateTime);
		prepstmt.setString(7, flightDuration);
		prepstmt.setString(8, flightLayover);
		prepstmt.setString(9, flightInternational);
		prepstmt.setString(10, flightPrice);
		
		// Execute query.
		int resultset = prepstmt.executeUpdate();
	}
}
