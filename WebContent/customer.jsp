<!DOCTYPE html>
<html>
<head>
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
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>
<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
getConnection();
// TODO: Print Customer information
String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid "
			+"FROM customer WHERE userid=?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setString(1,userName);
ResultSet rst = pstmt.executeQuery();
out.println("<h1 class=\"display-3 center-text\">Customer Profile</h1>");
out.println("<table class =\" jumbotron container mt-5 ml-auto\">");
String first = "";
while(rst.next()){
	first += rst.getString("firstname");
	out.println("<tr><th>Id</th><td class=\"lead\">"+rst.getString("customerid")+"</td></tr>");
	out.println("<tr><th>First Name</th><td class=\"lead\">"+rst.getString("firstname")+"</td></tr>");
	out.println("<tr><th>Last Name</th><td class=\"lead\">"+rst.getString("lastname")+"</td></tr>");
	out.println("<tr><th>Email</th><td class=\"lead\">"+rst.getString("email")+"</td></tr>");
	out.println("<tr><th>Phone</th><td class=\"lead\">"+rst.getString("phonenum")+"</td></tr>");
	out.println("<tr><th>Address</th><td class=\"lead\">"+rst.getString("address")+"</td></tr>");
	out.println("<tr><th>City</th><td class=\"lead\">"+rst.getString("city")+"</td></tr>");
	out.println("<tr><th>State</th><td class=\"lead\">"+rst.getString("state")+"</td></tr>");
	out.println("<tr><th>Postal Code</th><td class=\"lead\">"+rst.getString("postalcode")+"</td></tr>");
	out.println("<tr><th>Country</th><td class=\"lead\">"+rst.getString("country")+"</td></tr>");
	out.println("<tr><th>User ID</th><td class=\"lead\">"+rst.getString("userid")+"</td></tr>");
}
// Make sure to close connection

closeConnection();
%>

<%
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
//out.println(currFormat.format(5.0);  // Prints $5.00

//Make connection

try{
	getConnection();
	String sql2 = "SELECT orderId, O.CustomerId, totalAmount, firstName+' '+lastName, orderDate FROM OrderSummary O, Customer C WHERE "
			+ "O.customerId = C.customerId AND userid= '"+userName+"'";
	Statement stmt2 = con.createStatement();
	ResultSet rst2 = stmt2.executeQuery(sql2);		
	out.print("<table class=\"table\"><tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
	
	// Use a PreparedStatement as will execute many times
	String sql3 = "SELECT productId, quantity, price FROM OrderProduct WHERE orderId=?";
	PreparedStatement pstmt3 = con.prepareStatement(sql3);
	
	while (rst2.next())
	{	int orderId = rst2.getInt(1);
		out.print("<tr><td>"+orderId+"</td>");
		out.print("<td>"+rst2.getString(5)+"</td>");
		out.print("<td>"+rst2.getInt(2)+"</td>");		
		out.print("<td>"+rst2.getString(4)+"</td>");
		out.print("<td>"+currFormat.format(rst2.getDouble(3))+"</td>");
		out.println("</tr>");

		// Retrieve all the items for an order
		pstmt3.setInt(1, orderId);				
		ResultSet rst3 = pstmt3.executeQuery();
		
		out.println("<tr align=\"right\"><td colspan=\"4\"><table class=\"table table-secondary\">");
		out.println("<th>Product Id</th> <th>Quantity</th> <th>Price</th></tr>");
		while (rst3.next())
		{
			out.print("<tr><td>"+rst3.getInt(1)+"</td>");
			out.print("<td>"+rst3.getInt(2)+"</td>");
			out.println("<td>"+currFormat.format(rst3.getDouble(3))+"</td></tr>");
		}
		out.println("</table></td></tr>");
	}
	out.println("</table>");
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
	closeConnection();
%>
<%@ include file="footer.jsp" %>

</body>
</html>

