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
		<title>LoginPortal</title>
		<!-- Google Fonts -->
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Pacifico|Poppins">
		<!-- CloudCruiser CSS -->
		<link rel="stylesheet" href="/CloudCruiser/resources/css/cloudcruiser.css">
		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	</head>
	
	<body>
		<div class="container mt-5">
		
		<div class="text-center mb-4">
		<img src="/CloudCruiser/resources/assets/logo.jpg" alt="Logo"
		class="img-fluid rounded" style="max-width: 100%;">
		</div>
		
		<p class="cc_paragraph text-center">Log into your account.</p>
		
		<form action="AccountLogin.jsp" method="post">
			<div class="cc_form">
				<label for="username">Email:</label>
				<input type="text" class="form-control" name="email" id="email" required>
			</div>
			
			<div class="cc_form">
				<label for="password">Password:</label>
				<input type="password" class="form-control" name="password" id="password" required>
			</div>
			
			<div class="cc_form">
				<label for="accountType">Account Type:</label>
				<select class="form-control" name="accountType">
					<option value="Passenger">Passenger</option>
					<option value="Representative">Representative</option>
					<option value="Admin">Admin</option>
				</select>
			</div>
			
			<button class="cc_button" type="submit">Log In</button>
		</form>
		
		</div>
	
    <!-- Bootstrap JS and Popper.js -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <!-- Bootstrap JavaScript -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	</body>
</html>