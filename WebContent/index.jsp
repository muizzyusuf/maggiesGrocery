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

<title>FOOD4ALL Main Page</title>
</head>
<body>

	<header>
		<nav style="background-color: #e7e7e7" class="navbar navbar-default">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" href="#"><img src="img/logo.png"
						height="80px" width="100px"> -Let Us Serve You</a>
				</div>
				<div class="dropdown mr-5">
					<button class="btn btn-secondary dropdown-toggle" type="button"
						data-toggle="dropdown">
						MENU <span class="caret"></span>
					</button>
					<ul class="dropdown-menu text-center">
						<li class="active"><a href="index.jsp">Home</a></li>
						<li><a href="listprod.jsp">Begin Shopping</a></li>
						<li><a href="listorder.jsp">List All Orders</a></li>
						<li><a href="admin.jsp">Administrators</a></li>
						<li><a href="customer.jsp">Customer Info</a></li>
						<div class="dropdown-divider"></div>
						<li><a href="login.jsp">Log in</a></li>
						<li><a href="signUp.jsp">Sign up</a></li>
						<li><a href="logout.jsp">Log Out</a></li>
						<li>
							<%
								// TODO: Display user name that is logged in (or nothing if not logged in)	
								if (session == null || session.getAttribute("authenticatedUser") == null) {
									// user is not logged in, do something about it
								} else {
									out.println(
											"<div><p class=\"lead\" ><img class=\"img-rounded\" style=\"width:20px;height:20px;\" src=\"img/login_user.png\"> : "
													+ session.getAttribute("authenticatedUser") + "</p></div>");
								}
							%>
						</li>
					</ul>
				</div>
			</div>
		</nav>
	</header>

	<div class="container text-center mt-3">
		<div class="jumbotron">
			<div class="page-header">
				<h1>About us</h1>
			</div>
			<hr>
			<p class="lead">"Our company was first founded in 2010 by
				Margreta Gomwalk and her husband Muizz Yusuf. They realized the
				urgent need of a 24-hour quick stop store that will be not only
				convenient but also provide the fundamental needs of any household.
				After they opened the first small store in their neighbourhood, it
				quickly took off. Many neighbours found that it saved their time and
				energy without breaking the bank. With the huge success garnered,
				the Yusuf's decided to open a similar style shop in the west side of
				Kelowna. After that one's success, the company has gone on to open
				several branches across B.C. Our website is designed to provide an
				even more convenient shopping experience to people with a busy
				lifestyle. With multiple items needed by over 80% of Canadian
				families, we are confident that we will provide the service you
				need. Why drive to the store when we can deliver to you? "</p>
		</div>

	</div>

	<footer
		style="background-color: #e7e7e7; position: absolute; width: 100%">
		<div class="footer-copyright text-center py-3">© 2019 Copyright:
			Maggie's Grocery Store</div>


	</footer>


</body>