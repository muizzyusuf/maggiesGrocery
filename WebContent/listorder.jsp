<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>FOOD4ALL Grocery Order List</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
	integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>
</head>
<body>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<h1 class="display-3 text-center">Order List</h1>

<%
//Note: Forces loading of SQL Server driver

// Useful code for formatting currency values:
 NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
	
try{
	getConnection();
	String sql = "SELECT orderId, O.CustomerId, totalAmount, firstName+' '+lastName, orderDate FROM OrderSummary O, Customer C WHERE "
			+ "O.customerId = C.customerId";
	Statement stmt = con.createStatement();
	ResultSet rst = stmt.executeQuery(sql);		
	out.print("<table class=\"table\"><tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
	
	// Use a PreparedStatement as will execute many times
	sql = "SELECT productId, quantity, price FROM OrderProduct WHERE orderId=?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	while (rst.next())
	{	int orderId = rst.getInt(1);
		out.print("<tr><td>"+orderId+"</td>");
		out.print("<td>"+rst.getString(5)+"</td>");
		out.print("<td>"+rst.getInt(2)+"</td>");		
		out.print("<td>"+rst.getString(4)+"</td>");
		out.print("<td>"+currFormat.format(rst.getDouble(3))+"</td>");
		out.println("</tr>");

		// Retrieve all the items for an order
		pstmt.setInt(1, orderId);				
		ResultSet rst2 = pstmt.executeQuery();
		
		out.println("<tr align=\"right\"><td colspan=\"4\"><table class=\"table table-secondary\">");
		out.println("<th>Product Id</th> <th>Quantity</th> <th>Price</th></tr>");
		while (rst2.next())
		{
			out.print("<tr><td>"+rst2.getInt(1)+"</td>");
			out.print("<td>"+rst2.getInt(2)+"</td>");
			out.println("<td>"+currFormat.format(rst2.getDouble(3))+"</td></tr>");
		}
		out.println("</table></td></tr>");
	}
	out.println("</table>");
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
	closeConnection();
// Write query to retrieve all order summary records

// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection
%>
<%@ include file="footer.jsp" %>
</body>
</html>

