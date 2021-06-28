let index = {
		init: function() {
			$('#btnSend').on("click",function() { // function(){} 대신 ()=>{} 를 사용한 이유는 this를 바인딩 하기 위해서
				index.send();
				
			});
			$('#btnConfirm').on("click",()=>{ // function(){} 대신 ()=>{} 를 사용한 이유는 this를 바인딩 하기 위해서
				index.confirm();
				
			});
			
			$("#receiveMail").on("change keyup", function() { // 화면의 이메일 입력란에 값이 바뀌면 인증번호 발송버튼 활성화
				$("#btnSend").prop("disabled", false); //
			});
		},
 		send: function(){
			//alert("테스트 테스트");
			let data = {
					receiveMail:$("#receiveMail").val()
					
			};
			
			if(data.receiveMail.length == 0 || data.receiveMail.length == null) {
				alert("이메일을 입력하세요.");
				return;
			}
			
			console.log(data);
			$.ajax({
				type:"POST",
				url: "/api/email",
				data: JSON.stringify(data), //http body 데이터
				beforeSend : function(xhr) {
					$("#btnSend").prop("disabled", true); // 인증번호 발송 버튼을 누를시, 발송 버튼 비활성화
					// 여기에 인증번호 발송 버튼을 전송중~ 으로 바꾸고
					$("#btnSend").attr('value','전송 중');
				},
				contentType: "application/json; charset=utf-8", //body데이터가 어떤 타입인지
				dataType:"json" // 응답이 왔을때 받을 타입
			}).done(function(resp){
				alert("이메일 인증번호 발송");
				// 여기에서 정송중~을 다시 인증번호 발송으로 바꾼다.
				$("#btnSend").attr('value','인증번호 발송');
				$("#pinCodeDiv").show();
				$("#btnConfirmDiv").show();
				console.log(resp);
			}).fail(function(error){
				console.log(error);
			}); 
		},
		confirm : function() {
			let data = {
				confirm:$("#pinCode").val()
					
			};
			var csrfParameterName ="${_csrf.parameterName}";
			var csrfTokenValue="${_csrf.token}";
			console.log(data);
			
			$.ajax({
				type:"POST",
				url: "/api/confirm",
				data: JSON.stringify(data), //http body 데이터
				contentType: "application/json; charset=utf-8", //body데이터가 어떤 타입인지
				dataType:"json", // 응답이 왔을때 받을 타입
				success : function(data) { // 데이터가 넘어갔을때 찍히는 로그값
					console.log("confirm :: ", data);
					if(data.data == 1){ // 
						alert("인증이 완료 되었습니다.");
						$("#userEmail").val($("#receiveMail").val());
					}else{
						alert("인증번호가 일치하지 않습니다.");
					}
					
					
					
				}
			})
		},
}
index.init();
