package com.cs336.pkg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class FlightReservation
{
	/**
	 * Empty Constructor.
	 */
	public FlightReservation() {
	}
	
	/**
	 * Method that makes flight reservations and creates a ticket.
	 * If seats available on flight, add to Reservation table.
	 * Otherwise, add to WaitingList table.
	 * @param firstName
	 * @param lastName
	 * @param email
	 * @param departingFlight
	 * @param arrivingFlight
	 * @param flightClass
	 * @param flightType
	 * @param newTicket
	 * @throws SQLException
	 */
	public void makeReservation(String firstName, String lastName, String email, String departingFlight, String arrivingFlight, String flightClass, String flightType, boolean newTicket) throws SQLException {
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
    			String reservationQuery = "INSERT INTO Reservation (CustomerID, FlightNumber, Class) VALUES (?, ?, ?)";
    			
    			PreparedStatement reservationStatement = con.prepareStatement(reservationQuery);
    			reservationStatement.setString(1, email);
    			reservationStatement.setInt(2, Integer.parseInt(departingFlight));
    			reservationStatement.setString(3, flightClass);
    			reservationStatement.executeUpdate();
    			
    			System.out.println("Added to Reservation (Departing)");
    		}
    		// No seats available.
    		else {
    			// Add to WaitingList since there are no available seats.
    			String addToWaitingListQuery = "INSERT INTO WaitingList (CustomerID, FirstName, LastName, FlightNumber, Class) VALUES (?, ?, ?, ?, ?)";
    			
    			PreparedStatement addToWaitingListStatement = con.prepareStatement(addToWaitingListQuery);
    			addToWaitingListStatement.setString(1, email);
    			addToWaitingListStatement.setString(2, firstName);
    			addToWaitingListStatement.setString(3, lastName);
    			addToWaitingListStatement.setInt(4, Integer.parseInt(departingFlight));
    			addToWaitingListStatement.setString(5, flightClass);
    			addToWaitingListStatement.executeUpdate();
    			
    			System.out.println("Added to WaitingList (Departing)");
    		}
    	}
    	
    	// HANDLE ARRIVING FLIGHT:
    	if (flightType != null && flightType.equalsIgnoreCase("round")) {
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
        			
        			System.out.println("Added to Reservation (Arriving)");
        		}
        		// No seats available.
        		else {
        			// Add to WaitingList since there are no available seats.
        			String addToWaitingListQuery = "INSERT INTO WaitingList (CustomerID, FirstName, LastName, FlightNumber, Class) VALUES (?, ?, ?, ?, ?, ?)";
        			
        			PreparedStatement addToWaitingListStatement = con.prepareStatement(addToWaitingListQuery);
        			addToWaitingListStatement.setString(1, email);
        			addToWaitingListStatement.setString(2, firstName);
        			addToWaitingListStatement.setString(3, lastName);
        			addToWaitingListStatement.setInt(4, Integer.parseInt(arrivingFlight));
        			addToWaitingListStatement.setString(5, flightClass);
        			addToWaitingListStatement.executeUpdate();
        			
        			System.out.println("Added to WaitingList (Arriving)");
        		}
        	}
    	}
    	
    	// Create ticket:
    	// newTicket = true if method is being called by PassengerBookFlight.jsp.
    	// newTicket = false if method is being called by FlightReservation.java.
    	if (newTicket) {
    		String ticketQuery = "INSERT INTO Ticket (CustomerID, FirstName, LastName, DepartingFlightNumber, ReturningFlightNumber) VALUES (?, ?, ?, ?, ?)";
    		
    		PreparedStatement ticketStatement = con.prepareStatement(ticketQuery);
    		ticketStatement.setString(1, email);
    		ticketStatement.setString(2, firstName);
    		ticketStatement.setString(3, lastName);
    		ticketStatement.setInt(4, Integer.parseInt(departingFlight));
    		// Check if arrivingFlight is empty -> set null in the PreparedStatement.
            if (arrivingFlight == null || arrivingFlight.isEmpty()) {
                ticketStatement.setNull(5, java.sql.Types.INTEGER);
            }
            else {
                ticketStatement.setInt(5, Integer.parseInt(arrivingFlight));
            }
            
    		ticketStatement.executeUpdate();
    		
    		System.out.println("Added to Ticket.");
    	}
		
		// Close connection.
        con.close();
    }
	
	/**
	 * Method that cancels flight reservations and deletes a ticket (if passenger is first or business class).
	 * Passengers on waiting list of said flight are then given a reservation.
	 * @param email
	 * @param ticket
	 * @throws SQLException
	 */
	public void cancelReservation(String email, String ticket) throws SQLException {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
	    Connection con = db.getConnection();
	    
	    // DELETE RESERVATIONS:
	    // Create query -> Accounts for empty ReturningFlightNumber.
	    String flightQuery = "DELETE FROM Reservation "
	    		+ "WHERE FlightNumber IN (SELECT DepartingFlightNumber "
	    		+ "FROM Ticket "
	    		+ "WHERE TicketNumber = ? "
	    		+ "UNION "
	    		+ "SELECT COALESCE(ReturningFlightNumber, 0) "
	    		+ "FROM Ticket "
	    		+ "WHERE TicketNumber = ?"
	    		+ ")\n"
	    		+ "AND Class IN ('First', 'Business')";
	    
	    // Create SQL statement.
	    PreparedStatement flightStatement = con.prepareStatement(flightQuery);
	    flightStatement.setInt(1, Integer.parseInt(ticket));
	    flightStatement.setInt(2, Integer.parseInt(ticket));
	    
	    // Execute query.
	    int rowsAffectedReservation = flightStatement.executeUpdate();
	    System.out.println("Removed from Reservation: " + rowsAffectedReservation);
	    
	    // IF RESERVATION(S) DELETED:
	    if (rowsAffectedReservation > 0) {
	    	// DELETE TICKET:
	    	// Create query.
	    	String waitingListQuery = "SELECT WaitingID, CustomerID, FirstName, LastName, FlightNumber, Class FROM WaitingList";
	    	
	    	// Create SQL statement.
		    PreparedStatement waitingListStatement = con.prepareStatement(waitingListQuery);
		    
		    // Execute query.
		    ResultSet waitingListResultSet = waitingListStatement.executeQuery();
		    
		    // For each row found in resulting table...
		    while (waitingListResultSet.next()) {
		    	int waitingID = waitingListResultSet.getInt("WaitingID");
                String customerID = waitingListResultSet.getString("CustomerID");
                String firstName = waitingListResultSet.getString("FirstName");
                String lastName = waitingListResultSet.getString("LastName");
                int flightNumber = waitingListResultSet.getInt("FlightNumber");
                String flightClass = waitingListResultSet.getString("Class");

                // CREATE RESERVATION.
                makeReservation(firstName, lastName, customerID, String.valueOf(flightNumber), null, flightClass, null, false);

                // DELETE FROM WAITINGLIST.
                deleteFromWaitingList(waitingID);
            }
	    	
	    	// Create query.
	    	String ticketQuery = "DELETE FROM Ticket WHERE TicketNumber = ?";
	    	
	    	// Create SQL statement.
		    PreparedStatement ticketStatement = con.prepareStatement(ticketQuery);
		    ticketStatement.setInt(1, Integer.parseInt(ticket));
		    
		    // Execute query.
		    int rowsAffectedTicket = ticketStatement.executeUpdate();
		    System.out.println("Removed from Ticket: " + rowsAffectedTicket);
	    }
	    
	    // Close connection.
        con.close();
	}
	
	/**
	 * Helper method that deletes from WaitingList table.
	 * @param waitingID
	 * @throws SQLException
	 */
	private void deleteFromWaitingList(int waitingID) throws SQLException {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
	    String deleteFromWaitingListQuery = "DELETE FROM WaitingList WHERE WaitingID = ?";
	    
	    // Create SQL statement.
	    PreparedStatement deleteFromWaitingListStatement = con.prepareStatement(deleteFromWaitingListQuery);
	    deleteFromWaitingListStatement.setInt(1, waitingID);
	    
	    // Execute query.
	    int rowsAffectedWaitingList = deleteFromWaitingListStatement.executeUpdate();
	    System.out.println("Removed from WaitingList: " + rowsAffectedWaitingList);
	}
}