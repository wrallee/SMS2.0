<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBtdC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

<form name="insertSurvey" action="insertSurveyProcess.jsp" method="post" >
<div class="wrapper">
<table style="margin-left: auto; margin-right: auto; text-align:center;">
<tr>
	<td><h1>설문지 작성하기</h1></td>
</tr>
<tr>
	<td>설문코드: <input class="span" type="text" name="code"/></td>
</tr>
<tr>
	<td>제목 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <input class="span" type="text" name="title"/></td>
</tr>
<tr>
	<td>메모 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <input class="span" type="text" name="memo"/></td>
</tr>
<tr>
	<td>항목 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input class="span" type="text" name="order"/></td>
</tr>
<tr></tr>
<tr>

	<td><input type="button" name="add" value="추가" style="font-size:18px"
		onclick="location.href='javascript:insertSurvey.submit()'">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
		<input type="button" name="reset" value="취소" style="font-size:18px"
		onclick="location.href='surveyMenu.jsp'">
	</td>
</tr>
</table>
</div>
</form>
</body>
</html>