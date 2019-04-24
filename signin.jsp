<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign In</title>
</head>
<body>
	<%
		//List<String> list = new ArrayList<String>();

		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM accounts WHERE username='" + username +"' AND pass='"+ password +"'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			if(result.next() == false){	
				response.sendRedirect("loginfailed.jsp");
			}
			else{
				if(result.getString("isCustomerRep").equals("1")){
					session.setAttribute("isCustRep", "1");
				}
				else{
					session.setAttribute("isCustRep", "0");
				}
				if(result.getString("isAdmin").equals("T")){
					session.setAttribute("isAdmin", "T");
				}
				else{
					session.setAttribute("isAdmin", "0");
				}
				int accountID = result.getInt("accountID");
				session.setAttribute("accountID",accountID);
				response.sendRedirect("mainredirect.jsp");
			}
			
			
			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>

</body>
</html>
