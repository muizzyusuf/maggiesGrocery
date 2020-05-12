<%@ page language="java"
	import="java.io.*,java.sql.*,
			javax.servlet.http.HttpServletRequest,
            javax.servlet.http.HttpServletResponse,
            javax.servlet.jsp.JspWriter  
"%>

<%@ include file="jdbc.jsp"%>
<%

	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String email = request.getParameter("email");
	String phonenum = request.getParameter("phoneNum");
	String address = request.getParameter("address");
	String city = request.getParameter("city");
	String state = request.getParameter("state");
	String postalCode = request.getParameter("postalCode");
	String country = request.getParameter("country");
	String userid = request.getParameter("userid");
	String password = request.getParameter("password");
	try {
		getConnection();
		String sql = "INSERT INTO customer ( firstName, lastName, email, phoneNum, address, city, state, postalCode, country, userid, password  ) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, firstName);
		pstmt.setString(2, lastName);
		pstmt.setString(3, email);
		pstmt.setString(4, phonenum);
		pstmt.setString(5, address);
		pstmt.setString(6, city);
		pstmt.setString(7, state);
		pstmt.setString(8, postalCode);
		pstmt.setString(9, country);
		pstmt.setString(10, userid);
		pstmt.setString(11, password);
		pstmt.executeUpdate();
	} catch (SQLException e) {
		out.println(e);
	}
	
	response.sendRedirect("index.jsp");	
%>
