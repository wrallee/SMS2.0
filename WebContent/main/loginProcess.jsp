<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "javax.naming.*" %>
<%@ page import = "sms.RatingDBBean" %>
<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name"); // 이름으로 로그인하기 위해 추가
	String id = request.getParameter("id");
	
	RatingDBBean manager = RatingDBBean.getInstance();
	if (!name.equals("")) 					// 이름으로 로그인하기 위해 추가
		id = manager.getIdFromName(name); 	// 이름으로 로그인하기 위해 추가
	int chk = manager.userCheck(id);
	
	if (chk == 1) {
		session.setAttribute("id", id);
		out.println("<script>");
		out.println("alert('admin페이지로 연결합니다.')");
		out.println("location.href = 'adminMenu.jsp'");
		out.println("</script>");
		
	} else if (chk == 0) {
		session.setAttribute("id", id);
		out.println("<script>");
		out.println("alert('사원 평가 페이지로 연결합니다.')");
		out.println("location.href = '../take-survey/ongoingCheck.jsp'");
		out.println("</script>");	
	} else {
		out.println("<script>");
		out.println("alert('아이디가 없습니다.')");
		out.println("location.href = 'loginform.jsp'");
		out.println("</script>");
	}

%>