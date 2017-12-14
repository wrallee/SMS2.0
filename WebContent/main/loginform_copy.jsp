<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원관리 시스템 로그인 페이지</title>
<script language = "javascript">
function check_input() {
	var str, i, ch;
	// 아이디체크
	if (document.loginform.id.value == "") {
		alert("아이디를 입력하세요");
		document.loginform.id.focus();
		return false;
	} else {
		str = document.loginform.id.value;
		
		for (i = 0; i < str.length; i++) {
			ch = str.substring(i, i + 1);
			if ( !((ch >= "0" && ch <= "9") || (ch >= "a" && ch <= "z") || (ch >= "A" && ch <= "Z")) ) {
				alert("특수문자가 포함, 다시 입력!!!");
				document.loginform.password.focus();
				return false;
			}
		}
		return true;
	} // 아이디 체크
	
	loginform.submit();
}
</script>
</head>
<body>
<form name = "loginform" action = "loginProcess.jsp" method = "post">
<center>
<table border = 1>
	<tr>
		<td colspan = 2 align = center>
			<b><font size = 5>로그인 페이지</font></b>
		</td>
	</tr>
	<tr>
		<td>사원번호: </td>
		<td><input type = "text" name = "id" /></td>
	</tr>	
	<tr>
		<td colspan = 2 align = center>
			<a href = "javascript:loginform.submit()" >로그인</a>
		</td>
	</tr>
</table>
</center>
</form>
</body>
</html>