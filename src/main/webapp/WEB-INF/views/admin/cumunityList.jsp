<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="row">
	<div class="col-md-5">
		<div class="card card-primary">
			<div class="card-header">
				<h3 class="card-title">일반회원</h3>
			</div>
			<div class="card-body">
				<div class="card-body box-profile">
					<div class="text-center">
						<img class="profile-user-img img-fluid img-circle" src="/resources/images/login.jpg" 
							 alt="User profile picture">
					</div>
					<h3 class="profile-username text-center">김시험</h3>
					<ul class="list-group list-group-unbordered mb-3">
						<li class="list-group-item">
							<b>회원 아이디</b> 
							<a class="float-right">a001</a>
						</li>
						<li class="list-group-item">
							<b>우편번호</b> 
							<a class="float-right">543234</a>
						</li>
						<li class="list-group-item">
							<b>주소</b> 
							<a class="float-right">별내면 청학리</a>
						</li>
						<li class="list-group-item">
							<b>상세주소</b> 
							<a class="float-right">204동 501호</a>
						</li>
						<li class="list-group-item">
							<b>전화번호</b> 
							<a class="float-right">13,287</a>
						</li>
						<li class="list-group-item">
							<b>가입 일</b> 
							<a class="float-right">2023/02/13</a>
						</li>
						<li class="list-group-item">
							<b>공개설정</b> 
							<a class="float-right">O</a>
						</li>
						<li class="list-group-item">
							<b>사용 여부</b> 
							<a class="float-right">O</a>
						</li>
					</ul>
				</div>	
			</div>
			<div class="card-footer">
				<div class="row">
					<div class="col-md-6">
						<button type="button" class="btn btn-block btn-primary" 
						        data-toggle="modal" data-target="#myModal">지원회사</button>
					</div>
					<div class="col-md-6">
						<button type="button" class="btn btn-block btn-danger" id = "blockBtn">차단</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-7" >
		<form>
			<div class="card card-primary">
				<div class="card-header">
					<h3 class="card-title">일반회원 목록</h3>
				</div>
				<div class="card-body">
					<div class="card-body">
						<div class="row">
							<div class="col-md-3">
								<select class="form-control" id="sel1">
									<option>이름</option>
									<option>아이디</option>
									<option>비밀번호</option>
									<option>회원등급</option>
								</select>
							</div>
							<div class="col-md-7">
								<input type="text" placeholder="검색어를 입력해주세요"
									style="width: 370px;" />
							</div>
							<div class="col-md-2">
								<button type="button" class="btn btn-primary">Search</button>
							</div>
						</div>
					</div>
					<table class="table table-head-fixed text-nowrap">
						<thead>
							<tr>
								<th>번호</th>
								<th>이름</th>
								<th>아이디</th>
								<th>비밀번호</th>
								<th>회원등급</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1.</td>
								<td><a href="/admin/nomalDetail? ">김시험</a></td>
								<td>a001</td>
								<td>1234</td>
								<td>라이트</td>
							</tr>
							<tr>
								<td>2.</td>
								<td><a href="/admin/nomalDetail? ">김학규</a></td>
								<td>asd1234</td>
								<td>seds2315</td>
								<td>베이직</td>
							</tr>
							<tr>
								<td>3.</td>
								<td><a href="/admin/nomalDetail?">이건방</a></td>
								<td>saq12324</td>
								<td>erte234215</td>
								<td>베이직</td>
							</tr>
							<tr>
								<td>4.</td>
								<td><a href="/admin/nomalDetail?">신시애</a></td>
								<td>gsdwr2311</td>
								<td>dwqert34432</td>
								<td>라이트</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="card-footer clearfix">
					<ul class="pagination justify-content-center">
						<li class="page-item"><a class="page-link" href="#">«</a></li>
						<li class="page-item"><a class="page-link" href="#">1</a></li>
						<li class="page-item"><a class="page-link" href="#">2</a></li>
						<li class="page-item"><a class="page-link" href="#">3</a></li>
						<li class="page-item"><a class="page-link" href="#">»</a></li>
					</ul>
				</div>
			</div>
		</form>
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
						<tbody>
							<tr>
								<td>1.</td>
								<td><a href="#">삼성이노베이션</a></td>
								<td><a href="#">당신의 재능을 뽑내세요!!!</a></td>
								<td>2023/02/13</td>
							</tr>
							<tr>
								<td>2.</td>
								<td><a href="#">카카오 </a></td>
								<td><a href="#">프로그래밍 잘하는 사람 손!!!!</a></td>
								<td>2023/02/12</td>
							</tr>
							<tr>
								<td>3.</td>
								<td><a href="#">LG</a></td>
								<td><a href="#">백엔드 개발자 구인</a></td>
								<td>2023/02/03</td>
							</tr>
							<tr>
								<td>4.</td>
								<td><a href="#">당근마켓</a></td>
								<td><a href="#">프런트 개발자 구인</a></td>
								<td>2023/02/06</td>
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


<script type="text/javascript">
$(function(){
	$("#blockBtn").on("click",function(){
		var result = confirm('이 회원을 차단하겟습니까?');
        if(result>0) {
            alert("차단되었습니다.");
        } else {
        	
        }
	});
});

</script>