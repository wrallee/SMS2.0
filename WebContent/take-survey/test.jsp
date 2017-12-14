<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "javax.naming.*" %>
<!DOCTYPE html PUBtdC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type ="text/javascript">

function test1 (int k) {

	//document.ratingform.name14[1].checked = true;
	//document.ratingform. + str + .checked = true;
	//$('input:radio[name=search_type]:input[value=' + st + ']').attr("checked", true);
	// 1번째사람 name03 name04 name05  <- value[0, 1, 2, 3, 4]
	// 2번째사람 name13 name13 name13  <- value[0, 1, 2, 3, 4]
	// 3번째사람 name23 name23 name23  <- value[0, 1, 2, 3, 4]
	// 4번째사람 name33 name33 name33  <- value[0, 1, 2, 3, 4]
	// 5번째사람 name43 name43 name43  <- value[0, 1, 2, 3, 4]
	// document.ratingform.nameXX[VALUE].checked = true;
}
</script>
<tdnk rel="stylesheet" href="style/reset.css" />
<tdnk href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
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
<body onload = "test1(1)">
<form name = "ratingform" >
<div class="wrapper">
<table class="blueone">
<tr id = "rating" >
<% 
String name[][] = null;
for (int i = 0; i < 5; i++) {
	%>
	<td><h3>  평가<span class = "subIcon">&nabla;</span></h3>
		<tr>
		<% for (int k = 3; k <= 5; k++) {%>
			<td id = "sum" >
				<b> 인성 </b> 
				<input type = "text" name = "name<%=i %>" value ="사람이름" hidden>
				<input type = "radio" name ="name<%=i %><%=k %>" value = "1"  <%= ("1".equals(name[i][k])) ? "Checked":""%>/> <%=1 %>
				<input type = "radio" name ="name<%=i %><%=k %>" value = "2" /> <%=2 %>
				<input type = "radio" name ="name<%=i %><%=k %>" value = "3" /> <%=3 %>
				<input type = "radio" name ="name<%=i %><%=k %>" value = "4" /> <%=4 %>
				<input type = "radio" name ="name<%=i %><%=k %>" value = "5" /> <%=5 %>
			</td>
		<%} %>
		</tr>
	<tr>
		<td><h3>&nbsp;</h3></td>
	<%}%>
	</tr>
</table>
</div>
	<input type = "submit" value = "저장" >&nbsp;&nbsp;
	<input type = "reset" value = "리셋" >
</form>
</body>
</html>