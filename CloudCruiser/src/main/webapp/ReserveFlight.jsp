<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.FlightReservation" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
			<title>RegistrationAccount</title>
	</head>
	
	<body>
<!-- Customer must be logged in to access this page. -->
<% if (session.getAttribute("user") == null) { %>
	You are not logged in!
	<br>
	<a href="LoginPortal.jsp">Please login.</a>
<% } else { %>
	<% try {
		// Get parameters from BrowseFlights.jsp.
		String firstName = request.getParameter("first_name");
     	String lastName = request.getParameter("last_name");
     	String email = request.getParameter("email");
     	String departingFlight = request.getParameter("departing_flight_num");
     	String arrivingFlight = request.getParameter("arriving_flight_num");
     	String flightClass = request.getParameter("flight_class");
     	String flightType = request.getParameter("flight_type");
		
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		//
		FlightReservation fr = new FlightReservation();
		try {
	        // Call the makeReservation.
	        fr.makeReservation(firstName, lastName, email, departingFlight, arrivingFlight, flightClass, flightType);
	    }
		catch (SQLException e) {
	        e.printStackTrace();
	        out.println("<p>Reservation failed. Please try again.</p>");
	    }
		
		out.println("<p>Reservation successful!</p>");
        
    	// Close connection.
        con.close();
	} catch (Exception ex) {
		out.print(ex);
	}
	%>
<% } %>
	</body>
</html>