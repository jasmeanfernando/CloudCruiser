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
		<title>LoginAccount</title>
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
		// Get parameters from PortalLogin.jsp.
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String accountType = request.getParameter("accountType");
		
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
			
		// Create query.
		String query = "";
		if (accountType.equalsIgnoreCase("Passenger")) {
			query = "SELECT * FROM Customer WHERE CID = ?";
		}
		else if (accountType.equalsIgnoreCase("Representative")) {
			query = "SELECT * FROM Representative WHERE RID = ?";
		}
		else {
			query = "SELECT * FROM Admin WHERE AID = ?";
		}
		
		// Create SQL statement.
		PreparedStatement prepstmt = con.prepareStatement(query);
		prepstmt = con.prepareStatement(query);
		prepstmt.setString(1, email);
		
		// Execute query.
		ResultSet resultset = prepstmt.executeQuery();
		
		// Check if username exists.
		if (resultset.next()) {
			String storedPassword = resultset.getString("Password");
			
			// Check if passwords match.
			if (password.equals(storedPassword)) {
				// Load session.
				session.setAttribute("user", email);
				
				// Launch appropriate portal.
				if (accountType.equalsIgnoreCase("Passenger")) {
					response.sendRedirect("PortalPassenger.jsp");
				}
				else if (accountType.equalsIgnoreCase("Representative")) {
        			response.sendRedirect("PortalRepresentative.jsp");
        		}
        		else {
        			response.sendRedirect("PortalAdmin.jsp");
        		}
			}
			else {
				out.println("<p class=\"cc_paragraph\">Password does not match. Please try again.</p>");
				out.println("<a class=\"cc_button\" href=\"PortalLogin.jsp\">Log In</a>");
			}
		}
		else {
			out.print("<p class=\"cc_paragraph\">" + accountType + " does not exist for email " + email + ". Please try again.</p>");
			out.println("<a class=\"cc_button\" href=\"PortalLogin.jsp\">Log In</a>");
		}
		
		// Close connection.
		con.close();
	}
	catch (Exception ex) {
		out.print("<p class=\"cc_paragraph\">Login failed. Please try again.</p>");
		out.println("<a class=\"cc_button\" href=\"PortalLogin.jsp\">Log In</a>");
	}
	%>
	</body>
</html>