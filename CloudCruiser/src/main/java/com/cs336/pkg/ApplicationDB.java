package com.cs336.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ApplicationDB
{
	public ApplicationDB() {
	}

	public Connection getConnection() {
		//Create a connection string to local database.
		String connectionUrl = "jdbc:mysql://localhost:3306/cloudcruiserdatabase?useSSL=false";
		Connection connection = null;
		
		try {
			//Load JDBC driver--The interface standardizing the connection procedure.
			//Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		try {
			//Create a connection to local database with appropriate username and password.
			connection = DriverManager.getConnection(connectionUrl,"root", "MYSQL#data14");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return connection;
	}
	
	public void closeConnection(Connection connection) {
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		ApplicationDB dao = new ApplicationDB();
		Connection connection = dao.getConnection();
		
		System.out.println(connection);
		dao.closeConnection(connection);
	}
}