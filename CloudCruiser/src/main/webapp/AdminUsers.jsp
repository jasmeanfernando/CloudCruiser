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
	%>
		<div class="container mt-1">
		
		<!-- Logo -->
		<div class="text-center mb-4">
		<img src="/CloudCruiser/resources/assets/logo.jpg" alt="Logo"
		class="img-fluid rounded" style="max-width: 25%;">
		</div>
		
		<!-- Customer Table -->
		<p class="cc_heading">Customers</p>
		<p class="cc_paragraph">Below are valid customers in CloudCruiser.</p>
		<table class="table table-striped table-hover">
		<thead>
		<tr>
			<th>Email</th>
			<th>Password</th>
			<th>First Name</th>
			<th>Last Name</th>
		</tr>
		</thead>
		<tbody>
		<% 
		try {
			// Get database connection.
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			// Create query.
			String query = "SELECT CID, Password, FirstName, LastName FROM Customer";
			
			// Create SQL statement.
			PreparedStatement prepstmt = con.prepareStatement(query);
			
			// Execute query.
			ResultSet resultset = prepstmt.executeQuery();
			
			// Iterate through the result set and display data.
			while (resultset.next()) {
		%>
			<tr>
				<td><%= resultset.getString("CID") %></td>
				<td><%= resultset.getString("Password") %></td>
				<td><%= resultset.getString("FirstName") %></td>
				<td><%= resultset.getString("LastName") %></td>
			</tr>
		<%
			}
			
			// Close connection.
			con.close();
		}
		catch (Exception e) {
			out.print("<p class=\"cc_paragraph\">Error loading page. Please try again.</p>");
			out.println("<a class=\"cc_button\" href=\"PortalAdmin.jsp\">Home</a>");
		}
		%>
		</tbody>
		</table>
		
		<!-- Refresh Database -->
		<div class="row justify-content-right">
			<a class="cc_button" href="AdminUsers.jsp">Refresh</a>
		</div>
		
		<!-- Representative Table -->
		<p class="cc_heading">Representatives</p>
		<p class="cc_paragraph">Below are valid representatives in CloudCruiser.</p>
		<table class="table table-striped table-hover">
		<thead>
		<tr>
			<th>Email</th>
			<th>Password</th>
			<th>First Name</th>
			<th>Last Name</th>
		</tr>
		</thead>
		<tbody>
		<% 
		try {
			// Get database connection.
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			// Create query.
			String query = "SELECT RID, Password, FirstName, LastName FROM Representative";
			
			// Create SQL statement.
			PreparedStatement prepstmt = con.prepareStatement(query);
			
			// Execute query.
			ResultSet resultset = prepstmt.executeQuery();
			
			// Iterate through the result set and display data.
			while (resultset.next()) {
		%>
			<tr>
				<td><%= resultset.getString("RID") %></td>
				<td><%= resultset.getString("Password") %></td>
				<td><%= resultset.getString("FirstName") %></td>
				<td><%= resultset.getString("LastName") %></td>
			</tr>
		<%
			}
			
			// Close connection.
			con.close();
		}
		catch (Exception e) {
			out.print("<p class=\"cc_paragraph\">Error loading page. Please try again.</p>");
			out.println("<a class=\"cc_button\" href=\"PortalAdmin.jsp\">Home</a>");
		}
		%>
		</tbody>
		</table>
		
		<!-- Refresh Database -->
		<div class="row justify-content-right">
			<a class="cc_button" href="AdminUsers.jsp">Refresh</a>
		</div>
		
		<!-- Edit User -->
		<p class="cc_heading">Edit User</p>
		<form class="row g-3 align-items-center cc_form" method="post" action="AdminEditUsers.jsp">
			<div class="col">
			
			<div class="mb-3">
				<select class="form-control" name="userAction">
					<option value="addUser">Add User</option>
					<option value="removeUser">Remove User</option>
				</select>
			</div>
			
			<div class="mb-3">
			<label class="form-label">Account Type:</label>
				<select class="form-control" name="accountType">
					<option value="Customer">Customer</option>
					<option value="Representative">Representative</option>
				</select>
			</div>
			
			<div class="mb-3">
				<label class="form-label">First Name:</label>
				<input type="text" class="form-control" name="firstName" id="firstName" required>
			</div>
			
			<div class="mb-3">
				<label class="form-label">Last Name:</label>
				<input type="text" class="form-control" name="lastName" id="lastName" required>
			</div>
		
			<div class="mb-3">
				<label class="form-label">Email:</label>
				<input type="text" class="form-control" name="email" id="email" required>
			</div>
			
			<div class="mb-3">
				<label class="form-label">Password:</label>
				<input type="text" class="form-control" name="password" id="password" required>
			</div>
		
			<div class="mb-3">
				<button type="submit" class="cc_button">Edit</button>
			</div>
			
			</div>
		</form>
		
		</div>
	
	<!-- Close the else statement. -->
	<% } %>
	<!-- Bootstrap JS and Popper.js -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<!-- Bootstrap JavaScript -->
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	</body>
</html>