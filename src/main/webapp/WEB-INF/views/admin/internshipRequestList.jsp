<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<style>
.nav-pills .nav-link.active {
    background-color: silver;
    color: white;
}

.lectuerCard {
	height: 600px;
}

</style>

<script>
startdata("internship");
$(function(){
	$("#isPermit").on("change",function(){
		$("#frm").submit();
	});
})


function startdata(kind) {
	// 파라미터 값으로 안넘어오면 시작페이지가 1인걸로 시작
	// 페이지를 시작하면 바로 불러오는 함수
	if(kind == "internship"){
		var currentPage = "${param.currentPage}";
		console.log(currentPage);
		console.log(currentPage == "");
		if("${param.currentPage}" == ""){
			currentPage = 1;
		} else{
			currentPage = "${param.currentPage}";
		}

		var searchType = "${param.searchType}";
		console.log(searchType);
		console.log(searchType == "");

		if("${param.searchType}" == ""){
			searchType = "title";
		} else{
			searchType = "${param.searchType}";
		}

		var isPermit = "${param.isPermit}";
		console.log(isPermit);
		console.log(isPermit == "");

		if("${param.isPermit}" == ""){
			isPermit = "allPermit";
		} else{
			isPermit = "${param.isPermit}";
		}

		var keyword = "${param.keyword}"

		console.log(keyword);
		console.log(keyword == "");

		if("${param.keyword}" == ""){
			keyword = "";
		} else{
			keyword = "${param.keyword}";
		}
		if(searchType == ""){
			searchType = $("#searchType").val();
		}

		var data = {"keyword": keyword, "currentPage": currentPage, "searchType": searchType, "kind" : kind, "isPermit" : isPermit}
		makeInternAjax(data,"#internshipList","#internshipPage","#internshipCurP", "internshipPageClick(this)");
	}
}// end startData

function makeInternAjax(dta, list, page, curPage, pageBtn){
	$.ajax({
		url:"/admin/makeInternAjax",
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		data:dta,
		type:"post",
		dataType:"json",
		success:function(result){
			console.log(result) // 배열 result[0] id name
			const conList = result.content;
			console.log(conList[0]) // 배열 result[0] id name
			var code = "";
			var pCode = "";
			code += "<table class='table table-head-fixed text-nowrap'>"
			code += "	<thead>"

			code += "	<th>기업명</th><th>인턴십 명</th><th>시작일</th><th>종료일</th><th></th>"

			for(let i=0;i<conList.length;i++){
				code += "	<tbody>"
			    code += "	<tr>"
			    code += "		<td>"+conList[i].entNm+"</td>"
			    code += "		<td style='float: left;'><a href='/myPremium/myInternshipDetail?itnsNo="+conList[i].itnsNo+"'>"+conList[i].prmmTitle+"</a></td>"

			    const timestamp = conList[i].itnsBgngDt;
			    const date = new Date(timestamp);
			    const year = date.getFullYear();
			    const month = ('0' + (date.getMonth() + 1)).slice(-2);
			    const day = ('0' + date.getDate()).slice(-2);
			    code += "		<td>"+year+"/"+month+"/"+day+"</td>"

			    const timestamp2 = conList[i].itnsEndDt;
			    const date2 = new Date(timestamp2);
			    const year2 = date2.getFullYear();
			    const month2 = ('0' + (date2.getMonth() + 1)).slice(-2);
			    const day2 = ('0' + date2.getDate()).slice(-2);
			    code += "		<td>"+year2+"/"+month2+"/"+day2+"</td>"
			    code += "		<td>";
			    if(conList[i].itnsAprvYn == 'Y'){
					code += '<form action="/admin/noPermit" method="post">';
				} else if (conList[i].itnsAprvYn == 'N'){
					code += '<form action="/admin/permitInternship" method="post">';
				}
			    if(conList[i].itnsAprvYn == 'Y'){
					code += '			<input type="hidden" name="itnsNo" value="'+conList[i].itnsNo+'"><button class="btn btn-block btn-outline-danger btn-sm" type="submit" >승인해제</button><security:csrfInput />';
				} else if (conList[i].itnsAprvYn == 'N'){
					code += '			<input type="hidden" name="itnsNo" value="'+conList[i].itnsNo+'"><button class="btn btn-block btn-outline-info btn-sm" type="submit" >승인하기</button><security:csrfInput />';
				} else if (conList[i].itnsAprvYn == 'D'){
					code += '			<input type="hidden" name="itnsNo" value="'+conList[i].itnsNo+'"><button class="btn btn-block btn-danger btn-sm" type="button" disabled >삭제됨</button><security:csrfInput />';
				}

			    code += "		</td> </form>"

				code += "	</tr>"
				code += "	</tbody>"
			}
			if(result.total == 0){
				code += "<tr><td colspan='5'>인턴십이 없습니다.</td></tr>"
			}
			code += "</table>";

			if(result.total != 0){
				pCode += "<ul class='pagination justify-content-center'>";
				pCode += "	<li class='paginate_button page-item previous ";
				if(result.startPage < 11){
					pCode += "      disabled'";
				}
				pCode += "		id='dataTable_previous'>";
				pCode += "		<a href='javascript:' onclick='"+pageBtn+"'";
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

					pCode += "			<a href='javascript:' onclick='"+pageBtn+"'";
					pCode += "				aria-controls='dataTable' data-dt-idx='1' tabindex='0'";
					pCode += "			class='page-link nodalPage'>"+i+"</a>";
					pCode += "		</li>";
				}
				// 반복문 끝
				pCode += "	<li class='paginate_button page-item next";
				// if문으로 넣기
				if(result.endPage >= result.totalPages){
					pCode += " disabled'";
				}
				pCode += "	' id='dataTable_next'>";
				pCode += "		<a href='javascript:' onclick='"+pageBtn+"'";
				pCode += "		   aria-controls='dataTable' data-dt-idx='7' tabindex='0'";
				pCode += "		   class='page-link' id= '"+(result.startPage+10)+"'>Next</a>";
				pCode += "	</li>";
				pCode += "</ul>";
			}
			console.log(code);
			$(list).html(code);
			console.log(pCode);
			$(page).html(pCode);
			$(curPage).val(result.currentPage);
		}
	});	// end ajax
}

