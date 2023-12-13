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
	<h1>Q&A By Keyword!</h1>
	<% try {
		// Get CID for query.
		String cid = (String) session.getAttribute("user");
				
		// Get parameters from CustomerQA.jsp.
		String type = request.getParameter("filterby");
		String text = request.getParameter("keyword");
		String[] keywords = text.split("\\s+");
				
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
		ResultSet result = null;
		if (type.equalsIgnoreCase("Question")) {
			String query = "SELECT QuestionID AS Parameter, CustomerID, "
				+ "QuestionText AS ParameterField, QuestionDateTime AS ParameterDateTime "
				+ "FROM Questions "
				+ "WHERE CustomerID = ? AND (";
			
			for (int i = 0; i < keywords.length; i++) {
				if (i > 0) {
					query += " OR ";
				}
				query += "QuestionText LIKE ?";
			}
			query += ")";
			
			// Create SQL statement.
			PreparedStatement prepstmt = con.prepareStatement(query);
			prepstmt.setString(1, cid);
			for (int i = 0; i < keywords.length; i++) {
				prepstmt.setString(i + 2, "%" + keywords[i] + "%");
			}
			
			// Execute query.
			result = prepstmt.executeQuery();
		}
		else {
			String query = "SELECT AnswerID AS Parameter, CustomerID, RepresentativeID, "
					+ "AnswerText AS ParameterField, AnswerDateTime AS ParameterDateTime "
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
			PreparedStatement prepstmt = con.prepareStatement(query);
			prepstmt.setString(1, cid);
			for (int i = 0; i < keywords.length; i++) {
				prepstmt.setString(i + 2, "%" + keywords[i] + "%");
			}
			
			// Execute query.
			result = prepstmt.executeQuery();
		}
		
		// Create HTML Table.
		out.print("<table border=2>");
		
		// Make row.
		out.print("<tr>");
		
		// Make column.
		out.print("<td>");
		out.print("Email"); // Column header.
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
			// Make column.
			out.print("<td>");
			out.print(result.getString("CustomerID"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("ParameterField"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("ParameterDateTime"));
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
<% } %>
	<p><a href="CustomerPortal.jsp">Back to Home</a></p>
	<p><a href="Logout.jsp">Log Out</a></p>
	</body>
</html>