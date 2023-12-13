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
		// Get parameters from EditUsers.jsp.
		String firstName = request.getParameter("first_name");
		String lastName = request.getParameter("last_name");
		String email = request.getParameter("username");
		String type = request.getParameter("usertype");
		// Handle null case with default value.
		
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query based userType.
		String query = "";
		if (type.equalsIgnoreCase("Customer")) {
			query = "DELETE FROM Customer WHERE CID = ?";
		}
		else {
			query = "DELETE FROM Representative WHERE RID = ?";
		}
		
		// Create SQL statement.
		PreparedStatement prepstmt = con.prepareStatement(query);
		prepstmt.setString(1, email);
		
		// Execute query.
		int rowsAffected = prepstmt.executeUpdate();
		
		// Check if update was successful.
        if (rowsAffected > 0) {
            out.println("<p>Account deletion successful!</p>");
        }
        else {
        	out.println("<p>Account deletion failed. Please try again.</p>");
        }
		
		// Close the connection.
        con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("<p>Timeout...</p>");
	}
	%>
	<p><a href="AdminPortal.jsp">Back to Home</a></p>
	<p><a href="Logout.jsp">Log Out</a></p>
<% } %>
</html>