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
		try {
			// Get database connection.
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			// Get parameters from Representative.jsp.
			// Aircraft:
			String aircraftAction = request.getParameter("aircraftAction");
			
			// Airport:
			String airportAction = request.getParameter("airportAction");
			
			// Flight:
			String flightAction = request.getParameter("flightAction");
			
			// Initialize Servlet.
			FlightSystem system = new FlightSystem ();
			
			try {
				// Edit Aircraft:
				if (aircraftAction != null) {
					// Get parameters from Aircraft form.
					String aircraftId = request.getParameter("aircraftId");
					String airlineId = request.getParameter("airlineId");
					String aircraftSeats = request.getParameter("aircraftSeats");
					
					// Make an aircraft change.
					system.editAircraft(aircraftAction, aircraftId, airlineId, aircraftSeats);
				}
				
				// Edit Airport:
				if (airportAction != null) {
					// Get parameters from Airport form.
					String airportId = request.getParameter("airportId");
					String name = request.getParameter("name");
					String city = request.getParameter("city");
					String state = request.getParameter("state");
					String country = request.getParameter("country");
					
					// Make an airport change.
					system.editAirport(airportAction, airportId, name, city, state, country);
				}
				
				// Edit Flight:
				if (flightAction != null) {
					// Get parameters from Flight form.
					String airlineId = request.getParameter("airlineId");
					String aircraftId = request.getParameter("aircraftId");
					String departureAirport = request.getParameter("departureAirport");
					String departureDateTime = request.getParameter("departureDateTime");
					String arrivalAirport = request.getParameter("arrivalAirport");
					String arrivalDateTime = request.getParameter("arrivalDateTime");
					String layover = request.getParameter("layover");
					String international = request.getParameter("international");
					String duration = request.getParameter("duration");
					String price = request.getParameter("price");
					
					// Make a flight change.
					system.editFlight(flightAction, airlineId, aircraftId, departureAirport, departureDateTime, arrivalAirport, arrivalDateTime, layover, international, duration, price);
				}
			}
			catch (SQLException e) {
				out.print("<p class=\"cc_paragraph\">System action failed. Please try again.</p>");
				out.println("<a class=\"cc_button\" href=\"PortalRepresentative.jsp\">Home</a>");
			}
			
			// Close connection.
			con.close();
		}
		catch (Exception e) {
			out.print("<p class=\"cc_paragraph\">Error loading page. Please try again.</p>");
			out.println("<a class=\"cc_button\" href=\"PortalRepresentative.jsp\">Home</a>");
		}
	%>
	
	<!-- Close the else statement. -->
	<% } %>
	<!-- Bootstrap JS and Popper.js -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<!-- Bootstrap JavaScript -->
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	</body>
</html>