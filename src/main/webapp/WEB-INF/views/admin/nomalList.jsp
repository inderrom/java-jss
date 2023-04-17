<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />

<style>
h6{
	width: 150px;
	color: #5c5c5c;
	display: inline-block;
}
h5{
	display: inline-block;
}
</style>
<script type="text/javascript">
var memId;
$(function(){
	var data;
	$(".memBtn").on("click",function(){
		console.log("눌렀음");
		memId = $(this).parent().find("a").html();
		data = {"memId":memId};
		console.log(memId);
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
				$("#memIdDetail").html("("+result.memId+")");
				$("#memNicknameDetail").html(result.memNickname);
				$("#memTelnoDetail").html(result.memTelno);
				$("#memJoinDtDetail").html(result.memJoinDt);

				if(result.memPrvcClctAgreYn=='Y') {
					$("#memPrvcClctAgreYnDetail").html("동의");
				} else if(result.memPrvcClctAgreYn=='N') {
					$("#memPrvcClctAgreYnDetail").html("미동의");
				}

				if(result.memRlsYn=='Y') {
					$("#memRlsYnDetail").html("동의");
				} else if(result.memPrvcClctAgreYn=='N') {
					$("#memRlsYnDetail").html("미동의");
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

				if(result.memAuth == "ROLE_NORMAL"){
					$(".btnAt").html("<button type='button' class='btn btn-outline-danger' id='blockBtn' >차단</button>")
				} else if(result.memAuth == "ROLE_BLOCK") {
					$(".btnAt").html("<button type='button' class='btn btn-outline-danger' id='resolveBtn'>차단해제</button>")
				}
				$("#supportBtn").removeAttr("disabled");
			}
		})
	});

	$(document).on("click","#blockBtn",function(){
		var result = confirm('이 회원을 차단하겟습니까?');
        if(result>0) {
			location.href = "/admin/blockMem?memId="+memId;
			Swal.fire("차단되었습니다.");
        } else {
        }
	});

	$(document).on("click","#resolveBtn",function(){
		var result = confirm('이 회원을 차단해제하겟습니까?');
        if(result>0) {
			location.href = "/admin/noBlockMem?memId="+memId;
			Swal.fire("차단되었습니다.");
        } else {
        }
	});

	$("#supportBtn").on("click",function(){
		console.log(memId);
		data = {"memId":memId, "mCurrentPage":1};
		console.log(data);
		$.ajax({
			url:"/admin/getjobPostingList",
// 			contentType : "application/json;charset:utf-8",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
// 			data:JSON.stringify(data),
			data:data,
			type:"post",
			dataType:"json",
			success:function(result){
				console.log(result) // 배열 result[0] id name
				const conList = result.content;
				/*
				$("#모달 안에 있는 td의 id").val(result[0].jobPstgNo);
				*/
				var code = "";
				var pCode = "";
				for(let i=0;i<conList.length;i++){
					code += "<tr>";
					code += "<td><a href='/admin/firmDetail?entNo="+conList[i].entNo+"'>"+conList[i].entNm+"</a></td>";
					code += "<td><a href='/enterprise/Detail?jobPstgNo="+conList[i].jobPstgNo+"'>"+conList[i].jobPstgTitle+"</a></td>";
					code += "<td>"+conList[i].jobPstgBgngDt+"</td>";
					code += "<td>"+conList[i].jobPstgEndDate+"</td>";
					code += "</tr>";
				}
				console.log(code);
				if(code == ""){
					code += "<tr style='text-align: center;'>";
					code += "<td colspan='4'>지원한 회사가 없습니다.</td>";
					code += "</tr>";
				}
				code += "</table>";
				if(result.total != 0){
					pCode += "<ul class='pagination justify-content-center'>";
					pCode += "	<li class='paginate_button page-item previous ";
					if(result.startPage < 11){
						pCode += "      disabled'";
					}
					pCode += "	'	id='dataTable_previous'>";
					pCode += "		<a href='javascript:' onclick='pageClick(this)'";
					pCode += "			aria-controls='dataTable' data-dt-idx='0' tabindex='0'";
					pCode += "			class='page-link' id='"+(result.startPage-10)+"'>Previous</a>";
					pCode += "	</li>";
					pCode += "";
					// 여기 까지 일단 붙이고
					// 반복문 시작
					for(let i = result.startPage; i<=result.endPage; i++){
						pCode += "		<li class='paginate_button page-item";
						// if문 시작
						if(result.currentPage == i){
							pCode += "			active";
						}
						pCode += "'>";
						// if문 끝
						pCode += "			<a href='javascript:' onclick='pageClick(this)'";
						pCode += "				aria-controls='dataTable' data-dt-idx='1' tabindex='0'";
						pCode += "			class='page-link nodalPage'>"+i+"</a>";
						pCode += "		</li>";
					}
					// 반복문 끝
					pCode += "	<li class='paginate_button page-item next";
					// if문으로 넣기
	// 				pCode += "		<c:if test='${data.endPage ge data.totalPages }'>disabled</c:if>";
					if(result.endPage >= result.totalPages){
						pCode += " disabled'";
					}
					pCode += "	' id='dataTable_next'>";
					pCode += "		<a href='javascript:' onclick='pageClick(this)'";
					pCode += "		   aria-controls='dataTable' data-dt-idx='7' tabindex='0'";
					pCode += "		   class='page-link' id= '"+(result.startPage+10)+"'>Next</a>";
					pCode += "	</li>";
					pCode += "</ul>";
				}
				console.log(code);
				$("#jobCurrent").html(code);
				console.log(pCode);
				$("#page").html(pCode);
			}
		});
	});

