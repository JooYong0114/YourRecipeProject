<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 - 너의 레시피는. </title>
<link rel="stylesheet" href="/static/css/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</head>
<body>
	<div id="wrap">
		<div id="loginBox" class="d-flex justify-content-center align-items-center" style="height:800px">
			<div class="d-flex flex-column justify-content-center align-items-center">
				<h1 class="display-4 text-warning d-flex align-items-center">
					<img src="https://www.urbanbrush.net/web/wp-content/uploads/edd/2018/06/web-20180616141645317419.png" class="mr-3" width=70px height=70px style="border-radius:100px">
					<b>너의 레시피는.</b>
				</h1>
				<h2 class="mt-5"><b>로그인</b></h2>
				<div>
					<input type="text" id="idInput" class="form-control mt-5 mb-2" name="loginId" placeholder="아이디" style="width:500px; height:60px">
					<input type="password" id="passwordInput" class="form-control mb-2" name="password" placeholder="비밀번호" style="width:500px; height:60px">
					<button type="submit" id="loginBtn" class="btn btn-success my-5 w-100" style="width:100px; height:60px"><b>로그인</b></button>
				</div>
				<div class="w-100 mb-4 d-flex justify-content-around align-items-center">
					<div><b>회원이 아니신가요?</b></div>
					<a href="/user/signup_view" class="btn btn-primary"><b>회원가입</b></a>
				</div>
			</div>
		</div>
	</div>
	
	<script>
		$(document).ready(function() {
			$("#loginBtn").on("click", function() {
				var id = $("#idInput").val();
				var password = $("#passwordInput").val();
				
				if(id == null || id == "") {
					alert("아이디를 입력하세요.");
					return;
				}
				
				if(password == null || password == "") {
					alert("비밀번호를 입력하세요.");
					return;
				}
			});
		});
	</script>
</body>
</html>