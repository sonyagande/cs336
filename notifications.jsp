<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Notifications</title>
</head>
<body>
	<%
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Holds the username for person getting the alert
		String username = (String)session.getAttribute("user");
		
		//pull user from buyer
		ResultSet rlt;
		rlt = stmt.executeQuery("SELECT username FROM accounts WHERE username='" + username + "'");
							
		//Will hold the query result
		String testUsername = "";
				
		//Assigns the result to a variable
		while(rlt.next()){
			testUsername = rlt.getString("username");
			
		}
		
		//Checks to make sure the current user is in the buyer table
		if(testUsername == null || testUsername == ""){
			out.println("There are no alerts. Return to your Account</a>");
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			return;
		}
		
		//This query finds the username and AID for every max bid of auctions that haven't closed out
		ResultSet hit = stmt.executeQuery("SELECT DISTINCT Username, auctionID"
									+	  " FROM bid,"
									+     " (SELECT auctionID AS accountId, MAX(price) AS price" 
									+     " FROM bids GROUP BY accountID) AS maxTable,"
									+	  " (SELECT auctionID AS accountID"
									+	  " FROM AuctionItem WHERE closingTime > current_time()) AS auctionTable,"
									+ 	  " (SELECT accountID AS accountID FROM bids WHERE Username ='" + username + "'" + " ) AS userTable"
									+	  " WHERE maxTable.price = price AND accountID = maxTable.accountID AND auctionTable.accountID = maxTable.accountID AND auctionTable.accountID = accountID AND accountID = userTable.accountID AND maxTable.accoutID = userTable.accountID AND auctionTable.accountID = userTable.accountID");
		
		//If a user doesn't have an alert this will be used as a flag
		boolean alertFlag = false;
				
		//Finds all the bids where the current user doesn't have a max bid and sends alerts for each auction the person was outbidded on
		while(hit.next()){
			String currentUsername = hit.getString("Username");
			int currentAID = hit.getInt("auctionID");
			
			if(!username.equals(username)){
				out.println("You were out bid in auction " +username);
				alertFlag = true;
				%>
				<br><%
			}
		}	
		
		if(alertFlag == false){
			out.println("You have no alerts");
			
		}
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("alert failed");
	} 	
%>


<br>
<br>
<a href="main.jsp">Back to main page</a>
</body>
</html>