// 	$(".nodalPage").on("click",function(){
// 		console.log("페이지 버튼 눌렸음")
// 	});
});

function pageClick(link){
	let value = link.innerHTML;
	console.log(value);
	console.log(memId);
	let idL = link.getAttribute("id");

	console.log(idL);
	if(value == "Previous" || value == "Next" ){
		value = idl;
	}

	data = {"memId":memId, "mCurrentPage":value};
	console.log(data);
	$.ajax({
		url:"/admin/getjobPostingList",
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		data:data,
		type:"post",
		dataType:"json",
		success:function(result){
			console.log(result) // 배열 result[0] id name
			const conList = result.content;
				/*
				$("#모달 안에 있는 td의 id").val(result[0].jobPstgNo);
				*/
			var code = "";
			var pCode = "";
			for(let i=0;i<conList.length;i++){
				code += "<tr>";
				code += "<td><a href='/admin/firmDetail?entNo="+conList[i].entNo+"'>"+conList[i].entNm+"</a></td>";
				code += "<td><a href='/admin/jobPostingDetail?jobPstgNo="+conList[i].jobPstgNo+"'>"+conList[i].jobPstgTitle+"</a></td>";
				code += "<td>"+conList[i].jobPstgBgngDt+"</td>";
				code += "</tr>";
			}
			console.log(code);
			pCode += "<ul class='pagination justify-content-center'>";
			pCode += "	<li class='paginate_button page-item previous ";
			if(result.startPage < 6){
				pCode += "      disabled'";
			}
			pCode += "	'	id='dataTable_previous'>";
			pCode += "		<a href='javascript:' onclick='pageClick(this)'";
			pCode += "			aria-controls='dataTable' data-dt-idx='0' tabindex='0'";
			pCode += "			class='page-link' id='"+(result.startPage-5)+"'>Previous</a>";
			pCode += "	</li>";
			pCode += "";
			// 여기 까지 일단 붙이고
			// 반복문 시작
			for(let i = result.startPage; i<=result.endPage; i++){
				pCode += "		<li class='paginate_button page-item";
				// if문 시작
				if(result.currentPage == i){
					pCode += "			active";
				}
				pCode += "'>";
				// if문 끝
				pCode += "			<a href='javascript:' onclick='pageClick(this)'";
				pCode += "				aria-controls='dataTable' data-dt-idx='1' tabindex='0'";
				pCode += "			class='page-link nodalPage'>"+i+"</a>";
				pCode += "		</li>";
			}
				// 반복문 끝
			pCode += "	<li class='paginate_button page-item next";
				// if문으로 넣기
//				pCode += "		<c:if test='${data.endPage ge data.totalPages }'>disabled</c:if>";
			if(result.endPage >= result.totalPages){
				pCode += " disabled'";
			}
			pCode += "	' id='dataTable_next'>";
			pCode += "		<a href='javascript:' onclick='pageClick(this)'";
			pCode += "		   aria-controls='dataTable' data-dt-idx='7' tabindex='0'";
			pCode += "		   class='page-link' id= '"+(result.startPage+5)+"'>Next</a>";
			pCode += "	</li>";
			pCode += "</ul>";
			console.log(code);

			$("#jobCurrent").html(code);
			console.log(pCode);

			$("#page").html(pCode);
			if(code == ""){
				code += "<tr style='text-align: center;'>";
				code += "<td colspan='4'>지원한 회사가 없습니다.</td>";
				code += "</tr>";
			}
		}
	});
}

