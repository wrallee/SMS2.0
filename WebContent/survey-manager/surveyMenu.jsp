<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*"%>
<%@ page import= "javax.sql.*" %>
<%@ page import= "javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import= "survey.SurveyDBBean" %>
<%@ page import= "survey.SurveyDataBean" %>
<%
	request.setCharacterEncoding ("utf-8");
	Connection conn=null;
	PreparedStatement pstmt1=null;
	PreparedStatement pstmt2=null;
	ResultSet rs1=null;
	ResultSet rs2=null;
	try {
		Context init=new InitialContext();
		DataSource ds=(DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn=ds.getConnection();
		
		pstmt1=conn.prepareStatement("SELECT * FROM SURVEY");
		pstmt2=conn.prepareStatement("SELECT * FROM SURVEY WHERE STATE = 'ONGOING'");
		
		rs1=pstmt1.executeQuery();
		rs2=pstmt2.executeQuery();
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
<%!
String getClassStatusName( String str ){
	if( str.equals( "ONGOING" ) ){
		return "ongoing_row" ;
	} else if( str.equals( "COMPLETE" ) ){
		return "complete_row" ;
	}
	return "" ;
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>설문지 관리 메뉴</title>
<link rel="stylesheet" href="style/reset.css" />
<link rel="stylesheet" href="style/survey_manage.css" />
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
</head>
<body>

<jsp:include page="../headerAdmin.jsp" >
	<jsp:param value="survey" name="menu"/>
</jsp:include>

<div class="workerManager">

<div class="wrapper">
	<div id="title" class="centerer">
		<h1>설문 관리</h1>
	</div>
	<%while(rs2.next()) {%>
		<div class="lefter">
			<div class="noti_ongoing">
				<h3 id="ongoing_survey"><%=rs2.getString("title") %></h3><h4 id="ongoing_text">설문이 진행 중입니다.</h4>
			</div>
		</div>
	<%} %>
	<!-- 반복시작부분이 중요하다. 설정을 잘 하기 ...코드 눌렀을때 메모까지 뜨게 함-->
	<div class="middler">
	<form name= "surveymenu" action="surveypr" method="post" class="listform">
		<table class="blueone" >
			<tr><th></th><th>설문<br/>코드</th><th>상태</th><th>제목</th><th>설명</th><th></th></tr>
		<% while(rs1.next()) {%>
	
		<tr class="<%=getClassStatusName( rs1.getString( "state" ) )%>">
		<td></td>
		<td><%=rs1.getString("code") %></td>
		<td><%=rs1.getString("state") %></td>
		<td><a href="../result-manager/srMain.jsp?code=<%=rs1.getString( "code" ) %>"><%=rs1.getString("title") %></a></td>
		<td width="40%"><%=rs1.getString("memo") %></td>
		<td><a style="cursor:pointer" name="deleteSurvey" class="btns"
		onclick="location.href='deleteSurvey.jsp?code=<%=rs1.getString("code") %>'">
			<i class="fa fa-minus-square" aria-hidden="true"></i></a>
		<% if (rs1.getString("state").equals("READY")) { %>
		<a style="cursor:pointer" name="updateSurvey" class="btns"
		onclick="location.href='updateSurvey.jsp?code=<%=rs1.getString("code") %>'">
			<i class="fa fa-pencil-square" aria-hidden="true"></i></a>
		<%} %>
		<% if (rs1.getString("state").equals("READY")) { %>
		<a style="cursor:pointer" name="ongoing" class="btns" 
		onclick="location.href='ongoingProcess.jsp?code=<%=rs1.getString("code")%>'">
			<i class="fa fa-play-circle" aria-hidden="true"></i></a>
		<%} else if (rs1.getString("state").equals("ONGOING")) {%>
		<a style="cursor:pointer" name="complete" class="complete_btn"
		onclick="location.href='completeProcess.jsp?code=<%=rs1.getString("code")%>'">
			<i class="fa fa-check-circle" aria-hidden="true"></i></a>
		<%} %>
	
		</td>
		</tr>
		<%} %>
		</table>
	</form>
</div>
<input type="button" name="newSurvey" value="설문추가" onclick="location.href='insertSurvey.jsp'">&nbsp;
</div>
</div>
</body>
</html>