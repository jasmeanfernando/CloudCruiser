<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336.pkg.*" %>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>RepresentativePortal</title>
		<!-- Google Fonts -->
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Pacifico|Poppins">
		<!-- CloudCruiser CSS -->
		<link rel="stylesheet" href="/CloudCruiser/resources/css/cloudcruiser.css">
		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	</head>
	
	<body>
	<!-- Customer must be logged in to access this page. -->
	<%
	if (session.getAttribute("user") == null) {
		out.println("<p class=\"cc_paragraph\">You are not logged in! Please login.</p>");
		out.println("<a class=\"cc_button\" href=\"PortalLogin.jsp\">Log In</a>");
	}
	else {
	%>
		<div class="container mt-1">
		
		<!-- Logo -->
		<div class="text-center mb-4">
		<img src="/CloudCruiser/resources/assets/logo.jpg" alt="Logo"
		class="img-fluid rounded" style="max-width: 25%;">
		</div>
		
		<!-- Aircraft Table -->
		<p class="cc_heading">Aircrafts</p>
		<p class="cc_paragraph">Below are a list of operating aircrafts.</p>
		<table class="table table-striped table-hover">
		<thead>
		<tr>
			<th>Aircraft</th>
			<th>Airline</th>
			<th>Number of Seats</th>
		</tr>
		</thead>
		<tbody>
		<% 
		try {
			// Get database connection.
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			// Create query.
			String query = "SELECT AircraftID, AirlineID, NumOfSeats FROM Aircraft";
			
			// Create SQL statement.
			Statement stmt = con.createStatement();
			
			// Execute query.
			ResultSet resultset = stmt.executeQuery(query);
			
			// Iterate through the result set and display data.
			while (resultset.next()) {
		%>
			<tr>
				<td><%= resultset.getString("AircraftID") %></td>
				<td><%= resultset.getString("AirlineID") %></td>
				<td><%= resultset.getString("NumOfSeats") %></td>
			</tr>
		<%
			}
			
			// Close connection.
			con.close();
		}
		catch (Exception e) {
			out.print("<p class=\"cc_paragraph\">Error loading page. Please try again.</p>");
			out.println("<a class=\"cc_button\" href=\"PortalRepresentative.jsp\">Home</a>");
		}
		%>
		</tbody>
		</table>
		
		<!-- Refresh -->
		<div class="row justify-content-right">
			<a class="cc_button" href="RepresentativeSystems.jsp">Refresh</a>
		</div>
		
		<!-- Edit Aircraft -->
		<p class="cc_heading">Edit Aircraft</p>
		<form class="row g-3 align-items-center cc_form" method="post" action="RepresentativeEditSystems.jsp">
			<div class="col">
			
			<div class="mb-3">
				<select class="form-control" name="aircraftAction">
					<option value="addAircraft">Add Aircraft</option>
					<option value="removeAircraft">Remove Aircraft</option>
				</select>
			</div>
		
			<div class="mb-3">
				<label class="form-label">Aircraft:</label>
				<input type="text" class="form-control" name="aircraftId" id="aircraftId" placeholder="AB000">
			</div>
			
			<div class="mb-3">
				<label class="form-label">Airline:</label>
				<input type="text" class="form-control" name="aircraftAirline" id="aircraftAirline" placeholder="AB">
			</div>
			
			<div class="mb-3">
				<label class="form-label">Number of Seats:</label>
				<input type="text" class="form-control" name="aircraftSeats" id="aircraftSeats" placeholder="0">
			</div>
		
			<div class="mb-3">
				<button type="submit" class="cc_button">Edit</button>
			</div>
			
			</div>
		</form>
		
		<!-- Airport Table -->
		<p class="cc_heading">Airports</p>
		<p class="cc_paragraph">Below are a list of operating airports.</p>
		<table class="table table-striped table-hover">
		<thead>
		<tr>
			<th>Airport</th>
			<th>Name</th>
			<th>City</th>
			<th>State</th>
			<th>Country</th>
		</tr>
		</thead>
		<tbody>
		<% 
		try {
			// Get database connection.
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			// Create query.
			String query = "SELECT AirportID, AirportName, City, State, Country FROM Airport";
			
			// Create SQL statement.
			Statement stmt = con.createStatement();
			
			// Execute query.
			ResultSet resultset = stmt.executeQuery(query);
			
			// Iterate through the result set and display data.
			while (resultset.next()) {
		%>
			<tr>
				<td><%= resultset.getString("AirportID") %></td>
				<td><%= resultset.getString("AirportName") %></td>
				<td><%= resultset.getString("City") %></td>
				<td><%= resultset.getString("State") %></td>
				<td><%= resultset.getString("Country") %></td>
			</tr>
		<%
			}
			
			// Close connection.
			con.close();
		}
		catch (Exception e) {
			out.print("<p class=\"cc_paragraph\">Error loading page. Please try again.</p>");
			out.println("<a class=\"cc_button\" href=\"PortalRepresentative.jsp\">Home</a>");
		}
		%>
		</tbody>
		</table>
		
		<!-- Refresh -->
		<div class="row justify-content-right">
			<a class="cc_button" href="RepresentativeSystems.jsp">Refresh</a>
		</div>
		
		<!-- Edit Airport -->
		<p class="cc_heading">Edit Airport</p>
		<form class="row g-3 align-items-center cc_form" method="post" action="RepresentativeEditSystems.jsp">
			<div class="col">
			
			<div class="mb-3">
				<select class="form-control" name="aircraftAction">
					<option value="addAirport">Add Airport</option>
					<option value="removeAirport">Remove Airport</option>
				</select>
			</div>
		
			<div class="mb-3">
				<label class="form-label">Airport:</label>
				<input type="text" class="form-control" name="AirportId" id="AirportId" placeholder="AB000">
			</div>
			
			<div class="mb-3">
				<label class="form-label">Name:</label>
				<input type="text" class="form-control" name="AirportName" id="AirportName" placeholder="AB000">
			</div>
			
			<div class="mb-3">
				<label class="form-label">City:</label>
				<input type="text" class="form-control" name="AirportCity" id="AirportCity" placeholder="AB000">
			</div>
			
			<div class="mb-3">
				<label class="form-label">State:</label>
				<input type="text" class="form-control" name="AirportState" id="AirportState" placeholder="AB000">
			</div>
			
			<div class="mb-3">
				<label class="form-label">Country:</label>
				<input type="text" class="form-control" name="AirportCountry" id="AirportCountry" placeholder="AB000">
			</div>
		
			<div class="mb-3">
				<button type="submit" class="cc_button">Edit</button>
			</div>
			
			</div>
		</form>
		
		
		</div>
	
	<!-- Close the else statement. -->
	<% } %>
	<!-- Bootstrap JS and Popper.js -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<!-- Bootstrap JavaScript -->
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	</body>
</html>
	
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
				out.print(result.getString("LayoverAirportID"));
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
</html>