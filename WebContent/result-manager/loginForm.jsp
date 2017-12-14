<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원관리 시스템 로그인 페이지</title>
</head>
<body>
<form name="loginform" action="srChkProcess.jsp" method="post">
<center>
<table border=1>
	<tr>
		<td colspan="3" align=center>
			<b><font size=5>로그인 페이지</font></b>
		</td>
	</tr>
	<tr><td>아이디: </td><td><input type="text" name="id" value="admin" /></td></tr>
	<%session.setAttribute("id", "admin"); %>
	<tr><td>서베이번호: </td><td><input type="text" name=code value="S01" /></td></tr>
	<tr><td>서베이제목: </td><td><input type="text" name="title" value="TestSurvey" /></td></tr>
	<tr>
		<td colspan="3" align=center>
			<input type="radio" name="group" value="all" checked />전체출력&nbsp;&nbsp;
			<input type="radio" name="group" value="rater" />평가자별&nbsp;&nbsp;
			<input type="radio" name="group" value="ratee" />평가대상별&nbsp;&nbsp;
			<input type="radio" name="group" value="groupby" />부서별최고득점
		</td>
	<tr>
		<td colspan="3" align=center>
			<a href="javascript:loginform.submit()">로그인</a>&nbsp;&nbsp;
			<a href="joinForm.jsp">회원가입</a>
		</td>
	</tr>
</table>
</center>
</form>
</body>
</html>