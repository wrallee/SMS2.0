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
	SurveyDataBean survey_info = null;
	if ((session.getAttribute("id")) == null ){
		out.println("<script> location.href = '../main/loginform.jsp' </script>");
	}
	id = (String)session.getAttribute("id");
	RatingDBBean manager = RatingDBBean.getInstance();

	if( (SurveyDataBean)manager.getSurveyInfo() == null ){
		out.println("<script>");
		out.println("alert('진행 중인 설문이 없습니다.')");
		out.println("location.href = '../main/logout.jsp'");
		out.println("</script>");
		out.println("설문없다");
	} else {
		out.println("<script>");
		out.println("location.href = 'rating.jsp'");
		out.println("</script>");
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
ONGOING CHECK
</body>
</html>