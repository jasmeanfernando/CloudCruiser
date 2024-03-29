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
			String query = "SELECT R.ReservationNumber, R.CustomerID, R.Class, "
				+ "F.FlightNumber, F.AirlineID, F.DepartureAirportID, F.ArrivalAirportID, F.TotalPrice "
				+ "FROM Reservation R "
				+ "JOIN Flight F ON R.FlightNumber = F.FlightNumber";
			
			String calcquery = "";
			
			// Get parameters: Search By.
			String searchByEmail = request.getParameter("searchByEmail");
			String searchByFlightId = request.getParameter("searchByFlightId");
			
			// Get parameters: Sort By.
			String sortBy = request.getParameter("sortBy");
			String value = "";
			String entity = "";
			String entityCost = "";
			
			if (searchByEmail != null && !searchByEmail.isEmpty()) {
				query += " WHERE R.CustomerID = '" + searchByEmail + "'";
			}
			
			if (searchByFlightId != null && !searchByFlightId.isEmpty()) {
				query += " WHERE R.FlightNumber = " + searchByFlightId;
			}
			
			if (sortBy != null && !sortBy.isEmpty()) {
				if (sortBy.equalsIgnoreCase("ActiveCustomer")) {
					value = "Most Active Customer";
					
					calcquery = "SELECT R.CustomerID AS Entity, SUM(F.TotalPrice) AS TotalPrice "
						+ "FROM Reservation R "
						+ "JOIN Flight F ON R.FlightNumber = F.FlightNumber "
						+ "GROUP BY R.CustomerID "
						+ "ORDER BY TotalPrice DESC";
				}
				else {
					value = "Most Active Flight ID";
					
					calcquery = "SELECT R.FlightNumber AS Entity, SUM(F.TotalPrice) AS TotalPrice "
						+ "FROM Reservation R "
						+ "JOIN Flight F ON R.FlightNumber = F.FlightNumber "
						+ "GROUP BY R.FlightNumber "
						+ "ORDER BY TotalPrice DESC";
				}
				
				// Create SQL statement.
				Statement calcstmt = con.createStatement();
				
				// Execute query.
				ResultSet calcresultset = calcstmt.executeQuery(calcquery);
				
				if (calcresultset.next()) {
					entity = calcresultset.getString("Entity");
					entityCost = calcresultset.getString("TotalPrice");
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
				<td><%= resultset.getString("CustomerID") %></td>
				<td><%= resultset.getString("ReservationNumber") %></td>
				<td><%= resultset.getString("FlightNumber") %></td>
				<td><%= resultset.getString("AirlineID") %></td>
				<td><%= resultset.getString("DepartureAirportID") %></td>
				<td><%= resultset.getString("ArrivalAirportID") %></td>
				<td><%= resultset.getString("Class") %></td>
				<td><%= resultset.getString("TotalPrice") %></td>
			</tr>
		<%
			}
			
			if (sortBy != null) {
				%>
				<p class="cc_paragraph"><%= value %>: <%= entity %></p>
				<p class="cc_paragraph">Financial Statement: <%= entityCost %></p>
				<%
			}
			
			// Close connection.
			con.close();
		}
		catch (Exception e) {
			out.print(e);
			out.print("<p class=\"cc_paragraph\">Error loading page. Please try again.</p>");
			out.println("<a class=\"cc_button\" href=\"PortalAdmin.jsp\">Home</a>");
		}
		%>
		</tbody>
		</table>
		
		<!-- Refresh -->
		<div class="row justify-content-right">
			<a class="cc_button" href="AdminReservations.jsp">Refresh</a>
		</div>
		
		<!-- Search By -->
		<p class="cc_heading">Search By</p>
		<p class="cc_paragraph">Search Reservations by Email or Flight ID.</p>
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
		
		<!-- Sort By -->
		<p class="cc_heading">Sort By Most Active</p>
		<form class="row g-3 align-items-center cc_form" method="get" action="">
			<div class="col">
				<div class="form-check form-check-inline">
					<input class="form-check-input" type="radio" name="sortBy" id="sortBy" value="ActiveCustomer" required>
					<label class="form-check-label">Customer</label>
				</div>
			</div>
		
			<div class="col">
				<div class="form-check form-check-inline">
					<input class="form-check-input" type="radio" name="sortBy" id="sortBy" value="ActiveFlight" required>
					<label class="form-check-label">Flight</label>
				</div>
			</div>
		
			<div class="col-12 mb-3">
				<button type="submit" class="cc_button">Sort</button>
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