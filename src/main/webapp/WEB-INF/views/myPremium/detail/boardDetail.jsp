<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<sec:authentication property="principal.memVO" var="memVO" />

<%-- ${brdDetail } --%>
<main>
	<div>
		<form role="form" id="frm" action="/board/boardInsert" method="post" enctype="multipart/form-data" autocomplete="off">
			<input type="hidden" id="memId" name="memId" value="${memVO.memId}" />
		
			<div class="card-body pb-2">
				<div class="position-relative mt-n4 z-index-2">
					<div class="bg-white shadow-primary border-radius-lg p-3">
						<h4 class="NanumSquareNeo text-black mb-3">${brdDetail.itnsCmmuTitle}</h4>
						<div class="row">
							<div class="col text-black opacity-8 text-end mb-0">
								<h6>${brdDetail.memNm}</h6>
								<fmt:formatDate pattern="yyyy.MM.dd" value="${brdDetail.itnsCmmuRegDt}"/>
							</div>
						</div>
					</div>
				</div>
				<div class="input-group my-4 input-group-static">
					<h5 class="NanumSquareNeo px-5 min-height-300">	
						${fn:replace(fn:replace(fn:escapeXml(brdDetail.itnsCmmuContent), CRLF, '<br/>'), LF, '<br/>')}
						<br/>
						<c:forEach var="attList" items="${brdDetail.attList}" varStatus="stat">
							<c:if test="${attList.attClfcNo eq 'ATTCL0014'}">
								<img src="/resources/images${attList.attNm}" style="width: 50%;" />
							</c:if>
						</c:forEach>
					</h5>
				</div>
			</div>
			<sec:csrfInput/>
		</form>
		<c:if test="${memVO.memId eq brdDetail.memId }">
			<div class="dropdown col text-end" >
				<button class="btn dropdown-toggle" type="button" id="dropdownBrdButton" data-bs-toggle="dropdown" aria-expanded="false"></button>
				<ul class="dropdown-menu px-2 py-3" aria-labelledby="dropdownBrdButton">
					<li><a class="dropdown-item border-radius-md" 
							href="javascript:location.href='/board/boardUpdate?boardNo=${boardVO.boardNo}';">수정</a></li>
					<li><a class="dropdown-item border-radius-md" 
							href="javascript:location.href='/board/boardDelete?boardNo=${boardVO.boardNo}';">삭제</a></li>
				</ul>
			</div>
		</c:if>
		
		<hr style="border-top: black 1px solid;" />
			
		<div id="cmntDiv">
			<!-- 댓글 시작 -->
			<c:choose>
				<c:when test="${fn:length(brdDetail.cmntList) > 0}">
					<c:forEach var="cmntVO" items="${brdDetail.cmntList}" varStatus="stat">
					
						<div id="${cmntVO.itnsCmmuCmntNo }" class="row align-items-center p-3">
							<div class="col">
								<!-- 프로필 사진 등록 여부 체크 -->
								<c:choose>
									<c:when test="${cmntVO.attNm != null}">
										<img src="/resources/images${cmntVO.attNm}" alt="프로필" class="avatar shadow border-radius-lg" />
									</c:when>
									<c:otherwise>
										<img src="/resources/images/icon/hand-print.png" alt="프로필" class="avatar shadow border-radius-lg" />
									</c:otherwise>
								</c:choose>
								<!-- 프로필 사진 등록 여부 체크 -->
								${cmntVO.memNm}
							</div>
							
							<div class="col-9 px-5 cmntCont">
								${cmntVO.itnsCmmuCmntContent}
							</div>
							
							<div class="col text-end">
								<c:if test="${memVO.memId eq cmntVO.memId }">
									<a class="text-end cmntDelete" data-cmmucmntno="${cmntVO.itnsCmmuCmntNo}">
										<i class="material-icons text-dark opacity-5">clear</i>
									</a>
								</c:if>
							</div>
						</div>
						
					</c:forEach>
				</c:when>
				<c:otherwise>
					<h6 id="emptyReply" style="text-align: center;margin: 100px;">첫 댓글을 등록해보세요!</h6>
				</c:otherwise>
			</c:choose>
			<!-- 댓글 끝 -->
		</div>

		<div class="input-group mb-4 input-group-static p-3">
			<textarea id="cmntContent" name="cmntContent" class="form-control" id="message" rows="4" placeholder="댓글을 등록해보세요."></textarea>
		</div>
			
		<div class="input-group mb-4 input-group-static p-3 justify-content-between">
			<button type="button" id="backToList" data-itnsno="${itnsNo}" class="btn btn-outline-secondary">목록</button>
			<button type="button" id="cmntIn" data-cmmuno="${brdDetail.itnsCmmuNo}" class="btn btn-light w-auto me-2" style="float: right;">등록</button>
		</div>
	</div>
</main>


<script type="text/javascript">
$(function(){
	$("#backToList").on("click", function(){
		console.log("#backToList itnsNo : " + itnsNo);
		
		$.ajax({
			url : "/myPremium/boardList",
			type : "post",
			data : {"itnsNo":itnsNo},
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success : function(result) {
				console.log(result);
				$("#note").html(result);
			}
		});
	});
	
	$(document).on("click",".cmntDelete", function(){
		let cmntNo = $(this).data("cmmucmntno");
		console.log("#cmntDelete cmntNo : ", cmntNo);
		
		$.ajax({
			url : "/myPremium/cmntDelete",
			type : "get",
			data : {"cmntNo":cmntNo},
			success : function(result) {
				$("#"+cmntNo).remove();
				
				let divArr = $(this)
			}
		});
	});
	
	$("#cmntIn").on("click", function(){
		let cmmuNo = $(this).data("cmmuno");
		let memId = "${memVO.memId}";
		let content = $("#cmntContent").val();
		$("#cmntContent").val("");
		
		if(content != null && content != ""){
			$.ajax({
				url : "/myPremium/cmntInsert",
				type : "post",
				data : {"cmmuNo":cmmuNo, "memId":memId, "content":content},
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success : function(result) {
					console.log("성공~! ", result);
					$("#emptyReply").remove();
					$("#cmntDiv").append(result);
				}
			});
		}
	});
});
</script>