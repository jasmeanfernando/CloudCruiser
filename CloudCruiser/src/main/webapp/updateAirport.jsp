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
		// Get parameters from EditSystems.jsp.
		String airport = request.getParameter("airport");
		String airportName = request.getParameter("airport_name");
		String newAirport = request.getParameter("new_airport");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String country = request.getParameter("country");
		String updateAction = request.getParameter("action");
		
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query based updateAction.
		String query = "";
		if (updateAction.equalsIgnoreCase("add")) {
			query = "INSERT INTO Airport (AirportID, AirportName, City, State, Country) "
				+ "VALUES (?, ?, ?, ?, ?)";
		}
		else if (updateAction.equalsIgnoreCase("delete")) {
			query = "DELETE FROM Airport "
				+ "WHERE AirportID = ?";
		}
		else {
			query = "UPDATE Airport "
				+ "SET AirportName = ? "
				+ "WHERE AirportID = ?";
		}
		
		// Create SQL statement.
		PreparedStatement prepstmt = con.prepareStatement(query);
		
		if (updateAction.equalsIgnoreCase("add")) {
			prepstmt.setString(1, airport);
			prepstmt.setString(2, airportName);
			prepstmt.setString(3, city);
			prepstmt.setString(4, state);
			prepstmt.setString(5, country);
		}
		else if (updateAction.equalsIgnoreCase("delete")) {
			prepstmt.setString(1, airport);
		}
		else {
			prepstmt.setString(1, newAirport);
			prepstmt.setString(2, airport);
		}
		
		// Execute query.
		int rowsAffected = prepstmt.executeUpdate();
		
		// Check if update was successful.
        if (rowsAffected > 0) {
            out.println("<p>Airport modifications successful!</p>");
        }
        else {
        	out.println("<p>Airport modifications failed. Please try again.</p>");
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