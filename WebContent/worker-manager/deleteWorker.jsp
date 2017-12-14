<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>

<%@ page import="worker.WorkerDBBean" %>
<%@ page import="worker.WorkerDataBean" %>

<% 
request.setCharacterEncoding( "utf-8" ) ;

WorkerDBBean manager = WorkerDBBean.getInstance() ;
int result = manager.deleteWorker( request.getParameter( "id" ) ) ;

String layer = request.getParameter("layer"); // 접근경로 파악을 위한 layer 변수 요청(search / click)

if( result != 0 ){
	out.println( "<script>" ) ;
	out.println( "alert( '사원 삭제 성공!' ) ; " ) ;
	if (layer == null) { // click을 통한 접근 시 본래창 새로고침
		out.println( "location.href='workerManager.jsp' ; " ) ;
	} else if (layer.equals("search")) { // search를 통한 접근 시 부모창 새로고침 후 팝업닫기
		out.println( "window.opener.location.href='workerManager.jsp';" );
		out.println( "window.close();" );
	}
	out.println( "</script>" ) ;
} else {
	out.println( "<script>" ) ;
	out.println( "alert( '사원 삭제 실패...' ) ; " ) ;
	if (layer == null)
		out.println( "location.href='javascript:history.back();' ; " ) ;
	else if (layer.equals("search"))
		out.println( "window.close();" );
	out.println( "</script>" ) ;
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
딜리트
</body>
</html>