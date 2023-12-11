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
			<title>CustomerPortal</title>
	</head>
	
	<body>
<!-- Customer must be logged in to access this page. -->
<% if (session.getAttribute("user") == null) { %>
	You are not logged in!
	<br>
	<a href="LoginPortal.jsp">Please login.</a>
<% } else { %>
	<h1>Browse all sorted flights!</h1>
	<br>
	<% try {
		// For HTML header -> no other purpose.
		String typeOfSort = "";
		
		// Get parameters from BrowseFlights.jsp.
		String sort = request.getParameter("sortby");
		if (sort == null) { // Handle null case with default value.
			sort = "price";
		}
		
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
		String query = "SELECT * FROM Flight ORDER BY ";
		
		// Sort by price.
		if (sort.equalsIgnoreCase("price")) {
			query += "TotalPrice";
			typeOfSort = "price";
		}
		// Sort by duration.
		else if (sort.equalsIgnoreCase("flight_duration")) {
			query += "FlightDuration";
			typeOfSort = "duration of flight";
		}
		// Sort by departure.
		else if (sort.equalsIgnoreCase("departure_time")) {
			query += "TIME(DepartureDateTime) ASC";
			typeOfSort = "departure time";
		}
		// Sort by arrival.
		else {
			query += "TIME(ArrivalDateTime) ASC";
			typeOfSort = "arrival time";
		}
		
		// Create SQL statement.
		Statement stmt = con.createStatement();
		
		// Execute query.
		ResultSet result = stmt.executeQuery(query);
		out.print("<p>List of flights sorted by " + typeOfSort + ".</p>");
		
		// Create HTML Table.
		out.print("<table border=2>");
		
		// Make row.
		out.print("<tr>");
		
		// Make column.
		out.print("<td>");
		out.print("Flight Number"); // Column header.
		out.print("</td>");
		
		out.print("<td>");
		out.print("Airline");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Aircraft");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Departure Airport");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Arrival Airport");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Departure Time");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Arrival Time");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Duration");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Layovers");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Price");
		out.print("</td>");
		
		// Parse each tuple in Flight.
		while (result.next()) {
			// Make row.
			out.print("<tr>");
			// Make column -> Prints "FlightNumber" of all existing tuples.
			out.print("<td>");
			out.print(result.getString("FlightNumber"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("AirlineID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("AircraftID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("DepartureAirportID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("ArrivalAirportID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("DepartureDateTime"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("ArrivalDateTime"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("FlightDuration"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("IsLayover"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("TotalPrice"));
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
	<p><a href="BrowseFlights.jsp">Back to Flights</a></p>
	<p><a href="Logout.jsp">Log Out</a></p>
<% } %>
	</body>
</html>