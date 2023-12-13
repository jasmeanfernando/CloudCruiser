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
	<h1>Customer Database</h1>
	<% try {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query -> Joins Flight and Layover.
		String query = "SELECT CID, Password, FirstName, LastName "
			+ "FROM Customer ";
		
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
		out.print("Email"); // Column header.
		out.print("</td>");
		
		out.print("<td>");
		out.print("Password");
		out.print("</td>");
		
		out.print("<td>");
		out.print("First Name");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Last Name");
		out.print("</td>");
		
		// Parse each tuple from queried table.
		while (result.next()) {
			// Make row.
			out.print("<tr>");
			// Make column -> Prints "FlightNumber" of all existing tuples.
			out.print("<td>");
			out.print(result.getString("CID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("Password"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("FirstName"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("LastName"));
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
	<h1>Customer Representative Database</h1>
	<% try {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query -> Joins Flight and Layover.
		String query = "SELECT RID, Password, FirstName, LastName "
			+ "FROM Representative ";
		
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
		out.print("Email"); // Column header.
		out.print("</td>");
		
		out.print("<td>");
		out.print("Password");
		out.print("</td>");
		
		out.print("<td>");
		out.print("First Name");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Last Name");
		out.print("</td>");
		
		// Parse each tuple from queried table.
		while (result.next()) {
			// Make row.
			out.print("<tr>");
			// Make column -> Prints "FlightNumber" of all existing tuples.
			out.print("<td>");
			out.print(result.getString("RID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("Password"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("FirstName"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("LastName"));
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
	<h2>Add User?</h2>
	<form method="post" action="registerAccount.jsp">
		<table>
			<tr>
			<td>First Name: </td><td><input type="text" name="first_name"></td></tr>
			<tr>
			<tr>
			<td>Last Name: </td><td><input type="text" name="last_name"></td></tr>
			<tr>
			<tr>
			<td>Email: </td><td><input type="text" name="username"></td></tr>
			<tr>
			<td>Password: </td><td><input type="password" name="password"></td></tr>
		</table>
		
		<input type="radio" name="usertype" value="Customer"> Passenger
       	<input type="radio" name="usertype" value="Representative"> Representative
			
		<br><br>
		<input type="submit" value="Submit">
	</form>
	
	<h2>Delete User?</h2>
	<form method="post" action="deleteAccount.jsp">
		<table>
			<tr>
			<td>First Name: </td><td><input type="text" name="first_name"></td></tr>
			<tr>
			<tr>
			<td>Last Name: </td><td><input type="text" name="last_name"></td></tr>
			<tr>
			<tr>
			<td>Email: </td><td><input type="text" name="username"></td></tr>
		</table>
		
		<input type="radio" name="usertype" value="Customer"> Passenger
       	<input type="radio" name="usertype" value="Representative"> Representative
			
		<br><br>
		<input type="submit" value="Submit">
	</form>
	
	<h2>Update User?</h2>
	<form method="post" action="updateAccount.jsp">
		<table>
			<tr>
			<td>First Name: </td><td><input type="text" name="first_name"></td></tr>
			<tr>
			<tr>
			<td>Last Name: </td><td><input type="text" name="last_name"></td></tr>
			<tr>
			<tr>
			<td>Email: </td><td><input type="text" name="username"></td></tr>
			<tr>
			<td>Password: </td><td><input type="text" name="password"></td></tr>
			<tr>
			<td>What do you want to update?</td>
			<td>
				<input type="radio" name="update" value="email"> Email
       			<input type="radio" name="update" value="password"> Password</td><tr>
       		<tr>
       		<td>What is the new parameter? </td><td><input type="text" name="new"></td></tr>
		</table>
		
		<input type="radio" name="usertype" value="Customer"> Passenger
       	<input type="radio" name="usertype" value="Representative"> Representative
			
		<br><br>
		<input type="submit" value="Submit">
	</form>
	</body>
	<p><a href="AdminPortal.jsp">Back to Home</a></p>
	<p><a href="Logout.jsp">Log Out</a></p>
<% } %>
</html>