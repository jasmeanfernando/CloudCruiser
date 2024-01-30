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
		// Initialize parameters for report.
		double totalPrice = 0.0;
		int totalReservations = 0;
	%>
		<div class="container mt-1">
		
		<!-- Logo -->
		<div class="text-center mb-4">
		<img src="/CloudCruiser/resources/assets/logo.jpg" alt="Logo"
		class="img-fluid rounded" style="max-width: 25%;">
		</div>
		
		<!-- Revenue Report Table -->
		<p class="cc_heading">Revenue Report</p>
		<p class="cc_paragraph">Generate a revenue report by one of the following filters: Month, flight, airline, or customer.</p>
		<table class="table table-striped table-hover">
		<thead>
		<tr>
			<th>Customer ID</th>
			<th>Reservation ID</th>
			<th>Flight ID</th>
			<th>Airline</th>
			<th>Price</th>
		</tr>
		</thead>
		<tbody>
		<%
		try {
			// Get database connection.
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			// Get parameters from AdminRevenueReports.jsp.
			String monthbyYearRevenue = request.getParameter("monthbyYearRevenue");
			String flightRevenue = request.getParameter("flightRevenue");
			String airlineRevenue = request.getParameter("airlineRevenue");
			String customerRevenue = request.getParameter("customerRevenue");
			
			// Initialize Servlet.
			RevenueReport revenue = new RevenueReport ();
			ResultSet calcresultset = null;
			ResultSet tableresultset = null;
			
			// Create calculation query.
			String calcQuery = "SELECT SUM(F.TotalPrice) AS RevenueTotalPrice, " +
				"COUNT(R.ReservationNumber) AS RevenueTotalReservations " +
				"FROM Reservation R " +
				"JOIN Flight F ON R.FlightNumber = F.FlightNumber ";
			
			try {
				// Create Month By Year Report.
				if (monthbyYearRevenue != null && !monthbyYearRevenue.isEmpty()) {
					// Update calculation query.
					calcQuery += "WHERE DATE_FORMAT(R.PurchaseDateTime, '%Y-%m') = ?";
					
					// Create SQL statement.
					PreparedStatement calcstmt = con.prepareStatement(calcQuery);
					calcstmt.setString(1, monthbyYearRevenue);
					
					// Execute calculation query.
					calcresultset = calcstmt.executeQuery();
					
					tableresultset = revenue.getMonthByYearRevenue(monthbyYearRevenue);
				}
				
				// Create Flight Report.
				else if (flightRevenue != null && !flightRevenue.isEmpty()) {
					// Update calculation query.
					calcQuery += "WHERE F.FlightNumber = ?";
					
					// Create SQL statement.
					PreparedStatement calcstmt = con.prepareStatement(calcQuery);
					calcstmt.setString(1, flightRevenue);
					
					// Execute calculation query.
					calcresultset = calcstmt.executeQuery();
					
					tableresultset = revenue.getFlightRevenue(flightRevenue);
				}
				
				// Create Airline Report.
				else if (airlineRevenue != null && !airlineRevenue.isEmpty()) {
					// Update calculation query.
					calcQuery += "WHERE F.AirlineID = ?";
					
					// Create SQL statement.
					PreparedStatement calcstmt = con.prepareStatement(calcQuery);
					calcstmt.setString(1, airlineRevenue);
					
					// Execute calculation query.
					calcresultset = calcstmt.executeQuery();
					
					tableresultset = revenue.getAirlineRevenue(airlineRevenue);
				}
				
				// Create Customer Report.
				else if (customerRevenue != null && !customerRevenue.isEmpty()) {
					// Update calculation query.
					calcQuery += "WHERE R.CustomerID = ?";
					
					// Create SQL statement.
					PreparedStatement calcstmt = con.prepareStatement(calcQuery);
					calcstmt.setString(1, customerRevenue);
					
					// Execute calculation query.
					calcresultset = calcstmt.executeQuery();
					
					tableresultset = revenue.getCustomerRevenue(customerRevenue);
				}
				
				if (calcresultset.next()) {
					totalPrice = calcresultset.getDouble("RevenueTotalPrice");
					totalReservations = calcresultset.getInt("RevenueTotalReservations");
				}
			}
			catch (SQLException e) {
				out.print("<p class=\"cc_paragraph\">Revenue action failed. Please try again.</p>");
				out.println("<a class=\"cc_button\" href=\"PortalAdmin.jsp\">Home</a>");
			}
			
			// Iterate through the result set and display data.
			while (tableresultset.next()) {
		%>
			<tr>
				<td><%= tableresultset.getString("CustomerID") %></td>
				<td><%= tableresultset.getString("ReservationNumber") %></td>
				<td><%= tableresultset.getString("FlightNumber") %></td>
				<td><%= tableresultset.getString("AirlineID") %></td>
				<td><%= tableresultset.getString("TotalPrice") %></td>
			</tr>
		<%
			}
			
			// Close connection.
			con.close();
		}
		catch (Exception e) {
			out.print("<p class=\"cc_paragraph\">Error loading page. Please try again.</p>");
			out.println("<a class=\"cc_button\" href=\"PortalAdmin.jsp\">Home</a>");
		}
		%>
		</tbody>
		</table>
		
		<p class="cc_paragraph">Report Total Price: <%= totalPrice %></p>
		<p class="cc_paragraph">Report Total Reservations: <%= totalReservations %></p>
		
		<!-- Back -->
		<div class="row justify-content-right">
			<a class="cc_button" href="AdminRevenueReports.jsp">Back</a>
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