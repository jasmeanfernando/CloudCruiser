package com.cs336.pkg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RevenueReport
{
	/**
	 * Empty Constructor.
	 */
	public RevenueReport() {
	}
	
	/**
	 * Method that generates report by month by year.
	 * @param monthbyYear
	 * @return
	 * @throws SQLException
	 */
	public ResultSet getMonthByYearRevenue(String monthbyYear) throws SQLException {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create table query.
		String tablequery = "SELECT R.ReservationNumber, R.CustomerID, F.FlightNumber, F.AirlineID, F.TotalPrice " +
			"FROM Reservation R " +
			"JOIN Flight F ON R.FlightNumber = F.FlightNumber " +
			"WHERE DATE_FORMAT(R.PurchaseDateTime, '%Y-%m') = ?";
		
		// Create SQL statement.
		PreparedStatement tablestmt = con.prepareStatement(tablequery);
		tablestmt.setString(1, monthbyYear);
		
		// Execute table query.
		ResultSet tableresultset = tablestmt.executeQuery();
		
		// Return table for display.
		return tableresultset;
	}
	
	/**
	 * Method that generates report by flight.
	 * @param flight
	 * @return
	 * @throws SQLException
	 */
	public ResultSet getFlightRevenue(String flight) throws SQLException {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create table query.
		String tablequery = "SELECT R.ReservationNumber, R.CustomerID, F.FlightNumber, F.AirlineID, F.TotalPrice " +
			"FROM Reservation R " +
			"JOIN Flight F ON R.FlightNumber = F.FlightNumber " +
			"WHERE F.FlightNumber = ?";
		
		// Create SQL statement.
		PreparedStatement tablestmt = con.prepareStatement(tablequery);
		tablestmt.setString(1, flight);
		
		// Execute table query.
		ResultSet tableresultset = tablestmt.executeQuery();
		
		// Return table for display.
		return tableresultset;
	}
	
	/**
	 * Method that generates report by airline.
	 * @param airline
	 * @return
	 * @throws SQLException
	 */
	public ResultSet getAirlineRevenue(String airline) throws SQLException {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create table query.
		String tablequery = "SELECT R.ReservationNumber, R.CustomerID, F.FlightNumber, F.AirlineID, F.TotalPrice " +
			"FROM Reservation R " +
			"JOIN Flight F ON R.FlightNumber = F.FlightNumber " +
			"WHERE F.AirlineID = ?";
		
		// Create SQL statement.
		PreparedStatement tablestmt = con.prepareStatement(tablequery);
		tablestmt.setString(1, airline);
		
		// Execute table query.
		ResultSet tableresultset = tablestmt.executeQuery();
		
		// Return table for display.
		return tableresultset;
	}
	
	/**
	 * Method that generates report by customer email.
	 * @param email
	 * @return
	 * @throws SQLException
	 */
	public ResultSet getCustomerRevenue(String email) throws SQLException {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create table query.
		String tablequery = "SELECT R.ReservationNumber, R.CustomerID, F.FlightNumber, F.AirlineID, F.TotalPrice " +
			"FROM Reservation R " +
			"JOIN Flight F ON R.FlightNumber = F.FlightNumber " +
			"WHERE R.CustomerID = ?";
		
		// Create SQL statement.
		PreparedStatement tablestmt = con.prepareStatement(tablequery);
		tablestmt.setString(1, email);
		
		// Execute table query.
		ResultSet tableresultset = tablestmt.executeQuery();
		
		// Return table for display.
		return tableresultset;
	}
}
