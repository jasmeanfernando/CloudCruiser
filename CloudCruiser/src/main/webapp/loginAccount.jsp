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
			<title>LoginAccount</title>
	</head>
	
	<body>
	<% try {
		// Get parameters from LoginPortal.jsp.
		String accountID = request.getParameter("username");
		String accountPW = request.getParameter("password");
		String accountType = request.getParameter("usertype");
	    if (accountType == null) { // Handle null case with default value.
	    	accountType = "Customer";
	    }
		
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		//Create query.
		String query = "";
		if (accountType.equalsIgnoreCase("Customer")) {
			query = "SELECT * FROM " + accountType + " WHERE CID = ?";
		}
		else if (accountType.equalsIgnoreCase("Representative")) {
			query = "SELECT * FROM " + accountType + " WHERE RID = ?";
		}
		else {
			query = "SELECT * FROM " + accountType + " WHERE AID = ?";
		}
		
		// Create SQL statement.
		PreparedStatement preparedStatement = con.prepareStatement(query);
		preparedStatement = con.prepareStatement(query);
        preparedStatement.setString(1, accountID);

        // Execute the query.
        ResultSet resultSet = preparedStatement.executeQuery();
        
     	// Check if username exists.
        if (resultSet.next()) {
            // Username exists, check password.
            String storedPassword = resultSet.getString("Password");
            if (accountPW.equals(storedPassword)) {
            	// Load next session.
            	session.setAttribute("user", accountID);
            	if (accountType.equalsIgnoreCase("Customer")) {
            		// Redirect to next session.
            		response.sendRedirect("CustomerPortal.jsp");
        		}
        		else if (accountType.equalsIgnoreCase("Representative")) {
        			response.sendRedirect("RepresentativePortal.jsp");
        		}
        		else {
        			response.sendRedirect("AdminPortal.jsp");
        		}
            }
            else {
                out.println("<p>Password incorrect for " + accountType + " " + accountID + ".</p>");
            }
        }
        else {
            out.println("<p>Username does not exist for " + accountType + ".</p>");
        }
     	
     	// Close the connection.
        con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("<p>Login failed.</p>");
	}
	%>
	</body>
</html>