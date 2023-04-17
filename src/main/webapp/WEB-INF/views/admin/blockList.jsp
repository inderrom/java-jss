<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
var memId;
$(function(){
	var data;
	let tmp = "";
	tmp += "<tr>";
	tmp += "	<td colspan='5'>아이디를 클릭하면 신고내역을 확인할 수 있습니다.</td>";
	tmp += "</tr>";
	$("#reportTable").html(tmp);

	$(".memBtn").on("click",function(){
		console.log("눌렀음");
		memId = $(this).parent().find("a").html();
		data = {"memId":memId, "currentPage" : 1};
		console.log(memId);
		console.log(data);


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
					code += "<td>"+List[i].memId+"</td>";
					code += "<td>"+List[i].memNm+"</td>";
					code += "<td>"+List[i].memReportList[0].rptRsn+"</td>";
					code += "<td>"+List[i].memReportList[0].rptRegDt+"</td>";
					code += "<td><button type='button' class='btn btn-block btn-outline-info' id = 'blockBtn' disabled='disabled'>차단해제</button></td>";
					code += "</tr>";
				}
				console.log(code);
				if(code == ""){
					code += "<tr style='text-align: center;'>";
					code += "<td colspan='5'>신고 목록이 없습니다.</td>";
					code += "</tr>";
				}
				$("#reportTable").html(code);

				if(result.total != 0){
					pCode += "<ul class='pagination justify-content-center'>";
					pCode += "	<li class='paginate_button page-item previous ";
					if(result.startPage < 10){
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

				$("#pagingReport").html(pCode);
			}
		});
	});

	$("#blockBtn").on("click",function(){
		var result = confirm('이 회원을 차단해제하겟습니까?');
        if(result>0) {
			location.href = "/admin/nonBlockMem?memId="+memId;
        	alert("차단되었습니다.");
        } else {
        }
	});

});

function pageClick(link){
	 let value = link.innerHTML;
	 console.log(value);
	 data = {"memId":memId, "currentPage" : value};
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
					code += "<td>"+List[i].memNm+"</td>";
					code += "<td>"+List[i].memId+"</td>";
					code += "<td>"+List[i].memReportList[0].rptRsn+"</td>";
					code += "<td>"+List[i].memReportList[0].rptRegDt+"</td>";
					code += "</tr>";
				}
				console.log(code);
				if(code == ""){
					code += "<tr style='text-align: center;'>";
					code += "<td colspan='5'>신고 목록이 없습니다.</td>";
					code += "</tr>";
				}
				$("#reportTable").html(code);

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

				$("#pagingReport").html(pCode);
			}
		});

}

</script>

<div class="content-header">
	<h5>차단회원 관리</h5>
</div>

<form>
	<div class="card">
		<div class="card-body">
			<div class="row">
				<div class="col-md-3">
					<select class="form-control" id="sel1" name = "searchType">
						<option value="name"<c:if test="${param.searchType == 'name' }"><c:out value="selected"/></c:if>>이름</option>
						<option value="id" <c:if test="${param.searchType == 'id' }"><c:out value="selected"/></c:if> >아이디</option>
					</select>
				</div>
				<div class="col-md-6" >
					<input type="text" placeholder="검색어를 입력해주세요"
					       name = "keyword" value="${param.keyword}" class="form-control form-control-md " />
				</div>
				<div class="col-md-3">
					<button type="submit" class="col-md-12 btn btn-block btn-outline-dark">Search</button>
				</div>
			</div>
		</div>
		<div class="col-12">
			<table class="table table-head-fixed text-nowrap">
				<thead>
					<tr style="text-align: center;">
						<th style="width: 60px">번호</th>
						<th>이름</th>
						<th>아이디</th>
						<th>가입일시</th>

					</tr>
				</thead>
				<tbody>
					<c:forEach var="memVo" items="${data.content}" varStatus="stat">
						<tr style="text-align: center;">
							<td>${memVo.rnum}</td>
							<td>${memVo.memNm}</td>
							<td ><a type="button" class="memBtn" >${memVo.memId}</a></td>
							<td>${memVo.memJoinDt}</td>
						</tr>
					</c:forEach>
					<c:if test="${data.total == 0}">
						<td colspan="6" style="text-align: center;">차단된 회원이 없습니다.</td>
					</c:if>
				</tbody>
			</table>
			<c:if test='${data.total != 0 }'>
				<div class="clearfix">
					<ul class="pagination justify-content-center">
						<li
							class="paginate_button page-item previous
						<c:if test='${data.startPage lt 11 }'>disabled</c:if>"
							id="dataTable_previous"><a
							href="/admin/blockList?currentPage=${data.startPage-10}&keyword=${param.keyword}&searchType=${param.searchType}"
							aria-controls="dataTable" data-dt-idx="0" tabindex="0"
							class="page-link">Previous</a></li>

						<c:set var="currentPage" value="${not empty param.currentPage ? param.currentPage : 1}" />
							<c:forEach var="pNo" begin="${data.startPage}" end="${data.endPage}">
								<li class="paginate_button page-item
								<c:if test='${currentPage eq pNo}'> active</c:if> ">
								<a href="/admin/blockList?currentPage=${pNo}&keyword=${param.keyword}&searchType=${param.searchType}"
								   aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link"> ${pNo} </a>
							</li>
						</c:forEach>
						<li
							class="paginate_button page-item next
						<c:if test='${data.endPage ge data.totalPages }'>disabled</c:if>"
							id="dataTable_next">
							<a href="/admin/blockList?currentPage=${data.startPage+10}&keyword=${param.keyword}&searchType=${param.searchType}"
							   aria-controls="dataTable" data-dt-idx="7"
							   tabindex="0" class="page-link"> Next </a>
						</li>
					</ul>
				</div>
			</c:if>
		</div>
	</div>
</form>

<div class="card">
	<div class="card-header">
		<h3 class="card-title">회원 신고 목록</h3>
	</div>
	<div class="card-body">
		<div class="text-center">
		</div>
		<table class="table table-head-fixed text-nowrap">
				<thead>
					<tr>
						<td style="width: 90px">이름</td>
						<td style="width: 130px">아이디</td>
						<td style="width: 320px">신고내용</td>
						<td>신고일자</td>
						<td></td>
					</tr>
				</thead>
				<tbody id="reportTable">
				</tbody>
		</table>
		<div class="card-footer clearfix" id="pagingReport">

		</div>
	</div>
</div>

<!-- The Modal -->
<div class="modal fade" id="myModal">
	<div class="modal-dialog modal-lg">
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
								<th>번호</th>
								<th>기업명</th>
								<th>채용공고</th>
								<th>등록일자</th>
							</tr>
						</thead>
						<tbody id="jobCurrent">
							<tr style="text-align: center;"><td colspan="5">아이디를 누르면 신고 목록을 확인 할 수 있습니다.</td></tr>
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

