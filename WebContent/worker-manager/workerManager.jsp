<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%@ page import="java.util.*" %>
<%@ page import="worker.WorkerDataBean" %>
<%@ page import="worker.WorkerDBBean" %>

<%

/*
☆☆☆☆이 부분에 세션 체크☆☆☆☆
*/
	
WorkerDBBean DBmanager = WorkerDBBean.getInstance() ;
ArrayList<WorkerDataBean> workerList = DBmanager.getWorkerlist2() ;

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<title>사원 관리</title>

<link rel="stylesheet" href="style/reset.css" />
<link rel="stylesheet" href="style/worker_manage.css" />
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">


<!-- jQuery Script 추가 //우찬수정 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
function closeLayer() {
	$('.popupLayer').css({
		"display": "none"
	});
}
$(function infoPageFunc() {
	$('.infoPage').click(function(e){
		var worker_id = $(this).text();
		
		$('.infoPart').load("infoWorker.jsp", {
			id: worker_id,
			layer: "layer"
		});
		
		var sWidth = window.innerWidth;
		var sHeight = window.innerHeight;
		
		var oWidth = $('.popupLayer').width();
		var oHeight = $('.popupLayer').height();
		
		var divLeft = e.clientX + 10;
		var divTop = e.clientY + 5;
				
		$('.popupLayer').css({
			"top": divTop,
			"left": divLeft,
			"position": "absolute",
			"display": "block",
		}).show();
	});
});
function searchPop() {
	var pop_title = "searchPopup";
	
	window.open("", pop_title, "width=250, height=200, location=no, status=no");
	var searchform = document.searchform;
	searchform.target = pop_title;
	searchform.action = "searchWorkerResult.jsp";
	
	searchform.submit();
}
</script>


</head>
<body>
<jsp:include page="../headerAdmin.jsp" >
	<jsp:param value="worker" name="menu"/>
</jsp:include>
<div class="workerManager">


<!-- Hidden Layer 추가 //우찬수정-->
<div class="popupLayer" style="display:none">
	<div class="infoPart">
	여긴 레이어~<br />
	클릭하면 바로 나타나는 레이어에요^*^~
	</div>
	<div style="text-align:right">
		<input type="button" style="margin:3px" onClick="closeLayer()" value="닫기"/>
	</div>
</div>


<div class="wrapper">
	<!--<form action="~~" method="post">  -->
	<div id="title" class="centerer">
		<h1>사원 관리</h1>
	</div>
	
	<!-- <h3><a href = "../main/adminMenu.jsp?id=admin">돌아가기</a></h3> -->
	<div class="righter">
		<form id="searchform" name="searchform" action="searchWorkerResult.jsp" method="post">
			<input type="text" class="searchInput" name="id" onkeypress="if(event.keyCode==13) {searchPop();}" />
			<a name="searchWorker" onclick="searchPop()" href="#">
				<i id="btn_search" class="fa fa-search" aria-hidden="true"></i>
			</a>
		</form>
	</div>
	<div class="middler">
		<form name="listform" action="#" method="post" class="listform">
			<table class="blueone">
				<tr><th></th><th>사원번호</th><th>부서</th><th>이름</th><th></th></tr>
				<%for( WorkerDataBean worker : workerList ) { %>
					<tr>
						<td></td>
						<td class="infoPage" ><%=worker.getId() %></td>
						<td><%=worker.getDept() %></td>
						<td><%=worker.getName() %></td>
						<td>
						
					<!-- 팝업띄우기로 변경 // 우찬수정 -->
							<a style="cursor:pointer" onclick="window.open('infoWorker.jsp?id=<%=worker.getId() %>', '사원 정보', 'width=250, height=200, location=no, status=no')" name="detailworker" class="btns">
								<i class="fa fa-info-circle" aria-hidden="true"></i>
							</a>
					<!-- 팝업띄우기로 변경 // 우찬수정 -->
							<a style="cursor:pointer" onclick="window.open('updateWorker.jsp?id=<%=worker.getId() %>', '사원 수정', 'width=250, height=200, location=no, status=no')" name="updateworker" id="editPage" class="btns">
								<i class="fa fa-pencil-square" aria-hidden="true"></i>
							</a>
							<a style="cursor:pointer" onclick="location.href='deleteWorker.jsp?id=<%=worker.getId()%>'" name="deleteWorker" class="btns">
								<i class="fa fa-minus-square" aria-hidden="true"></i>
							</a>
						</td>
					</tr>
				<%} %>
			</table>
		</form>
	</div>
<!-- 추가 역시 팝업으로 나오도록 변경 // 우찬수정 -->
	<input type="button" name="insertWorker" value="사원추가" onclick="window.open('insertWorker.jsp', '사원 추가', 'width=250, height=200, location=no, status=no')"> <!-- location.href='insertWorker.jsp'"> -->
	
	
</div>
</div>
</body>
</html>