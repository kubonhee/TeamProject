<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset=UTF-8>
<title>2021. 5. 26.오후 5:03:13</title>
<link rel="stylesheet" href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
<script src='//unpkg.com/jquery@3/dist/jquery.min.js'></script>
<script src='//unpkg.com/popper.js@1/dist/umd/popper.min.js'></script>
<script src='//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js'></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
</head>
<body>
	<h2 style="text-align: center" id="name"></h2>
	<div class="container w-25" style="text-align: center;">
		<div class="m-5 p-5">
		    <a href="/"><img src="${pageContext.request.contextPath}/resources/img/core-img/logo.png" alt=""></a>
		</div>
		<div>	
			<form class="user" method="post" name="login"  action="${pageContext.request.contextPath}/naverTerms">
				<div class="form-group">
				     <input type="text" class="form-control" aria-describedby="emailHelp" id="userEmail" name="userEmail" placeholder="아이디">
				 </div>
				<div class="form-group">
				     <input type="password" class="form-control" id="userPw" name="userPw" placeholder="비밀번호">
				 </div>
				     <input type="hidden" class="form-control" id="oauthid" name="oauthid" value="${id}">
				 <button onclick="loginChk()" class="btn btn-danger btn-block">Login</button>
				 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			</form>
		</div>
		<div class="m-3">
			<a href="${pageContext.request.contextPath}/memberTerms">회원가입</a> / 
			<a href="${pageContext.request.contextPath}/#">아이디 찾기</a> / 
			<a href="${pageContext.request.contextPath}/#">비밀번호 찾기</a>
		</div>
	</div>
<script>
	function loginChk(){
		if(document.login.userEmail.value=="" || document.login.userEmail.value == null){
			alert("아이디를 입력하세요.");
		} else if(document.login.userPw.value=="" || document.login.userEmail.value == null){
			alert("비밀번호를 입력하세요.");
		}
	}
</script>	
<script type="text/javascript">
	 $(document).ready(function() {
		 var name = ${result}.response.name;
		 var email = ${result}.response.email;
		 var result = ${result}.response.name;
		 var id = ${result}.response.id;
		 $("#name").html("환영합니다. "+name+"님.");
		 $("#email").html(email);
		 $("#result").html(result);
	});
</script>
</body>
</html>