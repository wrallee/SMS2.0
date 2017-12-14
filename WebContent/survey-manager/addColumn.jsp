<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding ("utf-8");
String code=request.getParameter("code");

%>
<html>
<head>
<title>항목추가</title>
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
</head>
<body>
<jsp:include page="../headerAdmin.jsp" >
	<jsp:param value="survey" name="menu"/>
</jsp:include>


<form name="addColumn" action="addColumnProcess.jsp" method="post">
<input type="hidden" name= "tablename" value="<%=code%>">
<div class="wrapper">
<table style="margin-left: auto; margin-right: auto; text-align:center;">
<tr>
<td><h1>항목 추가하기</h1></td>
</tr>
<tr></tr>
<tr></tr>
<tr>
<td>추가할 항목  <input type="text" name="column"></td>
</tr>
<tr></tr>
<tr></tr>
<tr></tr>
<tr></tr>
<tr height="30px">
<td><input type="button" name="add" value="추가" style="font-size:18px"
onclick="location.href='javascript:addColumn.submit()'">&nbsp;&nbsp;&nbsp;
<input type="button" name="re" value="취소" style="font-size:18px"
onclick="location.href='surveyMenu.jsp'">
</td>
</tr>
</table>
</div>
</form>
</body>
</html>