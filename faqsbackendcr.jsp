<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>FAQ Backend for Customer Rep</title>
</head>
<body>
	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			int questionID = Integer.parseInt(request.getParameter("questionID"));
			String answer = request.getParameter("answer");
			//String question = request.getParameter("question");
			
			String str = "UPDATE faqs SET answer='"+answer+"' WHERE questionID="+questionID;
			//Run the query against the database.
			//ResultSet result = stmt.executeQuery(str);
			
			PreparedStatement ps = con.prepareStatement(str);
			//ps.setInt(1, questionID);
			//ps.setString(2, question);
			//ps.setString(3, answer);
			ps.executeUpdate();
			System.out.println(str);
			
			//Make an HTML table to show the results in:
			/*
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
			out.print("answer");
			out.print("</td>");
			out.print("</tr>");
			*/
		
			
			response.sendRedirect("faqscustomerrep.jsp");
			//close the connection.
			con.close();

		} catch (Exception e) {
			out.print(e);
			out.print("Update failed");
		}
	%>

</body>
</html>
