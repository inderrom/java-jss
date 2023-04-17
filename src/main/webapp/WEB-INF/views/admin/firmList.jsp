<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
h6{
	width: 200px;
	color: #5c5c5c;
	display: inline-block;
}
h5{
	display: inline-block;
}
</style>
<script type="text/javascript">
var memId = "";
$(function(){
	$(".memBtn").on("click",function(){
		console.log("눌렀음");

		$("#postCheck").removeAttr("disabled");
		$("#blockBtn").removeAttr("disabled");

		memId = $(this).parent().find("a").html();
		data = {"memId":memId};
		console.log(memId);
		console.log(data);
		$.ajax({
			url:"/admin/getFirmDetail",
			contentType : "application/json;charset:utf-8",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			success:function(result){
				console.log(result);
				$("#entNm").html(result.enterPriseList[0].entNm);
				$("#memId").html("("+result.memId+")");
				$("#memPass").html(result.memPass);
				$("#entPicNm").html(result.enterPriseMemList[0].entPicNm);
				$("#entPicTelno").html(result.enterPriseMemList[0].entPicTelno);
				$("#entPicJbgd").html(result.enterPriseMemList[0].entPicJbgd);
				$("#entUrl").html(result.enterPriseList[0].entUrl);
				$("#entZip").html("["+result.enterPriseList[0].entZip+"]");
				$("#entAddr").html(result.enterPriseList[0].entAddr);
				$("#entDaddr").html(result.enterPriseList[0].entDaddr);
				$("#entSlsAmt").html(result.enterPriseList[0].entSlsAmt);
				$("#entSector").html(result.enterPriseList[0].entSector);
				$("#entEmpCnt").html(result.enterPriseList[0].entEmpCnt);
				$("#isMembership").html(result.vip);
				$("#grade").html(result.vipGrdNm);

				description = result.enterPriseList[0].entDescription;
				if(description != null){
					const code = "<h6>"+description+"</h6>";
					$("#dicription").html(code);
				} else {
					const code = "<h6>기업 설명이 없습니다.</h6>";
					$("#dicription").html(code);
				}

				att = result.boardAttVOList[0];

				console.log("이미지 나오니?")

				if(att != null){
					img = result.boardAttVOList[0].attNm;
					$(".profileImg").attr("src","/resources/images"+img);
				} else {
					$(".profileImg").attr("src","/resources/images/회사예시사진.png");
				}


				// 날짜형태로 바꿔주는 변수
				var entFndnDt = new Date(result.enterPriseList[0].entFndnDt);
				var formattedDate = entFndnDt.toLocaleDateString('ko-KR', {year: 'numeric', month: '2-digit', day: '2-digit'});
				$("#entFndnDt").html(formattedDate);
			}
		});
	});

	$(".deleteBtn").on("click",function(){
		var result = confirm('차단 하시겠습니까?');
		if(result>0) {
            location.href = "/admin/blockFirm?memId="+memId;
            Swal.fire("차단 되었습니다.");
        } else if(result==0) {
        	Swal.fire("취소 되었습니다.")
        }
		else {
			Swal.fire("차단 하는 도중 오류가 발생했습니다.")
        }

	});

	$("#postCheck").on("click",function(){
		console.log(memId);
		data = {"memId":memId, "mCurrentPage":1};
		console.log(data);
		$.ajax({
			url:"/admin/getjobPostedList",
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
					code += "<td>"+conList[i].rnum+"</td>";
					code += "<td><a href='/admin/jobPostingDetail?jobPstgNo="+conList[i].jobPstgNo+"'>"+conList[i].jobPstgTitle+"</a></td>";
					code += "<td>"+conList[i].jobPstgBgngDt+"</td>";
					code += "<td>"+conList[i].jobPstgEndDate+"</td>";
					code += "</tr>";
				}
				console.log(code);
				if(code == ""){
					code += "<tr style='text-align: center;'>";
					code += "<td colspan='4'>게시한 채용공고가 없습니다.</td>";
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
				$("#nPage").html(pCode);
			}
		});
	});
});

function pageClick(link){
	let value = link.innerHTML;
	console.log(value);

	console.log(memId);
	data = {"memId":memId, "mCurrentPage":value};
	console.log(data);
	$.ajax({
		url:"/admin/getjobPostedList",
//			contentType : "application/json;charset:utf-8",
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
//			data:JSON.stringify(data),
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
				code += "<td>"+conList[i].rnum+"</td>";
				code += "<td><a href='/admin/jobPostingDetail?jobPstgNo="+conList[i].jobPstgNo+"'>"+conList[i].jobPstgTitle+"</a></td>";
				code += "<td>"+conList[i].jobPstgBgngDt+"</td>";
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
			$("#nPage").html(pCode);
		}
	});


}
</script>

<div class="content-header">
	<h5>기업회원 목록</h5>
</div>

