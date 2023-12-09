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
	<a href="loginPortal.jsp">Please login.</a>
<% } else { %>
	<h1>Browse all filtered flights!</h1>
	<br>
	<% try {
		// For HTML header -> no other purpose.
		String typeOfFilters = "";
		
		// Get parameters from BrowseFlights.jsp.
		String min_price = request.getParameter("filterby_min_price");
		String max_price = request.getParameter("filterby_max_price");
		String airline = request.getParameter("filterby_airline");
		String layovers = request.getParameter("filterby_layovers");
		String departure_time = request.getParameter("filterby_departure_time");
		String arrival_time = request.getParameter("filterby_arrival_time");
		
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query -> 1=1 to signify boolean value to append 'AND' to the query.
		String query = "SELECT * FROM Flight WHERE 1=1";
		
		// Filter by price.
        if (min_price != null && !min_price.isEmpty()) {
        	query += " AND TotalPrice >= " + min_price;
        	typeOfFilters += "<br>minimum price";
        }
        if (max_price != null && !max_price.isEmpty()) {
            query += " AND TotalPrice <= " + max_price;
            typeOfFilters += "<br>maximum price";
        }
        
        // Filter by airline.
        if (airline != null && !airline.isEmpty()) {
            query += " AND AirlineID = '" + airline + "'";
            typeOfFilters += "<br>airline";
        }
        
        // Filter by layovers.
        if (layovers != null && !layovers.isEmpty()) {
            query += " AND FlightNumber IN (SELECT LayoverNumber FROM Layover GROUP BY LayoverNumber HAVING COUNT(*) <= " + layovers + ")";
            typeOfFilters += "<br>layovers";
        }
        
        // Filter by time.
        if (departure_time != null && !departure_time.isEmpty()) {
            query += " AND TIME(DepartureDateTime) = '" + departure_time + "'";
            typeOfFilters += "<br>departure time";
        }
        if (arrival_time != null && !arrival_time.isEmpty()) {
            query += " AND TIME(ArrivalDateTime) = '" + arrival_time + "'";
            typeOfFilters += "<br>arrival time";
        }
        
        // Remove trailing space.
        query = query.trim();
        
     	// Create SQL statement.
     	Statement stmt = con.createStatement();
     	
     	// Execute query.
     	ResultSet result = stmt.executeQuery(query);
     	
		out.print("<p>List of flights filtered by:" + typeOfFilters + "</p>");
		
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
		//ex.printStackTrace(); -> Helps with debugging.
		out.print(ex);
		out.print("<p>Timeout...</p>");
	}
	%>
	<p><a href="BrowseFlights.jsp">Back to Flights</a></p>
	<p><a href="Logout.jsp">Log Out</a></p>
<% } %>
	</body>
</html>