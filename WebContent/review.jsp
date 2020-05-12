<%@ page language="java"
	import="java.io.*,java.sql.*,
			javax.servlet.http.HttpServletRequest,
            javax.servlet.http.HttpServletResponse,
            javax.servlet.jsp.JspWriter  
"%>

<%@ include file="jdbc.jsp" %>
<%
	int reviewRating = Integer.parseInt(request.getParameter("reviewRating"));
	String reviewDate = request.getParameter("reviewDate");
	int customerId = Integer.parseInt(request.getParameter("customerId"));
	int productId = Integer.parseInt(request.getParameter("productId"));
	String comment = request.getParameter("reviewComment");
	getConnection();
	try {
		
		String sql = "INSERT INTO review (reviewRating, reviewDate, customerId, productId, reviewComment) VALUES (?,?,?,?,?)";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, reviewRating);
		pstmt.setString(2, reviewDate);
		pstmt.setInt(3, customerId);
		pstmt.setInt(4, productId);
		pstmt.setString(5, comment);
		pstmt.executeUpdate();
	
		
	} catch (SQLException e) {
		out.println(e);
	}
	closeConnection();
	
	response.sendRedirect("product.jsp?id="+productId);	
%>
