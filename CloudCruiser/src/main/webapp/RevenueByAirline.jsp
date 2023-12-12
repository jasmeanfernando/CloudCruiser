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
			<title>RegistrationAccount</title>
	</head>
	
	<body>
	<% double price = 0.0; %>
	<% int res = 0; %>
<!-- Customer must be logged in to access this page. -->
<% if (session.getAttribute("user") == null) { %>
	You are not logged in!
	<br>
	<a href="LoginPortal.jsp">Please login.</a>
<% } else { %>
	<% try {
		// Get parameters from RevenueReports.jsp.
		String airline = request.getParameter("airline_num");
		
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		//Create query.
		String aggregateSql = "SELECT SUM(F.TotalPrice) AS TotalPriceForAirline, COUNT(R.ReservationNumber) AS NumberOfReservations " +
                              "FROM Reservation R " +
                              "JOIN Flight F ON R.FlightNumber = F.FlightNumber " +
                              "WHERE F.AirlineID = ?";
        
		PreparedStatement aggregateStatement = con.prepareStatement(aggregateSql);
        aggregateStatement.setString(1, airline);
        ResultSet aggregateResultSet = aggregateStatement.executeQuery();
        
        String detailSql = "SELECT R.ReservationNumber, R.CustomerID, F.FlightNumber, F.TotalPrice " +
                           "FROM Reservation R " +
                           "JOIN Flight F ON R.FlightNumber = F.FlightNumber " +
                           "WHERE F.AirlineID = ?";
        
        PreparedStatement detailStatement = con.prepareStatement(detailSql);
        detailStatement.setString(1, airline);
        ResultSet detailResultSet = detailStatement.executeQuery();

        if (aggregateResultSet.next()) {
            price = aggregateResultSet.getDouble("TotalPriceForAirline");
            res = aggregateResultSet.getInt("NumberOfReservations");
        }
        
        out.print("<h2>Revenue Report By Airline</h2>");
        
        // Create HTML Table.
     	out.print("<table border=2>");
     	
     	// Make row.
     	out.print("<tr>");
     	
     	// Make column.
     	out.print("<td>");
     	out.print("Reservation Number"); // Column header.
     	out.print("</td>");
     	
     	out.print("<td>");
     	out.print("Email");
     	out.print("</td>");
     	
     	out.print("<td>");
     	out.print("Flight Number");
     	out.print("</td>");
     	
     	out.print("<td>");
     	out.print("TotalPrice");
     	out.print("</td>");
     	
     	// Parse each tuple from queried table.
     	while (detailResultSet.next()) {
     		// Make row.
     		out.print("<tr>");
     		// Make column -> Prints "ReservationNumber" of all existing tuples.
     		out.print("<td>");
     		out.print(detailResultSet.getString("ReservationNumber"));
     		out.print("</td>");
     		
     		out.print("<td>");
     		out.print(detailResultSet.getString("CustomerID"));
     		out.print("</td>");
     		
     		out.print("<td>");
     		out.print(detailResultSet.getString("FlightNumber"));
     		out.print("</td>");
     		
     		out.print("<td>");
     		out.print(detailResultSet.getString("TotalPrice"));
     		out.print("</td>");
     	}
		out.print("</table>");
        
    	// Close connection.
        con.close();
	} catch (Exception ex) {
		out.print(ex);
	}
	%>
	<p>Total Revenue: <%= price %></p>
    <p>Total Reservations: <%= res %></p>
	<p><a href="RevenueReports.jsp">Back to Home</a></p>
	<p><a href="Logout.jsp">Log Out</a></p>
<% } %>
	</body>
</html>