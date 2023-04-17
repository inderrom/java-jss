<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
h6{
	width: 150px;
	color: #5c5c5c;
}
</style>
<script type="text/javascript">
$(function(){
	var memId = "";
	var entNo = "ENT0011";
	$(".memBtn").on("click",function(){
		$("#searchNum").val("");
		$(".checkBtn").removeAttr("disabled");
		$(".permitBtn").removeAttr("disabled");

		console.log("눌렀음");
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
				entNo = result.enterPriseList[0].entNo;
				console.log(entNo);
				$("#entNm").html(result.enterPriseList[0].entNm);
				$("#memId").html(result.memId);
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

				description = result.enterPriseList[0].entDescription;
				if(description != null){
					const code = "<h5>"+description+"</h5>";
					$("#dicription").html(code);
				} else {
					const code = "<h5>기업 설명이 없습니다.</h5>";
					$("#dicription").html(code);
				}
				att = result.boardAttVOList[0];
				console.log("이미지 나오니?")
// 				if(att != null){
// 					img = result.boardAttVOList[0].attNm;
// 					$(".profileImg").attr("src","/resources/images"+img);
// 				} else {
// 					$(".profileImg").attr("src","/resources/images/회사예시사진.png");
// 				}


				// 날짜형태로 바꿔주는 변수
				var entFndnDt = new Date(result.enterPriseList[0].entFndnDt);
				var formattedDate = entFndnDt.toLocaleDateString('ko-KR', {year: 'numeric', month: '2-digit', day: '2-digit'});
				$("#entFndnDt").html(formattedDate);
			}
		});

		$.ajax({
			url:"/admin/getPermitRg",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			data:{"entNo":entNo},
			type:"post",
			success:function(result){
				console.log("파일 이름 가져오는 거 성공");
				console.log(result);
				document.getElementById("btnDownload").setAttribute("data-filename", result);
			}
		});
	});

	$(".permitBtn").on("click",function(){
		var result = confirm('승인 하시겠습니까?');
		if(result>0) {
            location.href = "/admin/permitFirm?memId="+memId;
            Swal.fire("승인 되었습니다.");
        } else if(result==0) {
        	Swal.fire("취소 되었습니다.")
        }
		else {
			Swal.fire("승인 하는 도중 오류가 발생했습니다.")
        }
	});

	//파일 다운로드 하기
	$("#btnDownload").on("click",function(){
		let fnm = $(this).data("filename");
		console.log("fnm : " + fnm);
		let vIfrm = document.getElementById("ifrm");
		vIfrm.src = "/download?fileName="+fnm;
	});
});

$(function(){
	let vurl = "https://apis.data.go.kr/B490001/gySjbPstateInfoService/getGySjBoheomBsshItem";	// 요청 url 주소 (고정)
	let serviceKey = "7K9rpuCuAtSJru4Uy7hxehoH2H%2FegrL24TuaWvR7w%2B0TVilOiLMdHAXvipaAqjwVhD7aMXhDtgct67sGhJ8sfA%3D%3D"; // 서비스키 (필수, 고정)
	let opaBoheomFg = "2"; // 산재/고용구분(2 고정)
	let v_saeopjaDrno = ""; // 사업자 등록번호

	$("#registFind").on("click",function(){
		v_saeopjaDrno = $("#searchNum").val();
		$.ajax({
			url: vurl + "?serviceKey=" + serviceKey + "&opaBoheomFg=" + opaBoheomFg + "&v_saeopjaDrno=" + v_saeopjaDrno,
			type: "get",
			dataType: "xml",
			success: function(result){
				// 요청을 하면 xml DOM객체를 반환 받는다.
				// DOM객체로 반환받기 때문에 html의 DOM객체와 동일한 방법으로 사용할 수 있다.
	// 			$("#disp").html(result);
				console.log(result);
				let post = $(result).find("post").html();						//우편번호
				let addr = $(result).find("addr").html();        				//주소
				let saeopjaDrno = $(result).find("saeopjaDrno").html();
				let saeopjangNm = $(result).find("saeopjangNm").html(); 		//사업장명
				let seongripDt = $(result).find("seongripDt").html();
				saeopjaDrno = saeopjaDrno.substring(0,3)+"-"+saeopjaDrno.substring(3,5)+"-"+saeopjaDrno.substring(5); //사업장등록번호
				seongripDt = seongripDt.substring(0,4)+"-"+seongripDt.substring(4,6)+"-"+seongripDt.substring(6);     //성립일자

				$("#saeopjaDrno").html(saeopjaDrno);
				$("#saeopjangNm").html(saeopjangNm);
				$("#addr").html(addr);
				$("#post").html("("+post+")");
				$("#seongripDt").html(seongripDt);
			}
		});
	});
});

</script>

<div class="content-header">
	<h5>기업회원 승인요청 관리</h5>
</div>

