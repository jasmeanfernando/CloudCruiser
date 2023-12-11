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
	<h1>Browse all available flights!</h1>
	<% try {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query -> Joins Flight and Layover.
		String query = "SELECT F.FlightNumber, F.AirlineID, F.AircraftID, F.DepartureAirportID, F.ArrivalAirportID, "
        	+ "F.DepartureDateTime, F.ArrivalDateTime, F.FlightDuration, F.TotalPrice, "
        	+ "L.LayoverAirportID, "
        	+ "COUNT(L.LayoverNumber) AS NumberOfLayovers "
        	+ "FROM Flight F "
        	+ "LEFT JOIN Layover L ON F.FlightNumber = L.LayoverNumber "
        	+ "GROUP BY F.FlightNumber, F.AirlineID, F.AircraftID, F.DepartureAirportID, F.ArrivalAirportID, "
        	+ "F.DepartureDateTime, F.ArrivalDateTime, F.FlightDuration, F.TotalPrice, L.LayoverAirportID";
		
		// Create SQL statement.
		Statement stmt = con.createStatement();
		
		// Execute query.
		ResultSet result = stmt.executeQuery(query);
		
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
		out.print("Departure Date & Time");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Arrival Date & Time");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Duration");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Number of Layovers");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Layover Airport");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Price");
		out.print("</td>");
		
		// Parse each tuple from queried table.
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
			out.print(result.getString("NumberOfLayovers"));
			out.print("</td>");
			
			out.print("<td>");
			String bool = result.getString("LayoverAirportID");
			if (bool == null) {
				out.print("N/A");
			}
			else {
				out.print("LayoverAirportID");
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
		out.print(ex);
		out.print("<p>Timeout...</p>");
	}
	%>
	<h2>Ready to Reserve a Flight?</h2>
	<form method="post" action="ReserveFlight.jsp">
		<table>
			<tr>
			<td>First Name: </td><td><input type="text" name="first_name"></td></tr>
			<tr>
			<tr>
			<td>Last Name: </td><td><input type="text" name="last_name"></td></tr>
			<tr>
			<tr>
			<td>Email: </td><td><input type="text" name="email"></td></tr>
			<tr>
			<td>Departing Flight Number: </td><td><input type="text" name="departing_flight_num"></td></tr>
			<td>Arriving Flight Number: </td><td><input type="text" name="arriving_flight_num"></td></tr>
			<tr>
			<td>Flight Class:</td><td><input type="radio" name="flight_class" value="First"> First Class
       		<input type="radio" name="flight_class" value="Business"> Business Class
       		<input type="radio" name="flight_class" value="Economy"> Economy Class</td><tr>
       		<tr>
       		<td>Flight Type:</td><td><input type="radio" name="flight_type" value="oneway"> One-Way Trip
       		<input type="radio" name="flight_type" value="roundtrip"> Round Trip</td><tr>
		</table>
		
		<input type="submit" value="Submit">
	</form>
	
	<h2>Sort By...</h2>
	<form method="get" action="FlightSort.jsp">
		<input type="radio" name="sortby" value="price" required> Price
		<input type="radio" name="sortby" value="flight_duration" required> Flight Duration
		<input type="radio" name="sortby" value="departure_time" required> Departure Time
		<input type="radio" name="sortby" value="arrival_time" required> Arrival Time
		<br><br>
		
		<input type="submit" value="Sort Flights">
	</form>
	
	<h2>Filter By...</h2>
	<form method="get" action="FlightFilter.jsp">
		Choose price range.
		<br>
		<input type="text" name="filterby_min_price" placeholder="Min Price"/>
		<br>
		<input type="text" name="filterby_max_price" placeholder="Max Price"/>
		<br><br>
		
		Choose an airline.
		<br>
		<select name="filterby_airline">
		<option value ="AA">American Airlines</option>
		<option value ="B6">JetBlue Airways</option>
		<option value ="DL">Delta</option>
		<option value ="UA">United Airlines</option>
		<option value ="WN">Southwest Airlines</option>
		</select>
		<br><br>
		
		Choose number of layovers.
		<br>
		<input type="text" name="filterby_layovers" placeholder="0"/>
		<br><br>
		
		Choose departure time (Input in military time).
		<br>
		<input type="text" name="filterby_departure_time" placeholder="00:00:00">
		<br><br>
		
		Choose arrival time (Input in military time).
		<br>
		<input type="text" name="filterby_arrival_time" placeholder="00:00:00">
		<br><br>
		
		<input type="submit" value="Filter Flights">
	</form>
	
	<h2>Search By...</h2> 
	<form method = "post" action ="FlightSearch.jsp">
		Choose two airports codes.
		<br>
		<input type="text" name="searchby_departure_airport" placeholder="Departure Airport"/> 
		<br>
		<input type="text" name="searchby_arrival_airport" placeholder="Arrival Airport"/> 
		<br><br>
		
		Choose trip type.
		<br>
		<input type="radio" name="searchby_triptype" value="oneway" required/> One-Way Trip
		<br>
		<input type="radio" name="searchby_triptype" value="roundtrip" required/> Round Trip
		<br>
		<input type="radio" name="searchby_triptype" value="either" required/> Any Trip
		<br><br>
		
		Choose date(s).
		<br>
		<input type="radio" name="searchby_date" value="1inflex" required/> Enter specific date.
		<br><input type="text" name="specific_date_start" placeholder="YYYY-MM-DD"/>
		
		<br>
		<input type="radio" name="searchby_date" value="2inflex" required/> Enter specific depart-by and arrive-by dates.
		<br><input type="text" name="specific_dates_start" placeholder="YYYY-MM-DD"/> to <input type="text" name="specific_dates_end" placeholder="YYYY-MM-DD"/>
		
		<br>
		<input type="radio" name="searchby_date" value="2flex" required/> Enter flexible depart-by and arrive-by dates (+/-3 days).
		<br><input type="text" name="flex_dates_start" placeholder="YYYY-MM-DD"/> to <input type="text" name="flex_dates_end" placeholder="YYYY-MM-DD"/>
		<br><br>
		
		<input type="submit" value="Search Flights">
	</form>
	<p><a href="CustomerPortal.jsp">Back to Home</a></p>
	<p><a href="Logout.jsp">Log Out</a></p>
<% } %>
	</body>
</html>