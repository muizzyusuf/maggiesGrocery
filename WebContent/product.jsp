<%@ page import="java.util.HashMap"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp"%>

<html>
<head>
<title>FOOD 4 ALL - Product Information</title>
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

	<%@ include file="header.jsp"%>
	<div class="container jumbotron col-md-7 mt-5 ml-auto text-center ">
		<%
			// Get product name to search for
			// TODO: Retrieve and display info for the product
			NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			String productId = request.getParameter("id");
			getConnection();
			String sql = "SELECT productname, productid, productprice, productDesc, productImageURL, productImage FROM product where productid = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, productId);
			ResultSet rst = pstmt.executeQuery();
			while (rst.next()) {
				out.println("<h3 class=\"display-3\">" + rst.getString("productname") + "</h3>");
				if (rst.getString("productImageURL") != null) {
					out.println(
							"<img width=\"200px\" height=\"250px\" src=\"" + rst.getString("productImageURL") + "\">");
				}
				if (rst.getString("productImage") != null) {
					out.println("<img width=\"200px\" height=\"250px\" src=\"displayImage.jsp?id=" + productId + "\">");
				}

				out.println("<h3 class=\"lead\" >ID: " + rst.getString("productid") + "</h3>");
				out.println("<h3 class=\"lead\" >Price: " + currFormat.format(rst.getFloat("productprice")) + "</h3>");
				out.println("<h3 class=\"lead\" >Description: " + rst.getString("productDesc") + "</h3>");

				out.println("<h3><a class=\"btn btn-primary\" href =\"addcart.jsp?id=" + rst.getInt("productId")
						+ "&name=" + rst.getString("productname") + "&price=" + rst.getDouble("productprice")
						+ "\">Add to cart</a></h3>");
				out.println("<h3><a class=\"btn btn-primary\" href=\"listprod.jsp\">Continue Shopping</a></h3>");

			}
			// TODO: If there is a productImageURL, display using IMG tag

			// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.

			// TODO: Add links to Add to Cart and Continue Shopping
			closeConnection();
		%>
	</div>

	<div class="container jumbotron col-md-5 mt-5 ml-auto">
		<h3 class="label text-center">Review this product:</h3>
		<form name="MyForm" method=post action="review.jsp"> 
			<div class="form-group">
				<label for="customerId">Customer ID:</label> <input type="text"
					name="customerId" maxlength=10 class="form-control">
			</div>
			<div class="form-group">
				<label for="productId">Product ID:</label> <input type="text"
					name="productId" maxlength=10 class="form-control">
			</div>
			<div class="form-group">
				<label for="reviewDate">Date:</label> <input type="date"
					name="reviewDate" placeholder="YYYY-MM-DD" class="form-control">
			</div>

			<div class="form-group">
				<label for="reviewRating">Rating:</label> <select
					name="reviewRating" class="form-control">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
				</select>
			</div>

			<div class="form-group">
				<label for="reviewComment">Comment:</label> <input type="text"
					maxlength=1000 name="reviewComment" class="form-control">
			</div>

			<div class="form-group">
				<input class="btn btn-success" type="submit" name="Submit2"
					value="Submit">
			</div>
		</form>
	</div>


	<div class="container col-md-5 mt-5 ml-auto">
		<%
			
				getConnection();
				String sql2 = "SELECT reviewRating, reviewDate, customerId, reviewComment FROM review WHERE productId ="+productId;
				Statement stmt2 = con.createStatement();
				ResultSet rst2 = stmt2.executeQuery(sql2);

				out.print("<h3 class=\"text-center label\">Reveiws</h3>");	
				while (rst2.next()) {

					out.println("<table class=\"table table-dark\">");
					out.println("<tr><th>Reviewed by: </th> <td>Customer " + rst2.getString(3) + "</td></tr>");
					out.println("<tr><th>Date: </th> <td>" + rst2.getString(2) + "</td></tr>");
					out.println("<tr><th>Rating out of 5: </th> <td>" + rst2.getString(1) + "</td></tr>");
					out.println("<tr><th>Comment: </th> <td>" + rst2.getString(4) + "</td></tr>");
					out.println("</table>");
				}
			
			closeConnection();
		%>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>

