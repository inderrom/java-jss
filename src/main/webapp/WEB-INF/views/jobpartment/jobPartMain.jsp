<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>

<style>
.entimgshow {
    display: list-item;
	list-style:none;
    width: 60px;
    height: 60px;
    border-radius: 3px;
    border: 1px solid #eee;
    float: left;
    margin: 6px;
    background-position: 50%;
    background-size: cover;
}
.choices__item {
	font-size: large;
}
</style>
<main>
	<section class="pt-3 pt-md-5 pb-md-5">
		<div class="container p-4 blur border-radius-lg" style="min-height: 1500px;background-color: rgb(255 244 244 / 60%) !important;">
			<div class="row">
				<div class="container bg-white border-radius-lg p-sm-5">
					<h2>이제 밤새워 채용 사이트 보지 마세요!</h2>
					<h5>잡아줄게에 이력서를 등록하시면, 기업의 인사 담당자가 직접 면접을 제안합니다.</h5>
					<ul style="margin-left: -40px;">
						<li class="entimgshow" style="background-image: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FcXtMRd%2Fbtr8J3PNfVM%2FhbikLkFa5z2TllnWYDyTM1%2Fimg.jpg')"></li>
						<li class="entimgshow" style="background-image: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FdtlcFN%2Fbtr8J5mx0H7%2FCKLsuF2fmMDQ2b9558d0nk%2Fimg.jpg')"></li>
						<li class="entimgshow" style="background-image: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FroyPE%2Fbtr8LjEuufM%2FDqIYvWFuwnzs7RKFKJCAek%2Fimg.png')"></li>
						<li class="entimgshow" style="background-image: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FL9ruu%2Fbtr8LgAY34X%2FdUgFjh0MWy0BxYuaBidhRk%2Fimg.jpg')"></li>
						<li class="entimgshow" style="background-image: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F8LJXX%2Fbtr8MoL9ozx%2FDYJmjKtLeT3buCsrZ4Evyk%2Fimg.jpg')"></li>
						<li class="entimgshow" style="background-image: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FBAD5W%2Fbtr8XymBg9S%2F2SKWucgUorz71jDrzW0XP0%2Fimg.jpg')"></li>
						<li class="entimgshow" style="background-image: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FAtkpk%2Fbtr8UU4p5O0%2FMFVPnbuTTNLLGStp4okrj1%2Fimg.jpg')"></li>
						<li class="entimgshow" style="background-image: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fc4ORW0%2Fbtr8UYlsBZY%2F9USGGjEKKTVGk5EuKqXZO0%2Fimg.jpg')"></li>
						<li class="entimgshow" style="background-image: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FdbxQtI%2Fbtr8LOqNLAY%2FONovXEtV8c87097ZOGQvek%2Fimg.jpg')"></li>
						<li class="entimgshow" style="background-image: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FuKXjK%2Fbtr8OU4RagY%2FK85Ue6Ug2YH40DI2TSk2Ak%2Fimg.jpg')"></li>
						<li class="entimgshow" style="background-image: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fd61mKQ%2Fbtr8T5Sw3EW%2FEdHxrAKEjyS7sAYDLvVvMK%2Fimg.jpg')"></li>
						<li class="entimgshow" style="background-image: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FcUBKuy%2Fbtr8P0DTZTX%2FZeiz2w54IfKinKB8qTZI11%2Fimg.jpg')"></li>
						<li class="entimgshow" style="background-image: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fbq4uIx%2Fbtr8LOqNRM1%2FKKaGiUVykWDbMLkxQKnae1%2Fimg.jpg')"></li>
						<li class="entimgshow" style="background-image: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fbmf7q7%2Fbtr8KILlrIm%2FWmqOITefN1BT0QGp4klBoK%2Fimg.jpg')"></li>
					</ul>
				</div>
			</div>
			<hr/>
			<div class="row bg-white border-radius-lg p-sm-5" style="align-items: center;">
				<div class="col-3 pt-4">
					<h5>내 직군의 연봉 알아보기</h5>
				</div>
				<div class="col-3 pt-4">
					<select class="form-control" name="job" id="job">
						<option value="DEVELOPER" selected>개발</option>
						<option value="MANAGEMENT">경영/비지니스</option>
						<option value="MARKETING" selected>마케팅/광고</option>
						<option value="DESIGN">디자인</option>
					</select>
				</div>
				<div class="col-3 pt-4">
					<select class="form-control" name="jobDetail" id="jobDetail">
						<option value="DEV0001">프론트엔드 개발자</option>
						<option value="DEV0002" >백엔드 개발자</option>
						<option value="DEV0003">ios 개발자</option>
						<option value="DEV0004">안드로이드 개발자</option>
						<option value="DEV0005">DBA</option>
						<option value="DEV0006" selected>브랜드 마케터</option>
					</select>
				</div>
				<div class="col-3 pt-4">
					<select class="form-control" name="crrYear" id="crrYear">
						<option value="DEV0001">경력</option>
						<option value="DEV0002" selected>신입</option>
					</select>
				</div>
				<div class="card card-body bg-gradient-success">
					<div class="row">
						<div class="col-8">
							<div class="container">
								<div class="card-body p-3">
									<div class="chart pt-3">
										<canvas id="chart-cons-week" class="chart-canvas" height="480" width="400" style="display: block; box-sizing: border-box; height: 320px; width: 393.7px;"></canvas>
									</div>
								</div>
							</div>
						</div>
						<div class="col mt-6">
							<p><span class="badge badge-success" style="font-size: large;">마케팅/광고</span></p>
							<p><span class="badge badge-success" style="font-size: large;">브랜딩 마케터</span></p>
							<br/>
							<p style="color: white;font-size: x-large;">
								신입 브랜드 마케터 예상 연봉
								<br/>
								<strong style="font-size: xxx-large;">2,856</strong>&nbsp;&nbsp;만원
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</main>

