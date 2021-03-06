<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- Favicon  -->
    <link rel="icon" href="${pageContext.request.contextPath}/resources/img/core-img/favicon.ico">
    
    <!-- Core Style CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/core-style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
		</div>
	</div> --%>
	
	<!-- Logo -->
	<div id="dataTable_filter" style="text-align: center;" class="mt-4">
		<a href="${pageContext.request.contextPath}/board/list">
			<img style="width: 230px;" src="${pageContext.request.contextPath}/resources/img/core-img/memberLogo.png">
		</a>
	</div>
	<hr>
	<div class="p-5" style="width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 5%;">
		<form action="${pageContext.request.contextPath}/memberModify" method="post">
		
			<sec:authentication property="principal" var="member" />
		 	<div>
		 		<label class="control-label" for="userEmail">아이디</label>
		 		<input readonly="readonly" class="form-control" type="text" id="userEmail" name="userEmail" value="${member.vo.userEmail}">
		 	</div>
		 	<div>
		 		<label class="control-label" for="userPw">비밀번호</label>
		 		<input class="form-control" type="text" id="userPw" name="userPw" placeholder="비밀번호">
		 	</div>
		 	<div>
		 		<label class="control-label" for="userName">이름</label>
		 		<input class="form-control" type="text" id="userName" name="userName" placeholder="이름">
		 	</div>
		 	<div>
		 		<label class="control-label" for="roadAddress">도로명 주소</label>
		 		<input class="form-control" type="text" id="roadAddress" name="roadAddress">
		 	</div>
		 	<div>
		 		<input style="background-color: #bdbdbd;" type="button" class="form-control" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
		 	</div>
		 	<div>
		 		<label class="control-label" for="postCode">우편 번호</label>
			    <input type="text" class="form-control" id="postCode" name="postCode" placeholder="우편번호"/>
			</div>
			<div>
				<label class="control-label" for="jibunAddress">지번 주소</label>
			    <input type="text" class="form-control" id="jibunAddress" name="jibunAddress" placeholder="지번주소"/>
			</div>
			<div>
				<label class="control-label" for="extraAddress">참고 항목</label>
		    	<input type="text" class="form-control" id="extraAddress" name="extraAddress" placeholder="참고항목"/>
			</div>
			<span id="guide" class="" style="color:#999;display:none"></span>
			<div>
				<label class="control-label" for="birthDate">생년 월일</label> 
				<input type="text" class="form-control" id="birthDate" name="birthDate" placeholder="생년월일" />
			</div>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<div class="mb-2 mt-3" style="text-align: center;">
			 	<button style="width: 366px; height: 38px;" class="btn btn-warning text-light" type="submit" id="submit">회원정보 수정</button>
			</div>
			<div style="text-align: center;">
				<a href="${pageContext.request.contextPath}/board/list">
				 	<button style="width: 366px; height: 38px;" class="cencle btn btn-danger" type="button" onclick="cencle()">취소</button>
				</a>
			</div>
		</form>
	</div>
	<script>
		function cencle() {
			alert("개인정정보 수정을 취소합니다.");
		}
	</script>
	 
	<script>
	   var csrfParameterName ="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";
	  $(function() {
	$(document).ajaxSend(function(e, xhr){
		xhr.setRequestHeader(csrfParameterName,csrfTokenValue);
	}); 
		
	      //input을 datepicker로 선언
	      $("#birthDate").datepicker({
	          dateFormat: 'yy-mm-dd' //달력 날짜 형태
	          ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	          ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
	          ,changeYear: true //option값 년 선택 가능
	          ,changeMonth: true //option값  월 선택 가능                
	          ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
	          ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	          ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
	          ,buttonText: "선택" //버튼 호버 텍스트              
	          ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
	          ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
	          ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
	          ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
	          ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
	          ,minDate: "-100Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	          ,maxDate: "+0y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후) 
			,yearRange:"-100:+0" /*2009 ~ 2119*/
	      });                    
	      
	      //초기값을 오늘 날짜로 설정해줘야 합니다.
	      $('#birthDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
	  });
	</script>
	
	<script>
	//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
		function execDaumPostcode() {
		    new daum.Postcode({
		        oncomplete: function(data) {
		            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		
		            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
		            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		            var roadAddr = data.roadAddress; // 도로명 주소 변수
		            var extraRoadAddr = ''; // 참고 항목 변수
		
		            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                extraRoadAddr += data.bname;
		            }
		            // 건물명이 있고, 공동주택일 경우 추가한다.
		            if(data.buildingName !== '' && data.apartment === 'Y'){
		               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		            }
		            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		            if(extraRoadAddr !== ''){
		                extraRoadAddr = extraRoadAddr;
		            }
		
		            // 우편번호와 주소 정보를 해당 필드에 넣는다.
		            document.getElementById('postCode').value = data.zonecode;
		            document.getElementById("roadAddress").value = roadAddr;
		            document.getElementById("jibunAddress").value = data.jibunAddress;
		            
		            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
		            if(roadAddr !== ''){
		                document.getElementById("extraAddress").value = extraRoadAddr;
		            } else {
		                document.getElementById("extraAddress").value = '';
		            }
		
		            var guideTextBox = document.getElementById("guide");
		            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
		            if(data.autoRoadAddress) {
		                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
		                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
		                guideTextBox.style.display = 'block';
		
		            } else if(data.autoJibunAddress) {
		                var expJibunAddr = data.autoJibunAddress;
		                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
		                guideTextBox.style.display = 'block';
		            } else {
		                guideTextBox.innerHTML = '';
		                guideTextBox.style.display = 'none';
		            }
		        }
		    }).open();
		}
	</script>
</body>
</html>