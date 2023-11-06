<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
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
<script src="/resources/js/jquery-3.6.0.js"></script>
<body>
	<header>
		<div class="collapse bg-dark" id="navbarHeader"></div>
		<div class="navbar navbar-dark bg-dark shadow-sm">
			<div class="container"></div>
		</div>
	</header>
	<main>
		<section class="py-5 text-center container">
			<div class="row py-lg-5">
				<div class="col-lg-6 col-md-8 mx-auto">
					<h1 class="fw-light">DDIT LIST</h1>
				</div>
			</div>
		</section>

		<div class="album py-5 bg-light">
			<div class="container">
				<form class="row g-3" method="post" id="searchForm">
					<input type="hidden" name="page" id="page"/>
					<div class="col-auto">
					
						<select class="form-select" name="searchType">
							<option value="title" <c:if test="${searchType eq 'title' }">selected</c:if>>제목</option>
							<option value="writer" <c:if test="${searchType eq 'writer' }">selected</c:if>>작성자</option>
							<option value="both" <c:if test="${searchType eq 'both' }">selected</c:if>>제목+작성자</option>
						</select>
					</div>
					<div class="col-auto">
						<label for="inputPassword2" class="visually-hidden">키워드</label>
						<input type="text" class="form-control" id="inputPassword2" value="${searchWord }" name="searchWord" placeholder="검색 키워드">
					</div>
					<div class="col-auto">
						<button type="submit" class="btn btn-primary mb-3">검색하기</button>
					</div>
				</form>
				<table class="table">
					<thead class="table-dark">
						<tr>
							<th scope="col" width="8%">번호</th>
							<th scope="col">제목</th>
							<th scope="col" width="14%">작성자</th>
							<th scope="col" width="16%">작성일</th>
							<th scope="col" width="8%">조회수</th>
						</tr>
					</thead>
					<tbody>
					<c:set value="${pagingVO.dataList }" var="boardList"/>
					<c:choose>
						<c:when test="${empty boardList }">
							<tr>
								<td colspan="5">조회하신 게시글이 존재하지 않습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
						<c:forEach items="${boardList }" var="board">
							<tr>
								<td>${board.boNo }</td>
								<td>
									<a href="/board/detail.do?boNo=${board.boNo }">${board.boTitle }</a>
								</td>
								<td>${board.boWriter }</td>
								<td>${board.boDate }</td>
								<td>${board.boHit }</td>
							</tr>	
						</c:forEach>
							
						</c:otherwise>
					</c:choose>
					</tbody>
				</table>
				<button type="button" class="btn btn-primary" id="registerBtn">등록</button>
				<div class="card-footer clearfix" id="pagigArea">
					${pagingVO.pagingHTML }
				</div>
			</div>
		</div>
	</main>
	<footer class="text-muted py-5">
		<div class="container">
			<p class="float-end mb-1">
				<a href="">@DDIT</a>
			</p>
		</div>
	</footer>
	<script src="${pageContext.request.contextPath }/assets/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<script type="text/javascript">
$(function(){
	var socket = null;
	
	var registerBtn = $("#registerBtn");
	var searchForm = $("#searchForm");
	var pagigArea = $("#pagigArea");
	
	pagigArea.on("click", "a", function(event){
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	registerBtn.on("click", function(){
		location.href = "/board/register.do";
	});
	
	
	
	
	/* $("#btnSend").on("click", function(event)){
		
	
		event.preventDefault();
		if(socket.readyState != 1) return;
		
		let msg = $("input#msg").val();
		socket.send(msg);
	}	  */
	
	
	
});
</script>