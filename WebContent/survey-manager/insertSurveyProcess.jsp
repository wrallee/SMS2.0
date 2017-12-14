<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*"%>
<%@ page import= "javax.sql.*" %>
<%@ page import= "javax.naming.*" %>
<%@ page import= "survey.SurveyDBBean" %>
<% request.setCharacterEncoding ("utf-8"); %>
<jsp:useBean id="surveydata" class="survey.SurveyDataBean" >
	<jsp:setProperty name="surveydata" property="*" />
</jsp:useBean>
<%
	SurveyDBBean manager=SurveyDBBean.getInstance();
	int result=manager.insertSurvey(surveydata);
	
	if(result!=0) {
		out.println("<script>");
		out.println("alert('설문지 입력 성공')");
		out.println("location.href='surveyMenu.jsp'");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('설문지 입력 실패')");
		out.println("location.href='insertSurvey.jsp'");
		out.println("</script>");
	}

%>