<script src="/resources/materialKet2/js/plugins/chartjs.min.js"></script>
<script>
	// Chart Consumption by day
	var ctx = document.getElementById("chart-cons-week").getContext("2d");

	new Chart(ctx, {
		type : "bar",
		data : {
			labels : [ "신입", "1년", "2년", "3년", "4년", "5년", "6년", "7년", "8년", "9년", "10년" ],
			datasets : [ {
				label : "연봉",
				tension : 0.4,
				borderWidth : 0,
				borderRadius : 0,
				borderSkipped : false,
				backgroundColor : "#ffffffbd",
				data : [ 2856, 3556, 3753, 4038, 4370, 4563, 5049, 5286, 5470, 5850, 6817 ],
				maxBarThickness : 15
			}, ],
		},
		options : {
			responsive : true,
			maintainAspectRatio : false,
			plugins : {
				legend : {
					display : false,
				}
			},
			interaction : {
				intersect : false,
				mode : 'index',
			},
			scales : {
				y : {
					grid : {
						drawBorder : false,
						display : true,
						drawOnChartArea : true,
						drawTicks : false,
						borderDash : [ 5, 5 ],
						color : '#c1c4ce5c'
					},
					ticks : {
						suggestedMin : 0,
						suggestedMax : 500,
						beginAtZero : true,
						padding : 10,
						color : '#ffffffbd',
						font : {
							size : 14,
							weight : 300,
							family : "Roboto",
							style : 'normal',
							lineHeight : 2
						}
					},
				},
				x : {
					grid : {
						drawBorder : false,
						display : true,
						drawOnChartArea : true,
						drawTicks : false,
						borderDash : [ 5, 5 ],
						color : '#c1c4ce5c'
					},
					ticks : {
						display : true,
						color : '#ffffffbd',
						padding : 10,
						font : {
							size : 14,
							weight : 300,
							family : "Roboto",
							style : 'normal',
							lineHeight : 2
						}
					}
				},
			},
		}
	});
</script>

<script src="https://demos.creative-tim.com/material-kit-pro/assets/js/plugins/choices.min.js" type="text/javascript"></script>
<script>
if (document.getElementById('job')) {
	var element = document.getElementById('job');
	const example = new Choices(element, {
		searchEnabled: false
	});
}
if (document.getElementById('jobDetail')) {
	var element = document.getElementById('jobDetail');
	const example = new Choices(element, {
		searchEnabled: false
	});
}
if (document.getElementById('crrYear')) {
	var element = document.getElementById('crrYear');
	const example = new Choices(element, {
		searchEnabled: false
	});
}
</script>