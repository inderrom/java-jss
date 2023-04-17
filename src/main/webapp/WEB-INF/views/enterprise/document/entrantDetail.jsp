<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />
<c:set var="entVO"  value="${sessionScope.entMemVO }"/>

<script type="text/javascript">
$(function(){
	let rsmNo = "${rsmNo}";
	let data = {
		"memId":"${stateList[0].MEM_ID}",
		"memNm":"${stateList[0].MEM_NM}",
		"title":"${stateList[0].JOB_PSTG_TITLE}",
		"entNm":"${entVO.ENT_NM}"
	};
	
	$.ajax({
		url : "/enterprise/resumeDetail",
		type : "post",
		data : {"rsmNo":rsmNo},
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success : function(result) {
			console.log(result);
			$("#resumeDetail").html(result);
		}
	});
	
	$("#passMail").on("click", function(){
		Swal.fire({
			title: '합격 메일을 발송하시겠습니까?',
			icon: 'question',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '발송',
			cancelButtonText: '취소'
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					url: "/api/passEmail",
					data: data,
					type: "post",
					beforeSend : function(xhr) {
			            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
					success: function(result){
						console.log("passMail success");
					}
				});
		  	}
		});
	});
	
	$("#failEmail").on("click", function(){
		Swal.fire({
			title: '불합격 메일을 발송하시겠습니까?',
			icon: 'question',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '발송',
			cancelButtonText: '취소'
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					url: "/api/failEmail",
					data: data,
					type: "post",
					beforeSend : function(xhr) {
			            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
					success: function(result){
						console.log("failEmail success");
						let info = {
							"jobPstgNo":"${jobPstgNo}",
							"rsmNo":"${rsmNo}",
							"emplClfcNo":"EMPSTS0005",
							"emplno":"${emplno}"
						};
						location.href="/enterprise/updateEmpState?"+$.param(info);
					}
				});
		  	}
		});
	});
});
</script>

<div class="modal-dialog modal-xl">
	<div class="modal-content">
		<div class="modal-header">
			<div class="row">
				<h5><span class="badge badge-secondary badge-lg">${stateList[0].CMCD_DTL_NM}</span> ${stateList[0].JOB_PSTG_TITLE}</h5>
			</div>
		</div>
		<div class="modal-body" style="min-height: 800px;">
			<div class="row">
				<div class="col-3" style="border-right: 1px solid #808080b3;">
					<div class="row">
						<select class="form-control" name="itnsEntrt-button" id="itnsEntrt-button" onchange="changeStatus()">
							<option class="text-center" value="" <c:if test="${stateList[0].CMCD_DTL_NM eq '접수' }">selected</c:if> disabled>채용 단계 이동</option>
							<option value="EMPSTS0003" <c:if test="${stateList[0].CMCD_DTL_NM eq '서류합격' }">selected</c:if> >서류합격</option>
							<option value="EMPSTS0004" <c:if test="${stateList[0].CMCD_DTL_NM eq '최종합격' }">selected</c:if>>최종합격</option>
							<option value="EMPSTS0005" <c:if test="${stateList[0].CMCD_DTL_NM eq '불합격' }">selected</c:if>>불합격</option>
						</select>
					</div>
					<div class="row my-sm-4" style="align-items: center;">
						<div class="col-8">
							<h3><img id="myprofile" src="/resources/images/icon/hand-print.png" alt="..." class="avatar shadow border-radius-lg"> ${stateList[0].MEM_NM }</h3>
						</div>
						<div class="col p-md-0 text-center">
							<a id="passMail" class="badge badge-info badge-lg m-md-1">합격</a>
							<a id="failEmail" class="badge badge-danger badge-lg m-md-1">불합격</a>
						</div>
					</div>
					<div class="row">
						<strong>이메일</strong>
						<small>${stateList[0].MEM_ID}</small>
						<hr />
						<strong>연락처</strong>
						<small>${stateList[0].MEM_TELNO }</small>
					</div>
					
					<hr />
					
					<div class="row">
						<strong>타임라인</strong>
						<c:forEach var="stateVO" items="${stateList }">
							<small>${stateVO.CMCD_DTL_NM } : <br/><fmt:formatDate value="${stateVO.EMPL_STS_CHG_DT }" type="both" dateStyle="long" timeStyle="short"/></small><br/><br/>
						</c:forEach>
					</div>
				</div>
				
				<div class="col">
					<div class="row" style="justify-content: space-between;">
						<div class="col-2"><strong>첨부파일</strong></div>
						<div class="col"><small style="font-size: 0.75rem;">다운로드</small></div>
					</div>
					<div class="row" style="justify-content: space-between;">
						<div class="col-3"><strong>이력서</strong></div>
					</div>
					
					<hr class="blackLine" />
					
					<div class="row" id="resumeDetail"></div>
				</div>
				
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
if (document.getElementById('itnsEntrt-button')) {
    var element = document.getElementById('itnsEntrt-button');
    const example = new Choices(element, {
      searchEnabled: false
    });
}

function changeStatus(){
	let itnsNo = "${param.itnsNo}";
	let itnsEntrt = document.getElementById("itnsEntrt-button");
	let itnsAprvYn  = itnsEntrt.options[itnsEntrt.selectedIndex].value; 
	let data = {
		
	};
	
	$.ajax({
		url:"/enterprise/changeEmpStat",
		data: data,
		type:'post',
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}"); 
		},
		success:function(result){
			console.log("result : "  , result) ;
 		}
	});
	
}
</script>