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
		
		<!-- Reservations Table -->
		<p class="cc_heading">Reservations</p>
		<p class="cc_paragraph">Below are flights that are reserved.</p>
		<table class="table table-striped table-hover">
		<thead>
		<tr>
			<th>Email</th>
			<th>Reservation ID</th>
			<th>Flight ID</th>
			<th>Airline</th>
			<th>Departure Airport</th>
			<th>Arrival Airport</th>
			<th>Class</th>
		</tr>
		</thead>
		<tbody>
		<% 
		try {
			// Get database connection.
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			// Create query.
			String query = "SELECT R.ReservationNumber, R.CustomerID, R.Class, "
				+ "F.FlightNumber, F.AirlineID, F.DepartureAirportID, F.DepartureDateTime, "
				+ "F.ArrivalAirportID, F.ArrivalDateTime, F.FlightDuration, F.TotalPrice "
				+ "FROM Reservation R "
				+ "JOIN Flight F ON R.FlightNumber = F.FlightNumber";
			
			// Create SQL statement.
			Statement stmt = con.createStatement();
			
			// Execute query.
			ResultSet resultset = stmt.executeQuery(query);
			
			// Iterate through the result set and display data.
			while (resultset.next()) {
		%>
			<tr>
				<td><%= resultset.getString("CustomerID") %></td>
				<td><%= resultset.getString("ReservationNumber") %></td>
				<td><%= resultset.getString("FlightNumber") %></td>
				<td><%= resultset.getString("AirlineID") %></td>
				<td><%= resultset.getString("DepartureAirportID") %></td>
				<td><%= resultset.getString("ArrivalAirportID") %></td>
				<td><%= resultset.getString("Class") %></td>
			</tr>
		<%
			}
			
			// Close connection.
			con.close();
		}
		catch (Exception e) {
			out.print("<p class=\"cc_paragraph\">Error loading page. Please try again.</p>");
			out.println("<a class=\"cc_button\" href=\"PortalPassenger.jsp\">Home</a>");
		}
		%>
		</tbody>
		</table>
		
		<!-- Refresh -->
		<div class="row justify-content-right">
			<a class="cc_button" href="RepresentativeReservations.jsp">Refresh</a>
		</div>
		
		<!-- Add Reservation -->
		<p class="cc_heading">Add Reservation</p>
		<form class="row g-3 align-items-center cc_form" method="post" action="PassengerEditFlights.jsp">
			<div class="col">
			
			<div class="mb-3">
				<label class="form-label">First Name:</label>
				<input type="text" class="form-control" name="flightFirstName" id="flightFirstName" placeholder="First Name" required>
			</div>
			
			<div class="mb-3">
				<label class="form-label">Last Name:</label>
				<input type="text" class="form-control" name="flightLastName" id="flightLastName" placeholder="First Name" required>
			</div>
			
			<div class="mb-3">
				<label class="form-label">Email:</label>
				<input type="text" class="form-control" name="flightEmail" id="flightEmail" placeholder="name@email.com" required>
			</div>
			
			<div class="mb-3">
				<label class="form-label">Choose departure and arrival flight.</label>
				<div class="input-group" required>
				<input type="text" class="form-control" name="depFlightId" id="depFlightId" placeholder="Departure Flight ID">
				<span class="input-group-text">to</span>
				<input type="text" class="form-control" name="arrFlightId" id="arrFlightId" placeholder="Arrival Flight ID">
				</div>
			</div>
			
			<div class="mb-3">
				<label class="form-label">Choose flight class.</label>
				<select class="form-control" name="flightClass" required>
					<option value="first">First</option>
					<option value="business">Business</option>
					<option value="economy">Economy</option>
				</select>
			</div>
			
			<div class="mb-3">
				<label class="form-label">Choose flight type.</label>
				<select class="form-control" name="flightType" required>
					<option value="round">Round Trip</option>
					<option value="oneway">One-Way Trip</option>
				</select>
			</div>
			
			<div class="mb-3">
				<button type="submit" class="cc_button">Add</button>
			</div>
			
			</div>
		</form>
		
		<!-- Update Reservation -->
		<p class="cc_heading">Update Reservation</p>
		<form class="row g-3 align-items-center cc_form" method="post" action="RepresentativeEditReservations.jsp">
			<div class="col">
			
			<div class="mb-3">
				<select class="form-control" name="reservationAction" required>
					<option value="updateFlightId">Update Flight ID</option>
					<option value="updateClass">Update Class</option>
				</select>
			</div>
			
			<div class="mb-3">
				<label class="form-label">Email:</label>
				<input type="text" class="form-control" name="reservationEmail" id="reservationEmail" placeholder="name@email.com" required>
			</div>
			
			<div class="mb-3">
				<label class="form-label">Reservation ID:</label>
				<input type="text" class="form-control" name="reservationId" id="reservationId" placeholder="0" required>
			</div>
			
			<div class="mb-3">
				<label class="form-label">Class/Flight ID:</label>
				<input type="text" class="form-control" name="reservationChange" id="reservationChange" placeholder="'First' or 'Business' or 'Economy' / '0'" required>
			</div>
			
			<div class="mb-3">
				<button type="submit" class="cc_button">Update</button>
			</div>
			
			</div>
		</form>
		
		<!-- WaitingList Table -->
		<p class="cc_heading">Waiting List</p>
		<p class="cc_paragraph">Below are flights that are not yet reserved because the flights are full.</p>
		<table class="table table-striped table-hover">
		<thead>
		<tr>
			<th>Waiting ID</th>
			<th>Email</th>
			<th>Flight ID</th>
			<th>Class</th>
			<th>Purchase Date/Time</th>
		</tr>
		</thead>
		<tbody>
		<% 
		try {
			// Get database connection.
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			// Create query.
			String query = "SELECT W.WaitingID, W.CustomerID, W.FlightNumber, W.Class, W.PurchaseDateTime "
				+ "FROM WaitingList W";
			
			// Get parameters: Search By.
			String searchByEmail = request.getParameter("searchByEmail");
			String searchByFlightId = request.getParameter("searchByFlightId");
			
			if (searchByEmail != null && !searchByEmail.isEmpty()) {
				query += " WHERE W.CustomerID = '" + searchByEmail + "'";
			}
			
			if (searchByFlightId != null && !searchByFlightId.isEmpty()) {
				query += " WHERE W.FlightNumber = " + searchByFlightId;
			}
			
			// Create SQL statement.
			Statement stmt = con.createStatement();
			
			// Execute query.
			ResultSet resultset = stmt.executeQuery(query);
			
			// Iterate through the result set and display data.
			while (resultset.next()) {
		%>
			<tr>
				<td><%= resultset.getString("WaitingID") %></td>
				<td><%= resultset.getString("CustomerID") %></td>
				<td><%= resultset.getString("FlightNumber") %></td>
				<td><%= resultset.getString("Class") %></td>
				<td><%= resultset.getString("PurchaseDateTime") %></td>
			</tr>
		<%
			}
			
			// Close connection.
			con.close();
		}
		catch (Exception e) {
			out.print("<p class=\"cc_paragraph\">Error loading page. Please try again.</p>");
			out.println("<a class=\"cc_button\" href=\"PortalPassenger.jsp\">Home</a>");
		}
		%>
		</tbody>
		</table>
		
		<!-- Refresh -->
		<div class="row justify-content-right">
			<a class="cc_button" href="RepresentativeReservations.jsp">Refresh</a>
		</div>
		
		<!-- Search By -->
		<p class="cc_heading">Search By</p>
		<p class="cc_paragraph">Search Waiting List by Email or Flight ID.</p>
		<form class="row g-3 align-items-center cc_form" method="get" action="">
			<div class="col">
			
			<div class="mb-3">
				<label class="form-label">Email:</label>
				<input type="text" class="form-control" name="searchByEmail" id="searchByEmail" placeholder="name@email.com">
			</div>
			
			<div class="mb-3">
				<label class="form-label">Flight ID:</label>
				<input type="text" class="form-control" name="searchByFlightId" id="searchByFlightId" placeholder="0">
			</div>
			
			<div class="mb-3">
				<button type="submit" class="cc_button">Search</button>
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