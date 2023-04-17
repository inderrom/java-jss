<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />

<!-- fullcalendar CDN -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>

<style>
/* body 스타일 */
html, body {
	font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	font-size: 14px;
}
/* 캘린더 위의 해더 스타일(날짜가 있는 부분) */
.fc-header-toolbar {
	padding-top: 1em;
	padding-left: 1em;
	padding-right: 1em;
}
.box {
    position: fixed;
    bottom: 5%;
    right: 3%;
    z-index: 1030;
}
.chat {
    position: fixed;
    bottom: 5%;
    right: 3%;
    width: 600px;
    height: 500px;
    z-index: 1030;
}
#communicate::-webkit-scrollbar {
  display: none;
}

/* 마우스 포인터 변경 */
.pointer {
  cursor: pointer;
}
</style>
<script type="text/javascript">
itnsNo = "${data.itnsNo}";

$(function(){
	console.log("#detail : " + itnsNo);

	$(".my-menu-list").on("click", function(){
		let mennum = $(this).data("menunm");
		$("#internshipTitle").html('<h4 class="text-gradient text-primary">'+mennum+'</h4>');

		if(mennum == "인턴십소개"){
			$(".internInfo").hide();
			$("#itnsInfo").show();
		}
		if(mennum == "참여자"){

			$(".internInfo").hide();
			$("#account").show();
		}
		if(mennum == "공지사항"){
			$("#noticeNew").remove();
			$.ajax({
				url : "/myPremium/boardList",
				type : "post",
				data : {"itnsNo":itnsNo},
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success : function(result) {
					console.log("#/myPremium/boardList " + result);
					$("#note").html(result);
				}
			});

			$(".internInfo").hide();
			$("#note").show();
		}
		if(mennum == "채팅"){
			$(".internInfo").hide();
			$("#chat").show();
			$("#msgArea").scrollTop($("#msgArea")[0].scrollHeight);
		}
		if(mennum == "일정"){
			$(".internInfo").hide();
			$("#calendar").show();
		}
	});

	$(".box").on("click", function(){
		$(this).hide();
		$(".chat").show();
	});
	$("#botClose").on("click", function(){
		$(".chat").hide();
		$(".box").show();
	});


	//전송 버튼 누르는 이벤트
	$("#button-send").on("click", function(e) {
		sendMsg();
		$('#msg').val('');
	});
});

var sock = new SockJS('http://localhost/chatting');

sock.onmessage = onMessage;
sock.onclose = onClose;
sock.onopen = onOpen;

function sendMsg() {
	let text = "${memVO.memId}/${memVO.memNm}/"+$('#msg').val()+"/"+itnsNo;
	console.log(text);

	sock.send(text);

	$("#button-send").prop("disabled",true);
}

