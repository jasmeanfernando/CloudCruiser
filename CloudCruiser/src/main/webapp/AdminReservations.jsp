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
	<h1>Browse all booked reservations!</h1>
	<% try {	  
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query -> Joins Flight and Reservation.
		String query = "SELECT R.ReservationNumber, R.CustomerID, R.Class, "
			+ "F.FlightNumber, F.AirlineID, F.DepartureAirportID, F.ArrivalAirportID, F.DepartureDateTime, "
			+ "F.ArrivalDateTime, F.FlightDuration, F.IsLayover, F.TotalPrice "
			+ "FROM Reservation R "
			+ "JOIN Flight F ON R.FlightNumber = F.FlightNumber";
		
		// Create SQL statement.
		Statement stmt = con.createStatement();
		
		// Execute query.
		ResultSet result = stmt.executeQuery(query);
		
		// Create HTML Table.
		out.print("<table border=2>");
		
		// Make row.
		out.print("<tr>");
		
		// Make column.
		out.print("<td>");
		out.print("Flight Number"); // Column header.
		out.print("</td>");
		
		out.print("<td>");
		out.print("Reservation Number");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Email");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Airline");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Class");
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
		out.print("Layovers");
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
			out.print(result.getString("ReservationNumber"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("CustomerID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("AirlineID"));
			out.print("</td>");
				
			out.print("<td>");
			out.print(result.getString("Class"));
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
			String bool = result.getString("IsLayover");
			if (bool == "1") {
				out.print("Yes");
			}
			else {
				out.print("No");
			}
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("TotalPrice"));
			out.print("</td>");
			
		}
		
		out.print("</table>");
	}
	catch (Exception ex) {
		out.print(ex);
		out.print("<p>Timeout...</p>");
	}
	%>
	<h2>Sort By...</h2>
	<form method="get" action="ReservationSort.jsp">
		<table>
			<tr>
			<input type="radio" name="sortby" value="getEmails" required> Email
			<input type="radio" name="sortby" value="getFlights" required> Flight Number
			<tr>
			<td>Customer Email: </td><td><input type="text" name="email"></td></tr>
			<tr>
			<td>Flight Number: </td><td><input type="text" name="flight_num"></td></tr>
		</table>
		<input type="submit" value="Sort Reservations">
	</form>
	<p><a href="AdminPortal.jsp">Back to Home</a></p>
	<p><a href="Logout.jsp">Log Out</a></p>
<% } %>
</html>