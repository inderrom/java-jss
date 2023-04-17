<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="card card-primary">
	<div class="card-header">
		<h3 class="card-title">상세정보</h3>
	</div>
	<div class="card-body">
		<div class="card-body box-profile">
			<div class="text-center">
				<img class="profile-user-img img-fluid" src="/resources/images/회사예시사진.png" 
					 alt="User profile picture" style="width: 400px;height: 200px;">
			</div>
			<h2 class="profile-username text-center"><input type="text" id="entNm" class="form-control" value="${data.entNm}" 
					   style="text-align: center;"  disabled/></h2>
			<ul class="list-group list-group-unbordered mb-3">
				<li class="list-group-item">
					<b>기업회원 아이디</b> 
					<a class="float-right" ><input type="text" id="memId" class="form-control" value="${data.enterpriseMemVoList[0].memId}" 
					   style="text-align: center;"  disabled/></a>
				</li>
				<li class="list-group-item">
					<b>담당자 이름</b> 
					<a class="float-right" ><input type="text" id="entPicNm" class="form-control" value="${data.enterpriseMemVoList[0].entPicNm}" 
					   style="text-align: center;"  disabled/></a>
				</li>
				<li class="list-group-item">
					<b>담당자 연락처</b> 
					<a class="float-right" ><input type="text" id="entPicTelno" class="form-control" value="${data.enterpriseMemVoList[0].entPicTelno}" 
					   style="text-align: center;"  disabled/></a>
				</li>
				<li class="list-group-item">
					<b>담당자 직급</b> 
					<a class="float-right" ><input type="text" id="entPicJbgd" class="form-control" value="${data.enterpriseMemVoList[0].entPicJbgd}" 
					   style="text-align: center;"  disabled/></a>
				</li>
				<li class="list-group-item">
					<b>사이트 주소</b> 
					<a class="float-right" ><input type="text" id="entUrl" class="form-control" value="${data.entUrl}" 
					   style="text-align: center;"  disabled/></a>
				</li>
				<li class="list-group-item">
					<b>우편 번호</b> 
					<a class="float-right" ><input type="text" id="entZip" class="form-control" value="${data.entZip}" 
					   style="text-align: center;"  disabled/></a>
				</li>
				<li class="list-group-item">
					<b>기업 주소</b> 
					<a class="float-right" ><input type="text" id="entAddr" class="form-control" value="${data.entAddr}" 
					   style="text-align: center;"  disabled/></a>
				</li>
				<li class="list-group-item">
					<b>기업 상세 주소</b> 
					<a class="float-right" ><input type="text" id="entDaddr" class="form-control" value="${data.entDaddr}" 
					   style="text-align: center;"  disabled/></a>
				</li>
				<li class="list-group-item">
					<b>기업 매출액</b> 
					<a class="float-right" ><input type="text" id="entSlsAmt" class="form-control" value="${data.entSlsAmt}" 
					   style="text-align: center;"  disabled/></a>
				</li>
				<li class="list-group-item">
					<b>기업 산업군</b> 
					<a class="float-right" ><input type="text" id="entSector" class="form-control" value="${data.entSector}" 
					   style="text-align: center;"  disabled/></a>
				</li>
				<li class="list-group-item">
					<b>기업 직원 수</b> 
					<a class="float-right" ><input type="text" id="entEmpCnt" class="form-control" value="${data.entEmpCnt}" 
					   style="text-align: center;"  disabled/></a>
				</li>
				<li class="list-group-item">
					<b>기업 설립 연도</b> 
					<a class="float-right" ><input type="text" id="entFndnDt" class="form-control" value="<fmt:formatDate value='${data.entFndnDt}' pattern='yyyy' />" 
					   style="text-align: center;"  disabled/></a>
				</li>
			</ul>
		</div>	
	</div>
	<div class="card-footer">
	</div>
</div>