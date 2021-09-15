<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - 너의 레시피는. </title>
<link rel="stylesheet" href="/static/css/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</head>
<body>
	<div id="wrap">
		<div id="signupBox" class="d-flex justify-content-center align-items-center" style="height:1000px">
			<div class="d-flex flex-column justify-content-center align-items-center">
				<h1 class="display-4 text-warning d-flex align-items-center">
					<img src="https://www.urbanbrush.net/web/wp-content/uploads/edd/2018/06/web-20180616141645317419.png" class="mr-3" width=70px height=70px style="border-radius:100px">
					<b>너의 레시피는.</b>
				</h1>
				<h2 class="mt-5"><b>회원가입</b></h2>
				<div>
					<div class="input-group mt-5 mb-2">
						<input type="text" id="idInput" class="form-control" name="loginId" placeholder="아이디" style="height:60px">
						<div class="input-group-append">
							<button type="button" id="idDuplicateConfirmBtn" class="btn btn-success" style="height:60px">중복확인</button>
						</div>
					</div>
					<div id="availableId" class="text-success mb-2 d-none">사용가능한 아이디 입니다.</div>
					<div id="duplicatedId" class="text-danger mb-2 d-none">중복된 아이디 입니다.</div>
					<input type="password" id="passwordInput" class="form-control mb-2" name="password" placeholder="비밀번호" style="height:60px">
					<div class="input-group mb-2">
						<input type="password" id="passwordComfirmInput" class="form-control" placeholder="비밀번호 확인" style="height:60px">
						<div class="input-group-append">
							<button type="button" id="passwordComfirmBtn" class="btn btn-success" style="height:60px">비밀번호 확인</button>
						</div>
					</div>
					<div id="correspondPassword" class="text-success mb-2 d-none">비밀번호가 일치합니다.</div>
					<div id="differentPassword" class="text-danger mb-2 d-none">비밀번호가 일치하지 않습니다.</div>
					<div class="input-group mb-2">
						<input type="text" id="nicknameInput" class="form-control" name="nickname" placeholder="닉네임" style="height:60px">
						<div class="input-group-append">
							<button type="button" id="nicknameDuplicateConfirmBtn" class="btn btn-success" style="height:60px">중복확인</button>
						</div>
					</div>
					<div id="availableNickname" class="text-success mb-2 d-none">사용가능한 닉네임 입니다.</div>
					<div id="duplicatedNickname" class="text-danger mb-2 d-none">중복된 닉네임 입니다.</div>
					<input type="text" id="emailInput" class="form-control mb-2" name="email" placeholder="이메일" style="width:500px; height:60px">
					<button type="submit" id="signupBtn" class="btn btn-success my-5 w-100" style="width:500px; height:60px"><b>가입하기</b></button>
				</div>
				<div class="w-100 mb-4 d-flex justify-content-around align-items-center">
					<div><b>회원 이신가요?</b></div>
					<a href="/user/signin_view" class="btn btn-primary"><b>로그인</b></a>
				</div>
			</div>
		</div>
	</div>
	
	<script>
		$(document).ready(function() {
			$("#idDuplicateConfirmBtn").on("click", function() {
				var loginId = $("#idInput").val();
				
				if(loginId == null || loginId == "") {
					alert("아이디를 입력하세요.");
					return;
				}
				
				$.ajax({
					type:"get",
					url:"/user/id_duplicate_check",
					data:{"loginId":loginId},
					success:function(data) {
						if(data.result == true) {
							$("#availableId").addClass("d-none");
							$("#duplicatedId").removeClass("d-none");
						}
						else {
							$("#availableId").removeClass("d-none");
							$("#duplicatedId").addClass("d-none");
						}
					},
					error:function(e) {
						alert("ajax error");
					}
				});
			});
			
			$("#passwordComfirmBtn").on("click", function() {
				var password = $("#passwordInput").val();
				var passwordConfirm = $("#passwordComfirmInput").val();
				
				
				if(password == passwordConfirm) {
					if(passwordConfirm == null || passwordConfirm == "") {
						alert("비밀번호 확인란을 입력하세요.");
					} 
					else {
						$("#correspondPassword").removeClass("d-none");
						$("#differentPassword").addClass("d-none");						
					}
				}
				else {
					$("#correspondPassword").addClass("d-none");
					$("#differentPassword").removeClass("d-none");
				}
			});
			
			$("#nicknameDuplicateConfirmBtn").on("click", function() {
				var nickname = $("#nicknameInput").val();
				
				if(nickname == null || nickname == "") {
					alert("닉네임을 입력하세요.");
					return;
				}
				
				$.ajax({
					type:"get",
					url:"/user/nickname_duplicate_check",
					data:{"nickname":nickname},
					success:function(data) {
						if(data.result == true) {
							$("#availableNickname").addClass("d-none");
							$("#duplicatedNickname").removeClass("d-none");
						}
						else {
							$("#availableNickname").removeClass("d-none");
							$("#duplicatedNickname").addClass("d-none");
						}
					},
					error:function(e) {
						alert("ajax error");
					}
				});
			});
			
			$("#signupBtn").on("click", function(event) {
				event.preventDefault();
				
				var loginId = $("#idInput").val().trim();
				var password = $("#passwordInput").val();
				var passwordConfirm = $("#passwordComfirmInput").val();
				var nickname = $("#nicknameInput").val().trim();
				var email = $("#emailInput").val().trim();
				
				if(loginId == null || loginId == "") {
					alert("아이디를 입력하세요.");
					$("#idInput").focus();
					return false;
				}
				
				if(password == null || password == "") {
					alert("비밀번호를 입력하세요.");
					$("#passwordInput").focus();
					return false;
				}
				
				if(passwordConfirm == null || passwordConfirm == "") {
					alert("비밀번호 확인란을 입력하세요.");
					alert(passwordConfirm);
					$("#passwordComfirmInput").focus();
					return false;
				}
				
				if(nickname == null || nickname == "") {
					alert("닉네임을 입력하세요.");
					$("#nicknameInput").focus();
					return false;
				}
				
				if(email == null || email == "") {
					alert("이메일을 입력하세요.");
					$("#emailInput").focus();
					return false;
				}
				
				$.ajax({
					type:"post",
					url:"/user/sign_up",
					data:{"loginId":loginId, "password":password, "nickname":nickname, "email":email},
					success:function(data) {
						if(data.result == "success") {
							alert("회원 가입 성공!");
							location.href="/user/signin_view";
						}
						else {
							alert("회원 가입 실패");
						}
					},
					error:function(e) {
						alert("ajax error");
					}
				});
			});
		});
	</script>
</body>
</html>