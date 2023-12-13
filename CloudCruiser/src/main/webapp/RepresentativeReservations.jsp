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
	<h1>Reservation Database</h1>
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
        
		// Close the connection.
        con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("<p>Timeout...</p>");
	}
	%>
	<h2>Add Reservation?</h2>
	<form method="post" action="ReserveFlight.jsp">
		<table>
			<tr>
			<td>First Name: </td><td><input type="text" name="first_name"></td></tr>
			<tr>
			<tr>
			<td>Last Name: </td><td><input type="text" name="last_name"></td></tr>
			<tr>
			<td>Email: </td><td><input type="text" name="email"></td></tr>
			<tr>
			<td>Departing Flight Number: </td><td><input type="text" name="departing_flight_num"></td></tr>
			<td>Arriving Flight Number: </td><td><input type="text" name="arriving_flight_num"></td></tr>
			<tr>
			<td>Flight Class:</td><td><input type="radio" name="flight_class" value="First"> First Class
       		<input type="radio" name="flight_class" value="Business"> Business Class
       		<input type="radio" name="flight_class" value="Economy"> Economy Class</td><tr>
       		<tr>
       		<td>Flight Type:</td><td><input type="radio" name="flight_type" value="oneway"> One-Way Trip
       		<input type="radio" name="flight_type" value="roundtrip"> Round Trip</td><tr>
		</table>
		
		<input type="submit" value="Submit">
	</form>
	
	<h2>Update Reservation?</h2>
	<p>Complete 'Email' and 'Reservation Number', fill out only the information to be updated, and indicate the change.</p>
	<form method="post" action="updateReservation.jsp">
		<table>
			<tr>
			<td>Email: </td><td><input type="text" name="email"></td></tr>
			<tr>
			<td>Reservation Number: </td><td><input type="text" name="res_num"></td></tr>
			<tr>
			<td>Flight Number: </td><td><input type="text" name="flight_num"></td></tr>
			<tr>
			<td>Flight Class:</td><td><input type="radio" name="flight_class" value="First"> First Class
       		<input type="radio" name="flight_class" value="Business"> Business Class
       		<input type="radio" name="flight_class" value="Economy"> Economy Class</td><tr>
       		<tr>
			<td>Change Made?</td><td><input type="radio" name="change" value="flight"> Flight Number
       		<input type="radio" name="change" value="class"> Flight Class</td><tr>
		</table>
		
		<input type="submit" value="Submit">
	</form>
	
	<h1>Waiting List Database</h1>
	<% try {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
		String query = "SELECT WaitingID, CustomerID, FirstName, LastName, FlightNumber, Class, PurchaseDateTime "
			+ "FROM WaitingList";
		
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
		out.print("Waiting Number"); // Column header.
		out.print("</td>");
		
		out.print("<td>");
		out.print("Email");
		out.print("</td>");
		
		out.print("<td>");
		out.print("First Name");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Last Name");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Flight Number");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Flight Class");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Purchase Date & Time");
		out.print("</td>");
		
		// Parse each tuple from queried table.
		while (result.next()) {
			// Make row.
			out.print("<tr>");
			// Make column.
			out.print("<td>");
			out.print(result.getString("WaitingID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("CustomerID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("FirstName"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("LastName"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("FlightNumber"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("Class"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("PurchaseDateTime"));
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
	<h2>Search By...</h2>
	<form method="post" action="WaitingListSearch.jsp">
		<table>
			<tr>
			<td>Flight Number: </td><td><input type="text" name="flight_num"></td>
		</table>
		
		<input type="submit" value="Submit">
	</form>
	
	</body>
	<p><a href="RepresentativePortal.jsp">Back to Home</a></p>
	<p><a href="Logout.jsp">Log Out</a></p>
<% } %>
</html>