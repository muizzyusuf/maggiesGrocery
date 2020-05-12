<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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

<meta charset="ISO-8859-1">
<title>Sign Up</title>
</head>
<body>
	<%@ include file="header.jsp"%>
<div class="container jumbotron col-md-9 ml-auto">
			<h4 class="text-center">Sign Up</h4>
			<form name="Myotherform" method=post action="createUser.jsp">
				<div class="form-group row">
					<label class="col-md-3" for="firstName">First Name:</label> <input
						type="text" name="firstName" maxlength=40
						class="col-md-6 form-control">
				</div>
				<div class="form-group row">
					<label class="col-md-3" for="lastName">Last Name:</label> <input
						type="text" name="lastName" maxlength=40
						class="col-md-6 form-control">
				</div>
				<div class="form-group row">
					<label class="col-md-2" for="email">Email:</label> <input
						type="email" name="email" maxlength=50
						class="col-md-6 form-control">
				</div>
				<div class="form-group row">
					<label class="col-md-2" for="phoneNum">Phone:</label> <input
						type="text" name="phoneNum" maxlength=20
						class="col-md-6 form-control">
				</div>
				<div class="form-group row">
					<label class="col-md-2" for="address">Address:</label> <input
						type="text" name="address" maxlength=50
						class="col-md-6 form-control">
				</div>
				<div class="form-group row">
					<label class="col-md-2" for="city">City:</label> <input type="text"
						name="city" maxlength=40 class="col-md-6 form-control">
				</div>
				<div class="form-group row">
					<label class="col-md-2" for="state">State:</label> <input
						type="text" name="state" maxlength=20
						class="col-md-6 form-control">
				</div>
				<div class="form-group row">
					<label class="col-md-2" for="postalCode">Postal-code:</label> <input
						type="text" name="postalCode" maxlength=20
						class="col-md-6 form-control">
				</div>
				<div class="form-group row">
					<label class="col-md-2" for="country">Country:</label> <input
						type="text" name="country" maxlength=40
						class="col-md-6 form-control">
				</div>
				<div class="form-group row">
					<label class="col-md-2" for="userid">Username:</label> <input
						type="text" name="userid" maxlength=20
						class="col-md-6 form-control">
				</div>
				<div class="form-group row">
					<label class="col-md-2" for="password">Password:</label> <input
						type="password" name="password" maxlength=10
						class="form-control col-md-6">
				</div>
				<div class="form-group">
					<input class="btn btn-success" type="submit" name="Submit2"
						value="Sign up">
				</div>
			</form>
		</div>
<%@ include file="footer.jsp"%>
</body>
</html>