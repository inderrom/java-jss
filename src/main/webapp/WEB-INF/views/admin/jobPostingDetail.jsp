<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<style>
h3{
	border-bottom: 1px solid #0000004f;
	padding-bottom: 1%;
    margin-bottom: 15px;
}
</style>
<script type="text/javascript" src="/resources/adminlte3/plugins/summernote/summernote.js"></script>
<script type="text/javascript">

function permitJobpost (post){
	console.log(post);
	postNo = post.getAttribute("data-no");
	console.log(postNo);
	$("#goPermit").submit();
}

function noPermitJobpost (post){

	console.log(post);

	postNo = post.getAttribute("data-no");

	console.log(postNo);

	$("#noPermit").submit();
}

</script>

<div class="content-header">
	<h5>채용공고 상세</h5>
</div>

<div class="card card-default">
	<div class="card-body">
		<div class="row">
			<div class="col-10">
				<p style="font-size: xx-large;">
					${data.jobPstgTitle }<br/> 
					<small>${data.entNm}</small> 
				</p>
			</div>
			<div class="col" style="text-align: right;">
				<c:if test="${data.jobPstgAprvYn == 'N'}">
					<form action="/admin/permitJobpost" method="post" style="display: inline-block;">
						<input type="hidden" name = "jobPstgNo" value="${data.jobPstgNo}" />
						<button class="btn btn-outline-success" onclick="permitJobpost(this)" data-no ="${data.jobPstgNo}">승인하기</button>
						<sec:csrfInput />
					</form>
				</c:if>
				<c:if test="${data.jobPstgAprvYn == 'Y'}">
					<form action="/admin/noPermitJobpost" method="post" style="display: inline-block;">
						<input type="hidden" name = "jobPstgNo" value="${data.jobPstgNo}" />
						<button class="btn btn-outline-danger" onclick="noPermitJobpost(this)" data-no ="${data.jobPstgNo}">승인취소</button>
						<sec:csrfInput />
					</form>
				</c:if>
				<button class="btn btn-outline-info" onclick="javascript:location.href='/admin/jobPostingList'">목록</button>
			</div>
		</div>
		<div class="card-body">
			<div class="form-group">
				<h3 class="text_content"><i class="material-icons">label</i> 주요 내용</h3>
				<h5 class="NanumSquareNeo pl-2">${fn:replace(fn:replace(fn:escapeXml(data.jobPstgContent), CRLF, '<br/>'), LF, '<br/>')}</h5>
				<br/><br/>
			</div>

			<div class="form-group">
				<h3 class="text_content"><i class="material-icons">label</i> 주요업무</h3>
				<h5 class="NanumSquareNeo pl-2">${fn:replace(fn:replace(fn:escapeXml(data.jobPstgMainWork), CRLF, '<br/>'), LF, '<br/>')}</h5>
				<br/><br/>
			</div>

			<div class="form-group">
				<h3 class="text_content"><i class="material-icons">label</i> 우대사항</h3>
				<h5 class="NanumSquareNeo pl-2">${fn:replace(fn:replace(fn:escapeXml(data.jobPstgRpfntm), CRLF, '<br/>'), LF, '<br/>')}</h5>
				<br/><br/>
			</div>

			<div class="form-group">
				<h3 class="text_content"><i class="material-icons">label</i> 혜택 및 복지</h3>
				<h5 class="NanumSquareNeo pl-2">${fn:replace(fn:replace(fn:escapeXml(data.jobPstgBnf), CRLF, '<br/>'), LF, '<br/>')}</h5>
				<br/><br/>
			</div>

			<div class="form-group">
				<h3 class="text_content"><i class="material-icons">label</i> 기간</h3>
				<h5 class="NanumSquareNeo pl-2">${data.jobPstgBgngDt} ~ ${data.jobPstgEndDate}</h5>
				<br/><br/>
			</div>

			<div class="form-group">
				<h3 class="text_content"><i class="material-icons">label</i> 관련 태그</h3>
				<div class="row mt-4">
					<c:forEach var="tagVo" items="${data.jobPostingTagVOList}" varStatus="stat">
						<button class="btn tag_style" style="height: 10%; background-color: #5B7EFA;color: white;font-size: large;">${tagVo.jobPstgTagNm}</button><p>&nbsp;&nbsp;</p>
					</c:forEach>
				<br/><br/>
				</div>
			</div>
		</div>
	</div>
</div>
