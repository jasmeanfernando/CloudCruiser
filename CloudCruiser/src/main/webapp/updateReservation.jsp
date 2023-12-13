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
			<title>RegistrationPortal</title>
	</head>
	
	<body>
<!-- Customer must be logged in to access this page. -->
<% if (session.getAttribute("user") == null) { %>
	You are not logged in!
	<br>
	<a href="LoginPortal.jsp">Please login.</a>
<% } else { %>
	<% try {
		// Get parameters from RepresentativeReservations.jsp.
		String email = request.getParameter("email");
		String reservation = request.getParameter("res_num");
		String newFlightNum = request.getParameter("flight_num");
		String newFlightClass = request.getParameter("flight_class");
		String updateInfo = request.getParameter("change");
		
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query based updateAction.
		String query = "";
		if (updateInfo.equalsIgnoreCase("flight")) {
			query = "UPDATE Reservation "
				+ "SET FlightNumber = ? "
				+ "WHERE ReservationNumber = ? AND CustomerID = ?";
		}
		else {
			query = "UPDATE Reservation "
				+ "SET Class = ? "
				+ "WHERE ReservationNumber = ? AND CustomerID = ?";
		}
		
		// Create SQL statement.
		PreparedStatement prepstmt = con.prepareStatement(query);
		
		if (updateInfo.equalsIgnoreCase("flight")) {
			prepstmt.setString(1, newFlightNum);
			prepstmt.setString(2, reservation);
			prepstmt.setString(3, email);
		}
		else {
			prepstmt.setString(1, newFlightClass);
			prepstmt.setString(2, reservation);
			prepstmt.setString(3, email);
		}
		
		// Execute query.
		int rowsAffected = prepstmt.executeUpdate();
		
		// Check if update was successful.
        if (rowsAffected > 0) {
            out.println("<p>Reservation modifications successful!</p>");
        }
        else {
        	out.println("<p>Reservation modifications failed. Please try again.</p>");
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