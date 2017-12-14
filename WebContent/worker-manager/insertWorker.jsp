<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="department.DepartmentDB" %>
<%@ page import="department.DepartmentBean" %>
<%@ page import="java.util.*" %>

<%

ArrayList<DepartmentBean> deptList = null ;
DepartmentDB manager= DepartmentDB.getInstance();
deptList = (ArrayList<DepartmentBean>) manager.getDeptlist() ;

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="style/worker_manage.css" />
<script type="text/javascript">
window.onload = function(){
	initSelect( "dept" ) ;
}
function initSelect( selectName ){
	
	var dname_arr = [] ;
	var dno_arr = [] ;
	
	<%
	for( int i = 0 ; i < deptList.size() ; i++ ){

	%>dname_arr.push( '<%=deptList.get( i ).getDname() %>' ) ;<%
	%>dno_arr.push( '<%=deptList.get( i ).getDno() %>' ) ;<%
	}%>
	
	
	for( var i = 0 ; i < dno_arr.length ; i++ ){
		var select_option = document.createElement( "option" ) ;
		select_option.setAttribute( "value" , dno_arr[ i ] ) ;
		var select_option_text = document.createTextNode( dname_arr[ i ] ) ;
		select_option.appendChild( select_option_text ) ;
		
		document.getElementById( selectName ).appendChild( select_option ) ;
	}
}

function seachWorker( keyword ){
	
}
</script>


</head>



<body>
<b>사원 추가</b>
<form name="insertform" action="insertWorkerProcess.jsp" method="post">
	<ul>
		<li>사번<input type="text" class="popUpInput" name="id" /></li>
		<li>이름<input type="text" class="popUpInput" name="name" /></li>
		<li>
			부서
			<select id="dept" name="dept" >
				<option>지역을 선택하세요.</option>
			</select>
		</li>
		
		<li>주소<input type="text" class="popUpInput" name="addr" /></li>
	</ul>
	<a href="javascript:insertform.submit()">입력완료</a>
	<a href = "javascript:window.close();">취소</a>
	<!-- <a href = "javascript:history.go(-1);">취소</a> -->
</form>
</body>
</html>