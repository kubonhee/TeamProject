<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title  -->
    <title>Amado - Furniture Ecommerce Template | Checkout</title>

    <!-- Favicon  -->
    <link rel="icon" href="${pageContext.request.contextPath}/resources/img/core-img/favicon.ico">

    <!-- Core Style CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/core-style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mycss.css">
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body class="bg-gradient joinwrapper">
	<div class="cart-table-area section-padding-100">
		<div class="container" style="text-align: center;">
			<div>
    			<a href="${pageContext.request.contextPath}/board/list"><img style="width: 200px;" src="${pageContext.request.contextPath}/resources/img/core-img/memberLogo.png" alt=""></a>
			</div>
			<hr>
			<h1>회원가입</h1>
			<h3>Amad 회원가입을 통하여 여러 사람들과 거래하세요!</h3>
			<hr>
			<div class="checkout_details_area mt-50 container">
				<form method="post">
					<div class="form-row">
						<div class="form-group col-9 mb-3">
							<input type="text" style="background-color:#e9e9e9" class="form-control" id="receiveMail" placeholder="이메일">
						</div>
						<div class="form-group col-3 mb-3">
							<input style="height: 60px;" type="button" class="btn btn-warning text-light font-weight-bold" id="btnSend" value="인증번호 발송"><br>
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-9 mb-3" id="pinCodeDiv" style="display: none;">
							<input type="text" style="background-color:#e9e9e9" class="form-control" id="pinCode" placeholder="인증번호"/>
						</div>
						<div class="form-group col-3 mb-3" id="btnConfirmDiv" style="display: none;">
							<input style="height: 60px;" onclick="confimChek()" type="button" class="btn btn-warning text-light font-weight-bold" id ="btnConfirm" value="인증번호 확인"/>
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-12 mb-3">
							<label for="userEmail" ></label> 
							<input style="background-color:#e9e9e9" type="text" class="form-control"  id="userEmail" placeholder="아이디" />
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-12 mb-3">
							<label for="userPw"></label> 
							<input type="password" style="background-color:#e9e9e9" class="form-control"  id="userPw" placeholder="비밀번호" />
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-12 mb-3">
							<label for="name"></label> 
							<input type="text" style="background-color:#e9e9e9" class="form-control"  id="userName" placeholder="이름" />
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-9 mb-3">
							<input readonly="readonly" type="text" style="background-color:#e9e9e9" class="form-control" id="roadAddress" placeholder="도로명주소"/>
						</div>
						<div class="form-group col-3 mb-3">
							<input style="height: 60px;" type="button" class="btn btn-warning text-light font-weight-bold" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
						</div>
					</div>
					<div class="form-row">
						<div class="col-12 mb-3 mt-3">
							<input readonly="readonly" type="text" style="background-color:#e9e9e9" class="form-control" id="postCode" placeholder="우편번호"/>
						</div>
					</div>
					<div class="form-row">
						<div class="col-12 mb-3">
							<input readonly="readonly" type="text" style="background-color:#e9e9e9" class="form-control" id="jibunAddress" placeholder="지번주소"/>
						</div>
					</div>
					<div class="form-row">
						<div class="col-12 mb-3">
							<input readonly="readonly" type="text" style="background-color:#e9e9e9" class="form-control" id="extraAddress" placeholder="상세주소"/>
						</div>
					</div>
	
					<!-- <div class="container mapBox d-lg-none" id="mapView"> -->
					<hr>
						<p>앞으로 거래하실 장소를 표시해주세요</p>
					<hr>
					<div class="form-row">
						<div class="container mapBox form-group col-12" id="mapView">
		                	<div id="map" style="min-height:500px"></div>
			               	<input type="hidden" id="latitude" name="latitude">
			               	<input type="hidden" id="longitude" name="longitude">
			               	<input type="hidden" id="detailaddr" name="detailaddr">
						</div>
					</div>
					
					<span id="guide" class="" style="color:#999;display:none"></span>
					<div class="form-row">
						<div class="col-12 mb-3">
							<label for="birthDate"></label> 
							<input type="text" style="background-color:#e9e9e9" class="form-control" id="birthDate" placeholder="생년월일" />
						</div>
					</div>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">	
				</form>
			</div>
			<div class="container">
				<div class="form-row">
					<div class="col-12 mb-3 mt-3">
						<input type="button" class="btn btn-warning btn-lg form-control text-white font-weight-bold" id="btnSave"  value="회원가입"><br>
					</div>
				</div>
				<div class="form-row">
					<div class="col-12 mb-3">
						<a href="${pageContext.request.contextPath}/board/list">
							<button class="cencle btn btn-secondary btn-lg form-control text-white font-weight-bold" type="button">취소</button>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/resources/js/member.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/email.js"></script>
	<script src="${pageContext.request.contextPath}//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0e5e76b0333590c8c5bce62444180f85&libraries=services"></script>
	<script type="text/javascript">
		$("#btnJoin").click(function() {
			event.preventDefault();
			
			$("#latitude").val(globalCoords.lat);
			$("#longitude").val(globalCoords.lng);
			console.log($(this).closest("form").serialize());
		})
		
		var globalCoords = {};
		var mapContainer = document.getElementById('map'); // 지도를 표시할 div
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		var marker, map, infowindow;
		
		navigator.geolocation.getCurrentPosition(function(pos) {
			
		mapOption = { 
	        center: new kakao.maps.LatLng(pos.coords.latitude, pos.coords.longitude), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
		map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		// 마커가 표시될 위치입니다 
		var markerPosition = new kakao.maps.LatLng(pos.coords.latitude, pos.coords.longitude); 
		
		// 마커를 생성합니다
		marker = new kakao.maps.Marker({
		    position: markerPosition
		});
		
	 	infoWindow = new kakao.maps.InfoWindow({
		    position: new kakao.maps.LatLng(pos.coords.latitude, pos.coords.longitude),
		    content: 'open me plz.'
		})
		
	 	kakao.maps.event.addListener(marker, 'dragend', function() {
	 		displayAddr(marker.getPosition());
	 		console.log(marker.getPosition());
	 		globalCoords.lat = marker.getPosition().Ma
	 		globalCoords.lng = marker.getPosition().La
	 		document.getElementById('latitude').value = globalCoords.lat;
	        document.getElementById('longitude').value= globalCoords.lng;
		}); 
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		// 마커가 드래그 가능하도록 설정합니다 
		marker.setDraggable(true); 
		displayAddr(new kakao.maps.LatLng(pos.coords.latitude, pos.coords.longitude));
		globalCoords.lat = pos.coords.latitude
 		globalCoords.lng = pos.coords.longitude
 		
 		if(document.getElementById('latitude').value == ''){
			document.getElementById('latitude').value = pos.coords.latitude;
	        document.getElementById('longitude').value= pos.coords.longitude;
        }
	})
	
	function displayAddr(coords) {
		searchDetailAddrFromCoords(coords, function(result, status) {
	         if (status === kakao.maps.services.Status.OK) {
	        	 console.log(result[0].address);
	             detailAddr = '<div>' + result[0].address.address_name + '</div>';
	             var content = '<div class="info-title"><small>' +
	                             detailAddr + 
	                         '</small></div>';

				 console.log(content);
	             // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
	             infoWindow.setContent(content);
	             infoWindow.open(map, marker);
	             document.getElementById('detailaddr').value = result[0].address.address_name;
	             
	             var infoTitle = document.querySelectorAll('.info-title');
	             infoTitle.forEach(function(e) {
	                 var w = e.offsetWidth + 10;
	                 var ml = w/2;
	                 e.parentElement.style.top = "0";
	                 e.parentElement.style.left = "50%";
	                 e.parentElement.style.marginLeft = -ml+"px";
	                 e.parentElement.style.width = w+"px";
	                 e.parentElement.previousSibling.style.display = "none";
	                 e.parentElement.parentElement.style.border = "0px";
	                 e.parentElement.parentElement.style.background = "unset";
	             });
	         }   
	     });
	}
	
	
	function searchAddrFromCoords(coords, callback) {
	    // 좌표로 행정동 주소 정보를 요청합니다
	    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);  
	    
	    
	}
	
	function searchDetailAddrFromCoords(coords, callback) {
	    // 좌표로 법정동 상세 주소 정보를 요청합니다
	    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
	}
	
	// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
	function displayCenterInfo(result, status) {
	    if (status === kakao.maps.services.Status.OK) {
	        var infoDiv = document.getElementById('centerAddr');
	
	        for(var i = 0; i < result.length; i++) {
	            // 행정동의 region_type 값은 'H' 이므로
	            if (result[i].region_type === 'H') {
	                infoDiv.innerHTML = result[i].address_name;
	                break;
	            }
	        }
	    }    
	}
</script>
<!-- Bootstrap core JavaScript-->
<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="${pageContext.request.contextPath}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="${pageContext.request.contextPath}/resources/js/sb-admin-2.min.js"></script>

</body>

</html>