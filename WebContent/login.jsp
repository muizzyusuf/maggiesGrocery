<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
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
<div style="margin:0 auto;display:inline">



<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p class=\"lead text-center\">"+session.getAttribute("loginMessage").toString()+"</p>");
%>

<div class="container jumbotron col-md-6 ml-auto">
<h4 class="text-center">Login to System</h4>
<form  name="MyForm" method=post action="validateLogin.jsp">
<div class="form-group">
  <label for="usr">Customer ID:</label>
  <input type="text" name="username"  size=10 maxlength=10 class="form-control">
</div>
<div class="form-group">
  <label for="pwd">Password:</label>
  <input type="password" name="password" size=10 maxlength="10" class="form-control" >
</div>
<div class="form-group">
  <input class="btn btn-success" type="submit" name="Submit2" value="Log In">
</div>

</form>
</div>

</div>
<%@ include file="footer.jsp"%>
</body>
</html>