//서버에서 메시지를 받았을 때
function onMessage(msg) {
	console.log(msg);

	var data = msg.data;
	var sessionId = null; //데이터를 보낸 사람
	var message = null;

	var arr = data.split(":");
	sessionId = arr[0];
	message = arr[1];
	var msgarr = message.split("/");
	senderId = msgarr[0];
	senderNm = msgarr[1];
	senderMsg = msgarr[2];

	console.log("senderId : " + senderId);
	console.log("senderNm : " + senderNm);
	console.log("senderMsg : " + senderMsg);

	var cur_session = '${memVO.memId}'; //현재 세션에 로그인 한 사람 아이디
	var memNm = '${memVO.memNm}'; //현재 세션에 로그인 한 사람 이름

	if(sessionId == cur_session){
		var str = '<div class="row justify-content-end text-right mb-4">';
		var dt = new Date();

		str += '	<div class="col-auto">';
		str += '		<div class="card bg-success text-white">';
		str += '			<div class="card-body p-2">';
		str += '				<h5 class="mb-1">'+senderMsg+'</h5>';
		str += '				<div class="d-flex align-items-center justify-content-end text-sm opacity-6">';
		str += '					<i class="material-icons text-sm me-1">done_all</i>';
		str += '					<small>'+ dt.toLocaleTimeString() +'</small>';
		str += '				</div>';
		str += '			</div>';
		str += '		</div>';
		str += '	</div>';
		str += '	<div class="col-auto mt-auto">';
		str += '		<img id="myprofile" src="/resources/images/icon/hand-print.png" alt="..." class="avatar-xs shadow border-radius-lg"><br/>';
		str += '		<strong>'+memNm+'</strong>';
		str += '	</div>';
		str += '</div>';

		$("#msgArea").append(str);
	}else{
		var str = '<div class="row justify-content-start mb-4">';
		var dt = new Date();

		str += '	<div class="col-auto mt-auto"> ';
		str += '		<img src="/resources/images/icon/hand-print.png" alt="..." class="avatar-xs shadow border-radius-lg"><br/> ';
		str += 			senderNm;
		str += '	</div> ';
		str += '	<div class="col-auto"> ';
		str += '		<div class="card "> ';
		str += '			<div class="card-body p-2"> ';
		str += '				<h5 class="mb-1">'+senderMsg+'</h5> ';
		str += '				<div class="d-flex align-items-center text-sm opacity-6"> ';
		str += '					<i class="material-icons text-sm me-1">schedule</i> ';
		str += '					<small>'+ dt.toLocaleTimeString() +'</small> ';
		str += '				</div>';
		str += '			</div> ';
		str += '		</div> ';
		str += '	</div> ';
		str += '</div>';

		$("#msgArea").append(str);
	}

	$("#msgArea").scrollTop($("#msgArea")[0].scrollHeight);

}

//채팅창에서 나갔을 때
function onClose(evt) {
}
//채팅창에 들어왔을 때
function onOpen(evt) {
}

function checkvalues(tg){
	if(tg.value == ""){
		$("#button-send").prop("disabled",true);
	}else{
		$("#button-send").prop("disabled",false);
	}
}
</script>

