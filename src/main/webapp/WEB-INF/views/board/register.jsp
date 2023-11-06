<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.108.0">
<title>DDIT BOARD LIST</title>
<link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/album/">
<link href="${pageContext.request.contextPath }/resources/assets/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}

.b-example-divider {
	height: 3rem;
	background-color: rgba(0, 0, 0, .1);
	border: solid rgba(0, 0, 0, .15);
	border-width: 1px 0;
	box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em
		rgba(0, 0, 0, .15);
}

.b-example-vr {
	flex-shrink: 0;
	width: 1.5rem;
	height: 100vh;
}

.bi {
	vertical-align: -.125em;
	fill: currentColor;
}

.nav-scroller {
	position: relative;
	z-index: 2;
	height: 2.75rem;
	overflow-y: hidden;
}

.nav-scroller .nav {
	display: flex;
	flex-wrap: nowrap;
	padding-bottom: 1rem;
	margin-top: -1px;
	overflow-x: auto;
	text-align: center;
	white-space: nowrap;
	-webkit-overflow-scrolling: touch;
}
</style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<body>
<c:set value="등록" var="name"/>
<c:if test="${status eq 'u'}">
	<c:set value="수정" var="name"/>
</c:if>
	<header>
		<div class="collapse bg-dark" id="navbarHeader">
		</div>
		<div class="navbar navbar-dark bg-dark shadow-sm">
			<div class="container"></div>
		</div>
	</header>
	<main>
		<section class="py-5 text-center container">
			<div class="row py-lg-5">
				<div class="col-lg-6 col-md-8 mx-auto">
					<h1 class="fw-light">DDIT ${name }</h1>
				</div>
			</div>
		</section>
		<form class="album py-5 bg-light" action="" method="post" id="dditboard">
			<c:if test="${status eq 'u' }">
				<input type="hidden" name="boNo" value="${board.boNo }">
			</c:if>
			<div class="card">
			<div class="container">
					<div class="card-header">${name }</div>
					<div class="card-body">
						<div class="input-group input-group-lg">
							<span class="input-group-text" id="inputGroup-sizing-lg">제목</span>
							<input type="text" id="boTitle" class="form-control" name="boTitle" value="${board.boTitle }"/>
						</div>
						<div class="input-group input-group-lg">
							<span class="input-group-text" id="inputGroup-sizing-lg">내용</span>
							<textarea class="form-control" aria-label="With textarea" rows="12" id="boContent" name="boContent">${board.boContent }</textarea>
						</div>
						<div class="input-group input-group-lg">
							<span class="input-group-text" id="inputGroup-sizing-lg">태그</span>
								<input type="text" class="form-control" name="tag"
								value="<c:forEach items="${board.tagList }" var="tagList" >${tagList.tag } </c:forEach>"/>
						</div>
					</div>
					<div class="card-footer">
						<button type="button" class="btn btn-info" id="registerBtn" value="">${name }</button>
						<button type="button" class="btn btn-primary" id="listBtn">목록</button>
					</div>
				</div>
			</div>
		</form>
	</main>
	<footer class="text-muted py-5">
		<div class="container">
			<p class="float-end mb-1">
				<a href="">@DDIT</a>
			</p>
		</div>
	</footer>
	<script src="${pageContext.request.contextPath }/resources/assets/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<script type="text/javascript">
$(function(){
	var registerBtn = $("#registerBtn");
	var listBtn = $("#listBtn");
	var dditboard = $("#dditboard");
	
	var ws = new WebSocket("ws://localhost:8888/alarm");
	connect();
	
	registerBtn.on("click", function(){
		var boTitle = $("#boTitle").val();
		var boContent = $("#boContent").val();
		
		if(boTitle == null || boTitle == ""){
			alert("제목을 입력해주세요!");
			return false;
		}
		if(boContent == null || boContent == ""){
			alert("내용을 입력해주세요!");
			return false;
		}
		
		/*버튼 엘리먼트라서 text()  */
		if($(this).text() == "수정"){
			dditboard.attr("action", "/board/modify.do")
		}
		
		dditboard.submit();
	});
	
	listBtn.on("click", function(){
		location.href = "/board/list.do";
	});
	
	
	
	function connect(){
		/* 소켓 연결되었을 때 */
		ws.onopen = function(){
			ws.send("${member.memId}");
			wsSend();
			console.log("소켓 연결");
		};
		
		ws.onmessage = function(e) {
	 		console.log("핸들러에서 전송한 메세지", e.data);
		};
		
		ws.onclose = function(e){
			console.log("소켓 중단");
		};
		
		var wsSend = function(){
			setInterval(function() {
				// 3초마다 클라이언트로 메시지 전송
				ws.send("${member.memId}님이 게시물을 등록하였습니다.");
			}, 3000);
		}
	}
	 
	
	
});
</script>