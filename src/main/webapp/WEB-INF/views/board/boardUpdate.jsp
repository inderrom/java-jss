<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript">
$(function(){
	$("tr").on("click",function(){
		let txt = $(this).find("td").eq(0).attr("id");
		location.href="/board/boardDetail?boardNo="+txt;
	});
	
	$("#brdModi").on("click",function(){
		$("#frm").submit();
	});
	
	$("#cancle").on("click",function(){
		history.back();
	});
	
});
</script>

<main>
	<section class="pt-3 pt-md-5 pb-md-5">
		<div class="container blur border-radius-lg p-5" style="min-height: 1000px;justify-content: center;background-color: rgb(255 244 244 / 60%) !important;">
			<div class="row">
				<div class="col mx-auto d-flex justify-content-center flex-column">
					<div class="card d-flex justify-content-center p-4 shadow-lg">
						<div class="card card-plain">
							<form role="form" id="frm" action="/board/boardUpdate" method="post" autocomplete="off">
							<input type="hidden" id="memId" name="memId" value="${boardVO.memId}" />
							<input type="hidden" id="boardNo" name="boardNo" value="${boardVO.boardNo}" />
								<div class="card-body pb-2">
									<div class="mb-4">
										<div class="input-group mb-4 input-group-static">
											<label>제목</label>
											<input type="text" id="boardTitle" name="boardTitle" class="form-control" value="${boardVO.boardTitle}" style="font-size: x-large;" />
										</div>
									</div>
									<div class="input-group mb-4 input-group-static">
										<label>내용</label>
										<textarea id="boardContent" name="boardContent" class="form-control" rows="30" style="font-size: x-large;" >${boardVO.boardContent}</textarea>
									</div>
									<c:forEach items="${boardVO.boardAttVOList }" var="boardAttVOList">
							            <div class="col">
							            	<i class="material-icons">attachment</i> <strong style="font-size: x-large;" >${fn:substringAfter(boardAttVOList.attNm, "_")}</strong> <a href='#' id='file-delete'><i class="material-icons">clear</i></a>
							            </div>
							        </c:forEach>
									<div class="row">
										<div class="col-md-12" >
											<button type="button" id="cancle" class="btn btn-secondary" style="float: right;margin-left: 5px;">취소</button>
											<button type="button" id="brdModi" class="btn btn-success" style="float: right;">수정</button>
										</div>
									</div>
								</div>
								<sec:csrfInput/>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</main>