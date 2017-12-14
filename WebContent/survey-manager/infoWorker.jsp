<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*"%>
<%@ page import= "javax.sql.*" %>
<%@ page import= "javax.naming.*" %>
<%
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	
	try {
		Context init=new InitialContext();
		DataSource ds=(DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn= ds.getConnection();
		
		pstmt= conn.prepareStatement("SELECT * FROM WORKER");
		rs=pstmt.executeQuery();
	} catch(SQLException e) {
		e.printStackTrace();
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>사원 정보</title>
</head>
<body>
<!--<form action="~~" method="post">  -->
<h1>사원 정보</h1>
<div>
<ul>
	<%while(rs.next()) { %>
	<li>사원번호 : <%=rs.getString("id") %></li>
	<li>이름 : <%=rs.getString("name") %></li>
	<li>부서 : <%=rs.getString("dept") %></li>
	<li><input type="button" name="detailworker" value="상세정보" onclick="location.href='detailWorker.jsp?id=<%=rs.getString("id") %>'"></li>
	<li><input type="button" name="updateworker" value="사원수정" onclick="location.href='updateWorker.jsp?id=<%=rs.getString("id") %>'"></li>
	<li><input type="button" name="deleteWorker" value="사원삭제" onclick="location.href='deleteWorker.jsp?id=<%=rs.getString("id") %>'"></li>
	<%} %>
</ul>
</div>
<input type="button" name="insertWorker" value="사원추가" onclick="location.href='insertWorker.jsp'">
</body>
</html>