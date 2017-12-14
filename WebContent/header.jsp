<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "javax.naming.*" %>
<%@ page import = "sms.RatingDBBean" %>
<%
	RatingDBBean manager = RatingDBBean.getInstance();
	String id = (String)session.getAttribute("id");
	String sessName = manager.getName(id);
%>
<div name = "header">
<% if (!(id.equals("admin"))) {%>
	<B>사번 <%=id %> | <%=sessName %>님 환영합니다</B>
<% } else { %>
	<B>관리자님 환영합니다</B>
<% } %>
	<h3><a style="cursor:pointer" onclick="location.href='../main/logout.jsp'">로그아웃</a></h3>
</div> 