<section class="content pt-3 pt-md-5 pb-md-5">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<header>
					<div class="page-header rounded-3 min-vh-50" style="background-image: url('/resources/images${data.attNm}');" loading="lazy">
						<span class="mask bg-gradient-dark opacity-4"></span>
					</div>
				</header>
				<div class="card card-body blur shadow-blur mx-md-4 mt-n6 overflow-hidden">
					<div class="container">
						<div class="row border-radius-md p-3 position-relative">
							<h3>${data.prmmTitle}</h3>
						</div>
					</div>
				</div>
			</div>

			<section class="pt-3">
				<div class="card shadow-lg mb-5">
					<div class="card-body row" style="min-height: 1000px;">
						<div class="col-2">

							<!-- 메뉴 -->
							<ul class="nav flex-column">
								<li class="nav-item my-menu-list pointer " data-menunm="인턴십소개">
									<a class="nav-link text-dark text-bold d-flex align-items-center my-md-2">
										<i class="material-icons text-dark opacity-5 pe-2">info</i>인턴십소개
									</a>
								</li>
								<li class="nav-item my-menu-list pointer " data-menunm="참여자">
									<a class="nav-link text-dark text-bold d-flex align-items-center my-md-2">
										<i class="material-icons text-dark opacity-5 pe-2">account_circle</i>참여자
									</a>
								</li>
								<li class="nav-item my-menu-list pointer " data-menunm="공지사항">
									<a class="nav-link text-dark text-bold d-flex align-items-center my-md-2">
										<i class="material-icons text-dark opacity-5 pe-2">note_alt</i>공지사항
										<sec:authorize access="hasRole('ROLE_NORMAL')">
											<span id="noticeNew" class="badge badge-primary">new</span>
										</sec:authorize>
									</a>
								</li>
								<li class="nav-item my-menu-list pointer " data-menunm="채팅">
									<a class="nav-link text-dark text-bold d-flex align-items-center my-md-2">
										<i class="material-icons text-dark opacity-5 pe-2">chat</i>채팅
									</a>
								</li>
								<li class="nav-item my-menu-list pointer " data-menunm="일정">
									<a class="nav-link text-dark text-bold d-flex align-items-center my-md-2">
										<i class="material-icons text-dark opacity-5 pe-2">calendar_month</i>일정
									</a>
								</li>
							</ul>
							<!-- 메뉴 -->
						</div>

						<div class="col-10">
							<div class="row">
								<div id="internshipTitle" class="col-md-8">
									<h4 class="text-gradient text-primary">
										일정
									</h4>
								</div>
							</div>

							<!-- 인턴십소개 -->
							<div id="itnsInfo" class="card min-height-600 internInfo" style="display: none;">
								<div class="card-body">
									<h6>${data.prmmContent}</h6>
								</div>
							</div>
							<!-- 인턴십소개 -->

							<!-- 참여자 -->
							<div id="account" class="row internInfo" style="display: none;">
								<!-- 정보 반복 구간 -->
								<c:forEach items="${itnsEntryantList }" var="itnsEntryant" >
									<div class="col-lg-3 col-sm-6 mb-4">
										<div class="p-3 info-horizontal">
											<div class="icon icon-shape text-center">
												<c:choose>
													<c:when test="${itnsEntryant.attNm eq null }">
														<img src="/resources/images/icon/hand-print.png" alt="..." class="avatar shadow border-radius-sm userimage" />
													</c:when>
													<c:otherwise>
														<img src="/resources/images${itnsEntryant.attNm }" alt="..." class="avatar shadow border-radius-sm userimage" />
													</c:otherwise>
												</c:choose>
											</div>
											<div class="description ps-3">
												<h5 class="mb-2">${itnsEntryant.memNm }</h5>
												<span class="badge badge-sm rounded-pill text-dark">${itnsEntryant.memJob }</span>
											</div>
										</div>
									</div>
								</c:forEach>
								<!-- 정보 반복 구간 -->
							</div>
							<!-- 참여자 -->

							<!-- 게시판 -->
							<div id="note" class="card min-height-600 internInfo" style="display: none;"></div>
							<!-- 게시판 -->

							<!-- 채팅 -->
							<div id="chat" class="card  min-height-600 internInfo" style="display: none;max-height: 600px;overflow: auto;">
								<div id="msgArea" class="card-body overflow-auto overflow-x-hidden">
									<div class="row mt-4">
										<c:set var="todayDate" value="<%= new java.util.Date()%>" />
										<div class="col-md-12 text-center">
											<span class="badge text-dark">
												<fmt:formatDate value="${todayDate }" pattern="yyyy.MM.dd"/>
											</span>
										</div>
									</div>

									<c:forEach var="chatVO" items="${itChatVO}">
										<c:choose>
											<c:when test="${chatVO.itnsChatSndr eq memVO.memId}">
												<div class="row justify-content-end text-right mb-4">
													<div class="col-auto">
														<div class="card bg-success text-white">
															<div class="card-body p-2">
																<h5 class="mb-1">
																	${chatVO.itnsChatContent }
																</h5>
																<div class="d-flex align-items-center justify-content-end text-sm opacity-6">
																	<i class="material-icons text-sm me-1">done_all</i>
																	<small><fmt:formatDate value="${chatVO.itnsChatDt }" type="time" /></small>
																</div>
															</div>
														</div>
													</div>
													<div class="col-auto mt-auto">
														<img id="myprofile" src="/resources/images/icon/hand-print.png" alt="..." class="avatar-xs shadow border-radius-lg"><br/>
														<strong>${memVO.memNm}</strong>
													</div>
												</div>
											</c:when>
											<c:otherwise>
												<div class="row justify-content-start mb-4">
													<div class="col-auto mt-auto">
														<img src="/resources/images/icon/hand-print.png" alt="..." class="avatar-xs shadow border-radius-lg"><br/>
														<strong>${chatVO.sdnm}</strong>
													</div>
													<div class="col-auto">
														<div class="card ">
															<div class="card-body p-2">
																<h5 class="mb-1">
																	${chatVO.itnsChatContent }
																</h5>
																<div class="d-flex align-items-center text-sm opacity-6">
																	<i class="material-icons text-sm me-1">schedule</i>
																	<small><fmt:formatDate value="${chatVO.itnsChatDt }" type="time" /></small>
																</div>
															</div>
														</div>
													</div>
												</div>
											</c:otherwise>
										</c:choose>
									</c:forEach>

								</div>

								<div class="card-footer d-block">
									<form class="align-items-center">
										<div class="input-group input-group-outline d-flex">
											<label class="form-label">메세지를 입력해보세요.</label>
											<input type="text" id="msg" class="form-control form-control-lg" onchange="checkvalues(this)">
											<button disabled id="button-send" class="btn bg-gradient-primary mb-0"><i class="material-icons">send</i></button>
										</div>
									</form>
								</div>

							</div>
							<!-- 채팅 -->

							<!-- 일정 -->
							<div id="calendar" class="internInfo"></div>
							<!-- 일정 -->
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
	<div id="connect" class="box bg-gray-200 shadow-lg p-3 rounded-3">
		<img alt="bot" src="/resources/images/icon/bot.png" />
		<strong>궁금한건 채팅으로 문의하세요!</strong>
	</div>

	<div class="chat bg-white p-3 shadow-xl rounded-3" style="display: none; border: 1px solid #a5a5a5;">
		<div id="conversation" class="min-height-400">
			<div class="text-end">
				<i class="material-icons" id="botClose">close</i>
			</div>
			<hr/>
			<div id="communicate" style="overflow-y: auto; max-height: 350px;">
				<div class="row justify-content-start">
					<div class="col-auto">
						<h6 class="NanumSquareNeo bg-gray-200 border-radius-lg shadow-lg p-2" style="display: inline-block;">
							안녕하세요 [ ${memVO.memNm} ] 회원님!<br/>
							이번 [ ${data.entNm } ] 에서 진행하는<br/>
							[ ${data.prmmTitle } ] 에 참여해주셔서 감사합니다.<br/><br/>
							해당 인턴십은 '채용 연계형' 입니다.<br/>
							과제 수행 내역을 기반으로 <br/>
							회원님의 역량을 평가하여 진행할 예정입니다.<br/><br/>
							앞으로 회원님의 역량을 마음껏 뽐내시길 기대하겠습니다.<br/>
							감사합니다 :)
						</h6>
					</div>
				</div>
			</div>
		</div>
		<form class="form-inline">
			<div class="form-group">
				<input type="text" id="msgBot" class="form-control" style="width: 80%;display: inline-block;" placeholder="내용을 입력하세요....">
				<button id="sendToBot" class="btn btn-default" disabled type="submit" style="vertical-align: baseline;">보내기</button>
			</div>
		</form>
	</div>
