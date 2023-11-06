<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="login-box">
	<div class="card">
		<div class="card-body login-card-body">
			<h1>로그인을 진행해주세요</h1>

			<!-- 스프링 시큐리티에서는  action 경로는 /login username -->
			<form action="/board/loginCheck.do" method="post" id="signForm">
				<div class="input-group mb-3">
					<input type="text" class="form-control" id="memId" name="memId"  placeholder="아이디를 입력해주세요">
					<div class="input-group-append">
						<div class="input-group-text">
							<span class="fas fa-envelope"></span>
						</div>
					</div>
					<span class="error invalid-feedback" style="display:block;">${errors.memId }</span>
				</div>
				<div class="input-group mb-3">
					<input type="password" class="form-control" id="memPw" name="memPw" placeholder="비밀번호를 입력해주세요">
					<div class="input-group-append">
						<div class="input-group-text">
							<span class="fas fa-lock"></span>
						</div>
					</div>
					<span class="error invalid-feedback" style="display:block;">${errors.memPw }</span>
				</div>
				<div class="row">
					<div class="col-8">
						<div class="icheck-primary"></div>
					</div>
					<div class="col-4">
						<button type="button" class="btn btn-primary btn-block" id="loginBtn">로그인</button>
					</div>
				</div>
			</form>

			<p class="mb-0">
				<a href="/board/signup.do" class="text-center">회원가입</a>
			</p>
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
	var signForm =$("#signForm");
	var loginBtn =$("#loginBtn");
	
	loginBtn.on("click", function(){
		var id = $("#memId").val();
		var pw = $("#memPw").val();
		
		/* if(id == null || id == ""){
			alert("아이디를 입력해주세요");
			return false;
		}
		
		if(pw == null || pw == ""){
			alert("비밀번호를 입력해주세요");
			return false;
		}  */
		signForm.submit();
	});
});
</script>
