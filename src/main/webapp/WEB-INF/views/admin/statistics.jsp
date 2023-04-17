<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content-wrapper" style="min-height: 625px;margin: 0px">
	<!-- Content Header (Page header) -->
	<!-- /.content-header -->

	<!-- Main content -->
	<section class="content">
		<div class="container-fluid"
			style="background-color: linear-gradient(270deg, rgba(155, 122, 210, 1) 0%, rgba(181, 255, 240, 1) 100%);">
			<!-- -------------------- body 시작 -------------------- -->



			<div class="content-header">
				<h5>잡아줄게 전체 통계</h5>
			</div>

			<div class="card">
				<div class="card-body">
					<div class="row justify-content-center">
						<div class="col-6"  id="memberChart" style="width: 100%; height: 500px;"></div>
						<div class="col-6"  id="visitMemberChart" style="width: 100%; height: 500px;"></div>
					</div>
					<div class="row mt-6">
						<div  id="visitantChart"style="width: 100%; height: 500px;"></div>
					</div>
					<div class="row justify-content-center">
						<div class="col-6" id="memMembershipChart" style="width: 100%; height: 500px;"></div>
						<div class="col-6" id="entMembershipChart" style="width: 100%; height: 500px;"></div>
					</div>
					<div class="row mt-6">
						<div  id="salesChart"style="width: 100%; height: 500px;"></div>
					</div>

				</div>
			</div>

		</div>
		<!-- /.container-fluid -->
	</section>
	<!-- /.content -->
</div>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<script type="text/javascript">
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(memberChart);
google.charts.setOnLoadCallback(visitMemberChart);
google.charts.setOnLoadCallback(memMembershipChart);
google.charts.setOnLoadCallback(entMembershipChart);
google.charts.setOnLoadCallback(visitantChart);
google.charts.setOnLoadCallback(salesChart);

// let memberChart =document.getElementById("memberChart");
// let membershipChart =document.getElementById("membershipChart");
// let visitantChart =document.getElementById("visitantChart");
// let salesChart =document.getElementById("salesChart");



//회원 비율 통계
function memberChart() {
	var memberData = google.visualization.arrayToDataTable([
		['회원분류', '회원수'],
      ['일반회원', 320210],
      ['기업회원',  25021]
    ]);

    var  memberOptions = {
      title: '회원별 통계 Total : 345,231 명',
      chartArea:{width:'100%'}
    };

    var memberChart = new google.visualization.PieChart(document.getElementById("memberChart"));

    memberChart.draw(memberData, memberOptions);
  };
//일별 회원 방문 비율 통계
function visitMemberChart() {
	var memberData = google.visualization.arrayToDataTable([
		['회원분류', '회원수'],
      ['일반회원', 4210],
      ['기업회원',  2021],
      ['기업회원',  521]
    ]);

    var  memberOptions = {
      title: '일별 회원 통계 Total : 6,752 명',
      chartArea:{width:'100%'}
    };

    var memberChart = new google.visualization.PieChart(document.getElementById("visitMemberChart"));

    memberChart.draw(memberData, memberOptions);
  };

//회원 멤버십 통계
function memMembershipChart() {

	var membershipData = google.visualization.arrayToDataTable([
      ['상태', '회원수'],
      ['미구독', 213474],
      ['구독',  106736]
    ]);

	var membershipOptions = {
      title: '일반회원 멤버십 구독 Total : 320,210 명',
      chartArea:{width:'100%'}
    };

	var membershipChart = new google.visualization.PieChart(document.getElementById("memMembershipChart"));

    membershipChart.draw(membershipData, membershipOptions);
  };

  //기업 멤버십 통계
function entMembershipChart() {

	var membershipData = google.visualization.arrayToDataTable([
		['상태', '회원수'],
      ['미구독', 9846],
      ['라이트구독',  9504],
      ['베이직',  5421],
      ['무제한',  214]
    ]);

	var membershipOptions = {
      title: '기업회원 멤버십 구독 Total : 25,021 명',
      chartArea:{width:'100%'}
    };

	var membershipChart = new google.visualization.PieChart(document.getElementById("entMembershipChart"));

    membershipChart.draw(membershipData, membershipOptions);
  };

//방문자 통계
  function visitantChart() {
      // Some raw data (not necessarily accurate)
      var data = google.visualization.arrayToDataTable([
        ['Month', '비회원', '일반회원', '기업회원', '총방문자'],
        ['22.2Q',  10767,      10220,      450,  	  21437   ],
        ['22.3Q',  12135,      9120,       1540,	  22795   ],
        ['22.4Q',  14157,      21167,      2302,      37626   ],
        ['23.1Q',  19139,      51110,      7602,      77851   ],
      ]);

      var options = {
        title : '회원별 방문자 통계 (단위: 명)',
        vAxis: {title: '방문자'},
        hAxis: {title: '분기별'},
        seriesType: 'bars',
        series: {3: {type: 'line'}},
      };

      var chart = new google.visualization.ComboChart(document.getElementById('visitantChart'));
      chart.draw(data, options);
    }
//매출액 통계
  function salesChart() {
      // Some raw data (not necessarily accurate)
      var data = google.visualization.arrayToDataTable([
        ['Month',    '일반회원', '기업회원', '총매출'],
        ['23.01',      11220,       450,        11670],
        ['23.02',      9120,        1040,       10160],
        ['23.03',      21167,       2302,       23469],
        ['23.04',      15110,       2002,       17112],
      ]);

      var options = {
        title : '회원별 총매출액 통계 (단위: 만원)',
        vAxis: {title: '매출액 '},
        hAxis: {title: '분기별'},
        seriesType: 'bars',
        series: {2: {type: 'line'}},
      };

      var chart = new google.visualization.ComboChart(document.getElementById('salesChart'));
      chart.draw(data, options);
    }

</script>
<script>

</script>