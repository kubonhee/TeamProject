<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title  -->
    <title>NEAR</title>
	
    <!-- Favicon  -->
    <link rel="icon" href="${pageContext.request.contextPath}/resources/img/android-icon-.png">

    <!-- Core Style CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/core-style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.css" integrity="sha512-rV4fiystTwIvs71MLqeLbKbzosmgDS7VU5Xqk1IwFitAM+Aa9x/8Xil4CW+9DjOvVle2iqg4Ncagsbgu2MWxKQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
     <!-- ##### jQuery (Necessary for All JavaScript Plugins) ##### -->
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" integrity="sha512-qTXRIMyZIFb8iQcfjXWCO8+M5Tbc38Qi5WzdPOYZHIlZpzBHG3L3by84BBBOiRGiEb7KKtAOAs5qYdUiZiQNNQ==" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/locale/ko.min.js" integrity="sha512-3kMAxw/DoCOkS6yQGfQsRY1FWknTEzdiz8DOwWoqf+eGRN45AmjS2Lggql50nCe9Q6m5su5dDZylflBY2YjABQ==" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <script src="https://code.jquery.com/jquery-1.12.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jq_ext.js"></script>
    
    
    <!-- bxSlider Javascript file --> 
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.js" integrity="sha512-p55Bpm5gf7tvTsmkwyszUe4oVMwxJMoff7Jq3J/oHaBk+tNQvDKNz9/gLxn9vyCjgd6SAoqLnL13fnuZzCYAUA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script> 
    
    <link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">
</head>

<body>



<!-- ?????? ???????????? ?????? ????????? ?????? ?????? ?????? ????????? ?????? ???????????? ?????? -->
<!-- Image Modal-->
<div class="modal fade" id="imageModal">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-body text-center imageModalBody">
            	<img class="mw-100">
            </div>
        </div>
    </div>
