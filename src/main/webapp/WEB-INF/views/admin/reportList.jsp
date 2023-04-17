<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.nav-pills .nav-link.active {
    background-color: silver;
    color: white;
}

</style>

<script type="text/javascript">
var memId;
var rptNo;
$(function(){
	var data;
	$(".memBtn").on("click",function(){
		console.log("눌렀음");
		memId = $(this).parent().find("a").html();
		rptNo = $(this).attr("id");
		data = {"memId":memId};
		console.log(memId);
		console.log(rptNo);
		console.log(data);
		$.ajax({
			url:"/admin/getMemDetail",
			contentType : "application/json;charset:utf-8",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			success:function(result){
				console.log(result);
				$("#memNmDetail").html(result.memNm);
				$("#memIdDetail").html(result.memId);
				$("#memPassDetail").html(result.memPass);
				$("#memTelnoDetail").html(result.memTelno);
				$("#memJoinDtDetail").html(result.memJoinDt);
				if(result.memPrvcClctAgreYn=='Y') {
					$("#memPrvcClctAgreYnDetail").html("동의");
				} else if(result.memPrvcClctAgreYn=='N') {
					$("#memPrvcClctAgreYnDetail").html("동의하지 않음");
				}
				if(result.memRlsYn=='Y') {
					$("#memRlsYnDetail").html("동의");
				} else if(result.memPrvcClctAgreYn=='N') {
					$("#memRlsYnDetail").html("동의하지 않음");
				}
				$("#memVipDetail").html(result.vip);
				$("#memDescriptionDetail").html(result.memDescription);
				$("#blockBtn").removeAttr("disabled");
				att = result.boardAttVOList[0]
				if(att != null){
					img = result.boardAttVOList[0].attNm;
					$(".profileImg").attr("src","/resources/images"+img);
				} else {
					$(".profileImg").attr("src","/resources/images/login.jpg");
				}
				$("#supportBtn").removeAttr("disabled");
			}
		});
	});

	$("#blockBtn").on("click",function(){
		var result = confirm('이 회원을 차단하겟습니까?');
        if(result>0) {
			location.href = "/admin/reportBlockMem?memId="+memId+"&rptNo="+rptNo;
        	alert("차단되었습니다.");
        } else {
        }
	});

});
</script>

<div class="content-header">
	<h5>신고회원 관리</h5>
</div>

<form>
	<div class="card">
		<div class="card-body">
			<div class="card-body">
				<div class="row">
					<div class="col-md-3">
						<select class="form-control" id="sel1" name="searchType">
							<option value="name"
								<c:if test="${param.searchType == 'name' }"><c:out value="selected"/></c:if>>이름</option>
							<option value="id"
								<c:if test="${param.searchType == 'id' }"><c:out value="selected"/></c:if>>아이디</option>
							<option value="rptRsn"
								<c:if test="${param.searchType == 'rptRsn' }"><c:out value="selected"/></c:if>>신고
								사유</option>
						</select>
					</div>
					<div class="col-md-7">
						<input type="text" placeholder="검색어를 입력해주세요"
							value="${param.keyword}" name="keyword"
							class="form-control form-control-md" />
					</div>
					<div class="col-md-2">
						<button type="submit" class="btn btn-block btn-outline-dark">Search</button>
					</div>
				</div>
			</div>
			<div class="col-12">
				<table class="table" style="margin: 0.5px;">
					<thead style="text-align: center;">
						<tr>
							<th>번호</th>
							<th>아이디</th>
							<th>이름</th>
							<th>신고 사유</th>
							<th>신고자 아이디</th>
							<th>신고 일자</th>
							<th>신고 분류</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="reportVo" items="${nomal.content}"
							varStatus="stat">
							<tr style="text-align: center;">
								<td>${reportVo.rnum}</td>
								<td><a type="button" class="memBtn" id="${reportVo.rptNo}">${reportVo.reportingList[0].memId}</a></td>
								<td>${reportVo.reportingList[0].memNm}</td>
								<td>${reportVo.rptRsn}</td>
								<td>${reportVo.memId}</td>
								<td>${reportVo.rptRegDt}</td>
								<td>${reportVo.rptClfcNm}</td>
							</tr>
						</c:forEach>
						<c:if test="${reportVo.total == 0}">
							<td colspan="6" style="text-align: center;">검색된 회원이 없습니다.</td>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
		<div class="card-footer clearfix">
			<c:if test='${nomal.total != 0 }'>
				<ul class="pagination justify-content-center">
					<li
						class="paginate_button page-item previous  <c:if test='${nomal.startPage lt 11 }'>disabled</c:if>"
						id="dataTable_previous"><a
						href="/admin/reportList?currentPage=${nomal.startPage-10}&keyword=${param.keyword}&searchType=${param.searchType}"
						aria-controls="dataTable" data-dt-idx="0" tabindex="0"
						class="page-link">Previous</a></li>
					<c:set var="currentPage"
						value="${not empty param.currentPage ? param.currentPage : 1}" />
					<c:forEach var="pNo" begin="${nomal.startPage}"
						end="${nomal.endPage}">
						<li
							class="paginate_button page-item <c:if test='${currentPage eq pNo}'> active</c:if> ">
							<a
							href="/admin/reportList?currentPage=${pNo}&keyword=${param.keyword}&searchType=${param.searchType}&tabName=normal"
							aria-controls="dataTable" data-dt-idx="1" tabindex="0"
							class="page-link"> ${pNo} </a>
						</li>
					</c:forEach>
					<li
						class="paginate_button page-item next <c:if test='${nomal.endPage ge nomal.totalPages }'>disabled</c:if>"
						id="dataTable_next"><a
						href="/admin/reportList?currentPage=${nomal.startPage+10}&keyword=${param.keyword}&searchType=${param.searchType}"
						aria-controls="dataTable" data-dt-idx="7" tabindex="0"
						class="page-link"> Next </a></li>
				</ul>
			</c:if>
		</div>
	</div>
</form>

<div class="card">
	<div class="card-body">
		<div class="card-body row box-profile">
		<img class="profile-user-img img-fluid profileImg" style="width: 200px;height: 200px;margin: 10px;" src="/resources/images/login.jpg" alt="프로필">
			<div class="col">
				<ul class="list-group list-group-unbordered mb-3">
					<li class="list-group-item">
						<div class="row">
							<div class="col" style="display: inherit;">
								<h6>이름 : &nbsp;&nbsp;</h6><h5 id="memNmDetail" style="text-align: center;"></h5>(<h5 id="memIdDetail" style="text-align: center;"></h5>)
							</div>
						</div>
					</li>
					<li class="list-group-item">
						<div class="row"><h6>전화번호 : &nbsp;&nbsp;</h6> <h5 id="memTelnoDetail" style="text-align: center;"></h5></div>
					</li>
					<li class="list-group-item">
						<div class="row"><h6>가입 일 : &nbsp;&nbsp;</h6> <h5 id="memJoinDtDetail" style="text-align: center;"></h5></div>
					</li>
					<li class="list-group-item">
						<div class="row"><h6>한줄 소개 : &nbsp;&nbsp;</h6> <h5 id="memDescriptionDetail" style="text-align: center;"></h5></div>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="card-footer">
		<div class="row">
			<div class="col-md-6"></div>
			<div class="col-md-6">
				<button type="button" class="btn btn-block btn-outline-danger"
					inputmode="text" id="blockBtn" disabled>차단</button>
			</div>
		</div>
	</div>
</div>
