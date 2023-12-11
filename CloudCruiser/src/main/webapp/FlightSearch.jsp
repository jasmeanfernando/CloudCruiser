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
	<h1>Search for flights!</h1>
	<br>
	<% try {
		// For HTML header -> no other purpose.
		String typeOfSearch = "";
		
		// Get parameters from BrowseFlights.jsp.
		String departure_airport = request.getParameter("searchby_departure_airport");
		String arrival_airport = request.getParameter("searchby_arrival_airport");
		String triptype = request.getParameter("searchby_triptype");
		String dates = request.getParameter("searchby_date");
		
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
		String query = "";
		
		// Search by date(s).
		String inflex_date = request.getParameter("specific_date_start");
		String inflex_min_date = request.getParameter("specific_dates_start");
		String inflex_max_date = request.getParameter("specific_dates_end");
		String flex_min_date = request.getParameter("flex_dates_start");
		String flex_max_date = request.getParameter("flex_dates_end");
		
     	if (dates != null) {
     		// One date.
     		if (dates.equalsIgnoreCase("1inflex")) {
     			typeOfSearch += "<br>* Specific Date";
     			
     		}
     		//Two dates.
     		else if (dates.equalsIgnoreCase("2inflex")) {
     			typeOfSearch += "<br>* Specific Dates";
     		}
     		else {
     			typeOfSearch += "<br>* Specific Date (+/- 3 days)";
     		}
     	}
     	
     	// Search by airports and trip type.
     	if (triptype != null) {
     		// ************************
     		// ************************
     		// One-Way Trip = 1 Flight!
     		// ************************
     		// ************************
     		if (triptype.equalsIgnoreCase("oneway")) {
     			//Initialize dates.
     			String whereByDate = "";
     			if (dates.equalsIgnoreCase("1inflex") || dates.equalsIgnoreCase("2inflex")) {
     				whereByDate = "AND DATE(DepartureDateTime) = '" + inflex_date + "'";
     			}
     			else {
     				whereByDate = "AND DATE(DepartureDateTime) BETWEEN '" + flex_min_date + "' - INTERVAL 3 DAY AND '" + flex_min_date + "' + INTERVAL 3 DAY";
     			}
     			
     			// Build query...
     			query = "SELECT * FROM Flight " // select with columnsFlightNumber, DepartureAirport
    				+ "WHERE DepartureAirportID = '" + departure_airport + "' AND ArrivalAirportID = '" + arrival_airport + "' "
     				+ whereByDate;
     			
     			typeOfSearch += "<br>* One-Way Trip";
     		}
     		// *********************************
     		// *********************************
     		// Round Trip/Any Trip = 2+ Flights!
     		// *********************************
     		// *********************************
     		else if (triptype.equalsIgnoreCase("roundtrip") || triptype.equalsIgnoreCase("either")) {
     			//Initialize dates.
     			String whereByDate1 = "";
     			String whereByDate2 = "";
     			if (dates.equalsIgnoreCase("1inflex")) {
     				whereByDate1 = "AND DATE(Flight1.DepartureDateTime) = '" + inflex_date + "' ";
     				whereByDate2 = "AND DATE(Flight2.DepartureDateTime) = '" + inflex_date + "' ";
     			}
     			else if (dates.equalsIgnoreCase("2inflex")) {
     				whereByDate1 = "AND DATE(Flight1.DepartureDateTime) = '" + inflex_min_date + "' ";
     				whereByDate2 = "AND DATE(Flight2.ArrivalDateTime) = '" + inflex_max_date + "' ";
     			}
     			else {
     				whereByDate1 = "AND DATE(Flight1.DepartureDateTime) BETWEEN '" + flex_min_date + "' - INTERVAL 3 DAY AND '" + flex_min_date + "' + INTERVAL 3 DAY ";
     				whereByDate2 = "AND DATE(Flight2.ArrivalDateTime) BETWEEN '" + flex_min_date + "' - INTERVAL 3 DAY AND '" + flex_min_date + "' + INTERVAL 3 DAY ";
     			}
     			
     			// Build query...
     			query = "SELECT Flight1.FlightNumber AS FlightNumber, "
     				+ "Flight1.AirlineID AS AirlineID, "
     				+ "Flight1.AircraftID AS AircraftID, "
     				+ "Flight1.DepartureAirportID AS DepartureAirportID, "
					+ "Flight1.ArrivalAirportID AS ArrivalAirportID, "
					+ "Flight1.DepartureDateTime AS DepartureDateTime, "
					+ "Flight1.ArrivalDateTime AS ArrivalDateTime, "
					+ "Flight1.FlightDuration AS FlightDuration, "
				    + "Flight1.IsLayover AS IsLayover, "
				    + "Flight1.TotalPrice AS TotalPrice "
					+ "FROM Flight AS Flight1 "
					+ "WHERE Flight1.DepartureAirportID = '" + departure_airport + "' AND Flight1.ArrivalAirportID = '" + arrival_airport + "' "
					+ whereByDate1
					+ "UNION "
					+ "SELECT Flight2.FlightNumber AS FlightNumber, "
					+ "Flight2.AirlineID AS AirlineID, "
		     		+ "Flight2.AircraftID AS AircraftID, "
					+ "Flight2.DepartureAirportID AS DepartureAirportID, "
					+ "Flight2.ArrivalAirportID AS ArrivalAirportID, "
					+ "Flight2.DepartureDateTime AS DepartureDateTime, "
					+ "Flight2.ArrivalDateTime AS ArrivalDateTime, "
					+ "Flight2.FlightDuration AS FlightDuration, "
				    + "Flight2.IsLayover AS IsLayover, "
				    + "Flight2.TotalPrice AS TotalPrice "
					+ "FROM Flight AS Flight2 "
					+ "WHERE Flight2.ArrivalAirportID = '" + departure_airport + "' AND Flight2.DepartureAirportID = '" + arrival_airport + "' "
					+ whereByDate2;
			
     			if (triptype.equalsIgnoreCase("roundtrip")) {
     				typeOfSearch += "<br>* Round Trip";
     			}
     			else {
     				typeOfSearch += "<br>* Any Trip";
     			}
     		}
     	}
     	
     	// Create SQL statement.
     	Statement stmt = con.createStatement();
     	
     	// Execute query.
     	ResultSet result = stmt.executeQuery(query);
     	
		out.print("<p>List of flights based on search criteria:" + typeOfSearch + "</p>");
		
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
			String bool = result.getString("IsLayover");
			if (bool == "1") {
				out.print("Yes");
			}
			else {
				out.print("No");
			}
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