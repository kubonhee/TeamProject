<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 <jsp:include page="../includes/header.jsp"/>
 
<!-- Categories list Section Begin --> 
 <div class="products-catagories-area clearfix">
	<div class="amado-pro-catagory clearfix" id="boardSection">
		<form id="searchForm" style="margin:0 auto;">
			<div class="search">
				<label style="display: inline-flex; margin-bottom:20px; margin-left: 100px;">
					<input type="hidden" name="type" value="TCWD">
					<i class="fas fa-search m-2"></i><input type="search" name="keyword" class="form-control form-control-sm " aria-controls="dataTable" placeholder="검색어를 입력하세요" style="width: 661px;">
					<button class="btn btn-sm btn-warning ml-2">search</button>
				</label>
			</div>
		</form> 
		<div class="row container-lg p-2 m-0">
		<%-- <h1>${list }</h1> --%>
			<c:forEach items="${list}" var="board">
				<div class="boardDiv col-sm-6 col-md-4 p-1">
					<a href="../board/details${pageMaker.cri.listLink}&bno=${board.bno}">
					<div style="height:350px; background:url(${pageContext.request.contextPath}${empty board.attachList ? '/resources/img/noimage.png' : '/display?fileName=' += board.attachList[0].downPath}) no-repeat center; background-size:cover">
					</div>
						<div class="hover-content mt-2">
							<h4 class="text-truncate">${board.title}</h4>
							<ul class="list-style:none;">
								<hr>
								<li>${board.detailaddr}</li>
								<li class="product-price">
									<p><span style="bold; color:#fbb710; font-size:20px;">${board.price} 원</span><span style="float: right; margin-top:5px;"><fmt:formatDate value="${board.regdate}"/></span></p>
								</li>
							</ul>
						</div>
					</a>
				</div>
			</c:forEach>
		</div>
		<div class="row"></div>
	</div>
    <%-- ${pageMaker} --%>
    <div class="row">
      	<div class="col-sm-12 col-md-4">
      		<div class="dataTables_info" id="dataTable_info" role="status" aria-live="polite">${pageMaker.total} entries</div>
      	</div>
      	
	    <div class="pagination-item">
	       <ul class="pagination">
	          <c:if test="${pageMaker.prev}">
	          <li class="paginate_button page-item previous mb-2 mt-3" id="dataTable_previous">
	             <a href="list${pageMaker.cri.listLink2}&pageNum=${pageMaker.startPage - 1}" aria-controls="dataTable" tabindex="0" class="page-link">Prev</a>
	          </li>
	          </c:if>
	          <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
	          <li class="paginate_button page-item mb-2 mt-3 ${num == pageMaker.cri.pageNum ? 'active' : ''}">
	             <a href="list${pageMaker.cri.listLink2}&pageNum=${num}" aria-controls="dataTable" tabindex="0" class="page-link">${num}</a>
	          </li>
	          </c:forEach>
	          <c:if test="${pageMaker.next}">
	          <li class="paginate_button page-item next mb-2 mt-3" id="dataTable_next">
	             <a href="list${pageMaker.cri.listLink2}&pageNum=${pageMaker.endPage + 1}" aria-controls="dataTable" tabindex="0" class="page-link">Next</a>
	          </li>
	          </c:if>
			</ul>
		</div> 
	</div>
 </div> 
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
    <script>
	$(function() {
	    var result = '${result}';
	    
	    checkModal(result);
	    history.replaceState({}, null, null); // 뒤로가기 했을때 전에 있던 캐쉬 제거됨으로써 버그개선
	    function checkModal(result){
	       if(result === '' || history.state){
	          return;
	       }
	       if(parseInt(result) > 0){
	          $(".modal-body").html("게시글 " + result + "번이 등록되었습니다")
	       }
	       $("#myModal").modal("show");
	    }
	    $("#amountNumber").change(function () {
			 console.log(location)
			 location.href = "list${pageMaker.cri.listLink2}&pageNum=" +$(this).val();

	    }).val('${pageMaker.cri.pageNum}');
	    
	    $("#searchMenu").val('${pageMaker.cri.type}')
	    	.next().val('${pageMaker.cri.keyword}')
	 });
</script>
<jsp:include page="../includes/footer.jsp"/>
