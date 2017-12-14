<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@ page import= "java.sql.*"%>
<%@ page import= "javax.sql.*" %>
<%@ page import= "javax.naming.*" %>
<%@ page import= "survey.SurveyDBBean" %>
<%@ page import= "survey.SurveyDataBean" %>
<% request.setCharacterEncoding ("utf-8"); 

//db에 접근하기 위한 객체
SurveyDBBean manager=SurveyDBBean.getInstance();

String code=request.getParameter("code");
String[] column= request.getParameterValues("col");
if (column == null) {
	out.println("<script>");
	out.println("alert('삭제할 항목을 선택해 주세요')");
	out.println("javascript:history.go(-1)");
	out.println("</script>");
} else {
	int res=0;
	
	for (int i = 0; i<column.length; i++) {
		res += manager.deleteColumn(code, column[i]);
	
	}
	
	if (res == 0) {
		out.println("<script>");
		out.println("alert('삭제실패')");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('삭제 성공')");
		out.println("location.href='surveyMenu.jsp'");
		out.println("</script>");
	}
}
%>


