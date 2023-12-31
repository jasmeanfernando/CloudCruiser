<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>CloudCruiser</title>
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
		
		<div class="text-center mb-4">
		<img src="/CloudCruiser/resources/assets/cover1.jpg" alt="Home Cover"
		class="img-fluid rounded" style="max-width: 100%;">
		</div>
		
		<p class="cc_paragraph">Imagine a world where booking flights is as easy as catching a cloud.
        With CloudCruiser, your travel dreams take flight effortlessly, and the only turbulence is deciding
        which amazing destination to choose! Say goodbye to the hassle, and hello to a sky full of possibilities.
        Fasten your seatbelt, and let the adventure unfold with CloudCruiser!</p>
        
        <div class="row justify-content-center">
        	<div class="col-md-6 text-center">
                <a class="cc_button" href="PortalRegister.jsp">Sign Up</a>
            </div>
            <div class="col-md-6 text-center">
                <a class="cc_button" href="PortalLogin.jsp">Log In</a>
            </div>
        </div>
        
    	</div>
    
    <!-- Bootstrap JS and Popper.js -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<!-- Bootstrap JavaScript -->
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	</body>
</html>