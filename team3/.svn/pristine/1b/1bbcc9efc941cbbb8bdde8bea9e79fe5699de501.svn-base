<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<jsp:include page="../includes/header.jsp"/>

	<!-- Begin Page Content -->
	<div class="container-fluid">
		<h1 class="h3 text-center mt-3 mb-5"></h1>
			<div class="card">
				<div class="card-header py-3" style="background-color: cornsilk;">
				    <h3 class="m-0 text-center font-weight-bold text-success">게시글 수정</h3>
				</div>
			<div class="card-body">
				<form method="post" class="needs-validation" novalidate >
					<div class="form-group">
					   	<label for="category" class="font-weight-bold text-warning">Category &nbsp:&nbsp&nbsp</label>
					   	<select class="form-select form-select-sm category" id="category" name="category" aria-label=".form-select-lg example" value='<c:out value="${board.category}"/>' required>
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
						<label for="price" class="font-weight-bold text-warning">price &nbsp:&nbsp&nbsp</label>
						<input type="text" class="form-control" id="price" placeholder="금액을 입력하세요" name="price" value='<c:out value="${board.price}"/>' required >원</input>
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">Please fill out this field.</div>
						<%-- <label for="bno" class="font-weight-bold text-warning ml-2">bno &nbsp:&nbsp&nbsp</label>
						<input type="text" class="form-control" id="bno"  name="price" value='<c:out value="${board.bno}"/>' required readonly/>
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">Please fill out this field.</div> --%>
						<label for="writer" class="font-weight-bold text-warning ml-2">writer &nbsp:&nbsp</label>
						<input type="text" class="form-control" id="writer" placeholder="작성자를 입력하세요" name="writer" value='<c:out value="${board.writer}"/>' required readonly />
						<!--  readonly value='<sec:authentication property="principal.username"/>' --> 
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">Please fill out this field.</div>
					</div>
					<div class="form-group">
						<label for="title" class="font-weight-bold text-warning">title</label>
						<input type="text" class="form-control" id="title" placeholder="게시글 제목을 입력하세요" name="title" value='<c:out value="${board.title}"/>' required />
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">Please fill out this field.</div>
					</div>
					<div class="form-group">
						<label for="title" class="font-weight-bold text-warning">content</label>
						<textarea class="form-control" rows="10" id="content" placeholder="게시글 내용을 입력하세요" name="content" required ><c:out value="${board.content}"/></textarea>
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">Please fill out this field.</div>
					</div>
				   <input class="btn btn-outline-dark float-right" type="button" value="Back" onclick="history.back()">
				   <sec:authorize access="isAuthenticated()">
				   <sec:authentication property="principal" var="pinfo"/>
				   <c:if test="${pinfo.username == board.writer}">
				   <input type="hidden" name="bno" value="${board.bno}">
				   <button data-oper="remove" onclick="return confirm('삭제한 게시물은 되돌릴 수 없습니다. 정말 삭제 하시겠습니까?')" class="btn btn-outline-danger float-right mx-1" formaction="remove${cri.listLink}&bno=${board.bno}">Remove</button>
				   <button data-oper="modify" onclick="modify()" class="btn btn-outline-warning float-right" formaction="modify${cri.listLink}">Modify</button>
				   </c:if>
				   </sec:authorize>
				   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
				</form>
			</div>
		</div>
		<div class="card mb-4">
			<div class="card-body">
				<div class="uploadDiv">
					<label className="files-button" for="files" style="padding: 6px 25px; background-color:#fbb710; border-radius: 4px; color: white; cursor: pointer;">
					<i class="fas fa-images"></i> 이미지 업로드
					</label>
					<input id="files" type="file" name="files" style="display:none;" accept="image/gif,image/jpeg,image/g,image/png" multiple>
					<!--파일 첨부시 이미지만 보이게 accept="image/gif,image/jpeg,image/png"  -->
				</div>
				<div class="uploadResult">
					<ul class="list-group list-group-horizontal" style="display: -webkit-box;">
					</ul>
				</div>
				<!-- Result Modal-->
			    <div class="modal fade" id="imageModal">
			        <div class="modal-dialog modal-xl">
			            <div class="modal-content">
			                <div class="modal-body text-center">
			                	<img class="mw-100">
			                </div>
			            </div>
			        </div>
			    </div>
            </div>
        </div>
	</div>	
	<script>
		var csrf = '${_csrf.headerName}';
		var csrfToken = '${_csrf.token}'; 
		var bno = <c:out value="${board.bno}" />;
		var cloneObj = $(".uploadDiv").clone();
		function checkExtension(name, size) {
			var regex = /(.*?)\.(exe|sh|jsp|php|jar)/gi;
			var maxSize = 1024 * 1024 * 5; //파일의 최대 크기 5M
			
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
	
	    $(function() {
	    	//수정시 원글의 카테고리로 고정하는 함수 가져오기
	    	$("#category").val('${board.category}');
	    });
			
		
		$(function() {
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
						str += "<i class='fas fa-paperclip text-muted'></i>" + obj.fileName;
					}
					else {
						str += "<img src='${pageContext.request.contextPath}/display?fileName=" + obj.thumbPath + "'>";
					}
					str += "<i class='fas fa-times text-danger removeFileBtn'></i>"
					str += "</li>";
				}
				$(".uploadResult ul").append(str);
			}
			$.getJSON("/board/getAttachList", {bno:bno}, function(uploadResultArr) {
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
						str += "<i class='fas fa-paperclip text-muted'></i>" + obj.fileName;
					}
					else {
						str += "<img src='${pageContext.request.contextPath}/display?fileName=" + obj.thumbPath + "'>";
					}
					str += "<i class='fas fa-times text-danger removeFileBtn'></i>"
					str += "</li>";
				}
				$(".uploadResult ul").html(str);
			});
		
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
				
				$li.remove();
			});
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
			$("button").click(function() {
				if($(this).data("oper") !== "modify") return;
				
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
		})
	</script>
	<script>
		function modify(){
			alert("게시글 수정이 완료 되었습니다.");
			location.href = "/board/modify";
		}
		
	</script>
<jsp:include page="../includes/footer.jsp"/>