</script>

<div class="content-header">
	<h5>일반회원 목록</h5>
</div>

<div class="card">
	<div class="card-body">
		<form>
			<div class="row">
				<div class="col-sm-2">
					<select class="form-control" id="sel1" name="searchType">
						<option value="name"
							<c:if test="${param.searchType == 'name' }"><c:out value="selected"/></c:if>>이름</option>
						<option value="id"
							<c:if test="${param.searchType == 'id' }"><c:out value="selected"/></c:if>>아이디</option>
					</select>
				</div>
				<div class="col-md-7">
					<input type="search" placeholder="검색어를 입력해주세요" name="keyword"
						value="${param.keyword}"
						class="form-control form-control-md" />
				</div>
				<div class="col-md-3">
					<button type="submit"
						class="col-md-12 btn btn-block btn-outline-dark">Search</button>
				</div>
			</div>
		</form>
	</div>
	<div class="col-12">
		<table class="table table-head-fixed text-nowrap">
			<thead>
				<tr style="text-align: center;">
					<th>번호</th>
					<th>이름</th>
					<th>아이디</th>
					<th>멤버십</th>
					<th>차단 여부</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="memVo" items="${data.content}" varStatus="stat">
					<tr style="text-align: center;">
						<td>${memVo.rnum}</td>
						<td>${memVo.memNm}</td>
						<td><a type="button" class="memBtn" data-toggle="modal" data-target="#memDetail">${memVo.memId}</a></td>
						<td>
							<c:choose>
								<c:when test="${memVo.vipGrdNo eq 'VIPGRD0001'}"> 멤버십 </c:when>
								<c:otherwise> - </c:otherwise>
							</c:choose>
						</td>
						<td><c:if test="${memVo.memAuth=='ROLE_BLOCK'}">차단회원</c:if>
							<c:if test="${memVo.memAuth!='ROLE_BLOCK'}">일반회원</c:if></td>
					</tr>
				</c:forEach>
				<c:if test="${data.total == 0}">
					<td colspan="6" style="text-align: center;">검색된 회원이 없습니다.</td>
				</c:if>
			</tbody>
		</table>
		<div class="clearfix">
			<c:if test='${data.total != 0 }'>
				<ul class="pagination justify-content-center">
					<li class="paginate_button page-item previous
						<c:if test='${data.startPage lt 6 }'>disabled</c:if>" id="dataTable_previous">
							<a href="/admin/nomalList?currentPage=${data.startPage-5}&keyword=${param.keyword}&searchType=${param.searchType}"
						 	   aria-controls="dataTable" data-dt-idx="0" tabindex="0"
						        class="page-link">Previous</a>
					</li>
					<c:set var="currentPage" value="${not empty param.currentPage ? param.currentPage : 1}" />
					<c:forEach var="pNo" begin="${data.startPage}" end="${data.endPage}">
						<li class="paginate_button page-item <c:if test='${currentPage eq pNo}'> active</c:if>">
							<a href="/admin/nomalList?currentPage=${pNo}&keyword=${param.keyword}&searchType=${param.searchType}"
							   aria-controls="dataTable" data-dt-idx="1" tabindex="0"
							   class="page-link"> ${pNo} </a>
						</li>
					</c:forEach>
					<li class="paginate_button page-item next
						<c:if test='${data.endPage ge data.totalPages }'>disabled</c:if>"
						id="dataTable_next">
						<a href="/admin/nomalList?currentPage=${data.startPage+5}&keyword=${param.keyword}&searchType=${param.searchType}"
						   aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link"> Next </a>
					</li>
				</ul>
			</c:if>
		</div>
	</div>
