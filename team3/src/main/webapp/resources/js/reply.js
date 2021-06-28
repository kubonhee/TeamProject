/**
 * reply module
 */

console.log("reply module.....");

var replyService = (function() {
	return {
		add: function(reply, callback, error){
			console.log("reply.add()...........");
			
			$.ajax({
				type: "post",
				url : reply.cp+"/replies/new",
				data : JSON.stringify(reply),
				contentType : "application/json; charset=utf-8",
				success : function(result, status, xhr){
					if(callback) {
						callback(result);
					}
				},
				error : function(xhr, status, er) {
					if(error) {
						error(er);
					}
				}
			});	
		},
		getList: function(param, callback, error) {
			var bno = param.bno;
			var rnoStr = param.rno ? "/" + param.rno : "";
			var url = param.cp+"/replies/more/" + bno +  rnoStr;

			console.log(url);
		
			/*
			 $.ajax({
				type : "get",
				url : url,
				dataType : "json",
				success : function(result){
					if(callback) {
						callback(result);
					}
				},
				error : function(xhr, status, er) {
					if(error) {
						error(er);
					}
				}
			})
			*/
			
			$.getJSON(url, function(result) {
				if(callback) {
					callback(result);
				}
			}).fail(function(xhr, status, er) {
				if(error) {
					error(er);

				}
			});
 		},
		remove: function(reply, callback, error) {
			var url = reply.cp+"/replies/" + reply.rno;
			console.log(url);
			$.ajax({
				type : "delete",
				url : url,
				data : JSON.stringify(reply),
				contentType : "application/json; charset=utf-8",
				success : function(result){
					if(callback) {
						callback(result);
					}
				},
				error : function(xhr, status, er) {
					if(error) {
						error(er);
					}
				}
			})
			
		},
		update: function(reply, callback, error) {
			var url = reply.cp+"/replies/" + reply.rno
			$.ajax({
				type: "put",
				url : url,
				data : JSON.stringify(reply),
				contentType : "application/json; charset=utf-8",
				success : function(result, status, xhr){
					if(callback) {
						callback(result);
					}
				},
				error : function(xhr, status, er) {
					if(error) {
						error(er);
					}
				}
			});
		},
		get: function(reply, callback, error) {
			var rno = reply.rno;
			var url = reply.cp+"/replies/" + rno
			$.getJSON(url, function(result) {
				if(callback) {
					callback(result);
				}
			}).fail(function(xhr, status, er) {
				if(error) {
					error(er);

				}
			});
		},
		displayTime: function(timeValue){
			//var today = moment(new Date());
			//var dateObj = moment(timeValue);
			
			//return today.diff(dateObj, 'days') < 1 ? dateObj.format("hh:mm:ss") : dateObj.format("yy/MM/DD")
			return moment(timeValue).fromNow();
		},
		getReplyDom: function(param) {
			str = "";
			str += '<li class="list-group-item" data-rno="' + param.rno + '">';
			str += '	<div class="header">';
			str += '		<strong>'+ param.replyer + '</strong>';
			str += '		<small class="float-right">' + this.displayTime(param.replyDate) + '</small>';
			str += '	</div>';
			str += '	<p class="mt-2">'+ param.reply + ' </p>';
			str += '</li>';
			return str;
		}
	}; 
})(); // 타입 언디파인드
