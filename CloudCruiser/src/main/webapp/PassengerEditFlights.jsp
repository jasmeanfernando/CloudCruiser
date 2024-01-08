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
		try {
			// Get database connection.
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			// Get parameters from PassengerFlights.jsp.
			String flightFirstName = request.getParameter("flightFirstName");
			String flightLastName = request.getParameter("flightLastName");
			String flightEmail = request.getParameter("flightEmail");
			String depFlightId = request.getParameter("depFlightId");
			String arrFlightId = request.getParameter("arrFlightId");
			String flightClass = request.getParameter("flightClass");
			String flightType = request.getParameter("flightType");
			
			// Get parameters from PassengerReservations.jsp.
			String ticketEmail = request.getParameter("ticketEmail");
			String ticketID = request.getParameter("ticketID");
			
			// Initialize Servlet.
			FlightReservation reservation = new FlightReservation ();
			
			try {
				// Create a reservation.
				if (flightFirstName != null && flightLastName != null && flightEmail != null && depFlightId != null && arrFlightId != null && flightClass != null && flightType != null) {
					reservation.makeReservation(flightFirstName, flightLastName, flightEmail, depFlightId, arrFlightId, flightClass, flightType, true);
				}
				// Cancel a reservation.
				if (ticketEmail != null && ticketID != null) {
					reservation.cancelReservation(ticketEmail, ticketID);
				}
			}
			catch (SQLException e) {
				out.print("<p class=\"cc_paragraph\">Reservation action failed. Please try again.</p>");
				out.println("<a class=\"cc_button\" href=\"PortalPassenger.jsp\">Home</a>");
			}
			
			// Close connection.
			con.close();
		}
		catch (Exception e) {
			out.print("<p class=\"cc_paragraph\">Error loading page. Please try again.</p>");
			out.println("<a class=\"cc_button\" href=\"PortalPassenger.jsp\">Home</a>");
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