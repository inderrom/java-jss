<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
var memId = "";
$(function(){
	$(".memBtn").on("click",function(){
		$(".deleteBtn").removeAttr("disabled");
		$(".checkBtn").removeAttr("disabled");
		console.log("눌렀음");	
		memId = $(this).parent().find("a").html();
		data = {"memId":memId};
		console.log(memId);
		console.log(data);
		$.ajax({
			url:"/admin/getBlockFirmDetail",
			contentType : "application/json;charset:utf-8",	
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			success:function(result){
				console.log(result);
				$("#entNm").val(result.enterPriseList[0].entNm);
				$("#memId").val(result.memId);
				$("#entPicNm").val(result.enterPriseMemList[0].entPicNm);
				$("#entPicTelno").val(result.enterPriseMemList[0].entPicTelno);
				$("#entPicJbgd").val(result.enterPriseMemList[0].entPicJbgd);
				$("#entUrl").val(result.enterPriseList[0].entUrl);
				$("#entZip").val(result.enterPriseList[0].entZip);
				$("#entAddr").val(result.enterPriseList[0].entAddr);
				$("#entDaddr").val(result.enterPriseList[0].entDaddr);
				$("#entSlsAmt").val(result.enterPriseList[0].entSlsAmt);
				$("#entSector").val(result.enterPriseList[0].entSector);
				$("#entEmpCnt").val(result.enterPriseList[0].entEmpCnt);

				description = result.enterPriseList[0].entDescription;
				
				// 날짜형태로 바꿔주는 변수
				var entFndnDt = new Date(result.enterPriseList[0].entFndnDt);
				var formattedDate = entFndnDt.toLocaleDateString('ko-KR', {year: 'numeric', month: '2-digit', day: '2-digit'});
				$("#entFndnDt").val(formattedDate);
			}
		});
		
		data = {"memId":memId, "currentPage":1};
		$.ajax({
			url:"/admin/getblockDetail",
// 			contentType : "application/json;charset:utf-8",	
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			data:data,
			type:"post",
			dataType:"json",
			success:function(result){
				$("#blockBtn").removeAttr("disabled");
				$("#supportBtn").removeAttr("disabled");
				
				console.log("result:" + result);
				result.content.map(function(item, idx){
					console.log(item.memId);
				});
				
				const List = result.content;
				var code = "";
				var pCode = "";
				for(let i=0;i<List.length;i++){
					code += "<tr>";
					code += "<td><a href='#'>"+List[i].memId+"</a></td>";
					code += "<td><a href='#'>"+List[i].memNm+"</a></td>";
					code += "<td>"+List[i].memReportList[0].rptRsn+"</td>";
					code += "<td>"+List[i].memReportList[0].rptClfcNo+"</td>";
					code += "<td>"+List[i].memReportList[0].rptRegDt+"</td>";
					code += "</tr>";
				}
				console.log(code);
				$("#reportTable").html(code);
				
				if(result.total != 0){
					pCode += "<ul class='pagination justify-content-center'>";
					pCode += "	<li class='paginate_button page-item previous ";
					if(result.startPage < 6){
						pCode += "      disabled'";
					}
					pCode += "		id='dataTable_previous'>";
					pCode += "		<a href='#'";
					pCode += "			aria-controls='dataTable' data-dt-idx='0' tabindex='0'";
					pCode += "			class='page-link'>Previous</a>";
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
					pCode += "		<a href='#'";
					pCode += "		   aria-controls='dataTable' data-dt-idx='7' tabindex='0'";
					pCode += "		   class='page-link'> Next </a>";
					pCode += "	</li>";
					pCode += "</ul>";
				}
				
				$("#pagingReport").html(pCode);
			}
		});
		
	});
		
	$(".deleteBtn").on("click",function(){
		var result = confirm('차단해제 하시겠습니까?');
		if(result>0) {
            location.href = "/admin/resolveBlockFirm?memId="+memId;
            alert("차단해제 되었습니다.");
        } else if(result==0) {
        	alert("취소 되었습니다.")
        } 
		else {
        	alert("차단해제 하는 도중 오류가 발생했습니다.")
        }
	});
});

