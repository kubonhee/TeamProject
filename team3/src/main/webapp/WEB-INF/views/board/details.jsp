<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
 <jsp:include page="../includes/header.jsp"/>
 <style>
 /* #mainSliderSec { width: 625.213px; height: 400px; position: relative; } */
 #sliderPager a {display: inline-block; width: 140px; height:140px; margin: 2px; border:1px solid}
.bx-wrapper:nth-of-type(1) {width: 580px; height:450px; overflow:hidden; margin: 0; background-size:contain; margin-top:5px}
.bx-viewport:nth-of-type(1) {}
 </style>
    <!-- Product Details Area Start -->
	<div class="single-product-area clearfix" id="boardSection">
		<div class="container">
		<form method="get">
            <div class="row">
                <div class="col-12">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mt-50">
                            <li class="breadcrumb-item"><a href="/">Home</a></li>
                            <li class="breadcrumb-item"><a href="../board/category?cate=${board.category}">category${board.category}</a></li>
                            <li class="breadcrumb-item active" aria-current="page">${board.title}</li>
                        </ol>
                    </nav>
                </div>
            </div>
            <div class="row">
                <div class="col-12 col-lg-7" style=" height: 700px;">
                    <div class="single_product_thumb">
                        <div id="product_details_slider">
                        	<!-- 여기에 래퍼, 뷰포트가 들어가지는건데  -->
                             <ol id="mainSlider">
                             	<c:forEach items="${board.attachList}" var="img" varStatus="s">
                             	<c:if test="${not empty img.fileName}">
                             	<li> 
                                     <a class="gallery_img" href="#">
                                         <img src="${pageContext.request.contextPath}/display?fileName=${img.downPath}"style="width:100%; height:62vh;">
                                     </a>
                                 </li>
                                 </c:if>
                                 <c:if test="${empty img.fileName}">
                                 <li> 
                                     <a class="gallery_img" href="#">
                                         <img src="${pageContext.request.contextPath}/resources/img/noimage.png"  style="width:100%; height:65vh;">
                                     </a>
                                 </li>
                                 </c:if>
                                 </c:forEach>
                             </ol>
                            <div id="sliderPager" style="height:100px">
                            	<c:forEach items="${board.attachList}" var="img" varStatus="s"> 
                          <c:if test="${not empty img.fileName}">
                                <a data-slide-index="${s.index}" href="#" style="background-image: url(${pageContext.request.contextPath}/display?fileName=${img.downPath});  background-size:cover;">
                                </a>
                             </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-lg-5">
                    <div class="single_product_desc">
                        <!-- Product Meta Data -->
                        <div class="product-meta-data">
                            <div class="line"></div>
                                <h4 class="">${board.title}</h4>
                             <p class="product-price" style="display: flex; justify-content: flex-end; margin-top:30px; margin-right: 10px;">${board.price}원</p>
                        </div>
						<div class="form-group ">
							<div class="two wide">
								<%-- <label for="bno" class="font-weight-bold text-warning">글번호:</label>
								<input type="text" class="form-control" id="bno" name="bno" required value="${board.bno}" readonly>
								<div class="valid-feedback">Valid.</div>
								<div class="invalid-feedback">Please fill out this field.</div> --%>
					
								<label for="writer" class="font-weight-bold text-warning mt-4">작성자:</label>
								<input type="text" class="form-control" id="writer" name="writer" required value="${board.writer}" readonly/>
								<div class="valid-feedback">Valid.</div>
								<div class="invalid-feedback">Please fill out this field.</div>
								
								<label for="detailaddr" class="font-weight-bold text-warning mt-4">거래지역:</label>
								<input type="text" class="form-control" id="detailaddr" name="detailaddr" required value="${board.detailaddr}" readonly/>
								<div class="valid-feedback">Valid.</div>
								<div class="invalid-feedback">Please fill out this field.</div>
								
								<label for="regdate" class="font-weight-bold text-warning mt-4">작성일:</label>
								<input type="text" class="form-control" id="regdate" name="regdate" required value="<fmt:formatDate value="${board.regdate}"/>" readonly/>
								<div class="valid-feedback">Valid.</div>
								<div class="invalid-feedback">Please fill out this field.</div>
							</div>
						</div>
					</div>
		</form>
		<button type="button" class="btn btn-danger btn-lg mt-2 mb-3" style="width: 100%; border-radius:10px 0 10px 0;" onclick="location.href = '${pageContext.request.contextPath}/ws/chat">Chat</button>
		<form class="cart clearfix" method="post">
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal" var="pinfo"/>
					<c:if test="${pinfo.username == board.writer}">
						<a href="modify${cri.listLink}&bno=${board.bno}"><button type="button" href="modify${cri.listLink}&bno=${board.bno}" onclick="return alert('게시글 수정 페이지로 이동합니다.')" name="Modify" class="btn btn-outline-success mt-3 mb-3" style="width: 100%; border-radius:10px 0 10px 0;">Modify</button></a>
					</c:if>
			</sec:authorize>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		</form>
		</div>
		<div class="contentform" style="display: contents;">
			<label for="content" class="font-weight-bold text-warning mt-3">상품설명 : </label>
			<textarea class="form-control" rows="10" id="content"  name="content" required readonly style="height: 337px"><c:out value="${board.content}"/></textarea>
			<div class="valid-feedback">Valid.</div>
			<div class="invalid-feedback">Please fill out this field.</div>
		</div>
	</div>
	<div>
	
		<div class="replySection mb-2">
			<sec:authentication property="principal" var="pinfo"/>
			<label class="reply-button m-3 float-right" for="addReplyBtn" style="padding: 16px 40px; margin-top:30px; background-color:#fbb710; border-radius: 4px; color: white;">
				<i class="fas fa-comment-dots"></i>댓글 작성하기
			</label>				
			<input id="addReplyBtn" type="button" name="replyBtn" style="display:none;"  multiple>
			<hr>
			<ul class="list-group chat"></ul> 
			<div class="reply-footer"></div>
			<button id="btnShowMore" class="btn btn-outline-danger btn-block">View More</button>
		</div>
  	</div>
 	</div>
