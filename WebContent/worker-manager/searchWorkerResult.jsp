<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="worker.WorkerDataBean" %>
<%@ page import="worker.WorkerDBBean" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>검색 결과</title>
<link rel="stylesheet" href="style/worker_manage.css" />
</head>
<body>
<%

/*
☆☆☆☆이 부분에 세션 체크☆☆☆☆
*/
	
WorkerDBBean DBmanager = WorkerDBBean.getInstance() ;
//ArrayList<WorkerDataBean> workerList = DBmanager.getWorkerlist2() ;
ArrayList<WorkerDataBean> workerList = new ArrayList<WorkerDataBean>() ;

String keyword = request.getParameter( "id" ) ;
if( keyword != null ){
	WorkerDataBean worker1 = DBmanager.selectWorker2( keyword ) ;
	if (worker1 == null) { 		
		out.println("<script> alert('사원번호를 찾을 수 없습니다!!!'); window.close() </script>");
	} else {
		workerList.add( worker1 ) ;
	}
}else{
	%>
	<script>
		alert( 'No data' ) ;
	</script>
	<%
}

%>
<b>검색 결과</b>
<%
if( workerList.size() > 0 ){
	for( WorkerDataBean worker : workerList ) { %>
	<ul>
		<li>사원번호 : <%=worker.getId() %></li>
		<li>이름 : <%=worker.getName() %></li>
		<li>부서 : <%=worker.getDept() %></li>
		<br />
		<li><input type="button" name="detailworker" value="상세정보" onclick="location.href='infoWorker.jsp?id=<%=worker.getId()%>&layer=search'"></li>
		<li><input type="button" name="updateworker" value="사원수정" onclick="location.href='updateWorker.jsp?id=<%=worker.getId()%>&layer=search'"></li>
		<li><input type="button" name="deleteWorker" value="사원삭제" onclick="location.href='deleteWorker.jsp?id=<%=worker.getId()%>&layer=search'"></li>
	</ul>
	<%} 
}else{
	%>
	<center><h2>No Data</h2></center>
	<%
}
	%>

</body>
</html>