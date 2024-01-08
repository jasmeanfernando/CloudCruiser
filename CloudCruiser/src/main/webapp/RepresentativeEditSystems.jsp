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
		try {
			// Get database connection.
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			// Get parameters from Representative.jsp.
			// Aircraft:
			String aircraftAction = request.getParameter("aircraftAction");
			String aircraftId = request.getParameter("aircraftId");
			String aircraftAirline = request.getParameter("aircraftAirline");
			String aircraftSeats = request.getParameter("aircraftSeats");
			
			// Initialize Servlet.
			System system = new System ();
			
			try {
				// Edit Aircraft:
				if () {
					system.makeReservation();
				}
				// Edit Airport:
				
				// Edit Flight:
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
			<title>RepresentativePortal</title>
	</head>
	
	<body>
<!-- Customer must be logged in to access this page. -->
<% if (session.getAttribute("user") == null) { %>
	You are not logged in!
	<br>
	<a href="LoginPortal.jsp">Please login.</a>
<% } else { %>
	<% try {
		// Get parameters from EditSystems.jsp.
		String aircraft = request.getParameter("aircraft");
		String airline = request.getParameter("airline");
		String newAirline = request.getParameter("new_airline");
		String numSeats = request.getParameter("num_seats");
		String updateAction = request.getParameter("action");
		
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query based updateAction.
		String query = "";
		if (updateAction.equalsIgnoreCase("add")) {
			query = "INSERT INTO Aircraft (AircraftID, AirlineID, NumOfSeats) "
				+ "VALUES (?, ?, ?)";
		}
		else if (updateAction.equalsIgnoreCase("delete")) {
			query = "DELETE FROM Aircraft "
				+ "WHERE AircraftID = ?";
		}
		else {
			query = "UPDATE Aircraft "
				+ "SET AirlineID = ? "
				+ "WHERE AircraftID = ?";
		}
		
		// Create SQL statement.
		PreparedStatement prepstmt = con.prepareStatement(query);
		
		if (updateAction.equalsIgnoreCase("add")) {
			prepstmt.setString(1, aircraft);
			prepstmt.setString(2, airline);
			prepstmt.setInt(3, Integer.parseInt(numSeats));
		}
		else if (updateAction.equalsIgnoreCase("delete")) {
			prepstmt.setString(1, aircraft);
		}
		else {
			prepstmt.setString(1, newAirline);
			prepstmt.setString(2, aircraft);
		}
		
		// Execute query.
		int rowsAffected = prepstmt.executeUpdate();
		
		// Check if update was successful.
        if (rowsAffected > 0) {
            out.println("<p>Aircraft modifications successful!</p>");
        }
        else {
        	out.println("<p>Aircraft modifications failed. Please try again.</p>");
        }
		
		// Close the connection.
        con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("<p>Timeout...</p>");
	}
	%>
	<p><a href="RepresentativePortal.jsp">Back to Home</a></p>
	<p><a href="Logout.jsp">Log Out</a></p>
<% } %>
</html>