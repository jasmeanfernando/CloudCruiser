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
		<title>PassengerPortal</title>
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
		
		<!-- Table -->
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
			
			// Get parameters: Sort By.
			String sortBy = request.getParameter("sortBy");
			
			// Get parameters: Filter By.
			String minPrice = request.getParameter("minPrice");
			String maxPrice = request.getParameter("maxPrice");
			String airline = request.getParameter("airline");
			String numOfLayovers = request.getParameter("numOfLayovers");
			String depDateTime = request.getParameter("depDateTime");
			String arrDateTime = request.getParameter("arrDateTime");
			
			// Get parameters: Search By.
			String depAirport = request.getParameter("depAirport");
			String arrAirport = request.getParameter("arrAirport");
			String tripType = request.getParameter("tripType");
			String oneDepDate = request.getParameter("1DepDate");
			String twoDepDate = request.getParameter("2DepDate");
			String twoArrDate = request.getParameter("2ArrDate");
			String threeDepDate = request.getParameter("3DepDate");
			String threeArrDate = request.getParameter("3ArrDate");
			
			// Choose correct query.
			// Sort by...
			if (sortBy != null) {
				// Update query.
				query += "ORDER BY " + sortBy;
			}
			
			// Filter by...
			if (minPrice != null || maxPrice != null || airline != null || numOfLayovers != null || depDateTime != null || arrDateTime != null) {
				String filters = "WHERE 1=1";
				
				// ...price.
				if (!minPrice.isEmpty()) {
					filters += " AND TotalPrice >= " + minPrice;
				}
				if (!maxPrice.isEmpty()) {
					filters += " AND TotalPrice <= " + maxPrice;
				}
				
				// ...airline.
				if (!airline.isEmpty()) {
					filters += " AND AirlineID = '" + airline + "'";
				}
				
				// ...layovers.
				if (!numOfLayovers.isEmpty()) {
					filters += " AND FlightNumber IN (SELECT LayoverNumber FROM Layover GROUP BY LayoverNumber HAVING COUNT(*) <= " + numOfLayovers + ")";
				}
				
				// ...time.
				if (!depDateTime.isEmpty()) {
					filters += " AND TIME(F.DepartureDateTime) = '" + depDateTime + "'";
				}
				if (!arrDateTime.isEmpty()) {
					filters += " AND TIME(F.ArrivalDateTime) = '" + arrDateTime + "'";
				}
				
				// Update query.
				query = "SELECT F.FlightNumber, F.AirlineID, F.AircraftID, F.DepartureAirportID, F.DepartureDateTime, "
						+ "F.ArrivalAirportID, F.ArrivalDateTime, F.FlightDuration, F.TotalPrice, "
						+ "COUNT(L.LayoverNumber) AS NumberOfLayovers "
						+ "FROM Flight F "
						+ "LEFT JOIN Layover L ON F.FlightNumber = L.LayoverNumber "
						+ filters
						+ " GROUP BY F.FlightNumber, F.AirlineID, F.AircraftID, F.DepartureAirportID, F.DepartureDateTime, "
						+ "F.ArrivalAirportID, F.ArrivalDateTime, F.FlightDuration, F.TotalPrice";
			}
			
			// Search by...
			if (depAirport != null && arrAirport != null && tripType != null) {
				// ...one-way trip (1 Flight).
				if (tripType.equalsIgnoreCase("oneway")) {
					String search = "WHERE F.DepartureAirportID = '" + depAirport + "' AND F.ArrivalAirportID = '" + arrAirport + "' ";
					
	     			if (!oneDepDate.isEmpty()) {
	     				search += "AND DATE(F.DepartureDateTime) = '" + oneDepDate + "' ";
	     			}
	     			
		     		// Update query.
					query = "SELECT F.FlightNumber, F.AirlineID, F.AircraftID, F.DepartureAirportID, F.DepartureDateTime, "
						+ "F.ArrivalAirportID, F.ArrivalDateTime, F.FlightDuration, F.TotalPrice, "
						+ "COUNT(L.LayoverNumber) AS NumberOfLayovers "
						+ "FROM Flight F "
						+ "LEFT JOIN Layover L ON F.FlightNumber = L.LayoverNumber "
						+ search
						+ "GROUP BY F.FlightNumber, F.AirlineID, F.AircraftID, F.DepartureAirportID, F.DepartureDateTime, "
						+ "F.ArrivalAirportID, F.ArrivalDateTime, F.FlightDuration, F.TotalPrice";
		     		}
					
	     		// ...round trip (2+ Flights).
	     		else {
	     			String date1 = "";
	     			String date2 = "";
	     			
	     			if (!twoDepDate.isEmpty() && !twoArrDate.isEmpty()) {
	     				date1 = "AND DATE(F1.DepartureDateTime) = '" + twoDepDate + "' ";
	     				date2 = "AND DATE(F2.ArrivalDateTime) = '" + twoArrDate + "' ";
	     			}
	     			else if (!threeDepDate.isEmpty() && !threeArrDate.isEmpty()) {
	     				date1 = "AND DATE(F1.DepartureDateTime) BETWEEN '" + threeDepDate + "' - INTERVAL 3 DAY ";
	     				date2 = "AND DATE(F2.ArrivalDateTime) BETWEEN '" + threeArrDate + "' - INTERVAL 3 DAY ";
	     			}
	     			
	     			// Update query.
	     			query = "SELECT F1.FlightNumber, F1.AirlineID, F1.AircraftID, F1.DepartureAirportID, F1.DepartureDateTime, "
						+ "F1.ArrivalAirportID, F1.ArrivalDateTime, F1.FlightDuration, F1.TotalPrice, "
						+ "COUNT(L1.LayoverNumber) AS NumberOfLayovers "
						+ "FROM Flight F1 "
						+ "LEFT JOIN Layover L1 ON F1.FlightNumber = L1.LayoverNumber "
						+ "WHERE F1.DepartureAirportID = '" + depAirport + "' AND F1.ArrivalAirportID = '" + arrAirport + "' "
						+ date1
						+ "GROUP BY F1.FlightNumber, F1.AirlineID, F1.AircraftID, F1.DepartureAirportID, F1.DepartureDateTime, "
						+ "F1.ArrivalAirportID, F1.ArrivalDateTime, F1.FlightDuration, F1.TotalPrice "
						+ "UNION "
						+ "SELECT F2.FlightNumber, F2.AirlineID, F2.AircraftID, F2.DepartureAirportID, F2.DepartureDateTime, "
						+ "F2.ArrivalAirportID, F2.ArrivalDateTime, F2.FlightDuration, F2.TotalPrice, "
						+ "COUNT(L2.LayoverNumber) AS NumberOfLayovers "
						+ "FROM Flight F2 "
						+ "LEFT JOIN Layover L2 ON F2.FlightNumber = L2.LayoverNumber "
						+ "WHERE F2.DepartureAirportID = '" + arrAirport + "' AND F2.ArrivalAirportID = '" + depAirport + "' " // Switch airports.
						+ date2
						+ "GROUP BY F2.FlightNumber, F2.AirlineID, F2.AircraftID, F2.DepartureAirportID, F2.DepartureDateTime, "
						+ "F2.ArrivalAirportID, F2.ArrivalDateTime, F2.FlightDuration, F2.TotalPrice";
	     		}
			}
			
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
			out.println("<a class=\"cc_button\" href=\"PortalPassenger.jsp\">Home</a>");
		}
		%>
		</tbody>
	</table>
	
	<!-- Refresh -->
	<div class="row justify-content-right">
		<a class="cc_button" href="PassengerFlights.jsp">Refresh</a>
	</div>
	
	<!-- Book a Flight -->
	<p class="cc_heading">Book a Flight</p>
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
			<button type="submit" class="cc_button">Book</button>
		</div>
		
		</div>
	</form>
	
	<!-- Sort By -->
	<p class="cc_heading">Sort By</p>
	<form class="row g-3 align-items-center cc_form" method="get" action="">
		<div class="col">
			<div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="sortBy" id="sortBy" value="TotalPrice" required>
				<label class="form-check-label">Price</label>
			</div>
		</div>
		
		<div class="col">
			<div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="sortBy" id="sortBy" value="FlightDuration" required>
				<label class="form-check-label">Flight Duration</label>
			</div>
		</div>
		
		<div class="col">
			<div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="sortBy" id="sortBy" value="DepartureDateTime" required>
				<label class="form-check-label">Departure Date</label>
			</div>
		</div>
		
		<div class="col">
			<div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="sortBy" id="sortBy" value="ArrivalDateTime" required>
				<label class="form-check-label">Arrival Date</label>
			</div>
		</div>
		
		<div class="col-12 mb-3">
			<button type="submit" class="cc_button">Sort</button>
		</div>
	</form>
	
	<!-- Filter By -->
	<p class="cc_heading">Filter By</p>
	<form class="row g-3 align-items-center cc_form" method="get" action="">
		<div class="col">
		
		<div class="mb-3">
			<label class="form-label">Choose a price range.</label>
			<div class="input-group">
			<input type="text" class="form-control" name="minPrice" id="minPrice" placeholder="Minimum Price">
			<span class="input-group-text">to</span>
			<input type="text" class="form-control" name="maxPrice" id="maxPrice" placeholder="Maximum Price">
			</div>
		</div>
		
		<div class="mb-3">
			<label class="form-label">Choose an airline.</label>
			<select class="form-control" name="airline">
				<option value=""></option>
				<option value="AA">American Airlines (AA)</option>
				<option value="B6">JetBlue Airways (B6)</option>
				<option value="DL">Delta (DL)</option>
				<option value="UA">United Airlines (UA)</option>
				<option value="WN">Southwest Airlines (WN)</option>
			</select>
		</div>
		
		<div class="mb-3">
			<label class="form-label">Choose the number of layovers.</label>
			<input type="text" class="form-control" name="numOfLayovers" id="numOfLayovers" placeholder="0">
		</div>
		
		<div class="mb-3">
			<label class="form-label">Choose a departure time.</label>
			<input type="text" class="form-control" name="depDateTime" id="depDateTime" placeholder="00:00:00">
		</div>
		
		<div class="mb-3">
			<label class="form-label">Choose an arrival time.</label>
			<input type="text" class="form-control" name="arrDateTime" id="arrDateTime" placeholder="00:00:00">
		</div>
		
		<div class="mb-3">
			<button type="submit" class="cc_button">Filter</button>
		</div>
		
		</div>
	</form>
	
	<!-- Search By -->
	<p class="cc_heading">Search By</p>
	<form class="row g-3 align-items-center cc_form" method="get" action="">
		<div class="col">
		
		<div class="mb-3">
			<label class="form-label">Choose departing and arriving airports.</label>
			<div class="input-group">
			<input type="text" class="form-control" name="depAirport" id="depAirport" placeholder="Departure Airport" required>
			<span class="input-group-text">to</span>
			<input type="text" class="form-control" name="arrAirport" id="arrAirport" placeholder="Arrival Airport" required>
			</div>
		</div>
		
		<div class="mb-3">
			<label class="form-label">Choose trip type.</label>
			<select class="form-control" name="tripType" required>
				<option value="round">Round Trip</option>
				<option value="oneway">One-Way Trip</option>
				<option value="any">Any Trip</option>
			</select>
		</div>
		
		<div class="mb-3">
			<label class="form-label">(One-Way) Enter specific date.</label>
			<div class="input-group">
			<input type="text" class="form-control" name="1DepDate" id="1DepDate" placeholder="YYYY-MM-DD">
			</div>
		</div>
		
		<div class="mb-3">
			<label class="form-label">(Round) Enter specific dates.</label>
			<div class="input-group">
			<input type="text" class="form-control" name="2DepDate" id="2DepDate" placeholder="YYYY-MM-DD">
			<span class="input-group-text">to</span>
			<input type="text" class="form-control" name="2ArrDate" id="2ArrDate" placeholder="YYYY-MM-DD">
			</div>
		</div>
		
		<div class="mb-3">
			<label class="form-label">(Round) Enter flexible dates.</label>
			<div class="input-group">
			<input type="text" class="form-control" name="3DepDate" id="3DepDate" placeholder="YYYY-MM-DD">
			<span class="input-group-text">to</span>
			<input type="text" class="form-control" name="3ArrDate" id="3ArrDate" placeholder="YYYY-MM-DD">
			</div>
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