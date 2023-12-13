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
	<h1>Aircraft Database</h1>
	<% try {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
		String query = "SELECT AircraftID, AirlineID, NumOfSeats "
			+ "FROM Aircraft";
		
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
		out.print("Aircraft"); // Column header.
		out.print("</td>");
		
		out.print("<td>");
		out.print("Airline");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Number of Seats");
		out.print("</td>");
		
		// Parse each tuple from queried table.
		while (result.next()) {
			// Make row.
			out.print("<tr>");
			// Make column.
			out.print("<td>");
			out.print(result.getString("AircraftID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("AirlineID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("NumOfSeats"));
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
	
	<h2>Modify Aircraft?</h2>
	<form method="post" action="updateAircraft.jsp">
		<table>
			<tr>
			<td>Aircraft: </td><td><input type="text" name="aircraft"></td>
			<tr>
			<td>Airline: </td><td><input type="text" name="airline"></td>
			<tr>
			<td>* New Airline: </td><td><input type="text" name="new_airline"></td>
			<tr>
			<td>Number of Seats: </td><td><input type="text" name="num_seats"></td>
		</table>
		
		<input type="radio" name="action" value="add"> Add
       	<input type="radio" name="action" value="delete"> Delete
       	<input type="radio" name="action" value="update"> Update
			
		<br><br>
		<input type="submit" value="Submit">
	</form>
	
	<h1>Airline Database</h1>
	<% try {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
		String query = "SELECT AirlineID, AirlineName "
			+ "FROM Airline";
		
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
		out.print("Airline"); // Column header.
		out.print("</td>");
		
		out.print("<td>");
		out.print("Name");
		out.print("</td>");
		
		// Parse each tuple from queried table.
		while (result.next()) {
			// Make row.
			out.print("<tr>");
			// Make column.
			out.print("<td>");
			out.print(result.getString("AirlineID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("AirlineName"));
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
	
	<h1>Airport Database</h1>
	<% try {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
		String query = "SELECT AirportID, AirportName, City, State, Country "
			+ "FROM Airport";
		
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
		out.print("Airport"); // Column header.
		out.print("</td>");
		
		out.print("<td>");
		out.print("Name");
		out.print("</td>");
		
		out.print("<td>");
		out.print("City");
		out.print("</td>");
		
		out.print("<td>");
		out.print("State");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Country");
		out.print("</td>");
		
		// Parse each tuple from queried table.
		while (result.next()) {
			// Make row.
			out.print("<tr>");
			// Make column.
			out.print("<td>");
			out.print(result.getString("AirportID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("AirportName"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("City"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("State"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("Country"));
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
	
	<h2>Modify Airport?</h2>
	<form method="post" action="updateAirport.jsp">
		<table>
			<tr>
			<td>Airport: </td><td><input type="text" name="airport"></td>
			<tr>
			<td>Airport Name: </td><td><input type="text" name="airport_name"></td>
			<tr>
			<td>* New Airport Name: </td><td><input type="text" name="new_airport"></td>
			<tr>
			<td>City: </td><td><input type="text" name="city"></td>
			<tr>
			<td>State: </td><td><input type="text" name="state"></td>
			<tr>
			<td>Country: </td><td><input type="text" name="country"></td>
		</table>
		
		<input type="radio" name="action" value="add"> Add
       	<input type="radio" name="action" value="delete"> Delete
       	<input type="radio" name="action" value="update"> Update
			
		<br><br>
		<input type="submit" value="Submit">
	</form>
	
	<h1>Flight Database</h1>
	<% try {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
		String query = "SELECT F.FlightNumber, F.AirlineID, F.AircraftID, F.DepartureAirportID, F.ArrivalAirportID, "
	        	+ "F.DepartureDateTime, F.ArrivalDateTime, F.FlightDuration, F.TotalPrice, "
	        	+ "L.LayoverAirportID, "
	        	+ "COUNT(L.LayoverNumber) AS NumberOfLayovers "
	        	+ "FROM Flight F "
	        	+ "LEFT JOIN Layover L ON F.FlightNumber = L.LayoverNumber "
	        	+ "GROUP BY F.FlightNumber, F.AirlineID, F.AircraftID, F.DepartureAirportID, F.ArrivalAirportID, "
	        	+ "F.DepartureDateTime, F.ArrivalDateTime, F.FlightDuration, F.TotalPrice, L.LayoverAirportID";
		
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
		out.print("Number of Layovers");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Layover Airport");
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
			out.print(result.getString("NumberOfLayovers"));
			out.print("</td>");
			
			out.print("<td>");
			String bool = result.getString("LayoverAirportID");
			if (bool == null) {
				out.print("N/A");
			}
			else {
				out.print("LayoverAirportID");
			}
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
	
	<h2>Modify Flight?</h2>
	<form method="post" action="updateFlight.jsp">
		<table>
			<tr>
			<td>Flight Number: </td><td><input type="text" name="flight_num"></td>
			<tr>
			<td>Airline: </td><td><input type="text" name="airline"></td>
			<tr>
			<tr>
			<td>Aircraft: </td><td><input type="text" name="aircraft"></td>
			<tr>
			<td>* New Aircraft: </td><td><input type="text" name="new_aircraft"></td>
			<tr>
			<td>Departure Airport: </td><td><input type="text" name="departure_airport"></td>
			<tr>
			<td>Arrival Airport: </td><td><input type="text" name="arrival_airport"></td>
			<tr>
			<td>Departure Date & Time: </td><td><input type="text" name="departure_datetime"></td>
			<tr>
			<td>Arrival Date & Time: </td><td><input type="text" name="arrival_datetime"></td>
			<tr>
			<td>Duration: </td><td><input type="text" name="duration"></td>
			<tr>
			<td>Has Layovers? </td><td><input type="text" name="layover"></td>
			<tr>
			<td>Is International? </td><td><input type="text" name="international"></td>
			<tr>
			<td>Total Price: </td><td><input type="text" name="price"></td>
		</table>
		
		<input type="radio" name="action" value="add"> Add
       	<input type="radio" name="action" value="delete"> Delete
       	<input type="radio" name="action" value="update"> Update
			
		<br><br>
		<input type="submit" value="Submit">
	</form>
	
	<h2>Search By...</h2>
	<form method="post" action="AirportSearch.jsp">
		<table>
			<tr>
			<td>Airport: </td><td><input type="text" name="airport"></td>
		</table>
		
		<input type="submit" value="Submit">
	</form>
	</body>
	<p><a href="RepresentativePortal.jsp">Back to Home</a></p>
	<p><a href="Logout.jsp">Log Out</a></p>
<% } %>
</html>