<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="register-box">
	<div class="card card-outline card-primary">
		<div class="card-body">
			<h1>회원가입</h1>
			
			<form action="/board/signup.do" method="post" id="signupForm">
				<div class="input-group mb-3">
					<input type="text" class="form-control" id="memId" name="memId" placeholder="아이디를 입력해주세요"> 
					<!-- <span class="input-group-append">
						<button type="button" class="btn btn-secondary btn-flat" id="idCheckBtn">중복확인</button>
					</span> -->
					<span class="error invalid-feedback" style="display:block;">${errors.memId }</span>
				</div>
				<div class="input-group mb-3">
					<input type="text" class="form-control" id="memPw" name="memPw" placeholder="비밀번호를 입력해주세요">
					<span class="error invalid-feedback" style="display:block;">${errors.memPw }</span>
				</div>
				<div class="input-group mb-3">
					<input type="text" class="form-control" id="memName" name="memName" placeholder="이름을 입력해주세요">
					<span class="error invalid-feedback" style="display:block;">${errors.memName }</span>
				</div>
				<div class="row">
					<div class="col-4">
						<button type="button" class="btn btn-primary btn-block" id="signupBtn">가입하기</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<br/>
	<div class="card card-outline card-secondary">
		<div class="card-header text-center">
			<button type="button" class="btn btn-secondary btn-block" onclick="javascript:location.href='/board/login.do'">뒤로가기</button>
		</div>
	</div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<c:if test="${not empty message }">
	<script type="text/javascript">
		alert("${message}");
		<c:remove var="message" scope="request"/>
		<c:remove var="message" scope="session"/>
	</script>
</c:if>

<script type="text/javascript">
$(function(){
	
	var idCheckBtn = $("#idCheckBtn");
	var signupBtn = $("#signupBtn");
	var signupForm = $("#signupForm");
		

	signupBtn.on("click", function() {
		var id = $("#memId").val();
		var pw = $("#memPw").val();
		var name = $("#memName").val();

		if (id == null || id == "") {
			alert("아이디를 입력해주세요.");
			return false;
		}
		if (pw == null || pw == "") {
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		if (name == null || name == "") {
			alert("이름을 입력해주세요.");
			return false;
		}
		
		signupForm.submit();
	});
});
</script>