<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="adminResult.AdminResultBean"%>
<%
	String code = request.getParameter("code"); // 서베이코드
	String group = request.getParameter("group"); // 라디오버튼
	String pagefile = request.getParameter("page");
	if (pagefile == null) pagefile = "surveyResult";
	if (group == null) group = "all";
	
	AdminResultBean manager = AdminResultBean.getInstance();
	ResultSet rs = null;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="style/reset.css" />
<link rel="stylesheet" href="style/worker_manage.css" />
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<script>
$("#category").change(function () {
	var selected = $("#category option:selected").val();
	$("#rBlock").load("surveyResult.jsp",
			{
				group: "<%=group %>",
				code: "<%=code %>",
				person: selected
			});
});
</script>
</head>

<select id="category">
<%if (group.equals("all")) { %>
	<option value="all">전체</option>
<%} else if (group.equals("rater")) { %> 
	<%rs = manager.getDistinctElement(code, group); %>
	<option value="default">평가자 선택</option>
	<%while (rs.next()) { %>
	<option value="<%=rs.getString(1) %>"><%=rs.getString(1) %></option>
	<%} %>
	
<%} else if (group.equals("ratee")) { %>
	<%rs = manager.getDistinctElement(code, group); %>
	<option value="default">평가대상 선택</option>
	<%while (rs.next()) { %>
	<option value="<%=rs.getString(1) %>"><%=rs.getString(1) %></option>
	<%} %>
<%} else if (group.equals("groupby")) { %>
	<option value="groupby">부서별 최고득점</option>
<%} %>
</select>
<div id="rBlock" class="wrapper">
	<jsp:include page='<%=pagefile + ".jsp" %>'>
		<jsp:param name="code" value="<%=code %>" />
		<jsp:param name="group" value="<%=group %>" />
	</jsp:include>
</div>

</html>