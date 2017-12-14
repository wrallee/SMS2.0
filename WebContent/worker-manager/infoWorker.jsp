<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>

<%@ page import="worker.WorkerDBBean" %>
<%@ page import="worker.WorkerDataBean" %>

<% 
request.setCharacterEncoding( "utf-8" ) ;


WorkerDBBean manager = WorkerDBBean.getInstance() ;
WorkerDataBean worker = manager.selectWorker2( request.getParameter( "id" ) ) ;
String layer = request.getParameter("layer");

%>

<%
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>
사원 정보
</title>
<link rel="stylesheet" href="style/worker_manage.css" />
</head>
<body>
<%if (layer == null) { %>
<b>사원 정보</b>
<%} else if (layer.equals("search")) { %>
<b>사원 정보</b>
<%} %>
<div class="normalList">
<ul>
    <%-- <%if(rs.next()) {%>
    <li>사원번호 : <%=rs.getString("id") %></li>
    <li>이름 : <%=rs.getString("name") %></li>
    <li>부서 : <%=rs.getString("dept") %></li>
    <li>주소 : <%=rs.getString("addr") %></li>
    <%} %> --%>
    <%if( worker != null ) {%>
    <li>사원번호 : <%=worker.getId() %></li>
    <li>이름 : <%=worker.getName() %></li>
    <li>부서 : <%=worker.getDept() %></li>
    <li>주소 : <%=worker.getAddr() %></li>
    <%} %>
    <%if (layer == null) { %>
    <br/>
    <a href = "javascript:window.close()">닫기</a>
    <%} else if (layer.equals("search")) {%>
    <br/>
    <a href = "javascript:history.go(-1)">뒤로가기</a>
    <%} %>
</ul>
</div>
</body>
</html>