</section>

<script src="/resources/js/app.js" charset="UTF-8"></script>

<div class="modal fade" id="modalAddOneSchedule" tabindex="-1" aria-labelledby="modalAddOneSchedule" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-body p-0">
				<div class="modal-content">
					<div class="modal-header">
						<div class="row" style="margin-left: 38%;">
							<h5 class="modal-title">일정</h5>
						</div>
						<div class="row">
							<button type="button" class="btn btn-link text-dark my-1" data-bs-dismiss="modal">
								<i class="fas fa-times"></i>
							</button>
						</div>
					</div>
					<div class="modal-body">
						<form id="frm">
							<input type="hidden" id="itnsSchdNo" name="itnsSchdNo"/>
							<div class="row" style="justify-content: center;">
								<div class="input-group input-group-static">
									<label>일정명</label>
									<input type="email"	class="form-control" id="itnsSchdTitle" name="itnsSchdTitle" >
								</div>
								<div class="input-group input-group-static">
									<div class="col-5">
										<label>날짜</label>
										<input type="date" class="form-control" id="intsStartDt" name="intsStartDt">
										<div class="form-check form-switch">
											<input type="checkbox" class="form-check-input" id="allDay"/>
											<label class="form-check-label" for="allDay">하루종일</label>
										</div>
									</div>
									<div class="col-2"></div>
									<div class="col-5">
										<label>시작시간</label>
										<input type="time" class="form-control" id="intsStartDtHr" name="intsStartDtHr" >
										<label>종료시간</label>
										<input type="time" class="form-control" id="intsEndDtHr" name="intsEndDtHr" >
									</div>
								</div>
								<button class="btn bg-gradient-light col-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOption" aria-expanded="false" aria-controls="collapseExample">색 선택</button>
								<div class="collapse" id="collapseOption">
									<div class="input-group input-group-static">
										<div class="col-2"></div>
										<datalist id="list">
											<option>#0080FF</option>
											<option>#FF0000</option>
											<option>#00FF00</option>
											<option>#000000</option>
											<option>#FFFFFF</option>
										</datalist>
										<div class="col-3">
											<label>배경색</label>
											<input type="color" class="form-control" list="list" id="backgroundColor" name="backgroundColor" value="#0080FF"/>
										</div>
										<div class="col-2"></div>
										<div class="col-3">
											<label>글자색</label>
											<input type="color" class="form-control" list="list" id="textColor" name="textColor" value="#FFFFFF"/>
										</div>
										<div class="col-2"></div>
									</div>
								</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn bg-gradient-primary" id="btnCancel">취소</button>
						<button type="button" class="btn bg-gradient-info" id="btnModify">추가하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<script>
	let itnsScheduleList = ${itnsScheduleList};
	let events = [];
	$.each(itnsScheduleList, function(i, v){
		let event = {
			'id': v.itnsSchdNo,
			'title': v.itnsSchdTitle,
			'start': v.intsStartDt,
			'end': v.intsEndDt,
			'allDay': v.intsEndDt == null ? true : false,
			'backgroundColor': v.backgroundColor,
			'textColor' : v.textColor
		}
		console.log(event);
		events.push(event);
	});
	let modalAddOneSchedule = $("#modalAddOneSchedule");

	modalAddOneSchedule.find("#allDay").on("change", function(){
		if($(this).is(":checked")){
			modalAddOneSchedule.find("#intsStartDtHr").prop("disabled", true);
			modalAddOneSchedule.find("#intsEndDtHr").prop("disabled", true);
			modalAddOneSchedule.find("#intsStartDtHr").val("");
			modalAddOneSchedule.find("#intsEndDtHr").val("");
		}else{
			$("#intsStartDtHr").prop("disabled", false);
			$("#intsEndDtHr").prop("disabled", false);
		}
	});



	let is = true;
	// calendar element 취득
	let calendarEl = $('#calendar')[0];
	// full-calendar 생성하기
	let calendar = new FullCalendar.Calendar(calendarEl, {
		height : '700px', // calendar 높이 설정
		expandRows : true, // 화면에 맞게 높이 재설정
		slotMinTime : '08:00', // Day 캘린더에서 시작 시간
		slotMaxTime : '20:00', // Day 캘린더에서 종료 시간
		// 해더에 표시할 툴바
		headerToolbar : {
			left : 'prev,next, today',
			center : 'title',
			right : 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
		},
		initialView : 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
// 		initialDate : '2023-07-15', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
		navLinks : true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
		editable : is, // 수정 가능 여부 설정
		selectable : true, // 달력 일자 드래그 설정가능
		nowIndicator : true, // 현재 시간 마크
		dayMaxEvents : true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
		locale : 'ko', // 한국어 설정
		// FullCalendar에서는 일정 하나하나를 event객체로 관리함 -> event : 일정
		eventAdd : function(obj) { // 이벤트 추가
			console.log(obj);
			console.log(obj.event.title); // 이벤트 객체는 이런식으로 사용할 수 있음
		},
		eventChange : function(obj) { // 이벤트 수정
			console.log(obj);
		},
		eventRemove : function(obj) { // 이벤트 삭제
			console.log(obj);
			console.log(obj.event.id);
		},
		eventClick : function(obj) { // 이벤트 클릭
			console.log(obj.event);
			modalAddOneSchedule.find("#itnsSchdNo").val(obj.event.id);
			modalAddOneSchedule.find("#itnsSchdTitle").val(obj.event.title);
			modalAddOneSchedule.find("#intsStartDt").val(obj.event.startStr.slice(0, 10));
			if(obj.event.end == null){
				modalAddOneSchedule.find("#allDay").prop("checked", true);
				modalAddOneSchedule.find("#intsStartDtHr").prop("disabled", true);
				modalAddOneSchedule.find("#intsEndDtHr").prop("disabled", true);
			}else{
				modalAddOneSchedule.find("#allDay").prop("checked", false);
				modalAddOneSchedule.find("#intsStartDtHr").prop("disabled", false);
				modalAddOneSchedule.find("#intsEndDtHr").prop("disabled", false);
			}
			modalAddOneSchedule.find("#intsStartDtHr").val(obj.event.startStr.slice(11, 19));
			modalAddOneSchedule.find("#intsEndDtHr").val(obj.event.endStr.slice(11, 19));
			modalAddOneSchedule.find("#backgroundColor").val(obj.event.backgroundColor);
			modalAddOneSchedule.find("#textColor").val(obj.event.textColor);
			modalAddOneSchedule.find("#btnCancel").html("삭제");
			modalAddOneSchedule.find("#btnCancel").off("click");
			modalAddOneSchedule.find("#btnCancel").on("click", function(){
				Swal.fire({
					title: obj.event.title + ' 삭제하시겠습니까?',
					icon: 'question',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: '수락',
					cancelButtonText: '취소'
				}).then((result) => {
					if (result.isConfirmed) {
						$.ajax({
							url: "/myPremium/deleteInternshipSchedule",
							type: "post",
							data: {"itnsSchdNo": obj.event.id},
							beforeSend: function(xhr) {
								xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
							},
							success	: function(result) {
								console.log(result);
								if(result > 0){
									obj.event.remove();
									Swal.fire("삭제되었습니다.");
									modalAddOneSchedule.modal("hide");
								}
							}
						});
				  	}
				});
			});
			modalAddOneSchedule.find("#btnModify").html("수정");
			modalAddOneSchedule.modal("show");
		},
		dateClick : function(obj) { // 날짜 클릭
			console.log(obj);
			let intsStartDt = new Date(obj.date);
			console.log(changeDateFormat(intsStartDt).slice(0, 10));
			modalAddOneSchedule.find("#itnsSchdTitle").val("");
			modalAddOneSchedule.find("#intsStartDt").val(changeDateFormat(intsStartDt).slice(0, 10));
			modalAddOneSchedule.find("#allDay").prop("checked", false);
			modalAddOneSchedule.find("#intsStartDtHr").prop("disabled", false);
			modalAddOneSchedule.find("#intsEndDtHr").prop("disabled", false);
			modalAddOneSchedule.find("#intsStartDtHr").val("");
			modalAddOneSchedule.find("#intsEndDtHr").val("");
			modalAddOneSchedule.find("#backgroundColor").val("#0080FF");
			modalAddOneSchedule.find("#textColor").val("#FFFFFF");
			modalAddOneSchedule.find("#btnCancel").html("취소");
			modalAddOneSchedule.find("#btnCancel").off("click");
			modalAddOneSchedule.find("#btnCancel").on("click", cancelAddSchedule);
			modalAddOneSchedule.find("#btnModify").html("추가하기");
			modalAddOneSchedule.find("#btnModify").off("click");
			modalAddOneSchedule.find("#btnModify").on("click", saveOneSchedule);
			modalAddOneSchedule.modal("show");
		},
		// 이벤트 객체 (테이블에서 데이터 가져와서 여기에 넣어주면 초기화면에 렌더링 됨 - JSON)
		events : events
	});
	// 캘린더 랜더링
	calendar.render();

	function cancelAddSchedule(){
		modalAddOneSchedule.modal("hide");
	}

	function saveOneSchedule(){
		let itnsSchdTitle = $("#itnsSchdTitle").val();
		let intsStartDtHr = $("#intsStartDtHr").val();
		let intsEndDtHr = $("#intsEndDtHr").val();
		let isAllDay = $("#allDay").is(":checked");

		if(itnsSchdTitle == ""){
			Swal.fire("일정명을 입력하세요.");
			return;
		}
		if(intsStartDtHr == "" && !isAllDay){
			Swal.fire("시작시간을 입력하세요.");
			return;
		}
		if(intsEndDtHr == "" && !isAllDay){
			Swal.fire("종료시간을 입력하세요.");
			return;
		}

		let form = document.querySelector("#frm");
		let formData = new FormData(form);
		formData.set("itnsNo", "${data.itnsNo}");
		if(!isAllDay && intsStartDtHr != "" && intsEndDtHr != ""){
			let intsStartDt = new Date(formData.get("intsStartDt") + " " + formData.get("intsStartDtHr"));
			let intsEndtDt = new Date(formData.get("intsStartDt") + " " + formData.get("intsEndDtHr"));
			formData.set("intsStartDt", changeDateFormat(intsStartDt));
			formData.set("intsEndDt", changeDateFormat(intsEndtDt));
			console.log(changeDateFormat(intsStartDt));
			console.log(changeDateFormat(intsEndtDt));
		}


		$.ajax({
			url: "/myPremium/setInternshipSchedule",
			type: "post",
			data: formData,
			processData: false,
			contentType: false,
			beforeSend: function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success	: function(result) {
				console.log(result);
				if(result.msg == 'success'){
					if(calendar.getEventById(result.itnsScheduleVO.itnsSchdNo) != null){
						calendar.getEventById(result.itnsScheduleVO.itnsSchdNo).remove();
					}
					calendar.addEvent(
							{
							 'id': result.itnsScheduleVO.itnsSchdNo,
							 'title': result.itnsScheduleVO.itnsSchdTitle,
							 'start': result.itnsScheduleVO.intsStartDt,
							 'end': result.itnsScheduleVO.intsEndDt,
							 'backgroundColor': result.itnsScheduleVO.backgroundColor,
							 'textColor' : result.itnsScheduleVO.textColor
							 });
					Swal.fire("완료.");
					modalAddOneSchedule.modal("hide");
				}else{
					Swal.fire("다시 시도해주세요.");
				}
			}

		});
	}

	function changeDateFormat(obj){
		let date = "";
		date += obj.getFullYear();
		date += "-" + ((obj.getMonth() + 1) < 10 ? "0" + (obj.getMonth() + 1) : (obj.getMonth() + 1));
		date += "-" + (obj.getDate() < 10 ? "0" + obj.getDate() : obj.getDate());
		date += " " + (obj.getHours() < 10 ? "0" + obj.getHours() : obj.getHours());
		date += ":" + (obj.getMinutes() < 10 ? "0" + obj.getMinutes() : obj.getMinutes());
		date += ":" + (obj.getSeconds() < 10 ? "0" + obj.getSeconds() : obj.getSeconds());
		return date;

	}

</script>