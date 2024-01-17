package com.cs336.pkg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class User
{
	/**
	 * Empty Constructor.
	 */
	public User() {
	}
	
	/**
	 * Method that returns information about user.
	 * @param accountType
	 * @param accountEmail
	 * @param accountAttribute
	 * @return information
	 * @throws SQLException
	 */
	public String getUserInformation(String accountType, String accountEmail, String accountAttribute) throws SQLException {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		String table;
		String column;
		if (accountType.equalsIgnoreCase("Passenger")) {
			table = "Customer";
			column = "CID";
		}
		else if (accountType.equalsIgnoreCase("Representative")) {
			table = "Representative";
			column = "RID";
		}
		else {
			table = "Admin";
			column = "AID";
		}
		
		// Create query.
		String query = "SELECT " + accountAttribute + " FROM " + table + " WHERE " + column + " = ?";
		
		// Create SQL statement.
		PreparedStatement prepstmt = con.prepareStatement(query);
		prepstmt.setString(1, accountEmail);
		
		// Execute query.
		ResultSet resultset = prepstmt.executeQuery();
		
		// If resultset.next() results in a table...
		// There exists such email in the database.
		if (resultset.next()) {
			// Obtain the value in the specified column.
			String information = resultset.getString(accountAttribute);
			return information;
		}
		
		return null;
	}
	
	/**
	 * Method that adds a user.
	 * @param accountType
	 * @param firstName
	 * @param lastName
	 * @param email
	 * @param password
	 * @throws SQLException
	 */
	public void addUser(String accountType, String firstName, String lastName, String email, String password) throws SQLException {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
		String query = "";
		if (accountType.equalsIgnoreCase("Customer")) {
			query = "INSERT INTO Customer (CID, Password, FirstName, LastName) VALUES (?, ?, ?, ?)";
		}
		else {
			query = "INSERT INTO Representative (RID, Password, FirstName, LastName) VALUES (?, ?, ?, ?)";
		}
		
		// Create SQL statement.
		PreparedStatement prepstmt = con.prepareStatement(query);
		prepstmt.setString(1, email);
		prepstmt.setString(2, password);
		prepstmt.setString(3, firstName);
		prepstmt.setString(4, lastName);
		
		// Execute query.
		int resultset = prepstmt.executeUpdate();
	}
	
	/**
	 * Method that removes a user.
	 * @param accountType
	 * @param firstName
	 * @param lastName
	 * @param email
	 * @param password
	 * @throws SQLException
	 */
	public int removeUser(String accountType, String firstName, String lastName, String email, String password) throws SQLException {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
		String query = "";
		if (accountType.equalsIgnoreCase("Customer")) {
			query = "DELETE FROM Customer WHERE CID = ? AND Password = ? AND FirstName = ? AND LastName = ?";
		}
		else {
			query = "DELETE FROM Representative WHERE RID = ? AND Password = ? AND FirstName = ? AND LastName = ?";
		}
		
		// Create SQL statement.
		PreparedStatement prepstmt = con.prepareStatement(query);
		prepstmt.setString(1, email);
		prepstmt.setString(2, password);
		prepstmt.setString(3, firstName);
		prepstmt.setString(4, lastName);
		
		// Execute query.
		int resultset = prepstmt.executeUpdate();
		
		// Return number of rows affected.
		return resultset;
	}
}