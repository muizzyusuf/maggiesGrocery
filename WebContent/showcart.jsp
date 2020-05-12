<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Your Shopping Cart</title>
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
	<%@ page import="java.text.NumberFormat"%>
	<%@ include file="jdbc.jsp"%>
	<%@ include file="header.jsp" %>
	<%
		getConnection();
		// Get the current list of products
		@SuppressWarnings({ "unchecked" })
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
				.getAttribute("productList");

		if (productList == null) {
			out.println("<H1>Your shopping cart is empty!</H1>");
			productList = new HashMap<String, ArrayList<Object>>();
		} else {
			NumberFormat currFormat = NumberFormat.getCurrencyInstance();

			double total = 0;
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext()) {
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				if (product.size() < 4) {
					out.println("Expected product with four entries. Got: " + product);
					continue;
				}

				int id = Integer.parseInt(product.get(0).toString());
				String name = product.get(1).toString();
				double price = Double.parseDouble(product.get(2).toString());
				int itemqty = Integer.parseInt(product.get(3).toString());

				

				try {
					Statement stmt = con.createStatement();
					ResultSet rst = stmt.executeQuery("select productId from incart where productId = " + id);
					String deleteId = request.getParameter("deleteId");
					String updatedQty = request.getParameter("quantity");
					String updatedId = request.getParameter("id");
					
					if (deleteId != null) {

						if (productList.containsKey(updatedId)) {
							product = (ArrayList<Object>) productList.get(updatedId);
							product.set(3, Integer.parseInt(updatedQty));
						}
						Statement stmt4 = con.createStatement();
						stmt4.executeUpdate("DELETE FROM incart WHERE productId="+deleteId);
						
					}else if (updatedQty != null) {

						if (productList.containsKey(updatedId)) {
							product = (ArrayList<Object>) productList.get(updatedId);
							product.set(3, Integer.parseInt(updatedQty));
						}
						Statement stmt4 = con.createStatement();
						stmt4.executeUpdate("UPDATE incart SET quantity = " + updatedQty + " WHERE productId = " + updatedId);
						
					}else{
						if (rst.next() == false) {
							Statement stmt1 = con.createStatement();
							stmt1.executeUpdate("INSERT INTO incart (productId, productName, price, quantity) VALUES ("
									+ id + ", '" + name + "', " + price + ", " + itemqty + " )");
						} else {
							Statement stmt2 = con.createStatement();
							stmt2.executeUpdate("UPDATE incart SET quantity = " + itemqty + " WHERE productId = " + id);
						}
					}

				} catch (SQLException e) {
					out.println(e);
				}

				double pr = 0;
				int qty = 0;

				try {
					pr = price;
				} catch (Exception e) {
					out.println("Invalid price for product: " + product.get(0) + " price: " + price);
				}
				try {
					qty = itemqty;
				} catch (Exception e) {
					out.println("Invalid quantity for product: " + product.get(0) + " quantity: " + qty);
				}

				//	out.print("<td>" + currFormat.format(pr) + "</td>");
				//	out.print("<td>" + currFormat.format(pr * qty) + "</td></tr>");
				//	out.println("</tr>");
				//total = total + pr * qty;
			}

			out.println("<h1 class =\"jumbotron display-3\">Your Shopping Cart</h1>");
			out.print(
					"<div class=\"container mt-5\"><table class=\"table\"><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
			out.println("<th>Price</th><th>Subtotal</th></tr>");

			try {
				Statement stmt9 = con.createStatement();
				ResultSet rst9 = stmt9.executeQuery(
						"SELECT productId, productName, quantity, price, (quantity*price) FROM incart");
				while (rst9.next()) {
					out.println("<tr class=\"text-center\"><td >" + rst9.getInt(1) + "</td><td>" + rst9.getString(2)
							+ "</td><td class=\"row\"><a class=\"col btn btn-secondary btn-sm\" href=\"showcart.jsp?id="
							+ rst9.getInt(1) + "&quantity=" + (rst9.getInt(3) - 1) +"\">-</a>"
							+ "<p class=\"col\">"+rst9.getInt(3)+"</p>"
							+ "<a class=\"col btn btn-secondary btn-sm\" href=\"showcart.jsp?id=" + rst9.getInt(1)
							+ "&quantity=" + (rst9.getInt(3) + 1) + "\">+</a></td>" + "<td>"
							+ currFormat.format(rst9.getFloat(4)) + "</td><td class=\"row\" ><p class=\"col\">"
							+ currFormat.format(rst9.getFloat(5)) + "</p> <a class=\"col btn btn-danger btn-sm ml-5\" href=\"showcart.jsp?deleteId=" + rst9.getInt(1)+"\">x</a></td></tr>");
				
						
				}
				
				
			} catch (SQLException e) {
				out.println(e);
			}
			
			
			Statement stmt19 = con.createStatement();
			ResultSet rst19 = stmt19.executeQuery("SELECT productId, sum(quantity*price) FROM incart GROUP BY productId");
			while (rst19.next()){
				total += rst19.getFloat(2);
			}

			out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>" + "<td align=\"right\">"
					+ currFormat.format(total) + "</td></tr>");
			out.println("</table></div>");

			out.println("<h2><a class=\"btn btn-primary\" href=\"checkout.jsp\">Check Out</a></h2>");

			closeConnection();
		}
	%>



	<h2>
		<a class="btn btn-primary" href="listprod.jsp">Continue Shopping</a>
	</h2>
	<%@ include file="footer.jsp" %>
</body>
</html>