function pageClick(link){
	 let value = link.innerHTML;
	 console.log(value);
	 data = {"memId":memId, "currentPage" : value};
	 $.ajax({
			url:"/admin/getblockDetail",
//			contentType : "application/json;charset:utf-8",	
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			data:data,
			type:"post",
			dataType:"json",
			success:function(result){
				$("#blockBtn").removeAttr("disabled");
				$("#supportBtn").removeAttr("disabled");
				
				console.log("result:" + result);
				result.content.map(function(item, idx){
					console.log(item.memId);
				});
				
				const List = result.content;
				var code = "";
				var pCode = "";
				for(let i=0;i<List.length;i++){
					code += "<tr>";
					code += "<td><a href='#'>"+List[i].memId+"</a></td>";
					code += "<td><a href='#'>"+List[i].memNm+"</a></td>";
					code += "<td>"+List[i].memReportList[0].rptRsn+"</td>";
					code += "<td>"+List[i].memReportList[0].rptClfcNo+"</td>";
					code += "<td>"+List[i].memReportList[0].rptRegDt+"</td>";
					code += "</tr>";
				}
				console.log(code);
				$("#reportTable").html(code);
				
				if(result.total != 0){
					pCode += "<ul class='pagination justify-content-center'>";
					pCode += "	<li class='paginate_button page-item previous ";
					if(result.startPage < 6){
						pCode += "      disabled'";
					}
					pCode += "		id='dataTable_previous'>";
					pCode += "		<a href='#'";
					pCode += "			aria-controls='dataTable' data-dt-idx='0' tabindex='0'";
					pCode += "			class='page-link'>Previous</a>";
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
					pCode += "		<a href='#'";
					pCode += "		   aria-controls='dataTable' data-dt-idx='7' tabindex='0'";
					pCode += "		   class='page-link'> Next </a>";
					pCode += "	</li>";
					pCode += "</ul>";
				}
				
				$("#pagingReport").html(pCode);
			}
		});
	
}

</script>

<div class="content-header">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1 class="m-0">기업 회원 관리</h1>
			</div>
			
		</div>
	</div>
</div>

