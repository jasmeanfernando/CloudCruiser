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
		// Get parameters from ReservationRepresentatives.jsp.
		String flightNumber = request.getParameter("flight_num");
		
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
		String query = "SELECT WaitingID, CustomerID, FirstName, LastName, FlightNumber, Class, PurchaseDateTime "
			+ "FROM WaitingList "
			+ "WHERE FlightNumber = ?";
		
		// Create SQL statement.
		PreparedStatement prepstmt = con.prepareStatement(query);
		prepstmt.setInt(1, Integer.parseInt(flightNumber));
		
		// Execute query.
		ResultSet result = prepstmt.executeQuery();
		
		// Create HTML Table.
		out.print("<table border=2>");
		
		// Make row.
		out.print("<tr>");
		
		// Make column.
		out.print("<td>");
		out.print("Waiting Number"); // Column header.
		out.print("</td>");
		
		out.print("<td>");
		out.print("Email");
		out.print("</td>");
		
		out.print("<td>");
		out.print("First Name");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Last Name");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Flight Number");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Flight Class");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Purchase Date & Time");
		out.print("</td>");
		
		// Parse each tuple from queried table.
		while (result.next()) {
			// Make row.
			out.print("<tr>");
			// Make column.
			out.print("<td>");
			out.print(result.getString("WaitingID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("CustomerID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("FirstName"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("LastName"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("FlightNumber"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("Class"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("PurchaseDateTime"));
			out.print("</td>");
		}
		out.print("</table>");
        
		// Close the connection.
        con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("<p>Timeout...</p>");
	}
	%>
	</body>
	<p><a href="RepresentativeReservations.jsp">Back to Home</a></p>
	<p><a href="Logout.jsp">Log Out</a></p>
<% } %>
</html>