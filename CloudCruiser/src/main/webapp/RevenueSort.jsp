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
<!-- Admin must be logged in to access this page. -->
<% if (session.getAttribute("user") == null) { %>
	You are not logged in!
	<br>
	<a href="LoginPortal.jsp">Please login.</a>
<% } else { %>
	<% try {
		// Get parameters from RevenueReports.jsp.
		String parameter = request.getParameter("sortby");
		
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		//Create query.
		String query = "";
		if (parameter.equalsIgnoreCase("Passenger")) {
			query = "SELECT R.CustomerID AS Parameter, SUM(F.TotalPrice) AS TotalPriceByParameter "
				+ "FROM Reservation R "
				+ "JOIN Flight F ON R.FlightNumber = F.FlightNumber "
				+ "GROUP BY R.CustomerID "
				+ "ORDER BY TotalPriceByParameter";
		}
		else {
			query = "SELECT R.FlightNumber AS Parameter, SUM(F.TotalPrice) AS TotalPriceByParameter "
				+ "FROM Reservation R "
				+ "JOIN Flight F ON R.FlightNumber = F.FlightNumber "
				+ "GROUP BY R.CustomerID, R.FlightNumber "
				+ "ORDER BY TotalPriceByParameter";
		}
		
		// Create SQL statement.
		Statement stmt = con.createStatement();
		
		// Execute query.
		ResultSet result = stmt.executeQuery(query);
		        
		out.print("<h2>Revenue Report By Lowest to Highest " + parameter + "</h2>");
        
        // Create HTML Table.
     	out.print("<table border=2>");
     	
     	// Make row.
     	out.print("<tr>");
     	
     	// Make column.
     	out.print("<td>");
     	out.print(parameter); // Column header.
     	out.print("</td>");
     	
     	out.print("<td>");
     	out.print("Total Price");
     	out.print("</td>");
     	
     	// Parse each tuple from queried table.
     	while (result.next()) {
     		// Make row.
     		out.print("<tr>");
     		// Make column.
     		out.print("<td>");
     		out.print(result.getString("Parameter"));
     		out.print("</td>");
     		
     		out.print("<td>");
     		out.print(result.getString("TotalPriceByParameter"));
     		out.print("</td>");

     	}
		out.print("</table>");
        
    	// Close connection.
        con.close();
	} catch (Exception ex) {
		out.print(ex);
	}
	%>
	<p><a href="RevenueReports.jsp">Back to Home</a></p>
	<p><a href="Logout.jsp">Log Out</a></p>
<% } %>
	</body>
</html>