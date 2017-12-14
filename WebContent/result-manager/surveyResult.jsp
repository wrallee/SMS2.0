<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="adminResult.AdminResultBean" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String code = request.getParameter("code"); // 서베이코드
	String group = request.getParameter("group"); // 라디오버튼
	String person = request.getParameter("person"); // 조사대상
	
	if (group == null) group = "all";
	if (person == null) person = "default";
	
	if (group.equals("groupby")) {
		person = "all";
	}
	
	AdminResultBean manager = AdminResultBean.getInstance();
	ResultSet rsInfo = manager.getInfoInSurvey(code);
	ResultSet rs = manager.getResultSet(code, group, person);
	ResultSetMetaData rsMdata = rs.getMetaData();
	
	rsInfo.next();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="style/reset.css" />
<link rel="stylesheet" href="style/worker_manage.css" />
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">

</head>
<body>
<div class="wrapper">
	<form name="listform" action="#" method="post" class="listform">
	<table class="blueone">
		<tr><td colspan="<%=rsMdata.getColumnCount() %>"><h3><%=rsInfo.getString("title") %> 서베이 결과</h3></td></tr>
		<%if (group.equals("groupby")) { %>
		<tr><td>부서별 최고득점자</td></tr>
		<%} %>
		<tr>
			<%for (int i=1; i<=rsMdata.getColumnCount(); i++) { %>
			<td><%=rsMdata.getColumnName(i) %></td>
			<%} %>
		</tr>
		<%while (rs.next()) { %>
		<tr>
			<%for (int i=1; i<=rsMdata.getColumnCount(); i++) { %>
			<td><%=rs.getString(i) %></td>
			<%} %>
		</tr>
		<%} %>
	</table>
	</form>
</div>
</body>
</html>