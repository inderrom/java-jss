<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<sec:authorize access="isAuthenticated()"> 
	<sec:authentication property="principal.memVO" var="memVO"/>
</sec:authorize>

<script type="text/javascript">
$(function() {
	let jsmemId = "${memVO.memId}";
	
	$.ajax({
		url:"/mem/memSearch",
		data: {"memId": jsmemId},
		type:"post",
		beforeSend : function(xhr) {
		       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
		   console.log(result);
		   if(result.attNm != null && result.attNm != ""){
			   $("#myprofileCMNT").attr("src", "/resources/images"+result.attNm);
		   }
		}
	});
	
	$("#cmntIn").on("click", function(){
		if(jsmemId == null || jsmemId == ""){
			location.href = "/login";
			return;
		}
		
		$("#isOk").text("");
		let cmnt = $("#cmntContent").val();
		console.log("cmntContent : " + cmnt);
		
		if(cmnt.length > 0){
			$("#frm").attr("action","/board/boardCommentInsert");
			$("#frm").submit();
		}else{
			$("#isOk").text("내용을 입력해주세요.");
			$("#isOk").css("color","red");
		}
	});
	
	$("#backToList").on("click", function(){
		location.href="/board/boardList?boardClfcNo=BRDCL0003"
	});
	
	$("#prevNo").on("click", function(){
		let prev = $(this).data("prev");
		location.href = "/board/boardDetail?boardNo=" + prev;
	});
	
	$("#nextNo").on("click", function(){
		let next = $(this).data("next");
		location.href = "/board/boardDetail?boardNo=" + next;
	});

	//파일 다운로드 하기
	$("#btnDownload").on("click",function(){
		let fnm = $(this).data("filename");
		console.log("fnm : " + fnm);
		let vIfrm = document.getElementById("ifrm");
		vIfrm.src = "/download?fileName="+fnm;
	});
});
</script>

