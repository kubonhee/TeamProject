<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset=UTF-8">
<title>Amado - Furniture Ecommerce Template | Home</title>
<link rel="stylesheet" href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
<script src='${pageContext.request.contextPath}//unpkg.com/jquery@3/dist/jquery.min.js'></script>
<script src='${pageContext.request.contextPath}//unpkg.com/popper.js@1/dist/umd/popper.min.js'></script>
<script src='${pageContext.request.contextPath}//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js'></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>

    <!-- Favicon  -->
    <link rel="icon" href="${pageContext.request.contextPath}/resources/img/core-img/favicon.ico">
    <!-- Core Style CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/${pageContext.request.contextPath}resources/css/core-style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}resources/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/info-style.css">
</head>
<body style="background-color: #f5f5f5;">
	<!-- 로그인 상태  -->
	<sec:authentication property="principal" var="member" />
	<!-- Nav Item - User Information -->
	<%-- <div style="text-align: right;">
		<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
			<span
				class="mr-2 d-none d-lg-inline" style="font-size: 15px;"> ${member}
					${member == 'anonymousUser' ? 'Not Login' : member.vo.userName}
			</span>
		</a> 
		<!-- Dropdown - User Information -->
		<div class="dropdown-menu shadow dropdown-menu-right" aria-labelledby="userDropdown" style="text-align: center;">
			<sec:authentication property="principal" var="member"/>
	        <sec:authorize access="isAnonymous()">
				<a class="dropdown-item" href="${pageContext.request.contextPath}/memberTerms">회원가입</a>
				<a class="dropdown-item" href="${pageContext.request.contextPath}/naverLogin">로그인</a>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<a class="dropdown-item" href="${pageContext.request.contextPath}/memberInfo">
					프로필
				</a>
				<div class="dropdown-divider"></div>
				<form method="post" action="/memberLogout">
					<button class="dropdown-item">
						<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
						로그아웃
					</button>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				</form>
			</sec:authorize>
		</div --%>>
	</div>
	
	<div style="text-align: center;">
		<a href="${pageContext.request.contextPath}/board/list"><img style="width: 230px;" src="${pageContext.request.contextPath}/resources/img/core-img/memberLogo.png" alt=""></a>
	</div>
	<hr>
	<div class="container" style="width: 600px;">
		<div class="p-5" style="background-color: #ffffff; border-radius: 20px;">
			<div>
				<form action="${pageContext.request.contextPath}/memberInfo" method="get">
					<sec:authentication property="principal" var="member" />
					<div style="margin: 0 auto; width: 500px; height:452px;">
						<H2>프로필</H2><br>
						<table style="margin: 0 auto;">
							<tr style="height: 40px;">
								<td style="width: 140px">아이디<td>
								<td>${member.vo.userEmail}</td>
							</tr>
							<tr>
								<td>이름<td>
								<td>${member.vo.userName}</td>
							</tr>
							<tr>
								<td>생년월일<td>
								<td>${member.vo.birthDate}</td>
							</tr>
							<tr>
								<td>우편번호<td>
								<td>${member.vo.postCode}</td>
							</tr>
							<tr>
								<td>주소<td>
								<td>${member.vo.roadAddress}</td>
							</tr>
							<tr>
								<td>지번<td>
								<td>${member.vo.jibunAddress}</td>
							</tr>
							<tr>
								<td>상세주소<td>
								<td>${member.vo.extraAddress}</td>
							</tr>
							<tr>
								<td>계정 생성일<td>
								<td>${member.vo.regDate}</td>
							</tr>
						</table>
					</div>
					<div class="mt-4" style="text-align: center;">
						<a href="${pageContext.request.contextPath}/memberModify">
							<button class="btn btn-warning cencle text-light" type="button" onclick="modify()" style="width: 366px; height: 38px;">정보 수정</button>
						</a>
					</div>
				</form>
			</div>
		<div>
			<form action="/memberRemove" method="post" name="removeForm" onsubmit="return confirm('정말 삭제하시겠습니까?')">
			<sec:authentication property="principal" var="member" />
				<div class="d-none">
			 		<label class="control-label" for="userEmail"></label>
			 		<input readonly="readonly" class="form-control" id="userEmail" name="userEmail" value="${member.vo.userEmail}">
		 		</div>
		 		<div class="mt-2" style="text-align: center;">
					<button class="btn btn-danger text-light" id="submit" style="width: 366px; height: 38px;">회원정보 삭제</button>
		 		</div>
		 		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			</form>
		</div>
		</div>
	</div>
	
	
	<!-- ##### Footer Area Start ##### -->
    <footer class="footer_area clearfix" style="margin-top: 200px;">
        <div class="container">
            <div class="row align-items-center">
                <!-- Single Widget Area -->
                <div class="col-12 col-lg-4">
                    <div class="single_widget_area">
                        <!-- Logo -->
                        <div class="footer-logo mr-50">
                            <a href="${pageContext.request.contextPath}/board/list"><img src="${pageContext.request.contextPath}/resources/img/core-img/logo2.png" alt=""></a>
                        </div>
                        <!-- Copywrite Text -->
                        <p class="copywrite"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a> & Re-distributed by <a href="https://themewagon.com/" target="_blank">Themewagon</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
                    </div>
                </div>
                <!-- Single Widget Area -->
                <div class="col-12 col-lg-8">
                    <div class="single_widget_area">
                        <!-- Footer Menu -->
                        <div class="footer_menu">
                            <nav class="navbar navbar-expand-lg justify-content-end">
                                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#footerNavContent" aria-controls="footerNavContent" aria-expanded="false" aria-label="Toggle navigation"><i class="fa fa-bars"></i></button>
                                <div class="collapse navbar-collapse" id="footerNavContent">
                                    <ul class="navbar-nav ml-auto">
                                        <li class="nav-item active">
                                            <a class="nav-link" href="index.html">Home</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="shop.html">Shop</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="product-details.html">Product</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="cart.html">Cart</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="checkout.html">Checkout</a>
                                        </li>
                                    </ul>
                                </div>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- ##### Footer Area End ##### -->

    <!-- ##### jQuery (Necessary for All JavaScript Plugins) ##### -->
    <script src="${pageContext.request.contextPath}resources/js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="${pageContext.request.contextPath}resources/js/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="${pageContext.request.contextPath}resources/js/bootstrap.min.js"></script>
    <!-- Plugins js -->
    <script src="${pageContext.request.contextPath}resources/js/plugins.js"></script>
    <!-- Active js -->
    <script src="${pageContext.request.contextPath}resources/js/active.js"></script>
	
	<script>
		function modify(){
			alert("회원정보를 수정합니다.");
		}
	</script>
