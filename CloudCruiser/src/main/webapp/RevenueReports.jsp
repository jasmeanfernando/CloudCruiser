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
			<title>AdminPortal</title>
	</head>
	
	<body>
<!-- Admin must be logged in to access this page. -->
<% if (session.getAttribute("user") == null) { %>
	You are not logged in!
	<br>
	<a href="LoginPortal.jsp">Please login.</a>
<% } else { %>
	<h1>Generate revenue reports!</h1>
	<h2>Revenue Report By Month</h2>
	<form method="get" action="RevenueByMonth.jsp">
		<table>
			<tr>
			<td>Month (YYYY-MM): </td><td><input type="text" name="month_num"></td></tr>
		</table>
		<input type="submit" value="Submit">
	</form>
	
	<h2>Revenue Report by Flight</h2>
	<form method="get" action="RevenueByFlight.jsp">
		<table>
			<tr>
			<td>Flight: </td><td><input type="text" name="flight_num"></td></tr>
		</table>
		<input type="submit" value="Submit">
	</form>
	
	<h2>Revenue Report By Airline</h2>
	<form method="get" action="RevenueByAirline.jsp">
		<table>
			<tr>
			<td>Airline: </td><td><input type="text" name="airline_num"></td></tr>
		</table>
		<input type="submit" value="Submit">
	</form>
	
	<h2>Revenue Report By Customer</h2>
	<form method="get" action="RevenueByCustomer.jsp">
		<table>
			<tr>
			<td>Customer: </td><td><input type="text" name="email"></td></tr>
		</table>
		<input type="submit" value="Submit">
	</form>
	<p><a href="AdminPortal.jsp">Back to Home</a></p>
	<p><a href="Logout.jsp">Log Out</a></p>
<% } %>
	</body>
</html>