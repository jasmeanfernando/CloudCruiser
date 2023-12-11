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
			<title>RegistrationAccount</title>
	</head>
	
	<body>
	<% try {
		// Get parameters from RegistrationPortal.jsp.
		String firstName = request.getParameter("first_name");
		String lastName = request.getParameter("last_name");
		String accountID = request.getParameter("username");
		String accountPW = request.getParameter("password");
		String accountType = request.getParameter("usertype");
	    if (accountType == null) { // Handle null case with default value.
	    	accountType = "Customer";
	    }
		
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create SQL statement.
		PreparedStatement preparedStatement = null;
		
		// Insert account into correct table: Customer or Representative.
		if (accountType.equalsIgnoreCase("Customer")) {
            String insertPassengerQuery = "INSERT INTO Customer (CID, Password, FirstName, LastName) VALUES (?, ?, ?, ?)";
            preparedStatement = con.prepareStatement(insertPassengerQuery);
            preparedStatement.setString(1, accountID);
            preparedStatement.setString(2, accountPW);
            preparedStatement.setString(3, firstName);
            preparedStatement.setString(4, lastName);
        }
		else {
            String insertRepresentativeQuery = "INSERT INTO Representative (RID, Password, FirstName, LastName) VALUES (?, ?, ?, ?)";
            preparedStatement = con.prepareStatement(insertRepresentativeQuery);
            preparedStatement.setString(1, accountID);
            preparedStatement.setString(2, accountPW);
            preparedStatement.setString(3, firstName);
            preparedStatement.setString(4, lastName);
        }

        // Execute query.
        int rowsAffected = preparedStatement.executeUpdate();

        // Check if insertion was successful.
        if (rowsAffected > 0) {
            out.println("<p>Registration successful!</p>");
        }
        else {
        	out.println("<p>Registration failed. Please try again.</p>");
        }
        
    	// Close connection.
        con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("<p>Registration failed.</p>");
	}
	%>
	</body>
</html>