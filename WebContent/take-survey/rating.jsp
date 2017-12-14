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
	String name = manager.getName(id);
	member_list = (ArrayList<RatingDataBean>)manager.getMemberlist(dept);

	survey_info = (SurveyDataBean)manager.getSurveyInfo();
	String code = survey_info.getCode();
	String[][] data = manager.dataLoading(id, dept, code);
	
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type ="text/javascript">

function loading () {
	data = manager.dataLoading(id, dept, Code);
}
</script>
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
	margin-left: auto;
	margin-right: auto;

	width: 670px ;
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
.blueone {
  border-collapse: collapse;
}  
.blueone th {
  padding: 2px;
  background-color: #4AB367;
  color: #ffffff;
  font-size: 10pt;
  font-weight: normal;
  text-align: center;
  height: 10px ;
  width: 800px ;
}

.blueone th:first-child{
  border-radius: 0px 0px 0px 0px ;
}
.blueone th:last-child{
  border-radius: 0px 0px 0px 0px ;
}
.blueone td {
  color: #232A2A;
  padding: 0px;
  font-size: 12pt;
  height: 12px;
  text-align: center;
}
.blueone tr {
  border-bottom: 2px solid #ddd;
}
.blueone td:nth-child(1){
	width: 120px ;
}
.blueone td:nth-child(2){
	width: 70px ;
}
.blueone td:nth-child(3){
	width: 70px ;
}
.blueone td:nth-child(4){
	width: 70px ;
}
.blueone td:nth-child(5){
	width: 70px ;
}
.blueone td:nth-child(6){
	width: 70px ;
}
.blueone td:nth-child(7){
	width: 70px ;
}
.blueone td:last-child{
	width: 70px ;
}


</style>
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../header.jsp" />
<DIV>
	<b>사원 번호 : <font size = 5><%= id %></font> </b> | 
	<b>이름 : <font size = 5><%= name %></font> </b> | 
	<b>부서 : <font size = 5><%= dept %></font> </b> | 

</DIV>

<h1 align = center><%=survey_info.getTitle()%> </h1>
<h2 align = center><%=survey_info.getMemo() %></h2>
<hr />
<form name = "ratingform" action = "SavingResult.jsp" method = "post" onload = "loading()" >
<div class="wrapper">
<table class="blueone">
<tr id = "rating" >
<% for (int i = 0; i < member_list.size(); i++) {
	RatingDataBean a = (RatingDataBean)member_list.get(i); 
	if (id.equals(a.getId())) { continue; } else {
	%>
	<td><h3> <%=a.getName() %>님 평가<span class = "subIcon"></span></h3></td>
</tr>

		<tr>
		<% for (int k = 3; k <= manager.getRSMDColCount(code); k++) {%>
			<td>●
				<b> <%=manager.getRSMDColName(code, k) %> </b> 
				<%for (int n = 0; n < data.length; n++) {
					if (a.getId().equals(data[n][1])) {
				%>
			
		
				
				<td><input type = "text" name = "name<%=i %>" value ="<%=a.getId() %>" hidden></td>
				<td><input type = "radio" id = "ratee<%=i %>" name ="name<%=i %><%=k %>" value = "1" <%= ("1".equals(data[n][k-1])) ? "Checked":""%> /> <%=1 %></td>
				<td><input type = "radio" id = "ratee<%=i %>" name ="name<%=i %><%=k %>" value = "2" <%= ("2".equals(data[n][k-1])) ? "Checked":""%> /> <%=2 %></td>
				<td><input type = "radio" id = "ratee<%=i %>" name ="name<%=i %><%=k %>" value = "3" <%= ("3".equals(data[n][k-1])) ? "Checked":""%>/> <%=3 %></td>
				<td><input type = "radio" id = "ratee<%=i %>" name ="name<%=i %><%=k %>" value = "4" <%= ("4".equals(data[n][k-1])) ? "Checked":""%>/> <%=4 %></td>
				<td><input type = "radio" id = "ratee<%=i %>" name ="name<%=i %><%=k %>" value = "5" <%= ("5".equals(data[n][k-1])) ? "Checked":""%>/> <%=5 %></td>
			</tr>
				<%break;} else { 
					if (n == data.length - 1) {%>
			
				<td><input type = "text" name = "name<%=i %>" value ="<%=a.getId() %>" hidden></td>
				<td><input type = "radio" id = "ratee<%=i %>" name ="name<%=i %><%=k %>" value = "1" /> <%=1 %></td>
				<td><input type = "radio" id = "ratee<%=i %>" name ="name<%=i %><%=k %>" value = "2" /> <%=2 %></td>
				<td><input type = "radio" id = "ratee<%=i %>" name ="name<%=i %><%=k %>" value = "3" /> <%=3 %></td>
				<td><input type = "radio" id = "ratee<%=i %>" name ="name<%=i %><%=k %>" value = "4" /> <%=4 %></td>
				<td><input type = "radio" id = "ratee<%=i %>" name ="name<%=i %><%=k %>" value = "5" /> <%=5 %></td>
			</tr>
					<%}
				}
				}%>
		<%} %>

		<%}
	} %>
</table>
</div>
	<center>
		<input type = "submit" value = "저장" >
	</center>
</form>
</body>
</html>