<div class="card">
	<div class="card-body">
		<form action="">
			<div class="card-body">
				<div class="row">
					<div class="col-md-3">
						<select class="form-control" id="sel1" name = "searchType" >
							<option value="firmName" <c:if test="${param.searchType == 'firmName' }"><c:out value="selected"/></c:if>>기업명</option>
							<option value="firmId" <c:if test="${param.searchType == 'firmId' }"><c:out value="selected"/></c:if>>아이디</option>
							<option value="entPicNm" <c:if test="${param.searchType == 'entPicNm' }"><c:out value="selected"/></c:if>>담당자 이름</option>
						</select>
					</div>
					<div class="col-md-7">
						<input type="text" placeholder="검색어를 입력해주세요"
						       name = "keyword" value="${param.keyword}" class="form-control form-control-md"/>
					</div>
					<div class="col-md-2">
						<button type="submit" class="btn btn-block btn-outline-dark">Search</button>
					</div>
				</div>
			</div>
		</form>
		<div class="col-12">
			<table class="table table-head-fixed text-nowrap">
				<thead style="text-align: center;">
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
							<td ><a type="button" class="memBtn" data-toggle="modal" data-target="#entDetail">${memVo.memId}</a></td>
							<td>${memVo.enterPriseList[0].entNm}</td>
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
			<c:if test='${data.total != 0 }'>
				<div class="card-footer clearfix" id="page">
					<ul class="pagination justify-content-center">
						<li
							class="paginate_button page-item previous <c:if test='${data.startPage lt 11 }'>disabled</c:if>"
							id="dataTable_previous"><a
							href="/admin/permitRequest?currentPage=${data.startPage-10}&keyword=${param.keyword}&searchType=${param.searchType}"
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
								href="/admin/permitRequest?currentPage=${pNo}&keyword=${param.keyword}&searchType=${param.searchType}"
								aria-controls="dataTable" data-dt-idx="1" tabindex="0"
								class="page-link"> ${pNo} </a>
							</li>
						</c:forEach>
						<li
							class="paginate_button page-item next
						<c:if test='${data.endPage ge data.totalPages }'>disabled</c:if>"
							id="dataTable_next"><a
							href="/admin/permitRequest?currentPage=${data.startPage+10}&keyword=${param.keyword}&searchType=${param.searchType}"
							aria-controls="dataTable" data-dt-idx="7" tabindex="0"
							class="page-link"> Next </a></li>
					</ul>
				</div>
			</c:if>
		</div>

	</div>
</div>

<!-- 기업 상세페이지 열기 -->
<div class="modal fade" id="entDetail">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header row" style="justify-content: flex-end;align-items: center;">
				<button type="button" class="btn btn-outline-info checkBtn" style="margin-right: 10px;"
				        data-toggle="modal" data-target="#myModal" disabled>사업자등록번호 확인</button>
				<button type="button" class="btn btn-outline-success permitBtn" style="margin-right: 10px;" disabled>승인하기</button>
				<button type="button" class="btn btn-defalt" data-dismiss="modal">X</button>
			</div>
			<div class="modal-body">
				<div class="card-body box-profile">
					<div class="row text-center">
						<div class="col-3">
							<img class="profile-user-img img-fluid profileImg" src="/resources/images/기업이미지.jpg" alt="대표사진" style="margin:10px; width: 250px;height: 200px;">
						</div>
						<div class="col">
							<div class="card card-body" style="margin: 10px;" id="dicription"></div>
						</div>
					</div>
					<ul class="list-group list-group-unbordered mb-3" style="padding: 10px;">
						<li class="list-group-item">
							<div class="row"><h6>기업명</h6> <h5 id="entNm" style="text-align: center;"></h5></div>
						</li>
						<li class="list-group-item">
							<div class="row"><h6>기업회원 아이디</h6> <h5 id="memId" style="text-align: center;"></h5></div>
						</li>
						<li class="list-group-item">
							<div class="row"><h6>담당자 이름</h6> <h5 id="entPicNm" style="text-align: center;"></h5></div>
						</li>
						<li class="list-group-item">
							<div class="row"><h6>담당자 연락처</h6> <h5 id="entPicTelno" style="text-align: center;"></h5></div>
						</li>
						<li class="list-group-item">
							<div class="row"><h6>담당자 직급</h6> <h5 id="entPicJbgd" style="text-align: center;"></h5></div>
						</li>
						<li class="list-group-item">
							<div class="row"><h6>사이트 주소</h6> <h5 id="entUrl" style="text-align: center;"></h5></div>
						</li>
						<li class="list-group-item">
							<div class="row">
								<h6>기업 주소</h6>
								<h5><span id="entZip"></span><span id="entAddr"></span> <span id="entDaddr"></span></h5>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 사업자등록번호 확인 모달 열기 -->
<div class="modal fade" id="myModal">
	<div class="modal-dialog modal-xl modal-content">
		<div class="row">
			<div class="col">
				<img src="/resources/images/사업자.png" />
			</div>
			<div class="col">
				<div class="modal-header row" style="justify-content: flex-end;">
				<button type="button" class="btn btn-defalt" data-dismiss="modal">X</button>
				</div>
				<div class="modal-body">
					<div class="card">
						<div class="card-body">
							<div class="form-group">
								<div class="row">
									<div class="col-lg-8">
										<input type="text" class="form-control" id="searchNum" placeholder="사업자 등록번호를 입력하세요">
									</div>
									<div class="col-lg-4">
										<button type="button" class="btn btn-block btn-outline-dark btn-sm" id="registFind">Search</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="card">
					<div class="card-body">
						<div class="card-body box-profile">
							<ul class="list-group list-group-unbordered mb-3" >
								<li class="list-group-item">
									<strong>사업자등록번호</strong><br/>
									<span id="saeopjaDrno" style="font-size: larger;"></span>
								</li>
								<li class="list-group-item">
									<strong>사업장명</strong><br/>
									<span id="saeopjangNm" style="font-size: larger;"></span>
								</li>
								<li class="list-group-item">
									<strong>주소</strong><br/>
									<span id="post" style="font-size: larger;"></span><br/><span id="addr" style="font-size: larger;"></span>
								</li>
								<li class="list-group-item">
									<strong>설립일자</strong><br/>
									<span id="seongripDt" style="font-size: larger;"></span>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>