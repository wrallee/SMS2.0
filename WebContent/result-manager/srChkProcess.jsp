<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="adminResult.AdminResultBean" %>
<%@ page import="java.sql.ResultSet" %>
<%
	String code = request.getParameter("code");
	
	AdminResultBean manager = AdminResultBean.getInstance();
	ResultSet rs = manager.getInfoInSurvey(code);
	if(!rs.next()) {
		out.println("<script>");
		out.println("alert('해당 설문이 없습니다.');");
		out.println("history.back();");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("location.href='srMain.jsp?code=" + code + "'");
		out.println("</script>");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>