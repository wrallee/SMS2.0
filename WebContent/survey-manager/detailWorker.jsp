<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%

Connection conn=null;
PreparedStatement pstmt=null;
ResultSet rs=null;

String id=request.getParameter("id");

try {
	
	Context init=new InitialContext();
	DataSource ds=(DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn= ds.getConnection();
	
	pstmt= conn.prepareStatement("SELECT * FROM WORKER WHERE id=?");
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();
	
} catch(SQLException e) {
	e.printStackTrace();
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>
사원 정보
</title>
</head>
<body>
<div>
	<%while(rs.next()) {%>
<ul>

	<li>사원번호 : <%=rs.getString("id") %></li>
	<li>이름 : <%=rs.getString("name") %></li>
	<li>부서 : <%=rs.getString("dept") %></li>
	<li>주소 : <%=rs.getString("addr") %></li>

</ul>
	<%} %>
</div>
</body>
</html>
