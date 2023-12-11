package com.cs336.pkg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class FlightReservation
{
	public FlightReservation() {
	}
	
	public void makeReservation(String firstName, String lastName, String email, String departingFlight, String arrivingFlight, String flightClass, String flightType) throws SQLException {
    	// Get database connection.
    	ApplicationDB db = new ApplicationDB();
    	Connection con = db.getConnection();
    	
    	// HANDLE DEPARTING FLIGHT:
    	// Create query.
    	String checkSeatsQuery = "SELECT Aircraft.AircraftID, "
    	        + "Aircraft.NumOfSeats AS TotalSeats, "
    	        + "COUNT(Reservation.ReservationNumber) AS ReservedSeats, "
    	        + "(Aircraft.NumOfSeats - COUNT(Reservation.ReservationNumber)) AS AvailableSeats "
    	        + "FROM Aircraft "
    	        + "JOIN Flight ON Aircraft.AircraftID = Flight.AircraftID "
    	        + "LEFT JOIN Reservation ON Flight.FlightNumber = Reservation.FlightNumber "
    	        + "WHERE Flight.FlightNumber = ? "
    	        + "GROUP BY Aircraft.AircraftID, Aircraft.NumOfSeats";
    	
    	// Create SQL statement.
    	PreparedStatement checkSeatsStatement = con.prepareStatement(checkSeatsQuery);
    	checkSeatsStatement.setInt(1, Integer.parseInt(departingFlight));
    	
    	// Execute query.
    	ResultSet checkSeatsResultSet = checkSeatsStatement.executeQuery();
    	
    	// If checkSeatsResultSet.next() result in a table...
    	// There are seats available.
    	if (checkSeatsResultSet.next()) {
    		// Obtain value in column 'AvailableSeats'.
    		int availableSeats = checkSeatsResultSet.getInt("AvailableSeats");
    		
    		if (availableSeats > 0) {
    			// Create reservation.
    			String reservationQuery = "INSERT INTO Reservation (CustomerID, FlightNumber, Class) "
    					+ "VALUES (?, ?, ?)";
    			
    			PreparedStatement reservationStatement = con.prepareStatement(reservationQuery);
    			reservationStatement.setString(1, email);
    			reservationStatement.setInt(2, Integer.parseInt(departingFlight));
    			reservationStatement.setString(3, flightClass);
    			reservationStatement.executeUpdate();
    		}
    		// No seats available.
    		else {
    			// Add to WaitingList since there are no available seats.
    			String addToWaitingListQuery = "INSERT INTO WaitingList (FlightNumber, CustomerID) "
    					+ "VALUES (?, ?)";
    			
    			PreparedStatement addToWaitingListStatement = con.prepareStatement(addToWaitingListQuery);
    			addToWaitingListStatement.setInt(1, Integer.parseInt(departingFlight));
    			addToWaitingListStatement.setString(2, email);
    			addToWaitingListStatement.executeUpdate();
    			
    			System.out.println("Departing--Added to WaitingList.");
    		}
    	}
    	
    	// HANDLE ARRIVING FLIGHT:
    	if (flightType.equalsIgnoreCase("roundtrip")) {
    		// Create query.
        	String checkSeatsQuery2 = "SELECT Aircraft.AircraftID, "
        	        + "Aircraft.NumOfSeats AS TotalSeats, "
        	        + "COUNT(Reservation.ReservationNumber) AS ReservedSeats, "
        	        + "(Aircraft.NumOfSeats - COUNT(Reservation.ReservationNumber)) AS AvailableSeats "
        	        + "FROM Aircraft "
        	        + "JOIN Flight ON Aircraft.AircraftID = Flight.AircraftID "
        	        + "LEFT JOIN Reservation ON Flight.FlightNumber = Reservation.FlightNumber "
        	        + "WHERE Flight.FlightNumber = ? "
        	        + "GROUP BY Aircraft.AircraftID, Aircraft.NumOfSeats";
        	
    		// Create SQL statement.
        	PreparedStatement checkSeatsStatement2 = con.prepareStatement(checkSeatsQuery2);
        	checkSeatsStatement2.setInt(1, Integer.parseInt(arrivingFlight));
        	
        	// Execute query.
        	ResultSet checkSeatsResultSet2 = checkSeatsStatement2.executeQuery();  
        	
        	// If checkSeatsResultSet2.next() result in a table...
        	// There are seats available.
        	if (checkSeatsResultSet2.next()) {
        		// Obtain value in column 'AvailableSeats'.
        		int availableSeats = checkSeatsResultSet2.getInt("AvailableSeats");
        		
        		if (availableSeats > 0) {
        			// Create reservation.
        			String reservationQuery = "INSERT INTO Reservation (CustomerID, FlightNumber, Class) "
        					+ "VALUES (?, ?, ?)";
        			
        			PreparedStatement reservationStatement = con.prepareStatement(reservationQuery);
        			reservationStatement.setString(1, email);
        			reservationStatement.setInt(2, Integer.parseInt(arrivingFlight));
        			reservationStatement.setString(3, flightClass);
        			reservationStatement.executeUpdate();
        		}
        		// No seats available.
        		else {
        			// Add to WaitingList since there are no available seats.
        			String addToWaitingListQuery = "INSERT INTO WaitingList (FlightNumber, CustomerID) "
        					+ "VALUES (?, ?)";
        			
        			PreparedStatement addToWaitingListStatement = con.prepareStatement(addToWaitingListQuery);
        			addToWaitingListStatement.setInt(1, Integer.parseInt(departingFlight));
        			addToWaitingListStatement.setString(2, email);
        			addToWaitingListStatement.executeUpdate();
        			
        			System.out.println("Arriving--Added to WaitingList.");
        		}
        	}
    	}
    	
    	// FLIGHTS RESERVED?
    	// Create ticket.
    	String ticketQuery = "INSERT INTO Ticket (FirstName, LastName, CustomerID, DepartingFlightNumber, ReturningFlightNumber) "
				+ "VALUES (?, ?, ?, ?, ?)";
		
		PreparedStatement ticketStatement = con.prepareStatement(ticketQuery);
		ticketStatement.setString(1, firstName);
		ticketStatement.setString(2, lastName);
		ticketStatement.setString(3, email);
		ticketStatement.setInt(4, Integer.parseInt(departingFlight));
		
		// Check if arrivingFlight is empty, and set null in the PreparedStatement.
        if (arrivingFlight == null || arrivingFlight.isEmpty()) {
            ticketStatement.setNull(5, java.sql.Types.INTEGER);
        }
        else {
            ticketStatement.setInt(5, Integer.parseInt(arrivingFlight));
        }
        
		ticketStatement.executeUpdate();
    }
}