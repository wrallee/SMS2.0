<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@ page import= "java.sql.*"%>
<%@ page import= "javax.sql.*" %>
<%@ page import= "javax.naming.*" %>
<%@ page import= "survey.SurveyDBBean" %>
<%@ page import= "survey.SurveyDataBean" %>

<% request.setCharacterEncoding ("utf-8"); 
	SurveyDBBean manager= SurveyDBBean.getInstance();
	
	String code=request.getParameter("code");
	
	int result= manager.ongoingSurvey(code);
	
	if (result == 0) {
		out.println("<script>");
		out.println("alert('개시 실패!!!')");
		out.println("location.href='surveyMenu.jsp'");
		out.println("</script>");
	} else if(result == -1) {
		out.println("<script>");
		out.println("alert('이미 진행중인 설문이 있습니다!!!')");
		out.println("location.href='surveyMenu.jsp'");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('설문이 개시되었습니다')");
		out.println("location.href='surveyMenu.jsp'");
		out.println("</script>");
		
		
	}
%>