</div>

 <!-- Result Modal-->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true" >
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="myModalLabel">REPLY MODAL</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">??</span>
                    </button>
                </div>
                <div class="modal-body">
                <form method="post" class="needs-validation" novalidate>
				   <div class="form-group">
				      <label for="reply" class="font-weight-bold text-warning">reply</label>
				      <input type="text" class="form-control" id="reply" name="reply" required placeholder="????????? ??????????????????">
				      <div class="valid-feedback">Valid.</div>
					  <div class="invalid-feedback">Please fill out this field.</div>
				   </div>
				   <div class="form-group">
				      <label for="replyer" class="font-weight-bold text-warning">replyer</label>
				      <input type="text" class="form-control" id="replyer" name="replyer" required placeholder="?????????">
				      <div class="valid-feedback">Valid.</div>
					  <div class="invalid-feedback">Please fill out this field.</div>
				   </div>
				   <div class="form-group">
				      <label for="replyDate" class="font-weight-bold text-warning">replyDate</label>
				      <input type="text" class="form-control" id="replyDate" name="replyDate" required placeholder="2021-01-01 13:50">
				      <div class="valid-feedback">Valid.</div>
					  <div class="invalid-feedback">Please fill out this field.</div>
				   </div>
				</form>
				</div>
                <div class="modal-footer">
                    <button id="modalModBtn" class="btn btn-outline-success btn-sm ac" type="button" data-dismiss="modal">Modify</button>
                    <button id="modalRemoveBtn" class="btn btn-outline-danger btn-sm ac " type="button" data-dismiss="modal">Remove</button>
                    <button id="modalRegBtn" class="btn btn-outline-success btn-sm ac" type="button" data-dismiss="modal">Register</button>
                    <button id="modalCloseBtn" class="btn btn-outline-secondary btn-sm " type="button" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    
	<!-- ????????? ??????  -->
	<sec:authentication property="principal" var="member" />
	<!-- Nav Item - User Information -->
	<div style="text-align: right;">
		<a class="nav-link dropdown-toggle mt-3" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
			<span
				class="mr-2 d-none d-lg-inline" style="font-size: 15px;"> <%-- ${member} --%>
					${member == 'anonymousUser' ? 'Not Login' : member.vo.userName}
			</span>
		</a> 
		<!-- Dropdown - User Information -->
		<div class="dropdown-menu shadow dropdown-menu-right" aria-labelledby="userDropdown" style="text-align: center;">
			<sec:authentication property="principal" var="member"/>
	        <sec:authorize access="isAnonymous()">
				<a class="dropdown-item" href="${pageContext.request.contextPath}/memberTerms">????????????</a>
				<a class="dropdown-item" href="${pageContext.request.contextPath}/naverLogin">?????????</a>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<a class="dropdown-item" href="${pageContext.request.contextPath}/memberInfo">
					?????????
				</a>
				<div class="dropdown-divider"></div>
				<form method="post" action="${pageContext.request.contextPath}/memberLogout">
					<button class="dropdown-item">
						<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
						????????????
					</button>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				</form>
			</sec:authorize>
		</div>
	</div>
	
	<!-- ?????????????????? -->
	<!-- Logo -->
	<div id="dataTable_filter" style="text-align: center;">
		<a href="${pageContext.request.contextPath}/board/list">
			<img src="${pageContext.request.contextPath}/resources/img/core-img/mainlogo.png" style="width: 230px; margin-bottom: 20px;" alt="">
		</a>
	</div> 

    <!-- ##### Main Content Wrapper Start ##### -->
    <div class="main-content-wrapper d-flex clearfix">

        <!-- Mobile Nav (max width 767px)-->
        <div class="mobile-nav">
            <!-- Navbar Brand -->
            <div class="amado-navbar-brand">
                <a href="${pageContext.request.contextPath}/board/list"><img src="${pageContext.request.contextPath}/resources/img/core-img/logo.png" alt=""></a>
            </div>
            <!-- Navbar Toggler -->
          <div class="amado-navbar-toggler">
                <span></span><span></span><span></span>
            </div> 
        </div>
        <!-- Header Area Start -->
        <header class="header-area clearfix">
            <!-- Close Icon -->
            <div class="nav-close">
                <i class="fa fa-close" aria-hidden="true"></i>
            </div>
		
            <!-- Amado Nav -->
            <nav class="amado-nav">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/board/register" class="mb-10" style="">????????????</a></li>
                    <li class="active"><a href="/">Home</a></li>
                    
                    <c:if test="${member != 'anonymousUser'}">
                    	<li><a href="${pageContext.request.contextPath}/nearList">Near</a></li> 
                    </c:if>
                    <li><a href="${pageContext.request.contextPath}/board/category?cate=1">????????????/??????</a></li>
                    <li><a href="${pageContext.request.contextPath}/board/category?cate=2">????????????/??????</a></li>
                    <li><a href="${pageContext.request.contextPath}/board/category?cate=3">?????????/??????</a></li>
                    <li><a href="${pageContext.request.contextPath}/board/category?cate=4">??????/??????</a></li>
                    <li><a href="${pageContext.request.contextPath}/board/category?cate=5">?????????/??????</a></li>
                    <li><a href="${pageContext.request.contextPath}/board/category?cate=6">????????????</a></li>
                    <li><a href="${pageContext.request.contextPath}/board/category?cate=7">????????????</a></li>
                    <li><a href="${pageContext.request.contextPath}/board/category?cate=8">??????/??????</a></li>
                    <li><a href="${pageContext.request.contextPath}/board/category?cate=9">??????/????????????</a></li>
                    <li><a href="${pageContext.request.contextPath}/board/category?cate=10">????????????</a></li>
                </ul>
            </nav>
           
            <!-- Social Button -->
            <div class="social-info d-flex justify-content-between">
                <a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
            </div>
        </header>
<script>
$(".main").click(function(){
    if($(".sub").is(":visible")){
        $(".sub").slideUp();
    }
    else{
        $(".sub").slideDown();
    }
})
</script>
<!-- Header Area End -->