</div>
 
   <script src="${pageContext.request.contextPath}/resources/js/reply.js"></script>
   <script>
		var cp = '${pageContext.request.contextPath}';
		var bno = '<c:out value="${board.bno}" />';
		var replyUL = $(".chat"); 
		
		console.log(cp);	
   		showList("");
	
		
		function showList(rno){
			replyService.getList({bno:bno, rno:rno, cp:cp}, function(list) {
				//댓글 목록 출력
				console.log(list);
				
				//if(page == -1) showList(result.realEnd);
				if(!list.length) {
					$("#btnShowMore").prop("disabled", true).text("추가 댓글이 없습니다");
				}
				
				
				var str = "";
				for(var i in list) {
					str += replyService.getReplyDom(list[i]);
				}
				$(".chat").html($(".chat").html() + str);
				
			})
		}
		var replyer = '';
		<sec:authorize access="isAuthenticated()">
		replyer = '<sec:authentication property="principal.username" htmlEscape="false"/>';
		
		</sec:authorize>
		var csrf = '${_csrf.headerName}';
		var csrfToken = '${_csrf.token}'; 
		
		$(function() {
			$(document).ajaxSend(function(e, xhr) {
				xhr.setRequestHeader(csrf, csrfToken); 
			})
			//등록폼 버튼 이벤트
			$("#addReplyBtn").click(function() {
				$("#myModal").find("input").val("");
				$("#replyer").val(replyer).prop("readonly", true); 
				$("#replyDate").closest("div").hide();
				$(".ac").hide().eq(2).show();
				$("#myModal").modal("show");
				$("#myModal").attr("style", "margin-top:10%;");
			})
			
			
			//댓글 목록 모달 팝업 이벤트
			$(".chat").on("click", "li", function() {
				var rno = $(this).data("rno");
				console.log(rno);
				replyService.get({rno:rno, cp:cp}, function(result) {
					console.log(result);
					$("#reply").val(result.reply);
					$("#replyer").val(result.replyer).prop("readonly", true);
					$("#replyDate").val(replyService.displayTime(result.replyDate)).prop("readonly", true).closest("div").show();
					$("#myModal").data("rno", rno);
					
					
					console.log(replyer == $("#replyer").val());
					if(replyer != $("#replyer").val()) {
						$(".ac").hide();
					}
					else {
						$(".ac").show().eq(2).hide();	
					}
					$("#myModal").modal("show");
					//$("#myModal").attr("style", "margin-top:10%;");
				});
			})
			
			//등록 적용 버튼 이벤트
			$("#modalRegBtn").click(function() {
				var reply = {bno:bno, reply:$("#reply").val(), replyer:replyer, cp:cp};
				console.log(reply);
				replyService.add(reply, function(result) {
					console.log(result);
					alert(result ? "success" : "failed"); //success
					$("#myModal").modal("hide");
					
					replyService.get({rno:result, cp:cp}, function(result) {
						$(".chat").append(replyService.getReplyDom(result));
					})
				});
			});
			//수정 적용 버튼 이벤트
			$("#modalModBtn").click(function() {
				var reply = {rno: $("#myModal").data("rno"), reply:$("#reply").val(), replyer:$("#replyer").val(), cp:cp};
				alert($("#myModal").data("rno"));
				console.log(reply);
				replyService.update(reply, function(result) {
					alert(result);
					$("#myModal").modal("hide");
					$(".chat li").each(function() {
						if($(this).data("rno") == $("#myModal").data("rno")){
							var $li = $(this);
							replyService.get({rno:$li.data("rno"),cp:cp}, function(result) {
								$li.find("p").html(result.reply);
							})
						}
					})
				});
			});
			
			//삭제 적용 버튼 이벤트
			$("#modalRemoveBtn").click(function() {
				replyService.remove({rno:$("#myModal").data("rno"), replyer:$("#replyer").val(), cp:cp}, function(result) {
					alert(result);
					$("#myModal").modal("hide");
					
					$(".chat li").each(function() {
						if($(this).data("rno") == $("#myModal").data("rno")){
							$(this).remove();
						}
					})
				});
			});
			
			//댓글 페이지 버튼 이벤트
			$(".reply-footer").on("click", "a", function() {
				event.preventDefault();
				
				pageNum = $(this).attr("href");
				showList(pageNum);
			});
			
			//btnShowMore 이벤트
			$("#btnShowMore").click(function() {
				// 마지막 rno를 가져오기
				var rno = $(".chat li:last").data("rno");
				// 그 rno를 기반으로 showList호출하기
				showList(rno);
			});
			
		})
		
		var fn = '${board.attachList[0].fileName}';
		/* var img ="${board.attachList}";
		${img} */
	    $(document).ready(function(){
			var $slider = $('#mainSlider').bxSlider({
				pagerCustom : '#sliderPager',
				buildPager : null,
				controls : false 
				/* 이미지슬라이드에 이동버튼 없애기 */
			});
			
			$("#mainSlider").on("click", ".gallery_img", function showImage(path) {
				event.preventDefault();
				$(".imageModalBody").html($(this).children())
				$("#imageModal").modal("show");
				$("#imageModal").attr("style", "margin-top:10%;", "z-index=0;");
			})
			
			if(fn) {
				$("#sliderPager").bxSlider({
					minSlides : 4,
					maxSlides : 4,
					pager: false,
					slideWidth:145
				}); 
			}
	    });
	</script>
<jsp:include page="../includes/footer.jsp"/>