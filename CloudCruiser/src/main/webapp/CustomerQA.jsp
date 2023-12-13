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
			<title>CustomerPortal</title>
	</head>
	
	<body>
<!-- Customer must be logged in to access this page. -->
<% if (session.getAttribute("user") == null) { %>
	You are not logged in!
	<br>
	<a href="LoginPortal.jsp">Please login.</a>
<% } else { %>
	<h1>Browse your questions!</h1>
	<% try {
		// Get CID for query.
		String cid = (String) session.getAttribute("user");
				
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
		String query = "SELECT QuestionID, CustomerID, QuestionText, QuestionDateTime "
			+ "FROM Questions "
			+ "WHERE CustomerID = ?";

		
		// Create SQL statement.
		PreparedStatement prepstmt = con.prepareStatement(query);
		prepstmt.setString(1, cid);
		
		// Execute query.
		ResultSet result = prepstmt.executeQuery();
		
		// Create HTML Table.
		out.print("<table border=2>");
		
		// Make row.
		out.print("<tr>");
		
		// Make column.
		out.print("<td>");
		out.print("Question Number"); // Column header.
		out.print("</td>");
		
		out.print("<td>");
		out.print("Customer");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Inquiry");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Date & Time");
		out.print("</td>");
		
		// Parse each tuple from queried table.
		while (result.next()) {
			// Make row.
			out.print("<tr>");
			// Make column -> Prints "FlightNumber" of all existing tuples.
			out.print("<td>");
			out.print(result.getString("QuestionID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("CustomerID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("QuestionText"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("QuestionDateTime"));
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
	
	<h1>Browse answers from CloudCruiser's Customer Representatives!</h1>
	<% try {
		// Get CID for query.
		String cid = (String) session.getAttribute("user");
				
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
		String query = "SELECT AnswerID, CustomerID, RepresentativeID, AnswerText, AnswerDateTime "
			+ "FROM Answers "
			+ "WHERE CustomerID = ?";
		
		// Create SQL statement.
		PreparedStatement prepstmt = con.prepareStatement(query);
		prepstmt.setString(1, cid);
		
		// Execute query.
		ResultSet result = prepstmt.executeQuery();
		
		// Create HTML Table.
		out.print("<table border=2>");
		
		// Make row.
		out.print("<tr>");
		
		// Make column.
		out.print("<td>");
		out.print("Question Number"); // Column header.
		out.print("</td>");
		
		out.print("<td>");
		out.print("Customer");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Representative");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Reply");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Date & Time");
		out.print("</td>");
		
		// Parse each tuple from queried table.
		while (result.next()) {
			// Make row.
			out.print("<tr>");
			// Make column -> Prints "FlightNumber" of all existing tuples.
			out.print("<td>");
			out.print(result.getString("AnswerID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("CustomerID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("RepresentativeID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("AnswerText"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("AnswerDateTime"));
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
	
	<h2>Post a Question?</h2>
	<p>Fill out your email and the inquiry you want to post.</p>
	<form method="post" action="PostQuestion.jsp">
		<table>
			<tr>
			<td>Email: </td><td><input type="text" name="email"></td></tr>
			<tr>
			<td>Inquiry: </td><td><input type="text" name="inquiry"></td></tr>
		</table>
		
		<input type="submit" value="Submit">
	</form>
	
	<h2>Filter By...</h2>
	<p>Enter some keywords to obtain your question/answer.</p>
	<form method="post" action="QAFilter.jsp">
		<table>
			<tr>
			<td>Email: </td><td><input type="radio" name="filterby" value="Question"> Question
			<input type="radio" name="filterby" value="Answer"> Answer</td></tr>
			<tr>
			<td>Keywords: </td><td><input type="text" name="keyword"></td></tr>
		</table>
		
		<input type="submit" value="Submit">
	</form>
<% } %>
	<p><a href="CustomerPortal.jsp">Back to Home</a></p>
	<p><a href="Logout.jsp">Log Out</a></p>
	</body>
</html>