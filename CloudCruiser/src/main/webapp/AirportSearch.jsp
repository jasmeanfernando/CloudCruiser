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
		// Get parameters from ReservationRepresentatives.jsp.
		String airport = request.getParameter("airport");
		
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
		String query = "SELECT FlightNumber, AirlineID, AircraftID, DepartureAirportID, ArrivalAirportID, "
	        	+ "DepartureDateTime, ArrivalDateTime, FlightDuration, TotalPrice "
	        	+ "FROM Flight "
	        	+ "WHERE DepartureAirportID = ? OR ArrivalAirportID = ?";
		
		// Create SQL statement.
		PreparedStatement prepstmt = con.prepareStatement(query);
		prepstmt.setString(1, airport);
		prepstmt.setString(2, airport);
		
		// Execute query.
		ResultSet result = prepstmt.executeQuery();
		
		// Create HTML Table.
		out.print("<table border=2>");
		
		// Make row.
		out.print("<tr>");
		
		// Make column.
		out.print("<td>");
		out.print("Flight Number"); // Column header.
		out.print("</td>");
		
		out.print("<td>");
		out.print("Airline");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Aircraft");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Departure Airport");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Arrival Airport");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Departure Date & Time");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Arrival Date & Time");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Duration");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Price");
		out.print("</td>");
		
		// Parse each tuple from queried table.
		while (result.next()) {
			// Make row.
			out.print("<tr>");
			// Make column -> Prints "FlightNumber" of all existing tuples.
			out.print("<td>");
			out.print(result.getString("FlightNumber"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("AirlineID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("AircraftID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("DepartureAirportID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("ArrivalAirportID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("DepartureDateTime"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("ArrivalDateTime"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("FlightDuration"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("TotalPrice"));
			out.print("</td>");
			
		}
		out.print("</table>");
        
		// Close the connection.
        con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("<p>Timeout...</p>");
	}
	%>
	<p><a href="RepresentativePortal.jsp">Back to Home</a></p>
	<p><a href="Logout.jsp">Log Out</a></p>
<% } %>
</html>