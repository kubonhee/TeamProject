<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset=UTF-8">
<title>2021. 5. 26.오후 5:03:13</title>
<link rel="stylesheet" href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
<script src='//unpkg.com/jquery@3/dist/jquery.min.js'></script>
<script src='//unpkg.com/popper.js@1/dist/umd/popper.min.js'></script>
<script src='//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js'></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
</head>
<body>
	<div class="container w-25" style="text-align: center;">
		<div class="p-5 mt-5 mb-5">
		    <a href="${pageContext.request.contextPath}/board/list"><img class="" style="width: 230px;" src="${pageContext.request.contextPath}/resources/img/core-img/memberLogo.png" alt=""></a>
		</div>
		<div>	
			<form class="user" method="post" name="login"  action="${pageContext.request.contextPath}/login">
				<div class="form-group">
			    	<input type="text" class="form-control" aria-describedby="emailHelp" id="username" name="username" placeholder="아이디">
				</div>
			 	<div class="form-group">
			    	<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">
				</div>
				<button onclick="loginChk()" class="btn btn-danger btn-block">Login</button>
				<div id="naver_id_login" class="mt-2">
					<a class="btn btn-outline-success btn-block" href="${url}">NAVER LOGIN</a>
				</div>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			</form>
		</div>
		<div class="mt-2">
			<a class="btn btn-outline-warning btn-block" href="${pageContext.request.contextPath}/memberTerms">회원가입</a>
		</div>
	</div>
	<script>
		function loginChk(){
			if(document.login.username.value=="" || document.login.username.value == null){
				alert("아이디를 입력하세요.");
			}else if(document.login.password.value=="" || document.login.username.value == null){
				alert("비밀번호를 입력하세요.");
			}
		}
	</script>	
</body>
</html>