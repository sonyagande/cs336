<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales Report</title>
	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str1 = "SELECT SUM(winningBid) AS sum FROM auctions";
			//Run the query against the database.
			ResultSet result1 = stmt.executeQuery(str1);
			result1.next();
			int total=result1.getInt("sum");
			
			out.print("<table>");
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Total Sales");
			out.print("</td>");
			out.print("</tr>");
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//Print out current bar or beer name:
			out.print(total);
			out.print("</td>");
			out.print("</tr>");
			out.print("</table>");
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM auctions WHERE winningBid IS NOT NULL";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			//Make an HTML table to show the results in:
			out.print("<table>");
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("itemID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("itemName");
			out.print("</td>");
			out.print("<td>");
			out.print("winningBid");
			out.print("</td>");
			out.print("<td>");
			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current bar or beer name:
				out.print(result.getInt("itemID"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("itemName"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("winningBid"));
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
