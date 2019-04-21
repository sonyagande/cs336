<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import= "javax.servlet.http.HttpServletRequest"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		List<String> list = new ArrayList<String>();

		try {
			
			//Create a connection string
			String url = "jdbc:mysql://cs336db.cvr5ehxrgnip.us-east-2.rds.amazonaws.com:3306";

			Class.forName("com.mysql.jdbc.Driver");

			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "cs336db","yahoo.com1");

			//Get the database connection
			//ApplicationDB db = new ApplicationDB();	
			//Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String username = request.getParameter("username");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM accounts WHERE username = " + username;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			if(result == null){
				System.out.println("An account does not exist with this username. Please sign up.");
			}
			
			System.out.println(username);
			
			String password = request.getParameter("password");
			
			String str2 = "Select * FROM accounts WHERE password = " + password;
			
			ResultSet result2 = stmt.executeQuery(str2);
			
			if(result2 == null){
				System.out.println("Your password is incorrect.");
			}
			else{
				System.out.println("Gets to else statement");
				response.sendRedirect("main.jsp");
	}


			//close the connection.
			con.close();
			response.sendRedirect("main.jsp");

		} catch (Exception e) {
		}
	%>

</body>
</html>
