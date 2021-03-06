<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<jsp:include page="../includes/header.jsp"/>
        
	<div class="container-fluid">
	<!-- Page Heading -->
		<h1 class="h3 text-center mt-3 mb-5"></h1>
		<div class="card">
			<div class="card-header py-3">
				<h3 class="m-0 text-center font-weight-bold text-success">상품 등록</h3>
			</div>
			<div class="card-body">
				<form method="post" class="needs-validation" novalidate id="form" name="form">
					<div class="form-group">
				    	<label for="category" class="font-weight-bold text-warning">Category:</label>
				    	<select class="form-select form-select-sm category" id="category" name="category" aria-label=".form-select-lg example" required>
				    		<option value="" disabled selected hidden>카테고리를 선택해주세요</option>
							<option value="1">여성의류/잡화</option>
							<option value="2">남성의류/잡화</option>
							<option value="3">디지털/가전</option>
							<option value="4">가구/생활</option>
							<option value="5">스포츠/레저</option>
							<option value="6">아동의류</option>
							<option value="7">아동잡화</option>
							<option value="8">도서/취미</option>
							<option value="9">차량/오토바이</option>
							<option value="10">무료나눔</option>
						</select>
					</div>
					<div class="form-group form-inline">
						<label for="price" class="font-weight-bold text-warning">price:</label>
						<input type="text" class="form-control" id="price" placeholder="금액을 입력하세요" name="price" required />
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">Please fill out this field.</div>
						
						<label for="writer" class="font-weight-bold text-warning">writer:</label>
						<input type="text" class="form-control" id="writer" placeholder="작성자를 입력하세요" name="writer" required readonly value='<sec:authentication property="principal.username"/>' />
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">Please fill out this field.</div>
					</div>
					<div class="form-group">
						<label for="title" class="font-weight-bold text-warning">title</label>
						<input type="text" class="form-control" id="title" placeholder="게시글 제목을 입력하세요" name="title" required />
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">Please fill out this field.</div>
					</div>
					<div class="form-group">
						<label for="title" class="font-weight-bold text-warning">content</label>
						<textarea class="form-control" rows="10" id="content" placeholder="게시글 내용을 입력하세요" name="content" required ></textarea>
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">Please fill out this field.</div>
					</div>
					<div class="container mapBox" id="mapView">
		            	<div id="map" style="min-height:500px"></div>
		            	<input type="hidden" id="latitude" name="latitude">
		            	<input type="hidden" id="longitude" name="longitude">
		            	<input type="hidden" id="detailaddr" name="detailaddr">
		            </div>
					<input class="btn btn-outline-info float-right ml-1" type="button" value="List" onclick="history.back()">
					<button type="reset" class="btn btn-outline-secondary float-right">reset</button>
					<button onclick="register()" class="btn btn-outline-success float-right mr-1">submit</button>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				</form>
			</div>
		</div>
	    <div class="card mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-warning">Attach File</h6>
			</div>
			<div class="card-body">
				<div class="uploadDiv">
					<label className="files-button" for="files" style="padding: 6px 25px; background-color:#fbb710; border-radius: 4px; color: white; cursor: pointer;">
						<i class="fas fa-images"></i> 이미지 업로드
					</label>
					<input id="files" type="file" name="files" style="display:none;" accept="image/gif,image/jpeg,image/jpg,image/png" multiple>
					<!--파일 첨부시 이미지만 보이게 accept="image/gif,image/jpeg,image/png"  -->
				</div>
				<div class="uploadResult">
					<ul class="list-group list-group-horizontal"></ul>
				</div>
			</div>
		</div>
	</div>
	                   
	<script>
		(function() {
		  'use strict';
		  window.addEventListener('load', function() {
		    // Get the forms we want to add validation styles to
		    var forms = document.getElementsByClassName('needs-validation');
		    // Loop over them and prevent submission
		    var validation = Array.prototype.filter.call(forms, function(form) {
		      form.addEventListener('submit', function(event) {
		        if (form.checkValidity() === false) {
		          event.preventDefault();
		          event.stopPropagation();
		        }
		        form.classList.add('was-validated');
		      }, false);
		    });
		  }, false);
		})();
	</script>
	<script>
		var regex = /(.*?)\.(exe|sh|jsp|php|jar)/gi; //이 파일들 업로드를 막기 위함
		/* /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/; */
		var maxSize = 1024 * 1024 * 5; //파일의 최대 크기 5M
		var cloneObj = $(".uploadDiv").clone();
		var uploadResult = $(".uploadResult ul");
		var csrf = '${_csrf.headerName}';
		var csrfToken = '${_csrf.token}'; 
		
		console.log(cloneObj);
		$(".uploadDiv").on("change", "#files", function() {
			var formData = new FormData();
			var files = $("#files")[0].files;
			console.log(files);
			
			for(var i in files) {
				if(!checkExtension(files[i].name, files[i].size)){
					$(".uploadDiv").html(cloneObj.html());
					return false;
				}
				formData.append("files", files[i]);
			}
			console.log(formData);

			$.ajax({
				url : '${pageContext.request.contextPath}/uploadAction',
				type : 'post',
				data : formData,
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrf, csrfToken)
				},
				dataType : 'json',
				processData : false,
				contentType : false,
				success : function(result){
					console.log(result);
					showUploadedFile(result);
					$(".uploadDiv").html(cloneObj.html());
				}
			});
		})
		function checkExtension(name, size) {
			if(size >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			
			if(regex.test(name)) {
				alert("해당 종류의 파일은 업로드 할 수 없습니다");
				return false;
			}
			return true;
		}
		
		
		function showUploadedFile(uploadResultArr) {
			var str = "";
			for(var i in uploadResultArr) {
				var obj = uploadResultArr[i];
				console.log(obj);
				str += "<li class='list-group-item' "
				str += " data-filename='" + obj.fileName
				str += "' data-image='" + obj.image
				str += "' data-uuid='" + obj.uuid
				str += "' data-uploadpath='" + obj.uploadPath
				str += "' >"
				if(!obj.image){
					console.log("obj.downPath :: "+obj.downPath);
					str += "<a href='${pageContext.request.contextPath}/download?fileName=" + obj.downPath + "'><i class='fas fa-paperclip text-muted'></i>" + obj.fileName + "</a>";
				}
				else {
					console.log("obj.thumbPath :: "+obj.thumbPath);
					str += "<a href='javascript:showImage(\"" + obj.downPath + "\")'>";
					str += "<img src='${pageContext.request.contextPath}/display?fileName=" + obj.thumbPath + "'></a>";
				}
				str += "<i class='fas fa-times text-danger removeFileBtn'></i>"
				str += "</li>";
			}
			uploadResult.append(str);
		}
		function showImage(path) {
			$("#imageModal img").attr("src", "${pageContext.request.contextPath}/display?fileName=" + path)
			$("#imageModal").modal("show");
			$("#imageModal").attr("style", "margin-top:10%;");
		}
		$(".uploadResult").on("click", ".removeFileBtn", function() {
			var $li = $(this).closest("li");
			var data = {
				fileName : $li.data("filename"), 
				image: $li.data("image"),
				uuid : $li.data("uuid"),
				uploadPath : $li.data("uploadpath")
			}
			console.log(data);
			console.log(JSON.stringify(data));
			$.ajax({
				url : "${pageContext.request.contextPath}/deleteFile",
				type: "post",
				data : JSON.stringify(data),
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrf, csrfToken)
				},
				contentType : "application/json; charset=utf-8",
				success : function(result) {
					alert(result);
					$li.remove();
				}
			});
		});
		
		$("button[type='submit']").click(function() {
			
			var forms = document.getElementsByClassName('needs-validation');
			
			event.preventDefault();
			var str = "";
			var attrs = ["fileName", "uuid", "uploadPath", "image"];
			$(".uploadResult li").each(function(i, it) {
				for(var j in attrs) {
					var tmp = '<input type="hidden" name="attachList[' + i + '].';
					tmp += attrs[j]+ '" value="' + $(it).data(attrs[j].toLowerCase())+ '">';
					console.log(tmp);
					str += tmp;
				}
			});
			console.log(str);
			//$(this).closest("form").append(str);
			//console.log($(this).closest("form").serialize());
			
			$(this).closest("form").append(str).submit();
		})
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
		 		globalCoords.latitude = marker.getPosition().Ma
		 		globalCoords.longitude = marker.getPosition().La 
		 		document.getElementById('latitude').value = globalCoords.latitude;
		        document.getElementById('longitude').value = globalCoords.longitude;
			}); 
		 	
			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);
			// 마커가 드래그 가능하도록 설정합니다 
			marker.setDraggable(true); 
			displayAddr(new kakao.maps.LatLng(pos.coords.latitude, pos.coords.longitude));
			globalCoords.latitude = pos.coords.latitude
	 		globalCoords.longitude = pos.coords.longitude
	 		
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
		             document.getElementById('detailaddr').value = result[0].address.address_name;
		             infoWindow.open(map, marker);
		             
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
	<script>
		function register(){
			if(document.getElementById('category').value ==""){
				/* throw new Error('노노노'); */
				alert("카테고리를 지정하십시오.");
				return;
			}else {
				document.form.submit();
				alert("게시글이 작성 되었습니다.");
				location.href = "/board/list";
			}
		}
	</script>
	
	
	
<jsp:include page="../includes/footer.jsp"/>
