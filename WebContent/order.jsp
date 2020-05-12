<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Calendar" %>


<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>FOOD4ALL Grocery Order Processing</title>
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

<%
// Get customer id
String custId = request.getParameter("usr");
// Get password
String password = request.getParameter("pwd");
// Get shopping cart
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
                
try 
{	
	if (custId == null || custId.equals(""))
		out.println("<h1>Invalid customer id.  Go back to the previous page and try again.</h1>");
	else if (productList == null)
		out.println("<h1>Your shopping cart is empty!</h1>");
	else
	{	
		// Check if customer id is a number
		int num=-1;
		try
		{
			num = Integer.parseInt(custId);
		} 
		catch(Exception e)
		{
			out.println("<h1>Invalid customer id.  Go back to the previous page and try again.</h1>");
			return;
		}		
        
		// Get database connection
        getConnection();
	                		
        String sql = "SELECT customerId, firstName+' '+lastName, password FROM customer WHERE customerId = ?";	
				      
   		getConnection();
   		PreparedStatement pstmt = con.prepareStatement(sql);
   		pstmt.setInt(1, num);
   		ResultSet rst = pstmt.executeQuery();
   		int orderId=0;
   		String custName = "";

   		if (!rst.next())
   		{
   			out.println("<h1>Invalid customer id.  Go back to the previous page and try again.</h1>");
   		}
   		else
   		{	
   			custName = rst.getString(2);
			String dbpassword = rst.getString(3);
				    		
			// make sure the password on the database is the same as the one the user entered
			if (!dbpassword.equals(password)) 
			{
				out.println("The password you entered was not correct.  Please go back and try again.<br>"); 
				return;
			}
		
   			// Enter order information into database
   			sql = "INSERT INTO OrderSummary (customerId, totalAmount, orderDate) VALUES(?, 0, ?);";

   			// Retrieve auto-generated key for orderId
   			pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
   			pstmt.setInt(1, num);
   			pstmt.setTimestamp(2, new java.sql.Timestamp(new Date().getTime()));
   			pstmt.executeUpdate();
   			ResultSet keys = pstmt.getGeneratedKeys();
   			keys.next();
   			orderId = keys.getInt(1);

   			out.println("<h1>Your Order Summary</h1>");
         	  	out.println("<table class=\"table\"><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");

           	double total =0;
           	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
           	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
						
           	while (iterator.hasNext())
           	{ 
           		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
                   ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
   				String productId = (String) product.get(0);
                   out.print("<tr><td>"+productId+"</td>");
                   out.print("<td>"+product.get(1)+"</td>");
   				out.print("<td align=\"center\">"+product.get(3)+"</td>");
                   String price = (String) product.get(2);
                   double pr = Double.parseDouble(price);
                   int qty = ( (Integer)product.get(3)).intValue();
   				out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
                  	out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
                   out.println("</tr>");
                   total = total +pr*qty;

               	sql = "INSERT INTO OrderProduct (orderId, productId, quantity, price) VALUES(?, ?, ?, ?)";
   				pstmt = con.prepareStatement(sql);
   				pstmt.setInt(1, orderId);
   				pstmt.setInt(2, Integer.parseInt(productId));
   				pstmt.setInt(3, qty);
   				pstmt.setString(4, price);
   				pstmt.executeUpdate();				
           	}
           	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
                          	+"<td aling=\"right\">"+currFormat.format(total)+"</td></tr>");
           	out.println("</table>");

   			// Update order total
   			sql = "UPDATE OrderSummary SET totalAmount=? WHERE orderId=?";
   			pstmt = con.prepareStatement(sql);
   			pstmt.setDouble(1, total);
   			pstmt.setInt(2, orderId);			
   			pstmt.executeUpdate();						

   			out.println("<h1 class=\"lead\" >Order completed.  Will be shipped soon...</h1>");
   			out.println("<h1 class=\"lead\" >Your order reference number is: "+orderId+"</h1>");
   			out.println("<h1class=\"lead\" >Shipping to customer: "+custId+" Name: "+custName+"</h1>");   			
   			
   			// Clear session variables (cart)
   			session.setAttribute("productList", null);   
   			
   			Statement stmt2 = con.createStatement();
   			stmt2.executeUpdate("DELETE FROM incart");
   		}
   	}
}
catch (SQLException ex)
{ 	out.println(ex);
}
finally
{
	try
	{
		if (con != null)
			con.close();
	}
	catch (SQLException ex)
	{       out.println(ex);
	}
}  
%>                       				

<h2><a class="btn btn-secondary" href="index.jsp">Back to Main Page</a></h2>

</BODY>
</HTML>

