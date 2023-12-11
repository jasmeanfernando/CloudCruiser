<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
			<title>RegistrationPortal</title>
	</head>
	
	<body>
	<h1>* Registration Portal *</h1>
	
	<p>New passenger or representative? Register an account with CloudCruiser!</p>
	
	<!-- Get user input to register an account. -->
	<form method="get" action="registerAccount.jsp">
		<table>
			<tr>
			<td>First Name: </td><td><input type="text" name="first_name"></td></tr>
			<tr>
			<td>Last Name: </td><td><input type="text" name="last_name"></td></tr>
			<tr>
			<td>Email: </td><td><input type="text" name="username"></td></tr>
			<tr>
			<td>Password: </td><td><input type="password" name="password"></td></tr>
		</table>
		
		<input type="radio" name="usertype" value="Customer"> Passenger
       	<input type="radio" name="usertype" value="Representative"> Representative
			
		<br><br>
		<input type="submit" value="Submit">
	</form>
	</body>
</html>