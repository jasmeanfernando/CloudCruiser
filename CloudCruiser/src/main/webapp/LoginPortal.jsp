<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
			<title>LoginPortal</title>
	</head>
	
	<body>
	<h1>* Login Portal *</h1>
	
	<p>Returning user? Log into your account with CloudCruiser!</p>
	
	<!-- Get user input to log into an account. -->
	<form method="post" action="loginAccount.jsp">
		<table>
			<tr>
			<td>Email: </td><td><input type="text" name="username"></td></tr>
        	<tr>
			<td>Password: </td><td><input type="password" name="password"></td></tr>
        </table>
		
		<input type="radio" name="usertype" value="Customer"> Passenger
       	<input type="radio" name="usertype" value="Representative"> Representative
       	<input type="radio" name="usertype" value="Admin"> Admin
        
        <br><br>
        <input type="submit" value="Login">
    </form>
    </body>
</html>