<div class="row">
	<div class="col-md-5 nochange">
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">상세정보</h3>
			</div>
			<div class="card-body">
				<div class="card-body box-profile">
					<div class="text-center">
						<img class="profile-user-img img-fluid" src="/resources/images/회사예시사진.png" 
							 alt="User profile picture" style="width: 400px;height: 200px;">
					</div>
					<h2 class="profile-username text-center"><input type="text" id="entNm" class="form-control" value="" 
							   style="text-align: center;"  disabled/></h2>
					<ul class="list-group list-group-unbordered mb-3">
						<li class="list-group-item">
							<b>기업회원 아이디</b> 
							<a class="float-right" ><input type="text" id="memId" class="form-control" value="" 
							   style="text-align: center;"  disabled/></a>
						</li>
						<li class="list-group-item">
							<b>담당자 이름</b> 
							<a class="float-right" ><input type="text" id="entPicNm" class="form-control" value="" 
							   style="text-align: center;"  disabled/></a>
						</li>
						<li class="list-group-item">
							<b>담당자 연락처</b> 
							<a class="float-right" ><input type="text" id="entPicTelno" class="form-control" value="" 
							   style="text-align: center;"  disabled/></a>
						</li>
						<li class="list-group-item">
							<b>담당자 직급</b> 
							<a class="float-right" ><input type="text" id="entPicJbgd" class="form-control" value="" 
							   style="text-align: center;"  disabled/></a>
						</li>
						<li class="list-group-item">
							<b>사이트 주소</b> 
							<a class="float-right" ><input type="text" id="entUrl" class="form-control" value="" 
							   style="text-align: center;"  disabled/></a>
						</li>
						<li class="list-group-item">
							<b>우편 번호</b> 
							<a class="float-right" ><input type="text" id="entZip" class="form-control" value="" 
							   style="text-align: center;"  disabled/></a>
						</li>
						<li class="list-group-item">
							<b>기업 주소</b> 
							<a class="float-right" ><input type="text" id="entAddr" class="form-control" value="" 
							   style="text-align: center;"  disabled/></a>
						</li>
						<li class="list-group-item">
							<b>기업 상세 주소</b> 
							<a class="float-right" ><input type="text" id="entDaddr" class="form-control" value="" 
							   style="text-align: center;"  disabled/></a>
						</li>
						<li class="list-group-item">
							<b>기업 매출액</b> 
							<a class="float-right" ><input type="text" id="entSlsAmt" class="form-control" value="" 
							   style="text-align: center;"  disabled/></a>
						</li>
						<li class="list-group-item">
							<b>기업 산업군</b> 
							<a class="float-right" ><input type="text" id="entSector" class="form-control" value="" 
							   style="text-align: center;"  disabled/></a>
						</li>
						<li class="list-group-item">
							<b>기업 직원 수</b> 
							<a class="float-right" ><input type="text" id="entEmpCnt" class="form-control" value="" 
							   style="text-align: center;"  disabled/></a>
						</li>
						<li class="list-group-item">
							<b>기업 설립 연도</b> 
							<a class="float-right" ><input type="text" id="entFndnDt" class="form-control" value="" 
							   style="text-align: center;"  disabled/></a>
						</li>
					</ul>
				</div>	
			</div>
			<div class="card-footer">
				<div class="row">
					<div class="col-md-6">
						<button type="button" class="btn btn-block btn-outline-info checkBtn"
						        data-toggle="modal" data-target="#myModal" disabled>채용공고 확인</button>
					</div>
					<div class="col-md-6">
						<button type="button" class="btn btn-block btn-danger deleteBtn" disabled>차단해제</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-7" >
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">기업 목록</h3>
			</div>
			<div class="card-body">
				<form>
					<div class="card-body">
						<div class="row">
							<div class="col-md-2">
								<select class="form-control" id="sel1" name = "searchType">
									<option value="firmName" <c:if test="${param.searchType == 'firmName' }"><c:out value="selected"/></c:if>>기업명</option>
									<option value="firmId" <c:if test="${param.searchType == 'firmId' }"><c:out value="selected"/></c:if>>아이디</option>
									<option value="entPicNm" <c:if test="${param.searchType == 'entPicNm' }"><c:out value="selected"/></c:if>>담당자 이름</option>
								</select>
							</div>
							<div class="col-md-8">
								<input type="text" placeholder="검색어를 입력해주세요"
								       name = "keyword" value="${param.keyword}"
									   class="form-control form-control-md" />
							</div>
							<div class="col-md-2">
								<button type="submit" class="btn btn-block btn-outline-dark">Search</button>
							</div>
						</div>
					</div>
				<table class="table table-head-fixed text-nowrap">
				</form>
					<thead>
						<tr>
							<th>번호</th>
							<th>아이디</th>
							<th>기업명</th>
							<th>딤당자</th>
							<th>담당자 연락처</th>
							<th>가입일자</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="memVo" items="${data.content}" varStatus="stat">
							<tr style="text-align: center;">
								<td>${memVo.rnum}</td>
								<td ><a type="button" class="memBtn" >${memVo.memId}</a></td>
								<td>${memVo.enterPriseList[0].entNm}</td>
								<td>${memVo.enterPriseMemList[0].entPicNm}</td>
								<td>${memVo.enterPriseMemList[0].entPicTelno}</td>
								<td>${memVo.memJoinDt}</td>
							</tr>
						</c:forEach>
						<c:if test="${data.total == 0}"> 
								<td colspan="6" style="text-align: center;">차단된 기업이 없습니다.</td>
						</c:if>
					</tbody>
				</table>
			</div>
			<c:if test='${data.total != 0 }'>
				<div class="card-footer clearfix" id="page">
					<ul class="pagination justify-content-center">
						<li
							class="paginate_button page-item previous <c:if test='${data.startPage lt 6 }'>disabled</c:if>"
							id="dataTable_previous"><a
							href="/admin/blockFirmList?currentPage=${data.startPage-5}&keyword=${param.keyword}&searchType=${param.searchType}"
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
								href="/admin/blockFirmList?currentPage=${pNo}&keyword=${param.keyword}&searchType=${param.searchType}"
								aria-controls="dataTable" data-dt-idx="1" tabindex="0"
								class="page-link"> ${pNo} </a>
							</li>
						</c:forEach>
						<li
							class="paginate_button page-item next
						<c:if test='${data.endPage ge data.totalPages }'>disabled</c:if>"
							id="dataTable_next"><a
							href="/admin/blockFirmList?currentPage=${data.startPage+5}&keyword=${param.keyword}&searchType=${param.searchType}"
							aria-controls="dataTable" data-dt-idx="7" tabindex="0"
							class="page-link"> Next </a></li>
					</ul>
				</div>
			</c:if>
			<div class="card">
				<div class="card-header">
					<h3 class="card-title">신고 목록</h3>
				</div>
				<div class="card-body">
					<table class="table table-head-fixed text-nowrap">
						<thead>
							<tr>
								<td style="width: 130px">아이디</td>
								<td style="width: 90px">이름</td>
								<td style="width: 320px">신고내용</td>
								<td>신고 분류</td>
								<td>신고일자</td>
							</tr>
						</thead>
						<tbody id="reportTable">
						</tbody>
					</table>
					<div class="card-footer clearfix" id="pagingReport"></div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- The Modal -->
