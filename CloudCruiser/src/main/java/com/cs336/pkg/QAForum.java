package com.cs336.pkg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class QAForum
{
	/**
	 * Empty Constructor.
	 */
	public QAForum() {
	}
	
	/**
	 * Method that adds a question to Question table.
	 * @param passengerEmail
	 * @param passengerQuestion
	 * @return resultset
	 * @throws SQLException
	 */
	public void addQuestion(String passengerEmail, String passengerQuestion) throws SQLException {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
		String query = "INSERT INTO Questions (CustomerID, QuestionText) VALUES (?, ?)";
		
		// Create SQL statement.
		PreparedStatement prepstmt = con.prepareStatement(query);
		prepstmt.setString(1, passengerEmail);
		prepstmt.setString(2, passengerQuestion);
		
		// Execute query.
		int resultset = prepstmt.executeUpdate();
	}
	
	/**
	 * Method that adds an answer to Answer table.
	 * @param representativeEmail
	 * @param customerEmail
	 * @param questionId
	 * @param answerResponse
	 * @throws SQLException
	 */
	public void addAnswer(String representativeEmail, String customerEmail, String questionId, String answerResponse) throws SQLException {
		// Get database connection.
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create query.
		String query = "INSERT INTO Answers (AnswerID, CustomerID, RepresentativeID, AnswerText) VALUES (?, ?, ?, ?)";
		
		// Create SQL statement.
		PreparedStatement prepstmt = con.prepareStatement(query);
		prepstmt.setInt(1, Integer.parseInt(questionId));
		prepstmt.setString(2, customerEmail);
		prepstmt.setString(3, representativeEmail);
		prepstmt.setString(4, answerResponse);
		
		// Execute query.
		int resultset = prepstmt.executeUpdate();
	}
}
