<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String code = request.getParameter("code");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>설문결과 조회</title>

<link rel="stylesheet" href="style/reset.css" />
<link rel="stylesheet" href="style/result_manage.css" />
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<script>
function changeResult() {
	var groupChk = $("input:radio[name='group']:checked").val();
	$('#resultBlock').load("srSubMenu.jsp",
			{
				page: "surveyResult",
				group: groupChk,
				code: "<%=code %>"
			});
}
</script>
</head>
<body>

<jsp:include page="../headerAdmin.jsp" >
	<jsp:param value="" name="menu"/>
</jsp:include>

<div class="resultManager" >

	<div class="wrapper">
		<div id="title" class="centerer">
			<h1>설문 결과 조회</h1>
		</div>
		<div id="radio_wrapper">
			<input type="radio" name="group" value="all" checked onclick="changeResult()" />전체출력&nbsp;&nbsp;
			<input type="radio" name="group" value="rater" onclick="changeResult()" />평가자별&nbsp;&nbsp;
			<input type="radio" name="group" value="ratee" onclick="changeResult()" />평가대상별&nbsp;&nbsp;
			<input type="radio" name="group" value="groupby" onclick="changeResult()" />부서별 최고득점&nbsp;&nbsp;
		</div>
	</div>
	<div id=resultBlock class="wrapper">
		<jsp:include page="srSubMenu.jsp" >
			<jsp:param name="page" value="surveyResult" />
			<jsp:param name="group" value="all" />
		</jsp:include>
	</div>

</div>
</body>
</html>