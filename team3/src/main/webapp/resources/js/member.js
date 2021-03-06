let member = {
		init: function(){
			$('#btnSave').on("click",()=>{ // function(){} 대신 ()=>{} 를 사용한 이유는 this를 바인딩 하기 위해서
				this.save();
			});
		},
		save: function(){
			//alert("테스트 테스트");
			let data = {
					userEmail:$("#userEmail").val(),
					userPw:$("#userPw").val(),
					userName:$("#userName").val(),
					birthDate:$("#birthDate").val(),
					postCode:$("#postCode").val(),
					roadAddress:$("#roadAddress").val(),
					jibunAddress:$("#jibunAddress").val(),
					extraAddress:$("#extraAddress").val(),
					latitude:$("#latitude").val(),
					longitude:$("#longitude").val(),
					detailaddr:$("#detailaddr").val()
			};
			console.log(data);
			if(data.userEmail.length == 0 || data.userEmail.length == null) {
				alert("아이디를 입력하세요.");
				return;
			}if(data.userPw.length == 0 || data.userPw.length == null){
				alert("비밀번호를 입력하세요.");
				return;
			}if(data.userName.length == 0 || data.userName.length == null){
				alert("이름을 입력하세요.");
				return;
			}if(data.roadAddress.length == 0 || data.roadAddress.length == null){
				alert("주소를 입력하세요.");
				return;
			}if(data.birthDate.length == 0 || data.birthDate.length == null){
				alert("생년월일을 입력하세요.");
				return;
			}
			
			// ajax 호출시 default가 비동기 호출
			// ajax통신을 이용 데이터를 json으로 변경하여 insert 요청한다.
			$.ajax({
				type:"POST",
				url: "/api/member",
				data: JSON.stringify(data), //http body 데이터
				contentType: "application/json; charset=utf-8", //body데이터가 어떤 타입인지
				dataType:"json" // 응답이 왔을때 받을 타입
				//회원가입 수행 요청
			}).done(function(resp){
				alert("회원가입이 완료 되었습니다.");
				location.href = "/";
				console.log(resp);
				/*location.href = "/register";*/
			}).fail(function(error){
				alert("유효하지 않은 데이터");
				alert(JSON.stringify(error));
			}); 
	}
}
member.init();