<div class="modal fade" id="myModal">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">채용공고 확인</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<div class="card-body">
					<table class="table table-head-fixed text-nowrap">
						<thead>
							<tr>
								<th style="widows: 50px;">번호</th>
								<th>제목</th>
								<th>글쓴이	</th>
								<th style="width: 150px">날짜</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1</td>
								<td><a href="" data-toggle="modal" data-target="#modalTwo">아 면접 떨어짐</a></td>
								<td>김드랍</td>
								<td>
									2023/01/23 12:23
									<div style="float: right;">
										<button type="button" class="btn btn-tool" title="edit"
												onclick="location.href='/admin/editCumuDetail'">
												<i class="fa-solid fa-pen-to-square"></i>
										</button>
										<button type="button" class="btn btn-tool deleteBtn" title="Remove">
											<i class="fas fa-times"></i>
										</button>	
									</div>	
								</td>
							</tr>
							<tr>
								<td>2</td>
								<td><a href="" data-toggle="modal" data-target="#modalTwo">아 면접 떨어짐</a></td>
								<td>심합격</td>
								<td>
									2023/01/23 16:23
									<div style="float: right;">
										<button type="button" class="btn btn-tool" title="edit"
												onclick="location.href='/admin/editCumuDetail'">
												<i class="fa-solid fa-pen-to-square"></i>
										</button>
										<button type="button" class="btn btn-tool deleteBtn" title="Remove">
											<i class="fas fa-times"></i>
										</button>	
									</div>								
								</td>
							</tr>
							<tr>
								<td>3</td>
								<td><a href="" data-toggle="modal" data-target="#modalTwo">아 면접 떨어짐</a></td>
								<td>니콜라스</td>
								<td>
									2023/01/23 14:23
									<div style="float: right;">
										<button type="button" class="btn btn-tool" title="edit"
												onclick="location.href='/admin/editCumuDetail'">
												<i class="fa-solid fa-pen-to-square"></i>
										</button>
										<button type="button" class="btn btn-tool deleteBtn" title="Remove">
											<i class="fas fa-times"></i>
										</button>	
									</div>									
								</td>
							</tr>
							<tr>
								<td>4</td>
								<td><a href="" data-toggle="modal" data-target="#modalTwo">아 면접 떨어짐</a></td>
								<td>심동근</td>
								<td>
									2023/01/23 14:23
									<div style="float: right;">
										<button type="button" class="btn btn-tool" title="edit"
												onclick="location.href='/admin/editCumuDetail'">
												<i class="fa-solid fa-pen-to-square"></i>
										</button>
										<button type="button" class="btn btn-tool deleteBtn" title="Remove">
											<i class="fas fa-times"></i>
										</button>	
									</div>									
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- The Modal -->
<div class="modal fade" id="modalTwo">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">채용공고 상세</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<!-- Modal body -->
			<div class="modal-body">
				<div class="card-body">
				</div>
				<div class="card-footer">
					<div class="row" >
						<div class="col-md-6"></div>
						<div class="col-md-3">
							<button type="button" class="btn btn-block btn-primary">수정</button>
						</div>
						<div class="col-md-3">
							<button type="button" class="btn btn-block btn-danger deleteBtn">삭제</button>
						</div>
					</div>
				</div>
			</div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
