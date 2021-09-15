<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나만의 레시피 작성 - 너의 레시피는.</title>
<link rel="stylesheet" href="/static/css/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<style>
	#editor img {
		max-width:100%;
		max-height:50%;
	}
</style>
</head>
<body>
	<div id="wrap">
		<div id="loginBox" class="d-flex justify-content-center align-items-center">
			<div class="d-flex flex-column justify-content-center align-items-center">
				<h1 class="display-4 text-warning d-flex align-items-center">
					<img src="https://www.urbanbrush.net/web/wp-content/uploads/edd/2018/06/web-20180616141645317419.png" class="mr-3" width=70px height=70px style="border-radius:100px">
					<b>너의 레시피는.</b>
				</h1>
				<h2 class="mt-5"><b>나만의 레시피 작성</b></h2>
				<div class="d-flex flex-column">
					<div class="d-flex justify-content-center align-items-center mt-5">
						<label style="font-size:20px;"><b>레시피명</b></label>
						<input type="text" id="titleInput" class="form-control ml-5" style="width:300px; height:50px">
					</div>
					<div class="d-flex justify-content-center align-items-center mt-3">
						<label style="font-size:20px;"><b>대표 이미지</b></label>
						<input type="file" id="fileInput" class="ml-5">
					</div>
					<div class="d-flex flex-column justify-content-center align-items-center mt-5">
						<h4><b>레시피 상세내용 입력</b></h4>
						<div id="editorMenu" class="d-flex mt-3 bg-warning p-2" style="border:1px solid gray; width:700px;">
						<button id="boldBtn" class="btn mr-2"><b>가</b></button>
						<button id="italicBtn" class="btn mr-2"><i>가</i></button>
						<button id="underlineBtn" class="btn mr-2"><u>가</u></button>
						<button id="strikeBtn" class="btn mr-2"><s>가</s></button>
						<button id="imageBtn" class="btn">이미지</button>
						<input id="imageInput" type="file" accept="image/*" class="d-none">
						</div>
						<div id="editor" class="p-3" contentEditable="true" name="content" style="border:1px solid gray; width:100%; height:30%;">
						</div>
					</div>
					<div class="d-flex justify-content-end">
						<button type="submit" id="submitBtn" class="btn btn-primary mt-3" style="width:100px; height:40px;"><b>작성 완료</b></button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$("#boldBtn").on("click", function() {
			setStyle("bold");
		});
		
		$("#italicBtn").on("click", function() {
			setStyle("italic");
		});
		
		$("#underlineBtn").on("click", function() {
			setStyle("underline");
		});

		$("#strikeBtn").on("click", function() {
			setStyle("strikeThrough");
		});
		
		function setStyle(style) {
			document.execCommand(style);
			editor.focus({preventScroll : true});
		}

		$("#imageBtn").on("click", function() {
			$("#imageInput").click();
		});
		
		$("#imageInput").on('change', function (e) { 
			const files = e.target.files; 
			if (!!files) { 
				insertImage(files[0]); 
			} 
		}); 
		
		function insertImage(file) { 
			const reader = new FileReader(); 
			reader.onload = function(e) { 
				editor.focus({preventScroll : true});
				document.execCommand('insertImage', false, reader.result);
			}
			reader.readAsDataURL(file); 
		}
		
		$("#submitBtn").on("click", function(e) {
			e.preventDefault();
			
			var title = $("#titleInput").val();
			var recipeImg = $("#fileInput")[0].files[0];
			var content = $("#editor").html();			
			
			if(title == null || title == "") {
				alert("레시피명을 입력하세요.");
				return false;
			}
			
			if(recipeImg == null) {
				alert("대표 이미지를 추가하세요.");
				return false;
			}
			
			if(content == null || content == "") {
				alert("레시피 상세내용을 입력하세요.");
				return false;
			}
			
			var formData = new FormData();
			formData.append("title", title);
			formData.append("file", recipeImg);
			formData.append("content", content);
			
			$.ajax({
				enctype:"multipart/form-data",
				type:"post",
				url:"/recipe/write",
				processData:false,
				contentType:false,
				data:formData,
				success:function(data) {
					if(data.result == "success") {
						alert("레시피 작성 성공!");
						// location.href="";
					}
					else {
						alert("레시피 작성에 실패 했습니다.");
					}
				},
				error:function(e) {
					alert("ajax error");
				}
			});
		});
	});
</script>
</html>