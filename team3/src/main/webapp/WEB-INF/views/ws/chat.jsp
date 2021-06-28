<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>2021. 6. 8.오후 12:30:18</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css" integrity="sha512-P5MgMn1jBN01asBgU0z60Qk4QxiXo86+wlFahKrsQf37c9cro517WzVSPPV1tDKzhku2iJ2FVgL67wG03SGnNA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js" integrity="sha512-XKa9Hemdy1Ui3KSGgJdgMyYlUg1gM+QhL6cnlyTe2qzMCYm4nAZ1PsVerQzTTXzonUR+dmswHqgJPuwCq1MaAg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>
<sec:authentication property='principal.vo' var="vo"/> 

<div class="container row mx-auto p-3">
	<div class="col-4">
		<ul class="list-group" id="chatList">
		</ul>
	</div>
	<div class="col-8">
		<div class="form-group">
			<div class="form-control" style="height:200px; overflow-y: scroll;" id="chatBoard">
			</div>
		</div>
		<form id="msgSendForm">
		<div class="form-group input-group">
			<input class="form-control" id="msgBox" readonly>
			<div class="input-group-append">
				<button class="btn btn-success" id="send" >메세지 전송</button>
			</div>
		</div>
		</form>
	</div>
	<div>
		<select class="form-control" multiple id="loginUser" size="3">
		</select>
	</div>
</div>
<script>
	var websocket;
	var roomId;
	var userId = '${vo.userEmail}';
	
	console.log(userId);
	
	function ChatMessage(roomId, userId, message) {
		this.roomId = roomId;
		this.userId= userId;
		this.message = message;
	}
	
	function connect() {
		var wsUri = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/ws/echo";
	    websocket = new WebSocket(wsUri);
	    websocket.onopen = onOpen;
	    websocket.onmessage = onMessage;
	    websocket.onclose = onClose;
	}
	//웹 소켓에 연결되었을 때 호출될 함수
	function onOpen() {
		var data = new ChatMessage(roomId, userId, "ENTER-CHAT");
		websocket.send(JSON.stringify(data));	
		console.log("connect() done", websocket);
	}
	
	// * 2 메세지 수신
	function onMessage(evt) {
		console.log(evt);
		writeMsg(JSON.parse(evt.data));
		$("#chatBoard").scrollTop($("#chatBoard").prop('scrollHeight'))
	}
	// 3. 연결 종료
	function onClose() {
		console.log("close() disconnect", websocket);
	}
	
	// 송신
	function sendMsg(msg) {
		var data = new ChatMessage(roomId, userId, msg);
		console.log(data);
		websocket.send(JSON.stringify(data));
	}
	
	function writeMsg(result){
		var lr = result.userId != userId ? "text-left" : 'text-right';
		appendMsg(lr, result.userId, result.message);
	}
	
	function appendMsg(lr, userId, message) {
		$(createMsg(lr, userId, message).appendTo("#chatBoard"));
	}
	
	function createMsg(lr, userId, message) {
		return $("<div>").attr("class", lr).html(message);
	}
	
	function getRoomList() {
		$.ajax("chatRoomList", {
			data : {userId:userId},
			dataType : "json",
			async : false
		})
		.done(function(result) {
			console.log(result);
			var str = "";
			for(var i in result)
				str += "<li class=\"list-group-item\" data-roomid='" + result[i].roomId + "'><a href='#'>" + result[i].masterId + "</a></li>";
			if(result.length == 0) {
				str = "<li class=\"list-group-item\">현재 활성화된 채팅 목록이 없습니다</li>";
			}	
			$("#chatList").html(str);
		})
	}
	
	function getLoginUser() {
		$.getJSON("chatSession")
		.done(function(result) {
			var str = "";
			console.log(result);
			for(var i in result) {
				str += "<option value='" + result[i].userId + "'>" + result[i].userId + "</option>";
			}
			$("#loginUser").html(str);
		})
	}
	function enterRoom(obj){
	    // 현재 html에 추가되었던 동적 태그 전부 지우기
	    $('#chatBoard').html("");
	    // obj(this)로 들어온 태그에서 id에 담긴 방번호 추출
	    roomId = obj.getAttribute("id");
	     // 해당 채팅 방의 메세지 목록 불러오기
	      $.ajax({
	        url:roomId,
	        data:{
	            userEmail:"${loginUser.email}"
	        },
	        async:false,
	        dataType:"json",
	        success:function(data){
	            for(var i = 0; i < data.length; i++){
	                // 채팅 목록 동적 추가
	                CheckLR(data[i]);
	            }
	        }
	    });
	     // 웹소켓 연결
	     connect();
	     console.log("enterRoom");
	}
	
	$(function() {
		getRoomList();
		getLoginUser();
		
		function doChat() {
			$.getJSON("room/" + roomId, {userId:userId})
			.done(function(result) {
				if(websocket) websocket.close();
				console.log(result);
				$("#chatBoard").html("");
				for(var i in result) {
					writeMsg(result[i]);
				}
				$("#msgBox").prop("readonly", 0);
				connect();
			})
		}
		
		$("#chatList").on("click", "a", function() {
			roomId = $(this).parent().data("roomid");
			doChat();
			
		});
		
		
		$("#loginUser").on("dblclick", "option", function() {
			var masterId = $(this).val();
			var data = {userId:userId, masterId:masterId}
			$.getJSON("createChat", data)
			.done(function(result) {
				roomId = parseInt(result);
				doChat();
			})
		}) 
		
		$("#send").click(function() {
			event.preventDefault();
			sendMsg($("#msgBox").val());
			$("#msgBox").val("");
		})
		
	})
</script>
</body>
</html>