<div class="card">
	<div class="card-body">
		<form action="">
			<div class="row">
				<div class="col-lg-3">
					<select class="form-control" id="sel1" name = "searchType">
						<option value="firmId" <c:if test="${param.searchType == 'firmId' }"><c:out value="selected"/></c:if>>아이디</option>
						<option value="firmName" <c:if test="${param.searchType == 'firmName' }"><c:out value="selected"/></c:if>>기업명</option>
						<option value="entPicNm" <c:if test="${param.searchType == 'entPicNm' }"><c:out value="selected"/></c:if>>담당자 이름</option>
					</select>
				</div>
				<div class="col-lg-7">
					<input type="text" placeholder="검색어를 입력해주세요"
					       name = "keyword" value="${param.keyword}" class="form-control "
						    />
				</div>
				<div class="col-lg-2">
					<button type="submit" class="btn btn-block btn-outline-dark">Search</button>
				</div>
			</div>
		</form>
		<table class="table table-head-fixed text-nowrap">
			<thead>
				<tr style="text-align: center;">
					<th>번호</th>
					<th>기업명</th>
					<th>아이디</th>
					<th>담당자</th>
					<th>담당자 연락처</th>
					<th>가입일자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="memVo" items="${data.content}" varStatus="stat">
					<tr style="text-align: center;">
						<td>${memVo.rnum}</td>
						<td>${memVo.enterPriseList[0].entNm}</td>
						<td ><a type="button" class="memBtn" data-toggle="modal" data-target="#entDetail">${memVo.memId}</a></td>
						<td>${memVo.enterPriseMemList[0].entPicNm}</td>
						<td>${memVo.enterPriseMemList[0].entPicTelno}</td>
						<td>${memVo.memJoinDt}</td>
					</tr>
				</c:forEach>
				<c:if test="${data.total == 0}">
						<td colspan="6" style="text-align: center;">검색된 기업이 없습니다.</td>
				</c:if>
			</tbody>
		</table>
		<div class="clearfix" id="page">
			<c:if test='${data.total != 0 }'>
				<ul class="pagination justify-content-center">
					<li
						class="paginate_button page-item previous <c:if test='${data.startPage lt 11 }'>disabled</c:if>"
						id="dataTable_previous"><a
						href="/admin/firmList?currentPage=${data.startPage-10}&keyword=${param.keyword}&searchType=${param.searchType}"
						aria-controls="dataTable" data-dt-idx="0" tabindex="0"
						class="page-link">Previous</a></li>

					<c:set var="currentPage"
						value="${not empty param.currentPage ? param.currentPage : 1}" />
					<c:forEach var="pNo" begin="${data.startPage}"
						end="${data.endPage}">
						<li
							class="paginate_button page-item
							<c:if test='${currentPage eq pNo}'> active</c:if> ">
							<a
							href="/admin/firmList?currentPage=${pNo}&keyword=${param.keyword}&searchType=${param.searchType}"
							aria-controls="dataTable" data-dt-idx="1" tabindex="0"
							class="page-link"> ${pNo} </a>
						</li>
					</c:forEach>
					<li
						class="paginate_button page-item next
					<c:if test='${data.endPage ge data.totalPages }'>disabled</c:if>"
						id="dataTable_next"><a
						href="/admin/firmList?currentPage=${data.startPage+10}&keyword=${param.keyword}&searchType=${param.searchType}"
						aria-controls="dataTable" data-dt-idx="7" tabindex="0"
						class="page-link"> Next </a></li>
				</ul>
			</c:if>
		</div>
	</div>
</div>




<!-- The Modal -->
<div class="modal fade" id="entDetail">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header row" style="justify-content: flex-end;">
				<button type="button" class="btn btn-outline-info" id="postCheck" style="margin-right: 10px;" 
					data-toggle="modal" data-target="#myModal" disabled>채용공고 확인</button>
				<button type="button" class="btn btn-outline-danger deleteBtn" style="margin-right: 10px;"  
					id="blockBtn" disabled>승인해제</button>
				<button type="button" class="btn btn-defalt" data-dismiss="modal">X</button>
			</div>
			<!-- Modal body -->
			<div class="modal-body">
				<img class="profile-user-img img-fluid profileImg" src="/resources/images/회사예시사진.png" alt="대표사진" style="margin: 20px;width: 250px;height: 200px;">
				<div class="card-body row box-profile">
					<div class="col">
						<ul class="list-group list-group-unbordered mb-3">
							<li class="list-group-item">
								<h6><i class="material-icons">keyboard_arrow_right</i>기업명(기업아이디)</h6>
								<h5 id="entNm" ></h5>
								<h5 id="memId" ></h5>
							</li>
							<li class="list-group-item">
								<h6><i class="material-icons">keyboard_arrow_right</i>담당자 이름</h6>
								<h5 id="entPicNm" ></h5>
							</li>
							<li class="list-group-item">
								<h6><i class="material-icons">keyboard_arrow_right</i>담당자 연락처</h6>
								<h5 id="entPicTelno" ></h5>
							</li>
							<li class="list-group-item">
								<h6><i class="material-icons">keyboard_arrow_right</i>담당자 직급</h6>
								<h5 id="entPicJbgd" ></h5>
							</li>
							<li class="list-group-item">
								<h6><i class="material-icons">keyboard_arrow_right</i>사이트 주소</h6>
								<h5 id="entUrl" ></h5>
							</li>
							<li class="list-group-item">
								<h6><i class="material-icons">keyboard_arrow_right</i>기업 주소</h6>
								<h5>
									<span id="entZip"><br/>
									</span><span id="entAddr">&nbsp;</span><span id="entDaddr"></span>
								</h5>
							</li>
							<li class="list-group-item">
								<h6><i class="material-icons">keyboard_arrow_right</i>멤버십 등급</h6>
								<h5 id="grade" ></h5>
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
			<div class="modal-header row" style="justify-content: flex-end;">
				<button type="button" class="btn btn-defalt" data-dismiss="modal">X</button>
			</div>
			<!-- Modal body -->
			<div class="modal-body">
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
				<div class="card-footer clearfix" id="nPage">
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
