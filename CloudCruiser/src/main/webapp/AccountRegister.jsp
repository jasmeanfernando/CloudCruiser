<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336.pkg.*" %>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>RegisterAccount</title>
		<!-- Google Fonts -->
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Pacifico|Poppins">
		<!-- CloudCruiser CSS -->
		<link rel="stylesheet" href="/CloudCruiser/resources/css/cloudcruiser.css">
		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	</head>
	
	<body>
	<%
	try {
		// Get parameters from PortalRegister.jsp.
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		String accountType = request.getParameter("accountType");
		
		// Check if passwords match.
		if (!password.equalsIgnoreCase(confirmPassword)) {
			out.println("<p class=\"cc_paragraph\">Passwords do not match. Please try again.</p>");
			out.println("<a class=\"cc_button\" href=\"PortalRegister.jsp\">Sign Up</a>");
		}
		else {
			// Get database connection.
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			// Create SQL statement.
			PreparedStatement prepstmt = null;
			
			// Create query.
			if (accountType.equalsIgnoreCase("Passenger")) {
				String insertPassengerQuery = "INSERT INTO Customer (CID, Password, FirstName, LastName) VALUES (?, ?, ?, ?)";
				prepstmt = con.prepareStatement(insertPassengerQuery);
				prepstmt.setString(1, email);
				prepstmt.setString(2, password);
				prepstmt.setString(3, firstName);
				prepstmt.setString(4, lastName);
			}
			else {
				String insertRepresentativeQuery = "INSERT INTO Representative (RID, Password, FirstName, LastName) VALUES (?, ?, ?, ?)";
				prepstmt = con.prepareStatement(insertRepresentativeQuery);
				prepstmt.setString(1, email);
				prepstmt.setString(2, password);
				prepstmt.setString(3, firstName);
				prepstmt.setString(4, lastName);
			}
			
			// Execute query.
			int rowsAffected = prepstmt.executeUpdate();
			
			// Check if insertion was successful.
			if (rowsAffected > 0) {
				out.println("<p class=\"cc_paragraph\">Registration successful!</p>");
			}
			else {
				out.println("<p class=\"cc_paragraph\">Registration failed. Please try again.</p>");
	        }
			out.println("<a class=\"cc_button\" href=\"PortalRegister.jsp\">Sign Up</a>");
	        
	    	// Close connection.
	        con.close();
		}
	}
	catch (Exception ex) {
		out.print("<p class=\"cc_paragraph\">Registration failed. Please try again.</p>");
		out.println("<a class=\"cc_button\" href=\"PortalRegister.jsp\">Sign Up</a>");
	}
	%>
	</body>
</html>