<main>
	<section class="pt-3 pt-md-5">
		<div class="container blur border-radius-lg p-5 pt-6" style="background-color: rgb(255 244 244 / 60%) !important;">
			
			<form id="frm" action="/board/boardUpdate" method="post" >
				<input type="hidden" id="memId" name="memId" value="${memVO.memId}" />
				<input type="hidden" id="boardNo" name="boardNo" value="${boardVO.boardNo}" />
				
				<!-- 글 시작 -->
				<div class="position-relative mt-n4 z-index-2">
					<div class="bg-white shadow-primary border-radius-lg p-3">
						<h3 class="text-black mb-0">${boardVO.boardTitle}
							<c:if test="${boardVO.boardClfcNo eq 'BRDCL0003'}">
								<h6 class="text-black text-end opacity-8 mb-0">
									<fmt:formatDate pattern="yyyy.MM.dd HH:mm" value="${boardVO.boardRegDt}"/>
									<a href="/mem/myBoardList?memId=${boardVO.memId}" >${boardVO.memNm}</a>
								</h6>
							</c:if>
						</h3>
					</div>
				</div>
				
				<div class="bg-white border-radius-lg p-5" style="min-height: 1000px;">
					<h5 style="min-height:300px; font-size: medium;">
						${fn:replace(fn:replace(fn:escapeXml(boardVO.boardContent), CRLF, '<br/>'), LF, '<br/>')}
						<br/>
						<c:forEach var="boardAttVOList" items="${boardVO.boardAttVOList}" varStatus="stat">
							<c:if test="${boardAttVOList.attClfcNo eq 'ATTCL0007'}">
								<img src="/resources/images${boardAttVOList.attNm}" style="width: 50%;" />
							</c:if>
						</c:forEach>
					</h5>
				
					<br/>
					<br/>
					<br/>
					<c:if test="${boardVO.boardClfcNo eq 'BRDCL0003'}">
						<div class="row">
							<div class="col-10">
								<img alt=".." src="/resources/images/comment.png" style="width: 30px;margin-right: 5px;" />${boardVO.cmntCnt}
								<c:forEach var="boardAttVOList" items="${boardVO.boardAttVOList}" varStatus="stat">
									<c:if test="${boardAttVOList.attClfcNo eq 'ATTCL0008'}">
										<button type="button" id="btnDownload" data-filename="${boardAttVOList.attNm}" >
											<img class="avatar avatar-sm border-radius-xl" src="/resources/images/attach_file.png">
										</button>
									</c:if>
								</c:forEach>
							</div>
							<c:if test="${memVO.memId eq boardVO.memId }">
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
						</div>
						<!-- 글 끝 -->
						
						<hr style="border-top: black 1px solid;" />
					
						<!-- 댓글 시작 -->
						<c:choose>
							<c:when test="${fn:length(boardVO.boardCmntVOList) > 0}">
								<c:forEach var="cmntVO" items="${boardVO.boardCmntVOList}" varStatus="stat">
									<div class="row d-flex align-items-center thiba">
	      								<div class="author align-items-center col-lg-3">
	      								
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
											
											<div class="name ps-3">
												<h6>${cmntVO.memNm}</h6>
												<div class="stats">
													<small>4년차</small>
												</div>
											</div>
										</div>
										
		   								<div class="col-lg-8 col-md-6 cmntCont" data-input="hi">
		   									<h5>${fn:replace(fn:replace(fn:escapeXml(cmntVO.cmntContent), CRLF, '<br/>'), LF, '<br/>')}</h5>
										</div>
										
										<c:if test="${memVO.memId eq cmntVO.memId }">
											<div class="dropdown col-lg-1 text-end">
												<button class="btn dropdown-toggle" type="button" id="dropdownCmntButton" data-bs-toggle="dropdown" aria-expanded="false"></button>
												<ul class="dropdown-menu px-2 py-3" aria-labelledby="dropdownCmntButton">
													<li>
														<a class="dropdown-item border-radius-md" 
														   href="javascript:location.href='/board/boardCommentDelete?cmntNo=${cmntVO.cmntNo}&boardNo=${boardVO.boardNo}';">삭제</a>
													</li>
												</ul>
											</div>
		 								</c:if>
		 								
									</div>
									<hr style="border-top: black 1px solid;" />
								</c:forEach>
							</c:when>
							<c:otherwise><h6 style="text-align: center;margin: 100px;">첫 댓글을 등록해보세요!</h6></c:otherwise>
						</c:choose>
						<!-- 댓글 끝 -->
					
					
						<br/>
						<div class="author align-items-center">
							<img id="myprofileCMNT" src="/resources/images/icon/hand-print.png" alt="..." class="avatar shadow border-radius-lg">
    								
							<div class="name ps-3">
								<span style="font-size: inherit;">${memVO.memNm}</span>
							</div>
						</div>
						<div class="input-group mb-4 input-group-static">
							<textarea id="cmntContent" name="cmntContent" class="form-control" id="message" rows="4" placeholder="댓글을 등록해보세요." style="width: 80%;"></textarea>
							<span id="isOk"></span>
							<button type="button" id="cmntIn" class="btn btn-light w-auto me-2" style="float: right;margin: 1px;" >등록</button>
						</div>
						<div class="row" style="justify-content: space-evenly;">
							<button type="button" id="prevNo" class="btn btn-outline-secondary" style="width: 44%;"data-prev="${boardVO.prevNo }" <c:if test="${boardVO.prevNo eq null}">disabled</c:if>>
								<h6><i class="material-icons">arrow_back</i> ${fn:substring(boardVO.prevTitle, 0, 30)}</h6>
							</button>
							<button type="button" id="backToList" class="btn btn-outline-secondary" style="width: 10%;"><h6>목록</h6></button>
							<button type="button" id="nextNo" class="btn btn-outline-secondary" style="width: 44%;" data-next="${boardVO.nextNo }" <c:if test="${boardVO.nextNo eq null}">disabled</c:if>>
								<h6>${fn:substring(boardVO.nextTitle, 0, 30)} <i class="material-icons">arrow_forward</i></h6>
							</button>
						</div>
						<sec:csrfInput/>
					</c:if>
				</div>
	        </form>
		</div>
	</section>
	<iframe title="ifrm" id="ifrm" name="ifrm" style="display:none;"></iframe>
</main>
