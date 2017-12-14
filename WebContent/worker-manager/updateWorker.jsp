<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="department.DepartmentDB" %>
<%@ page import="department.DepartmentBean" %>
<%@ page import="java.util.*" %>

<%

ArrayList<DepartmentBean> deptList = null ;
DepartmentDB manager= DepartmentDB.getInstance();
deptList = (ArrayList<DepartmentBean>) manager.getDeptlist() ;

%>
<%
Connection conn=null;
PreparedStatement pstmt=null;
ResultSet rs=null;
String id= null;
String info_id=request.getParameter("id");

String layer = request.getParameter("layer"); // 접근경로 판단을 위한 layer변수 요청(search / click)
try {
    
    Context init=new InitialContext();
    DataSource ds=(DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
    conn= ds.getConnection();
    
    pstmt= conn.prepareStatement("SELECT * FROM WORKER WHERE id=?");
    pstmt.setString(1, info_id);
    rs = pstmt.executeQuery();
    
} catch(SQLException e) {
    e.printStackTrace();
}
%> 

<%
 if( ! rs.next()) {
	 // 뭔가 대책이 필요할지도 모른다.
 } %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>사원 수정</title>
<link rel="stylesheet" href="style/worker_manage.css" />
<script type="text/javascript">
window.onload = function(){
	initSelect2( "dept" ) ;
}
function initSelect2( selectName ){
	
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
	document.getElementById( selectName ).value = "<%=rs.getString("dept") %>" ;
}

function seachWorker( keyword ){
	
}
</script>

</head>


    
<body>
<b>사원 수정</b>
<div class="normalList">
<form name="updateform" action="updateWorkerProcess.jsp" method="post">
	<ul>
		<li>사원번호 : <%=rs.getString("id") %></li>
		<li>이름<input type="text" class="popUpInput" name="name" value="<%=rs.getString("name") %>"/></li>
		
		<li>
			부서
			<select id="dept" name="dept" >
				<option>지역을 선택하세요.</option>
			</select>
		</li>
		
		<li>주소<input type="text" class="popUpInput" name="addr" value="<%=rs.getString("addr") %>"/></li>
	</ul>
	<input type="hidden" name="id" value="<%=rs.getString("id") %>" />
	<a href="javascript:updateform.submit()">입력완료</a>&nbsp;
	<!-- 취소 시 팝업 닫히도록 변경 // 우찬수정 -->
	<%if (layer == null) { %>
	<a href = "javascript:window.close();">취소</a>
	<%} else if (layer.equals("search")) { %>
	<a href = "javascript:history.go(-1);">뒤로가기</a>
	<%} %>
</form>
</div>
</body>
</html>