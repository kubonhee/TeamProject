<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="includes/header.jsp" />
        <!-- Header Area End -->

        <!-- 비동기처리 게시글 목록 출력-->
        <div class="products-catagories-area clearfix">
            <div class="amado-pro-catagory clearfix" id="boardSection">
                <!-- Single Catagory -->
                <%-- <div class="single-products-catagory clearfix">
                    <a href="shop.html">
                        <img src="${pageContext.request.contextPath}/resources/img/bg-img/1.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>From $180</p>
                            <h4>Modern Chair</h4>
                        </div>
                    </a>
                </div> --%>
            </div>
            <button id="btnShowMore" class="btn btn-warning btn-block">View More</button>
        </div>
        <!-- Product Catagories Area End -->
    </div>
    <!-- ##### Main Content Wrapper End ##### -->
 		<!-- Result Modal-->
		    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		        aria-hidden="true">
		        <div class="modal-dialog" role="document">
		            <div class="modal-content">
		                <div class="modal-header">
		                    <h5 class="modal-title" id="myModalLabel">Alert</h5>
		                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
		                        <span aria-hidden="true">×</span>
		                    </button>
		                </div>
		                <div class="modal-body">처리가 완료되었습니다.</div>
		                <div class="modal-footer">
		                    <button class="btn btn-danger" type="button" data-dismiss="modal">Close</button>
		                </div>
		            </div>
		        </div>
		    </div>
    <!-- ##### Newsletter Area End ##### -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0e5e76b0333590c8c5bce62444180f85&libraries=services"></script>
    <script src="${pageContext.request.contextPath}/resources/js/board.js"></script>
    <script>
    
    var cp = '${pageContext.request.contextPath}';
   	console.log(cp);	
   	showList("");
	
	function showList(bno, cri){
		boardService.getListMore({bno:bno, cp:cp, cri:cri}, function(list) {
			//글 목록 출력
			console.log(list);
			
			//if(page == -1) showList(result.realEnd);
			if(!list.length) {
				$("#btnShowMore").prop("disabled", true).text("추가 글이 없습니다");
			}
			
			var	str = boardService.getBoardDom(list);
			$("#boardSection").html($("#boardSection").html() + str);
			
		})
	}
	// searchBtn event
	$("#searchForm").submit(function() {
		event.preventDefault();
		console.log($(this).serializeObject());
		console.log($(this).serialize());
		$("#boardSection").html(""); //""빈값을 넣어 보드섹션을 비워주는것 그래야 검색한 목록을 보여줄수있음
		showList("", $(this).serialize());
		
	})
	
	
	//btnShowMore 이벤트
	$("#btnShowMore").click(function() {
		var bno = $("#boardSection .boardDiv:last").data("bno");
		showList(bno);
	});
	/* 	window.onscroll = function(e) {
		    //추가되는 임시 콘텐츠
		    //window height + window scrollY 값이 document height보다 클 경우,
		    if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
		    	// 마지막 bno를 가져오기
				var bno = $("#boardSection .boardDiv:last").data("bno");
				// 그 bno를 기반으로 showList호출하기
				showList(bno);
		    }
		}; */
		$(function(){
    		
    		var result = '${result}';
    		
    		checkModal(result);
    		
    		history.replaceState({},null,null); 
    		
    		function checkModal(result){
        		if(result === '' || history.state){
        			return;
        			
        		}
        		if(parseInt(result)>0){
					$(".modal-body").html("게시글 " + result + "번이 등록 되었습니다");      			
        		}
	           		$("#myModal").modal("show");
    		}
    		
    		$("#amountNumber").change(function(){
    			console.log(location);
    			location.href = "list${pageMaker.cri.listLink3}&amount=" + $(this).val();

    		}).val('${pageMaker.cri.amount}');
    		
    		$("#searchMenu").val('${pageMaker.cri.type}')
				.next().val('${pageMaker.cri.keyword}')
		
    	});
		
    $(function() {
    });
		
    </script>
    
<jsp:include page="includes/footer.jsp" />