</div>




<!-- 기업 상세페이지 열기 -->
<div class="modal fade" id="memDetail">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header row" style="justify-content: flex-end;">
				<button type="button" class="btn btn-outline-info checkBtn" id="supportBtn" style="margin-right: 10px;"
				        data-toggle="modal" data-target="#myModal" >지원회사</button>
		        <div class="btnAt"></div>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<div class="card-body row box-profile">
					<img class="profile-user-img img-fluid profileImg" style="width: 250px;height: 200px;margin-bottom: 20px;"
						src="/resources/images/login.jpg" alt="프로필">
					<div class="col">
						<ul class="list-group list-group-unbordered mb-3">
							<li class="list-group-item">
								<h6><i class="material-icons">keyboard_arrow_right</i>이름(아이디)</h6>
								<h5 id="memNmDetail" style="text-align: center;"></h5>
								<h5 id="memIdDetail" style="text-align: center;"></h5>
							</li>
							<li class="list-group-item">
								<h6><i class="material-icons">keyboard_arrow_right</i>전화번호</h6>
								<h5 id="memTelnoDetail" style="text-align: center;"></h5>
							</li>
							<li class="list-group-item">
								<h6><i class="material-icons">keyboard_arrow_right</i>가입 일</h6>
								<h5 id="memJoinDtDetail" style="text-align: center;"></h5>
							</li>
							<li class="list-group-item">
								<h6><i class="material-icons">keyboard_arrow_right</i>한줄 소개</h6>
								<h5 id="memDescriptionDetail" style="text-align: center;"></h5>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>



<!-- The Modal -->
<div class="modal fade" id="myModal">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">지원 현황</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<div class="card-body">
					<table class="table table-head-fixed text-nowrap">
						<thead>
							<tr>
								<th>기업명</th>
								<th>채용공고</th>
								<th>시작일</th>
								<th>종료일</th>
							</tr>
						</thead>
						<tbody id="jobCurrent"></tbody>
					</table>
					<div class="card-footer clearfix" id="page">
						<ul class="pagination justify-content-center">
							<li class="paginate_button page-item previous <c:if test='${data.startPage lt 11 }'>disabled</c:if>"
								id="dataTable_previous">
								<a href="/admin/nomalList?currentPage=${data.startPage-10}&keyword=${param.keyword}&searchType=${param.searchType}"
								   aria-controls="dataTable" data-dt-idx="0" tabindex="0"
								   class="page-link">Previous</a>
							</li>
							<c:forEach var="pNo" begin="${data.startPage}" end="${data.endPage}">
								<li class="paginate_button page-item
								<c:if test='${param.currentPage==pNo}'> active</c:if> ">
									<a href="/admin/nomalList?currentPage=${pNo}&keyword=${param.keyword}&searchType=${param.searchType}"
									   aria-controls="dataTable" data-dt-idx="1" tabindex="0"
									   class="page-link"> ${pNo} </a>
								</li>
							</c:forEach>
							<li
								class="paginate_button page-item next
						<c:if test='${data.endPage ge data.totalPages }'>disabled</c:if>"
							  id="dataTable_next">
							<a href="/admin/nomalList?currentPage=${data.startPage+10}&keyword=${param.keyword}&searchType=${param.searchType}"
							   aria-controls="dataTable" data-dt-idx="7" tabindex="0"
							   class="page-link"> Next </a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


