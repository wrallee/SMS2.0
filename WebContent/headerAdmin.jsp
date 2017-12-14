<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="main/style/reset.css" />

<%
//세션 체크

if ((session.getAttribute("id")) == null || !( (session.getAttribute("id")).equals( "admin" ) ) ){
	out.println("<script> alert('어딜들어와!'); location.href = '/SMS2.0/start.jsp'; </script>");
}
int menuN = 0 ;	// 무슨 메뉴가 선택 되어 있어야 하는지
if( request.getParameter( "menu" ) != null ){
	String str = request.getParameter( "menu" ) ;
	if( request.getParameter( "menu" ).equals( "worker" ) ){
		menuN = 1 ;
	}else if( request.getParameter( "menu" ).equals( "survey" ) ) {
		menuN = 2 ;
	}else{
		menuN = 3 ;
	}
}

%>

<style>
#header *{
	color: #ffffff ;
}
#header{
	-webkit-app-region: drag;
    z-index: 5;
    position: absolute;
    top: 0px;
    left: 0px;
    right: 0px;
    height: 80px;
    box-shadow: 0 0 4px rgba(0,0,0,.14), 0 4px 8px rgba(0,0,0,.28);
    background-color: #4ab367;
    
    display: flex ;
	justify-content: center ;
    
}

#wrapper{
	width: 980px ;
}

#symbol{
	font-size: 50px ;
}

.menulink{
	font-size: 28px ;
}

#logout{
	font-size: 20px ;
	margin-left: 380px ;
	
}

#workerM{
	margin-left: 10px ;
}
#surveyM{
	margin-left: 10px ;
}

</style>

<%
switch( menuN ){
case 1 :
	out.println("<style>#workerM{ border-bottom: 4px solid #ffffff; }</style>");
	break ;
case 2 :
	out.println("<style>#surveyM{ border-bottom: 4px solid #ffffff; }</style>");
	break ;
} ;
%>


<div id="header">
	<div id="wrapper">
		<a id="symbol" href="/SMS2.0/start.jsp">SMS2</a>
		<a class="menulink" href="#" >관리자 : </a>
		<a id="workerM" class="menulink" href="../worker-manager/workerManager.jsp">사원관리</a>
		<a id="surveyM" class="menulink" href="../survey-manager/surveyMenu.jsp">설문관리</a>
		<a id="logout" style="cursor:pointer" onclick="location.href='../main/logout.jsp'">로그아웃</a>
	</div>
</div>


