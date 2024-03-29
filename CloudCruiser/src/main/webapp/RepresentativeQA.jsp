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
		<title>RepresentativePortal</title>
		<!-- Google Fonts -->
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Pacifico|Poppins">
		<!-- CloudCruiser CSS -->
		<link rel="stylesheet" href="/CloudCruiser/resources/css/cloudcruiser.css">
		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	</head>
	
	<body>
	<!-- Representative must be logged in to access this page. -->
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
		
		<!-- Questions Table -->
		<p class="cc_heading">Questions</p>
		<p class="cc_paragraph">Below are questions posted to the public Q&A Forum.</p>
		<table class="table table-striped table-hover">
		<thead>
		<tr>
			<th>Question ID</th>
			<th>Customer</th>
			<th>Inquiry</th>
			<th>Posted Date/Time</th>
		</tr>
		</thead>
		<tbody>
		<% 
		try {
			// Get database connection.
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			// Create query.
			String query = "SELECT QuestionID, CustomerID, QuestionText, QuestionDateTime FROM Questions";
			
			// Create SQL statement.
			PreparedStatement prepstmt = con.prepareStatement(query);
			
			// Execute query.
			ResultSet resultset = prepstmt.executeQuery();
			
			// Iterate through the result set and display data.
			while (resultset.next()) {
		%>
			<tr>
				<td><%= resultset.getString("QuestionID") %></td>
				<td><%= resultset.getString("CustomerID") %></td>
				<td><%= resultset.getString("QuestionText") %></td>
				<td><%= resultset.getString("QuestionDateTime") %></td>
			</tr>
		<%
			}
			
			// Close connection.
			con.close();
		}
		catch (Exception e) {
			out.print("<p class=\"cc_paragraph\">Error loading page. Please try again.</p>");
			out.println("<a class=\"cc_button\" href=\"PortalRepresentative.jsp\">Home</a>");
		}
		%>
		</tbody>
		</table>
		
		<!-- Refresh Questions -->
		<div class="row justify-content-right">
			<a class="cc_button" href="RepresentativeQA.jsp">Refresh</a>
		</div>
		
		<!-- Answers Table -->
		<p class="cc_heading">Answers</p>
		<p class="cc_paragraph">Below are answers posted to the public Q&A Forum.</p>
		<table class="table table-striped table-hover">
		<thead>
		<tr>
			<th>Question ID</th>
			<th>Customer</th>
			<th>Representative</th>
			<th>Inquiry</th>
			<th>Posted Date/Time</th>
		</tr>
		</thead>
		<tbody>
		<% 
		try {
			// Get database connection.
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			// Create query.
			String query = "SELECT AnswerID, CustomerID, RepresentativeID, AnswerText, AnswerDateTime FROM Answers";
			
			// Create SQL statement.
			PreparedStatement prepstmt = con.prepareStatement(query);
			
			// Execute query.
			ResultSet resultset = prepstmt.executeQuery();
			
			// Iterate through the result set and display data.
			while (resultset.next()) {
		%>
			<tr>
				<td><%= resultset.getString("AnswerID") %></td>
				<td><%= resultset.getString("CustomerID") %></td>
				<td><%= resultset.getString("RepresentativeID") %></td>
				<td><%= resultset.getString("AnswerText") %></td>
				<td><%= resultset.getString("AnswerDateTime") %></td>
			</tr>
		<%
			}
			
			// Close connection.
			con.close();
		}
		catch (Exception e) {
			out.print("<p class=\"cc_paragraph\">Error loading page. Please try again.</p>");
			out.println("<a class=\"cc_button\" href=\"PortalRepresentative.jsp\">Home</a>");
		}
		%>
		</tbody>
		</table>
		
		<!-- Refresh Answers -->
		<div class="row justify-content-right">
			<a class="cc_button" href="RepresentativeQA.jsp">Refresh</a>
		</div>
		
		<!-- Answer a Question -->
		<p class="cc_heading">Answer a Question</p>
		<form class="row g-3 align-items-center cc_form" method="post" action="RepresentativeEditQA.jsp">
			<div class="col">
			
			<div class="mb-3">
				<label class="form-label">Customer Email:</label>
				<input type="text" class="form-control" name="customerEmail" id="customerEmail" placeholder="" required>
			</div>
			
			<div class="mb-3">
				<label class="form-label">Question ID:</label>
				<input type="text" class="form-control" name="questionId" id="questionId" placeholder="" required>
			</div>
			
			<div class="mb-3">
				<label class="form-label">Response:</label>
				<input type="text" class="form-control" name="answerResponse" id="answerResponse" placeholder="" required>
			</div>
		
			<div class="mb-3">
				<button type="submit" class="cc_button">Post</button>
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