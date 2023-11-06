<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link href="${pageContext.request.contextPath }/resources/assets/dist/css/bootstrap.min.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<a class="nav-link nav-icons" href="javascript:void(0);" id="navbarDropdownMenuLink1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		<i class="fas fa-fw fa-bell"></i>
		<input type="hidden" value="${loginUser.memId }" id="memIdSpan">
		<span class="indicator" id="alarmIcon" style="display:none;"></span>
	</a>
</body>

<script type="text/javascript">

window.onload = function(){
	var webSocket = new WebSocket("ws://localhost:8888/alarm");
	 
	webSocket.onopen = function(){
		/* webSocket.send("${loginUser.memId}");
		wsSend(); */
		console.log("연결");
	}
	
	webSocket.onmessage = function(e) {
// 		console.log("핸들러에서 전송한 메세지",e.data);
		var v_alarmIcon = document.querySelector("#alarmIcon");
		v_alarmIcon.style.display = 'inline';

	}
	
	var wsSend = function(){
		setInterval(function() {
			// 3초마다 클라이언트로 메시지 전송
			webSocket.send("${loginUser.memId}");
		}, 3000);
	}
}
</script>
</html>