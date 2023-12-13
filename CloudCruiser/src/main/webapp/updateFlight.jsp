<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
			<title>RegistrationPortal</title>
	</head>
	
	<body>
<!-- Customer must be logged in to access this page. -->
<% if (session.getAttribute("user") == null) { %>
	You are not logged in!
	<br>
	<a href="LoginPortal.jsp">Please login.</a>
<% } else { %>
	<% try {
		// Get parameters from EditSystems.jsp.
		String flightNumber = request.getParameter("flight_num");
		String airline = request.getParameter("airline");
		String aircraft = request.getParameter("aircraft");
		String newAircraft = request.getParameter("new_aircraft");
		String departingAirport = request.getParameter("departure_airport");
		String arrivingAirport = request.getParameter("arrival_airport");
		String departingDateTime = request.getParameter("departure_datetime");
		String arrivingDateTime = request.getParameter("arrival_datetime");
		String duration = request.getParameter("duration");
		String layover = request.getParameter("layover");
		String international = request.getParameter("international");
		String price = request.getParameter("price");
		String updateAction = request.getParameter("action");
		
		out.print(flightNumber);
		out.print(airline);
		out.print(aircraft);
		out.print(newAircraft);
		out.print(departingAirport);
		out.print(arrivingAirport);
		out.print(departingDateTime);
		out.print(arrivingDateTime);
		out.print(duration);
		out.print(layover);
		out.print(international);
		out.print(price);
		
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query based updateAction.
		String query = "";
		if (updateAction.equalsIgnoreCase("add")) {
			query = "INSERT INTO Flight (AirlineID, AircraftID, DepartureAirportID, ArrivalAirportID, "
				+ "DepartureDateTime, ArrivalDateTime, FlightDuration, IsLayover, IsInternational, "
				+ "TotalPrice) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		}
		else if (updateAction.equalsIgnoreCase("delete")) {
			query = "DELETE FROM Flight "
				+ "WHERE FlightNumber = ?";
		}
		else {
			query = "UPDATE Flight "
				+ "SET AircraftID = ? "
				+ "WHERE FlightNumber = ?";
		}
		
		out.print(query);
		
		// Create SQL statement.
		PreparedStatement prepstmt = con.prepareStatement(query);
		
		if (updateAction.equalsIgnoreCase("add")) {
			prepstmt.setString(1, airline);
			prepstmt.setString(2, aircraft);
			prepstmt.setString(3, departingAirport);
			prepstmt.setString(4, arrivingAirport);
			prepstmt.setString(5, departingDateTime);
			prepstmt.setString(6, arrivingDateTime);
			prepstmt.setInt(7, Integer.parseInt(duration));
			prepstmt.setString(8, layover);
			prepstmt.setString(9, international);
			prepstmt.setString(10, price);
		}
		else if (updateAction.equalsIgnoreCase("delete")) {
			prepstmt.setInt(1, Integer.parseInt(flightNumber));
		}
		else {
			prepstmt.setString(1, newAircraft);
			prepstmt.setInt(2, Integer.parseInt(flightNumber));
		}
		
		// Execute query.
		int rowsAffected = prepstmt.executeUpdate();
		
		// Check if update was successful.
        if (rowsAffected > 0) {
            out.println("<p>Flight modifications successful!</p>");
        }
        else {
        	out.println("<p>Flight modifications failed. Please try again.</p>");
        }
		
		// Close the connection.
        con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("<p>Error: " + ex.getMessage() + "</p>");
		out.print("<p>Timeout...</p>");
	}
	%>
	<p><a href="RepresentativePortal.jsp">Back to Home</a></p>
	<p><a href="Logout.jsp">Log Out</a></p>
<% } %>
</html>