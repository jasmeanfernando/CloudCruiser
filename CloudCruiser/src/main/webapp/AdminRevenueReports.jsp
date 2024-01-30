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
		
		<!-- Revenue Report -->
		<p class="cc_heading">Revenue Report</p>
		<p class="cc_paragraph">Generate a revenue report by one of the following filters: Month, flight, airline, or customer.</p>
		<form class="row g-3 align-items-center cc_form" method="get" action="AdminEditRevenueReports.jsp">
			<div class="col">
			
			<div class="mb-3">
				<label class="form-label">Month By Year:</label>
				<input type="text" class="form-control" name="monthbyYearRevenue" id="monthbyYearRevenue" placeholder="YYYY-MM">
			</div>
			
			<div class="mb-3">
				<label class="form-label">Flight ID:</label>
				<input type="text" class="form-control" name="flightRevenue" id="flightRevenue" placeholder="0">
			</div>
			
			<div class="mb-3">
				<label class="form-label">Airline:</label>
				<input type="text" class="form-control" name="airlineRevenue" id="airlineRevenue" placeholder="AB">
			</div>
			
			<div class="mb-3">
				<label class="form-label">Email:</label>
				<input type="text" class="form-control" name="customerRevenue" id="customerRevenue" placeholder="name@email.com">
			</div>
			
			<div class="mb-3">
				<button type="submit" class="cc_button">Generate</button>
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