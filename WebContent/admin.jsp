<%@ page import="java.text.NumberFormat" %>

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
<title>Administrator Page</title>
</head>
<body>

<%
// TODO: Include files auth.jsp and jdbc.jsp
%>
<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<%@ include file="header.jsp" %>

<%
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// TODO: Write SQL query that prints out total order amount by day
String sql = "SELECT orderdate, sum(totalamount) as total FROM ordersummary GROUP BY orderdate";
try 
{
	getConnection();
	// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.
	out.print("<p class=\"jumbotron display-4\"> Administrator Sales Report By Day</p>");
	
	Statement stmt = con.createStatement();
	ResultSet rst = stmt.executeQuery(sql);
	out.println("<div class=\"container mt-5\"><table class=\"table\"><tr><th>Order Date</th><th>Total Order Amount</th></tr>");	
	while(rst.next()) { 
		out.println("<tr><td>"+rst.getDate("orderdate")+"</td><td>"+currFormat.format(rst.getFloat("total"))+"</td></tr>");

		}
	
	out.println("</table></div>");

		
			
} 
catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}	




%>
<p class="jumbotron display-4"> All customers</p>

<% 
String sql2 = "SELECT customerId, firstName, lastName FROM customer";
try 
{
	getConnection();
	// TODO: Check if userId and password match some customer account. If so, set retStr to be the username
	Statement stmt2 = con.createStatement();
	ResultSet rst2 = stmt2.executeQuery(sql2);
	out.println("<div class=\"container mt-5\"><table class=\"table\"><tr><th>Customer ID</th><th>First Name</th><th>Last Name</th></tr>");	
	while(rst2.next()) { 
		out.println("<tr><td>"+rst2.getString(1)+"</td><td>"+rst2.getString(2)+"</td><td>"+rst2.getString(3)+"</td></tr>");

		}
	
	out.println("</table></div>");
			
} 
catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}	

%>
<%@ include file="footer.jsp" %>
</body>
</html>

