<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="worker.WorkerDBBean" %>

<% 
request.setCharacterEncoding( "utf-8" ) ;
%>

<jsp:useBean id="worker_to_insert" class="worker.WorkerDataBean">
	<jsp:setProperty name="worker_to_insert" property="*" />
</jsp:useBean>

<%
WorkerDBBean manager = WorkerDBBean.getInstance() ;
int result = manager.insertWorker( worker_to_insert ) ;

if( result != 0 ){
	out.println( "<script>" ) ;
	out.println( "alert( '사원 추가 성공!' ) ; " ) ;
	out.println( "window.opener.location.href='workerManager.jsp';" );
	out.println( "window.close();" );
	//out.println( "location.href='workerManager.jsp' ; " ) ;
	out.println( "</script>" ) ;
} else {
	out.println( "<script>" ) ;
	out.println( "alert( '사원 추가 실패! (사원번호가 중복이거나 값이 누락되었습니다)' ) ; " ) ;
	out.println( "window.close();");
	//out.println( "location.href='javascript:history.back();' ; " ) ;
	out.println( "</script>" ) ;
}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
인서트 워커 프로세스
</body>
</html>