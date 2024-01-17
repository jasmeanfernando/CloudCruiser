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
		<title>AdminPortal</title>
		<!-- Google Fonts -->
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Pacifico|Poppins">
		<!-- CloudCruiser CSS -->
		<link rel="stylesheet" href="/CloudCruiser/resources/css/cloudcruiser.css">
		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	</head>
	
	<body>
	<!-- Admin must be logged in to access this page. -->
	<%
	if (session.getAttribute("user") == null) {
		out.println("<p class=\"cc_paragraph\">You are not logged in! Please login.</p>");
		out.println("<a class=\"cc_button\" href=\"PortalLogin.jsp\">Log In</a>");
	}
	else {
		try {
			// Get database connection.
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			// Get parameters from AdminUsers.jsp.
			String userAction = request.getParameter("userAction");
			String accountType = request.getParameter("accountType");
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			
			// Initialize Servlet.
			User user = new User ();
			
			try {
				// Add a user.
				if (userAction != null && userAction.equalsIgnoreCase("addUser")) {
					user.addUser(accountType, firstName, lastName, email, password);
					out.print("<p class=\"cc_paragraph\">Added user.</p>");
					out.println("<a class=\"cc_button\" href=\"AdminUsers.jsp\">Back</a>");
				}
				// Remove a user.
				else {
					int rowsAffected = user.removeUser(accountType, firstName, lastName, email, password);
					if (rowsAffected > 0) {
						out.print("<p class=\"cc_paragraph\">Removed user.</p>");
						out.println("<a class=\"cc_button\" href=\"AdminUsers.jsp\">Back</a>");
					}
					else {
						out.print("<p class=\"cc_paragraph\">Failed to remove user.</p>");
						out.println("<a class=\"cc_button\" href=\"AdminUsers.jsp\">Back</a>");
					}
				}
			}
			catch (SQLException e) {
				out.println(e);
				out.print("<p class=\"cc_paragraph\">User action failed. Please try again.</p>");
				out.println("<a class=\"cc_button\" href=\"AdminUsers.jsp\">Home</a>");
			}
			
			// Close connection.
			con.close();
		}
		catch (Exception e) {
			out.print("<p class=\"cc_paragraph\">Error loading page. Please try again.</p>");
			out.println("<a class=\"cc_button\" href=\"PortalAdmin.jsp\">Home</a>");
		}
	%>
	<!-- Close the else statement. -->
	<% } %>
	<!-- Bootstrap JS and Popper.js -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<!-- Bootstrap JavaScript -->
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	</body>
</html>