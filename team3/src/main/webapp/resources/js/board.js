/**
 * board module
 */
console.log("board module.....");

var boardService = (function() {
	return {
		add: function(board, callback, error){
			console.log("board.add()...........");
			
			$.ajax({
				type: "post",
				url : "/board/register",
				data : JSON.stringify(board),
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
		getListMore: function(param, callback, error) {
			console.log(param)
			var bno = param.bno;
			var url = "/board/more/" + bno;
			var cri = param.cri ? param.cri : null;
			
			console.log("getListMore url :: " + url)
			$.getJSON(url, cri, function(result) {
				if(callback) {
					callback(result);
				}
			}).fail(function(xhr, status, er) {
				if(error) {
					error(er);
				}	
			});
 		},
 		
		remove: function(bno, callback, error) {
			var url = "/board/" + bno
			$.ajax({
				type : "delete",
				url : url,
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
		
		update: function(board, callback, error) {
			var url = "/board/details/modify/" + board.bno
			$.ajax({
				type: "put",
				url : url,
				data : JSON.stringify(board),
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
		
		categoryList: function(param, callback, error) {
 			console.log(param)
 			var category = param.category;
 			var url = "/board/category/" + category;
 			
 			console.log("categoryList url :: " + url)
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
 		
 		nearList: function(param, callback, error) {
 			
 			console.log(param)
 
 			var latitude = param.latitude;
 			var longitude = param.longitude;
 			
 			var member = param.member;
 			var url = "/near/nearList/"+ latitude + "/" + longitude;
 			
 			console.log(param);
 			console.log("near url :: " + url)
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
 		
		get: function(bno, callback, error) {
			var url = "/board/" + bno
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
			var today = moment(new Date());
			var dateObj = moment(timeValue);
			
			return today.diff(dateObj, 'days') < 1 ? moment(timeValue).fromNow() : dateObj.format("yy/MM/DD")
			//return moment(timeValue).fromNow();
		},
		
		getBoardDom: function(param) {
			console.log("getBoardDom...");
			var geocoder = new kakao.maps.services.Geocoder();
			strWrap = "";
			strWrap += '<div id="listContainer" class="row container-lg p-2 m-0 mt-5">';
			strWrap += '</div><div class="row">';
			strWrap += '</div>';
			var addrs = [];
			var $this = this;
			for(var i in param) {
				geocoder.coord2Address(param[i].longitude, param[i].latitude, function(result) {
					var addr = result[0].address.region_2depth_name + " " + result[0].address.region_3depth_name;
					console.log(param[i].attachList);
					var imgSrc = param[i].attachList != null ? '/display?fileName=' + param[i].attachList[0].downPath : "";
					var str = '';
					
					str += '<div class="boardDiv col-sm-6 col-md-4 p-2" data-bno =' + param[i].bno + '>';
					//../board/details/ << ????????? ???????????????. 
					str += 		'<a href="../board/details/' + param[i].bno + '">';
					str += 			'<div style="height:363px; background:url(' + imgSrc + ') no-repeat center; background-size:cover">'
					//str += 			'<img src="' + imgSrc + '" alt="">';
					str += 			'</div>'
					str += 			'<div class="hover-content">';
					str += 					'<h3 class="text-truncate" >' + param[i].title + '</h3>';
					str += 					'<hr>';
					str += 					'<ul class="list-style:none;">';
					str += 					'<li class="addrWrapper">' + addr + '</li>';
					str += 					'<li>' + $this.displayTime(param[i].regdate) + ' </li>';
					str += 					'<li class="product-price" style="bold; color:#fbb710; font-size:20px;">'+ param[i].price +'???</li>';
					str += 					'</ul>';
					str += 			'</div>';
					str += 		'</a>';
					str += '</div>';
					$("#listContainer").html($("#listContainer").html()+str);
				});
			}
			console.log(addrs);
			
			return strWrap;
		}
		
	}; 
})(); // ?????? ???????????????