function internshipPageClick(link){
	let value = link.innerHTML;
	console.log(value);
	let idL = link.getAttribute("id");
	console.log(idL);
	if(value == "Previous" || value == "Next" ){
		value = idl;
	}

	var keyword = $("#keyword").val();
	console.log(keyword);
	var searchType = $("#searchType").val();
	console.log(searchType);
	var isPermit = $("#isPermit").val();
	console.log(searchType);
	var data = {"keyword": keyword, "currentPage": value, "searchType":searchType, "kind" : "special", "isPermit" : isPermit}
	makeInternAjax(data,"#internshipList","#internshipPage","#internshipCurP", "internshipPageClick(this)");
}


</script>

<div class="content-header">
	<h5>인턴십 관리</h5>
</div>

<div class="card">
	<div class="card-body">
		<div class="card-body">
		<form id="frm">
			<div class="row">
				<div class="col-2">
					<select class="form-control" id="isPermit" name="isPermit">
						<option value="allPermit" <c:if test="${param.isPermit == 'allPermit' }"><c:out value="selected"/></c:if>>전체</option>
						<option value="permited" <c:if test="${param.isPermit == 'permited' }"><c:out value="selected"/></c:if>>승인</option>
						<option value="noPermit" <c:if test="${param.isPermit == 'noPermit' }"><c:out value="selected"/></c:if>>미승인</option>
					</select>
				</div>
				<div class="col-2">
					<select class="form-control" id="searchType" name="searchType">
						<option value="title" <c:if test="${param.searchType == 'title' }"><c:out value="selected"/></c:if>>제목</option>
						<option value="content" <c:if test="${param.searchType == 'content' }"><c:out value="selected"/></c:if>>내용</option>
					</select>
				</div>
				<div class="col">
					<input type="text" placeholder="검색어를 입력해주세요" value="${param.keyword}" id = "keyword"
						   name="keyword" class="form-control form-control-md" />
				</div>
				<div class="col-2">
					<button type="submit" class="btn btn-block btn-outline-dark">Search</button>
				</div>
			</div>
		</form>
			<!-- 여기에 들어갈 예정 -->
			<div id="internshipList" class="row " style="padding-top: 50px; text-align: center;">

			</div>
		</div>
	</div>
	<div class="card-footer clearfix">
		<div id="internshipPage"></div>
	</div>
</div>
<input id="internshipCurP" type="hidden" name="currentPage" value="" />
