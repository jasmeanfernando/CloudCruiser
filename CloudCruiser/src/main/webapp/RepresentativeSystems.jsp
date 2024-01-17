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
	<!-- Representative must be logged in to access this page. -->
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
				<input type="text" class="form-control" name="airlineId" id="airlineId" placeholder="AB">
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
				<select class="form-control" name="airportAction">
					<option value="addAirport">Add Airport</option>
					<option value="removeAirport">Remove Airport</option>
				</select>
			</div>
		
			<div class="mb-3">
				<label class="form-label">Airport:</label>
				<input type="text" class="form-control" name="airportId" id="airportId" placeholder="ABC">
			</div>
			
			<div class="mb-3">
				<label class="form-label">Name:</label>
				<input type="text" class="form-control" name="name" id="name" placeholder="">
			</div>
			
			<div class="mb-3">
				<label class="form-label">City:</label>
				<input type="text" class="form-control" name="city" id="city" placeholder="">
			</div>
			
			<div class="mb-3">
				<label class="form-label">State:</label>
				<input type="text" class="form-control" name="state" id="state" placeholder="">
			</div>
			
			<div class="mb-3">
				<label class="form-label">Country:</label>
				<input type="text" class="form-control" name="country" id="country" placeholder="">
			</div>
		
			<div class="mb-3">
				<button type="submit" class="cc_button">Edit</button>
			</div>
			
			</div>
		</form>
		
		<!-- Flight Table -->
		<p class="cc_heading">Flights</p>
		<p class="cc_paragraph">Below are a list of operating flights.</p>
		<table class="table table-striped table-hover">
		<thead>
		<tr>
			<th>ID</th>
			<th>Airline</th>
			<th>Aircraft</th>
			<th>Departure</th>
			<th>Date/Time</th>
			<th>Arrival</th>
			<th>Date/Time</th>
			<th>Duration</th>
			<th>Layovers</th>
			<th>Price</th>
		</tr>
		</thead>
		<tbody>
		<% 
		try {
			// Get database connection.
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			// Create query.
			String query = "SELECT F.FlightNumber, F.AirlineID, F.AircraftID, F.DepartureAirportID, F.DepartureDateTime, "
				+ "F.ArrivalAirportID, F.ArrivalDateTime, F.FlightDuration, F.TotalPrice, "
				+ "COUNT(L.LayoverNumber) AS NumberOfLayovers "
				+ "FROM Flight F "
				+ "LEFT JOIN Layover L ON F.FlightNumber = L.LayoverNumber "
				+ "GROUP BY F.FlightNumber, F.AirlineID, F.AircraftID, F.DepartureAirportID, F.DepartureDateTime, "
				+ "F.ArrivalAirportID, F.ArrivalDateTime, F.FlightDuration, F.TotalPrice ";
			
			// Create SQL statement.
			Statement stmt = con.createStatement();
			
			// Execute query.
			ResultSet resultset = stmt.executeQuery(query);
			
			// Iterate through the result set and display data.
			while (resultset.next()) {
		%>
			<tr>
				<td><%= resultset.getString("FlightNumber") %></td>
				<td><%= resultset.getString("AirlineID") %></td>
				<td><%= resultset.getString("AircraftID") %></td>
				<td><%= resultset.getString("DepartureAirportID") %></td>
				<td><%= resultset.getString("DepartureDateTime") %></td>
				<td><%= resultset.getString("ArrivalAirportID") %></td>
				<td><%= resultset.getString("ArrivalDateTime") %></td>
				<td><%= resultset.getString("FlightDuration") %></td>
				<td><%= resultset.getString("NumberOfLayovers") %></td>
				<td><%= resultset.getString("TotalPrice") %></td>
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
		
		<!-- Edit Flight -->
		<p class="cc_heading">Edit Flight</p>
		<form class="row g-3 align-items-center cc_form" method="post" action="RepresentativeEditSystems.jsp">
			<div class="col">
			
			<div class="mb-3">
				<select class="form-control" name="flightAction">
					<option value="addFlight">Add Flight</option>
					<option value="removeFlight">Remove Flight</option>
				</select>
			</div>
		
			<div class="mb-3">
				<label class="form-label">Airline:</label>
				<input type="text" class="form-control" name="airlineId" id="airlineId" placeholder="AB">
			</div>
			
			<div class="mb-3">
				<label class="form-label">Aircraft:</label>
				<input type="text" class="form-control" name="aircraftId" id="aircraftId" placeholder="AB000">
			</div>
			
			<div class="mb-3">
				<label class="form-label">Departure Airport:</label>
				<input type="text" class="form-control" name="departureAirport" id="departureAirport" placeholder="ABC">
			</div>
			
			<div class="mb-3">
				<label class="form-label">Departure Date/Time:</label>
				<input type="text" class="form-control" name="departureDateTime" id="departureDateTime" placeholder="YYYY-MM-DD 00:00:00">
			</div>
			
			<div class="mb-3">
				<label class="form-label">Arrival Airport:</label>
				<input type="text" class="form-control" name="arrivalAirport" id="arrivalAirport" placeholder="ABC">
			</div>
			
			<div class="mb-3">
				<label class="form-label">Arrival Date/Time:</label>
				<input type="text" class="form-control" name="arrivalDateTime" id="arrivalDateTime" placeholder="YYYY-MM-DD 00:00:00">
			</div>
			
			<div class="mb-3">
				<label class="form-label">Duration:</label>
				<input type="text" class="form-control" name="duration" id="duration" placeholder="0">
			</div>
			
			<div class="mb-3">
				<label class="form-label">Layover:</label>
				<input type="text" class="form-control" name="layover" id="layover" placeholder="0 for False, 1 For True">
			</div>
			
			<div class="mb-3">
				<label class="form-label">International:</label>
				<input type="text" class="form-control" name="international" id="international" placeholder="0 for False, 1 For True">
			</div>
			
			<div class="mb-3">
				<label class="form-label">Price:</label>
				<input type="text" class="form-control" name="price" id="price" placeholder="0">
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