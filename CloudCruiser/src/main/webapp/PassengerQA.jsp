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
		<title>PassengerPortal</title>
		<!-- Google Fonts -->
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Pacifico|Poppins">
		<!-- CloudCruiser CSS -->
		<link rel="stylesheet" href="/CloudCruiser/resources/css/cloudcruiser.css">
		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	</head>
	
	<body>
	<!-- Customer must be logged in to access this page. -->
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
			String query = "SELECT QuestionID, CustomerID, QuestionText, QuestionDateTime FROM Questions ";
			
			// Get parameters: Filter Questions/Answers.
			String qaType = request.getParameter("qaType");
			String qaKeywords = request.getParameter("qaKeywords");
			
			// Choose correct query.
			PreparedStatement prepstmt = null;
			ResultSet resultset = null;
			if (qaType != null && qaType.equalsIgnoreCase("question") && qaKeywords != null) {
				String[] keywords = qaKeywords.split("\\s+");
				
				// Filter questions.
				query = "SELECT QuestionID, CustomerID, QuestionText, QuestionDateTime "
					+ "FROM Questions "
					+ "WHERE ";
				
				for (int i = 0; i < keywords.length; i++) {
					if (i > 0) {
						query += " OR ";
					}
					query += "QuestionText LIKE ?";
				}
				
				// Create SQL statement.
				prepstmt = con.prepareStatement(query);
				int index = 1;
				for (int i = 0; i < keywords.length; i++) {
					prepstmt.setString(index, "%" + keywords[i] + "%");
					index++;
				}
				
				// Execute query.
				resultset = prepstmt.executeQuery();
			}
			else {
				// Create SQL statement.
				prepstmt = con.prepareStatement(query);
				
				// Execute query.
				resultset = prepstmt.executeQuery();
			}
			
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
			out.println("<a class=\"cc_button\" href=\"PortalPassenger.jsp\">Home</a>");
		}
		%>
		</tbody>
		</table>
		
		<!-- Refresh Questions -->
		<div class="row justify-content-right">
			<a class="cc_button" href="PassengerQA.jsp">Refresh</a>
		</div>
		
		<!-- Answers Table -->
		<p class="cc_heading">Answers</p>
		<p class="cc_paragraph">Below are answers to your questions.</p>
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
			String query = "SELECT AnswerID, CustomerID, RepresentativeID, AnswerText, AnswerDateTime "
				+ "FROM Answers "
				+ "WHERE CustomerID = '" + (String)session.getAttribute("user") + "'";
			
			// Get parameters: Filter Questions/Answers.
			String qaType = request.getParameter("qaType");
			String qaKeywords = request.getParameter("qaKeywords");
			
			// Choose correct query.
			PreparedStatement prepstmt = null;
			ResultSet resultset = null;
			if (qaType != null && qaType.equalsIgnoreCase("answer") && qaKeywords != null) {
				String[] keywords = qaKeywords.split("\\s+");
				
				// Filter answers.
				query = "SELECT AnswerID, CustomerID, RepresentativeID, AnswerText, AnswerDateTime "
					+ "FROM Answers "
					+ "WHERE CustomerID = ? AND (";
				
				for (int i = 0; i < keywords.length; i++) {
					if (i > 0) {
						query += " OR ";
					}
					query += "AnswerText LIKE ?";
				}
				query += ")";
				
				// Create SQL statement.
				prepstmt = con.prepareStatement(query);
				int index = 1;
				for (int i = 0; i < keywords.length; i++) {
					prepstmt.setString(index, "%" + keywords[i] + "%");
					index++;
				}
				
				// Execute query.
				resultset = prepstmt.executeQuery();
			}
			else {
				// Create SQL statement.
				prepstmt = con.prepareStatement(query);
				
				// Execute query.
				resultset = prepstmt.executeQuery();
			}
			
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
			out.println("<a class=\"cc_button\" href=\"PortalPassenger.jsp\">Home</a>");
		}
		%>
		</tbody>
		</table>
		
		<!-- Refresh Answers -->
		<div class="row justify-content-right">
			<a class="cc_button" href="PassengerQA.jsp">Refresh</a>
		</div>
		
		<!-- Post a Question -->
		<p class="cc_heading">Post a Question</p>
		<form class="row g-3 align-items-center cc_form" method="post" action="PassengerEditQA.jsp">
			<div class="col">
		
			<div class="mb-3">
				<label class="form-label">Inquiry:</label>
				<input type="text" class="form-control" name="questionInquiry" id="questionInquiry" placeholder="" required>
			</div>
		
			<div class="mb-3">
				<button type="submit" class="cc_button">Post</button>
			</div>
		
			</div>
		</form>
		
		<!-- Filter Q&A -->
		<p class="cc_heading">Filter Questions/Answers</p>
		<form class="row g-3 align-items-center cc_form" method="get" action="">
			<div class="col">
			
			<div class="mb-3">
			<select class="form-control" name="qaType" required>
				<option value="question">Question</option>
				<option value="answer">Answer</option>
			</select>
			</div>
			
			<div class="mb-3">
				<label class="form-label">Keywords:</label>
				<input type="text" class="form-control" name="qaKeywords" id="qaKeywords" placeholder="" required>
			</div>
		
			<div class="mb-3">
				<button type="submit" class="cc_button">Filter</button>
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