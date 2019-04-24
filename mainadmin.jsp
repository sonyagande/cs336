<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
</head>
<body>
<div class="topnav">
  <a class="active" href="main.jsp">Home</a>
  <a href="messages.jsp">Messages</a>
  <a href="faqredirect.jsp">FAQs</a>
  <a href="CreateAuction.jsp">Create Auction!</a>
  <a href="notifications.jsp">Notifications</a>
  <a href="salesreport.jsp">Sales Report</a>
  <a href="myaccount.jsp">My Account</a>
  <a href="index.jsp">Logout</a><br><br>
  <form method="post" action="mainbackend.jsp">
  <input type="text" placeholder="Search all items..." name="search">
  <input type="submit" value="Submit">
  </form><br><br>
	
Sort by..
  <form method="post" action="sortbackend.jsp">
    <!-- note the show.jsp will be invoked when the choice is made -->
	<!-- The next lines give HTML for radio buttons being displayed -->
  <input type="radio" name="sort" value="category"/>Category
  <br>
  <input type="radio" name="sort" value="rating"/>Rating
    <!-- when the radio for bars is chosen, then 'command' will have value 
     | 'bars', in the show.jsp file, when you access request.parameters -->
  <br>
  <input type="submit" value="submit" /><br><br>
  </form><br><br>
 View all auctions a specific user participated in..
<form method="post" action="viewbyuser.jsp">
  <input type="text" placeholder="Type in a User ID" name="userid">
  <input type="submit" value="Submit">
  </form><br><br> 
  
  View history of bids for a specific auction..
<form method="post" action="bidhistory.jsp">
  <input type="text" placeholder="Type in an Auction ID" name="auctionid">
  <input type="submit" value="Submit">
  </form>
 <br><br> 
 <form method="post" action="createbid.jsp">
	<table>
	<tr>    
	<td>ItemID:</td><td><input type="number" name="itemID"></td>
	</tr>
	<input type="submit" value="Submit">
	</form>

  <%
  
  //next thing to do is sort by column name
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();

			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM item";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			String str2 = "SELECT* FROM auction";
			ResultSet result2 = stmt2.executeQuery(str2);
			result2.next(); 
			
			
			
			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Item ID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Item Name");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("Category");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("Description");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("Rating");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("Status");
			out.print("</td>");
			out.print("</tr>");
			

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
				//Print out current bar/beer additional info: Manf or Address
			    out.print(result.getString("itemName"));
				out.print("</td>");
				out.print("<td>");
				//Print out current bar/beer additional info: Manf or Address
			    out.print(result.getString("category"));
				out.print("</td>");
				out.print("<td>");
				//Print out current bar/beer additional info: Manf or Address
			    out.print(result.getString("description"));
				out.print("</td>");
				out.print("<td>");
				//Print out current bar/beer additional info: Manf or Address
			    out.print(result.getString("rating"));
				out.print("</td>");
				
				
				if(result2.getInt("auctionID")!=result.getInt("itemID"))
				{
				   out.print("<td>");
					out.print("No Status");
					out.print("</td>");

				}
				else
				{
					out.print("<td>");
				    out.print(result2.getString("stat"));
				    result2.next();
					out.print("</td>");
					if(result2.getString("stat").equals("ON")){
						out.print("<td>");
						session.setAttribute("itemID",result.getInt("itemID"));
						%>
						<a href="createbid.jsp">Create Bid</a>
						<% 
						out.print("</td>");
						
					}
				}
				out.print("</tr>");

			}
			out.print("</table>");

			
			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>
</div>
</body>
</html>
