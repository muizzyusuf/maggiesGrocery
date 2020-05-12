<%@ page import="java.sql.*,java.net.URLEncoder"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>FOOD4ALL Grocery</title>
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

	<div class="container mt-3 ml-auto">
		<form method="get" action="listprod.jsp">
			<div class="row">
				<div class="col-md-8 form-group">
					<input class="form-control" type="text" name="productName"
						size="50" placeholder="Search for the products you want to buy">
				</div>
				<div class="col-md-2 form-group">
					<select name="categoryId" class="form-control" onchange="this.form.submit()">
						<option value="0" selected>Category</option>
						<option value="1">Beverages</option>
						<option value="2">Condiments</option>
						<option value="3">Dairy Products</option>
						<option value="4">Produce</option>
						<option value="5">Meat/Poultry</option>
						<option value="6">Seafood</option>
						<option value="7">Confections</option>
						<option value="8">Grains/cereals</option>
					</select>
				</div>

				<div class="col-md-1 form-group">
					<input class="btn btn-success" type="submit" value="Submit">
				</div>
				<div class="col-md-1 form-group">
					<input class="btn btn-dark" type="reset" value="Reset">
				</div>
			</div>
		</form>

	</div>

	<%
		// Get product name to search for
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		String name = request.getParameter("productName");
		String categoryId = request.getParameter("categoryId");
		getConnection();

		try {
			ResultSet rst = null;

			if (name != null && !name.equals("")) {
				String realName = "'%" + name + "%'";
				Statement stmt = con.createStatement();
				//pstmt.setString(1, realName);
				rst = stmt.executeQuery(
						"SELECT productId, productName, productPrice, productImageURL FROM Product WHERE ProductName LIKE "
								+ realName);
				out.println("<h1>Products that contains '" + name + "' </h1>");
				out.println("<table class=\"table\"><tr><th></th> <th>Product Name</th> <th>Price</th></tr>");

			} else if(categoryId == null){
				Statement stmt = con.createStatement();
				rst = stmt.executeQuery("SELECT productId,productName, productPrice, productImageURL FROM Product ");
				out.println("<h1>All Products</h1>");
				out.println("<table class=\"table\"><tr><th></th> <th>Product Name</th> <th>Price</th></tr>");
				
			}else if(categoryId != "0"){
				Statement stmt = con.createStatement();
				rst = stmt.executeQuery("SELECT productId,productName, productPrice, categoryId, productImageURL FROM Product WHERE categoryid ="+categoryId);
				out.println("<h1>All Products</h1>");
				out.println("<table class=\"table\"><tr><th></th> <th>Product Name</th> <th>Price</th></tr>");
			}

			while (rst.next()) {
				out.println("<tr><td><a href =\"addcart.jsp?id=" + rst.getInt("productId") + "&name="
						+ rst.getString("productname") + "&price=" + rst.getDouble("productprice")
						+ "\">Add to cart</a></td>" + "<td><figure class=\"figure\"><a href= \"product.jsp?id=" + rst.getInt("productId")
						+ "\"><img width=\"150px\" height=\"200px\" class=\"figure-img img-fluid rounded\" src=\""+rst.getString("productImageURL")+"\"><figcaption class=\"figure-caption text-center\">"+ rst.getString("productname").toUpperCase() + 
				          "</figcaption></a></figure></td> <td>"
						+ currFormat.format(rst.getFloat("productprice")) + "</td></tr>");

			}
			out.println("</table>");

		} catch (SQLException e) {
			out.print(e);
		}

		closeConnection();
		// Variable name now contains the search string the user entered
		// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

		// Make the connection

		// Print out the ResultSet

		// For each product create a link of the form
		// addcart.jsp?id=productId&name=productName&price=productPrice
		// Close connection

		// Useful code for formatting currency values:

		// out.println(currFormat.format(5.0);	// Prints $5.00
	
	 
	 
		%> 
	  <%@ include file="footer.jsp" %>
</body>
</html>