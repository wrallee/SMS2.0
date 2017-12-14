<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="worker.WorkerDBBean" %>

<% 
request.setCharacterEncoding( "utf-8" ) ;
%>

<jsp:useBean id="worker_to_update" class="worker.WorkerDataBean">
	<jsp:setProperty name="worker_to_update" property="*" />
</jsp:useBean>

<%
WorkerDBBean manager = WorkerDBBean.getInstance() ;
int result = manager.updateWorker( worker_to_update ) ;

// 팝업 닫히고 부모창 새로고침 // 우찬수정
if( result != 0 ){
	out.println( "<script>" ) ;
	out.println( "alert( '사원 수정 성공!' ) ; " ) ;
	out.println( "window.opener.location.href='workerManager.jsp';" );
	out.println( "window.close();" );
	//out.println( "location.href='workerManager.jsp' ; " ) ;
	out.println( "</script>" ) ;
} else {
	out.println( "<script>" ) ;
	out.println( "alert( '사원 수정 실패...' ) ; " ) ;
	out.println( "window.close();" );
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