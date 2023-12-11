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
		// Get parameters from CustomerReservations.jsp.
     	String email = request.getParameter("email");
     	String ticket = request.getParameter("ticket_num");
     	
     	// Handle null case with default value.
		
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		//
		FlightReservation fr = new FlightReservation();
		try {
	        // Call the makeReservation.
	        fr.cancelReservation(email, ticket);
	    }
		catch (SQLException e) {
	        e.printStackTrace();
	        out.println("<p>Cancellation failed. Please try again.</p>");
	    }
		
		out.println("<p>Cancellation successful!</p>");
        
    	// Close connection.
        con.close();
	} catch (Exception ex) {
		out.print(ex);
	}
	%>
<% } %>
	</body>
</html>