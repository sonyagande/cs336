<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>FAQ's</title>
<form method="post" action="faqsbackendcr.jsp">
	<table>
	<tr>    
	<td>QuestionID of the question you want to answer:</td><td><input type="number" name="questionID"></td>
	</tr>
	<tr>    
	<!--<td>Question you want to answer:</td><td><input type="text" name="question"></td>
	</tr>-->
	<td>Answer of the question:</td><td><input type="text" name="answer"></td>
	</tr>
	</table>
	<input type="submit" value="Submit">
	</form>
	<%

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
	
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM faqs WHERE answer IS NULL";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("questionID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("question");
			out.print("</td>");
			out.print("<td>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current bar or beer name:
				out.print(result.getInt("questionID"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("question"));
				out.print("</td>");
				out.print("<td>");
			}
			out.print("</table>");

			
			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>
	
</head>
<body>

</body>
</html>
