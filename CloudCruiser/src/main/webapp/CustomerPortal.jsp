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
	<%
	if (session.getAttribute("user") == null) {
	%>
	You are not logged in!
	<br>
	<a href="loginAccount.jsp">Please login.</a>
<%
	}
	else {
%>
	<h1>Welcome back, <%=session.getAttribute("user") %>!</h1>
	<p><a href="BrowseFlights.jsp">Browse Flights</a></p>
	<p><a href="CustomerReservations.jsp">View Reservations</a></p>
	<p><a href="CustomerWaitingList.jsp">View Waiting List</a></p>
	<p><a href="QA.jsp">View Q&A Forum</a></p>
	<p><a href="Logout.jsp">Log Out</a></p>
	<br>
	
	<h3>Sort By:</h3>
	<form action="SortedFlight.jsp">
		<input type="radio" name="orderby" value="price" required> Price
		<input type="radio" name="orderby" value="departure_time" required> Departure Time
		<input type="radio" name="orderby" value="arrival_time" required> Arrival Time
		<input type="radio" name="orderby" value="flight_duration" required> Flight Duration
		<br><br>
		
		<input type="submit" value="Sort Flights">
	</form>
	
	<h3>Filter By:</h3> 
	<form method = "post" action ="FilteredFlights.jsp">
		Choose two airports.
		<br>
		<input type="text" name="dep_airport" placeholder="Departure Airport"/> 
		<br>
		<input type="text" name="arr_airport" placeholder="Arrival Airport"/> 
		<br><br>
		
		Choose desired trip type.
		<br>
		<input type="radio" name="trip_type" value="roundtrip" required/> Round Trip
		<br>
		<input type="radio" name="trip_type" value="oneway" required/> One-Way Trip
		<br>
		<input type="radio" name="trip_type" value="either" required/> Any Trip
		<br><br>
		
		Choose departure date.
		<br>
		<input type="radio" name="dep_date" value="any" required/> Any date.
		<br>
		<input type="radio" name="dep_date" value="flex" required/> Enter flexible dates (+/3 days).
		<br>
		<input type="text" name="dep_date_start" placeholder="YYYY-MM-DD"/> to <input type="text" name="dep_date_end" placeholder="YYYY-MM-DD"/>
		<br>
		<input type="radio" name="dep_date" value="inflex" required/> Enter non-flexible date.
		<br>
		<input type="text" name="dep_date_start" placeholder="YYYY-MM-DD"/> to <input type="text" name="dep_date_end" placeholder="YYYY-MM-DD"/>
		<br><br>
		
		Choose arrival date.
		<br>
		<input type="radio" name="arr_date" value="any" required/> Any date.
		<br>
		<input type="radio" name="arr_date" value="flex" required/> Enter flexible dates (+/3 days).
		<br>
		<input type="text" name="arr_date_start" placeholder="YYYY-MM-DD"/> to <input type="text" name="arr_date_end" placeholder="YYYY-MM-DD"/>
		<br>
		<input type="radio" name="arr_date" value="inflex" required/> Enter non-flexible date.
		<br>
		<input type="text" name="dep_date_start" placeholder="YYYY-MM-DD"/> to <input type="text" name="dep_date_end" placeholder="YYYY-MM-DD"/>
		<br><br>
		
		Indicate layover preference (number of preferable stops).
		<br>
		<input type="text" name="num_stops" placeholder="Integer"/>
		<br><br>
		
		<input type="submit" value="Filter Flights">
	</form>	
<%
    }
%>
	
	</body>
</html>