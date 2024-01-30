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
		<title>AdminPortal</title>
		<!-- Google Fonts -->
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Pacifico|Poppins">
		<!-- CloudCruiser CSS -->
		<link rel="stylesheet" href="/CloudCruiser/resources/css/cloudcruiser.css">
		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	</head>
	
	<body>
	<!-- Admin must be logged in to access this page. -->
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
				+ "F.FlightNumber, F.AirlineID, F.DepartureAirportID, F.ArrivalAirportID "
				+ "FROM Reservation R "
				+ "JOIN Flight F ON R.FlightNumber = F.FlightNumber";
			
			// Get parameters: Search By.
			String searchByEmail = request.getParameter("searchByEmail");
			String searchByFlightId = request.getParameter("searchByFlightId");
			
			// Get parameters: Sort By.
			String sortBy = request.getParameter("sortBy");
			
			if (searchByEmail != null && !searchByEmail.isEmpty()) {
				query += " WHERE R.CustomerID = '" + searchByEmail + "'";
			}
			
			if (searchByFlightId != null && !searchByFlightId.isEmpty()) {
				query += " WHERE R.FlightNumber = " + searchByFlightId;
			}
			
			if (sortBy != null && !sortBy.isEmpty()) {
				if (sortBy.equalsIgnoreCase("ActiveCustomer")) {
					query = "SELECT SUM(F.TotalPrice) AS CustomerTotalPrice "
						+ "FROM Reservation R "
						+ "JOIN Flight F ON R.FlightNumber = F.FlightNumber "
						+ "GROUP BY R.CustomerID "
						+ "ORDER BY CustomerTotalPrice DESC";
				}
				else {
					query = "SELECT SUM(F.TotalPrice) AS FlightTotalPrice "
						+ "FROM Reservation R "
						+ "JOIN Flight F ON R.FlightNumber = F.FlightNumber "
						+ "GROUP BY R.FlightNumber "
						+ "ORDER BY FlightTotalPrice DESC";
				}
			}
			out.println(query);
			
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
			out.print(e);
			out.print("<p class=\"cc_paragraph\">Error loading page. Please try again.</p>");
			out.println("<a class=\"cc_button\" href=\"PortalPassenger.jsp\">Home</a>");
		}
		%>
		</tbody>
		</table>
		
		<!-- Refresh -->
		<div class="row justify-content-right">
			<a class="cc_button" href="AdminReservations.jsp">Refresh</a>
		</div>
		
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