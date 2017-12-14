<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import= "java.sql.*"%>
<%@ page import= "javax.sql.*" %>
<%@ page import= "javax.naming.*" %>
<%@ page import= "survey.SurveyDBBean" %>

<%
	String code= request.getParameter("code");
	SurveyDBBean manager= SurveyDBBean.getInstance();
	int result=manager.deleteSurvey(code);

if(result!=0) {
	out.println("<script>");
	out.println("alert('설문지 삭제 성공')");
	out.println("location.href='surveyMenu.jsp'");
	out.println("</script>");
} else {
	out.println("<script>");
	out.println("alert('설문지 삭제 실패')");
	out.println("location.href='surveyMenu.jsp'");
	out.println("</script>");
}

%>