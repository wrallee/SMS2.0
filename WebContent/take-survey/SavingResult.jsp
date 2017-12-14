<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "javax.naming.*" %>
<%@ page import = "sms.RatingDBBean" %>
<%@ page import = "sms.RatingDataBean" %>
<%@ page import = "sms.SurveyDataBean"%>
<%
	String id  = null;
	ArrayList<RatingDataBean> member_list = null;
	SurveyDataBean survey_info = null;
	if ((session.getAttribute("id")) == null ){
		out.println("<script> location.href = '../main/loginform.jsp' </script>");
	}
	id = (String)session.getAttribute("id");
	RatingDBBean manager = RatingDBBean.getInstance();
	String dept = manager.getDept(id);
	member_list = (ArrayList<RatingDataBean>)manager.getMemberlist(dept);
	survey_info = (SurveyDataBean)manager.getSurveyInfo();
	String code = survey_info.getCode();
	
	String[][] data = new String[member_list.size() - 1][manager.getRSMDColCount(code)];
	for (int i = 0; i < member_list.size() - 1; i++) { 
		if (request.getParameter("name" + i) == null) {
			i++;
			for (int l = i; l < member_list.size(); l++) {
				data[l - 1][1] = request.getParameter("name" + l);
				for (int k = 3; k <= manager.getRSMDColCount(code); k++) {
					data[l - 1][k - 1] = request.getParameter("name" + l + k);
				}
			}
			break;
		}
		data[i][1] = request.getParameter("name" + i);
		for (int k = 3; k <= manager.getRSMDColCount(code); k++) {
			data[i][k - 1] = request.getParameter("name" + i + k);
		}
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="style/reset.css" />
<link rel="stylesheet" href="style/saving_result.css" />
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
</head>
<body>
<center>
<h2>저장 페이지</h2>
<div class="wrapper">
<table class="blueone">
	<tr>
		<b>평가자 <%=id %></b>
	</tr>
	<tr>
	<td></td>
	<td></td>
	<% for (int k = 3; k <= manager.getRSMDColCount(code); k++) { %>
	<td><%=manager.getRSMDColName(code, k) %></td>
	<%	}%>
	</tr>
	<tr>
	<%for (int i = 0; i < member_list.size(); i++) {
		if (request.getParameter("name" + i) == null) continue;
	%>
		<td>대상자</td>
		<td><%=request.getParameter("name" + i) %></td>
		<%for (int k = 3; k <= manager.getRSMDColCount(code); k++) { %>
			<%if (request.getParameter("name" + i + k) == null) {%>
			<td>X</td>
			<%} else { %>
			<td><%=request.getParameter("name" + i + k) %></td>
			<%} %>
		<%} %>
	</tr>
	<%} %>
	<br/>
</table>
<%
	int result = manager.dataSaving(data, id, code);
	if (result == 0) {
		out.println("<script>");
		out.println("alert('데이터가 저장되지 않았습니다! ');");	
		out.println("location.href = 'rating.jsp'");
		out.println("</script>");	
	}
%>
<h3><%=result %>개의 행이 성공적으로 저장되었습니다</h3>
<a href = "rating.jsp">돌아가기</a>
</div>
</center>
</body>
</html>