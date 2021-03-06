<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset=UTF-8">
<title>2021. 6. 8.오전 9:16:07</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #f5f5f5;">
	<div class="p-5" style="background-color: #ffffff; height: 500px; width: 500px; margin: 0 auto; margin-top: 100px;">
		<div>
			<h1>${id }</h1>
			<h1>${email }</h1>
			<h2>네이버 계정으로<br>
			</h2>
			<p>안전한 거래를 위해 약관동의 후<br>
			본인인증을 완료해 주세요.</p>
		</div>
		<div>
			<form method="post" action="/naverTerms" name="form" style="display: inline-block;">
				<div class="custom-control custom-switch">
			      <input type="checkbox" class="custom-control-input" id="all">
			      <label class="custom-control-label" for="all">전체 동의</label>
			    </div>
				<div class="custom-control custom-switch">
			      <input type="checkbox" class="custom-control-input" id="switch1">
			      <label class="custom-control-label" for="switch1">네이버 로그인 필수 항목 모두 동의</label>
			    </div>
			    <div class="custom-control custom-switch">
			      <input type="checkbox" class="custom-control-input" id="switch2">
			      <label class="custom-control-label" for="switch2">개인정보 수집 이용 동의</label>
			    </div>
			    <div class="custom-control custom-switch">
			      <input type="checkbox" class="custom-control-input" id="switch3">
			      <label class="custom-control-label" for="switch3">위치정보 이용약관 동의</label>
			    </div>
			    <div class="custom-control custom-switch">
			      <input type="checkbox" class="custom-control-input" id="switch4">
			      <label class="custom-control-label" for="switch4">마케팅 수신 동의</label>
			    </div>
			    <div class="custom-control custom-switch">
			      <input type="checkbox" class="custom-control-input" id="switch5">
			      <label class="custom-control-label" for="switch5">개인정보 광고활용 동의</label>
			      <input type="text" value="${id}" id="oauthid" name="oauthid">
			    </div>
			</form>
		</div>
		<input class="btn btn-success btn-lg form-control text-white font-weight-bold mb-3 mt-3" type="button" value="네이버 로그인" onclick="chk()"/>
		<input class="btn btn-secondary btn-lg form-control text-white font-weight-bold mb-3" type="button" value="취소" onclick="nochk()" /> 
	</div>
<script type="text/javascript">
	$('#all').click(function(){
		if($("input:checkbox[id='all']").prop("checked")){
			$("input[type=checkbox]").prop("checked", true);
		}else{
			$("input[type=checkbox]").prop("checked",false);
		}
	});
</script>
<script type="text/javascript">
		function chk() {
			var req1 = document.form.switch1.checked;
			var req2 = document.form.switch2.checked;
			var req3 = document.form.switch3.checked;
			var req4 = document.form.switch4.checked;
			var req5 = document.form.switch5.checked;
			
			var num = 0;
			if (req1 == true 
					&& req2 == true
					&& req3 == true
					&& req4 == true
					&& req5 == true) {
				alert("네이버 로그인을 시작합니다.");
				num = 1;
			}
			if (num == 1) {
				location.href = "/naverTerms";
			}else if(req1 != true){
				alert("네이버 로그인 필수 항목 안내를 동의해주세요. ")
			}
			else if(req2 != true){
				alert("개인정보 수집 이용을 동의주세요.")
			}
			else if(req3 != true){
				alert("위치정보 이용약관을 동의해주세요.")
			}
			else if(req4 != true){
				alert("마케팅 수신을 동의해주세요.")
			}
			else if(req5 != true){
				alert("개인정보 광고활용 동의해주세요.")
			}
			else {
				alert("약관에 동의하셔야 합니다.");
			}
		}
		function nochk() {
			alert("동의하지 않으면 가입하실 수 없습니다");
			location.href = "/";
		}
</script>
</body>
</html>