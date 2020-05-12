<header class="mb-5">
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
						<li><a href="login.jsp">Login</a></li>
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