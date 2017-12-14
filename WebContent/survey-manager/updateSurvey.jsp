<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*"%>
<%@ page import= "javax.sql.*" %>
<%@ page import= "javax.naming.*" %>
<%@ page import= "survey.SurveyDBBean" %>
<%@ page import= "survey.SurveyDataBean" %>
<% request.setCharacterEncoding ("utf-8"); %>
<% 
String info_code=request.getParameter("code");

SurveyDBBean manager= SurveyDBBean.getInstance(); 
ResultSet rs= manager.getResultSet(info_code);
ResultSetMetaData rsMdata= manager.getTableMdata(info_code);
%>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="style/reset.css" />
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
* {
	font-family: 'Jeju Gothic', sans-serif;
}
.wrapper{
	display: flex ;
	flex-direction: column ;
	justify-content: center ;
	width: 600px ;
	background-color: #ffffff ;
	box-shadow: 0 0 8px rgba(0,0,0,.06), 0 4px 16px rgba(0,0,0,.12);
	position:absolute;
	top:20%;
	left:35%;
 	text-align:center; 
}
h1 {
	color: #4AB367 ;
	font-weight: normal;
	font-size: 40px ;
}
.span {
	width: 140px;

  min-height: 1px;
  margin-left: 20px;
}
</style>
</head>
<body>

<jsp:include page="../headerAdmin.jsp" >
	<jsp:param value="survey" name="menu"/>
</jsp:include>

<form name="deleteSurvey" action="deleteColumnProcess.jsp" method="post">
<input type="hidden" name="code" value="<%=info_code%>">
<div class="workerManaer">
<div class="wrapper" >
	<div id="title" class="centerer">
		<h1>설문지 수정</h1>
	</div>
<table style="margin-left: auto; margin-right: auto; text-align:center;">
<tr>
	<%
	for (int i = 3; i <= rsMdata.getColumnCount(); i++) {
	%>
	<td><%=rsMdata.getColumnName(i)%>
		<%if(i >= 3) {%>
			<input type="checkbox" name="col" value="<%=rsMdata.getColumnName(i)%>"></td>
	<%}
	}	%>
</tr>
<tr></tr>
<tr></tr>
<tr></tr>
<tr></tr>
<tr>
<td><input type="button" name="add" value="항목추가" style="font-size:18px"
onclick="location.href='addColumn.jsp?code=<%=info_code%>'">
</td>
<td><input type="button" name="delete" value="삭제" style="font-size:18px"
onclick="location.href='javascript:deleteSurvey.submit()'">
</td>
<td><input type="button" name="goback" value="뒤로가기" style="font-size:18px"
onclick="javascript:history.go(-1)">
</td>
</tr>
</table>
</div>
</div>
</form>
</body>
</html>