<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
$(function(){
	let vurl = "https://apis.data.go.kr/B490001/gySjbPstateInfoService/getGySjBoheomBsshItem";	// 요청 url 주소 (고정)
	let serviceKey = "7K9rpuCuAtSJru4Uy7hxehoH2H%2FegrL24TuaWvR7w%2B0TVilOiLMdHAXvipaAqjwVhD7aMXhDtgct67sGhJ8sfA%3D%3D"; // 서비스키 (필수, 고정)
	let opaBoheomFg = "2"; // 산재/고용구분(2 고정)
	let v_saeopjaDrno = "3068205291"; // 사업자 등록번호
	$.ajax({
		url: vurl + "?serviceKey=" + serviceKey + "&opaBoheomFg=" + opaBoheomFg + "&v_saeopjaDrno=" + v_saeopjaDrno,
		type: "get",
		dataType: "xml",
		success: function(result){
			// 요청을 하면 xml DOM객체를 반환 받는다.
			// DOM객체로 반환받기 때문에 html의 DOM객체와 동일한 방법으로 사용할 수 있다.
// 			$("#disp").html(result);
			console.log(result);
			
			let addr = $(result).find("addr").html();
			let gyEopjongNm = $(result).find("gyEopjongNm").html();
			let gyEopjongCd = $(result).find("gyEopjongCd").html();
			let opaBoheomFg = $(result).find("opaBoheomFg").html();
			let post = $(result).find("post").html();
			let saeopjaDrno = $(result).find("saeopjaDrno").html();
			let saeopjangNm = $(result).find("saeopjangNm").html();
			let sangsiInwonCnt = $(result).find("sangsiInwonCnt").html();
			let seongripDt = $(result).find("seongripDt").html();
			let saeopFg = $(result).find("saeopFg").html();
			
			saeopjaDrno = saeopjaDrno.substring(0,3)+"-"+saeopjaDrno.substring(3,5)+"-"+saeopjaDrno.substring(5);
			seongripDt = seongripDt.substring(0,4)+"-"+seongripDt.substring(4,6)+"-"+seongripDt.substring(6);
			
			str = "<table border='1'>";
			str += "<tr><td>주소</td><td>"+addr+"</td></tr>";
			str += "<tr><td>고용업종명</td><td>"+gyEopjongNm+"</td></tr>";
			str += "<tr><td>고용업종코드</td><td>"+gyEopjongCd+"</td></tr>";
			str += "<tr><td>산재/고용구분</td><td>"+opaBoheomFg+"</td></tr>";
			str += "<tr><td>우편번호</td><td>"+post+"</td></tr>";
			str += "<tr><td>사업장등록번호</td><td>"+saeopjaDrno+"</td></tr>";
			str += "<tr><td>사업장명</td><td>"+saeopjangNm+"</td></tr>";
			str += "<tr><td>상시인원</td><td>"+sangsiInwonCnt+"</td></tr>";
			str += "<tr><td>성립일자</td><td>"+seongripDt+"</td></tr>";
			str += "<tr><td>보험가입구분</td><td>"+saeopFg+"</td></tr>";
			str += "</table>";
			
			$("#disp").html(str);
		}
	});
	
});
</script>

<h3>근로복지공단_고용/산재보험 현황정보</h3>

<p>End Point<br/>
http://apis.data.go.kr/B490001/gySjbPstateInfoService</p>

<p>고용/산재보험 가입 사업장 상세정보 조회<br/>
gySjbPstateInfoService/getGySjBoheomBsshItem</p>

<p>요청 파라미터<br/>
opaBoheomFg(산재/고용 구분 = 산재 : 1, 고용 : 2)<br/>
v_saeopjaDrno(사업자등록번호 10자리 숫자만) - 3068205291(대덕인재개발원)</p>

<p>serviceKey<br/>
일반 인증키(Encoding)<br/>
7K9rpuCuAtSJru4Uy7hxehoH2H%2FegrL24TuaWvR7w%2B0TVilOiLMdHAXvipaAqjwVhD7aMXhDtgct67sGhJ8sfA%3D%3D
<br/>
일반 인증키(Decoding)<br/>
7K9rpuCuAtSJru4Uy7hxehoH2H/egrL24TuaWvR7w+0TVilOiLMdHAXvipaAqjwVhD7aMXhDtgct67sGhJ8sfA==</p>

<p>전체 요청 URL<br/>
https://apis.data.go.kr/B490001/gySjbPstateInfoService/getGySjBoheomBsshItem?serviceKey=7K9rpuCuAtSJru4Uy7hxehoH2H%2FegrL24TuaWvR7w%2B0TVilOiLMdHAXvipaAqjwVhD7aMXhDtgct67sGhJ8sfA%3D%3D&opaBoheomFg=2&v_saeopjaDrno=3068205291
</p>

<pre>응답
addr : 주소
gyEopjongNm : 고용업종명
gyEopjongCd : 고용업종코드
opaBoheomFg : 산재/고용구분
post : 우편번호
saeopjaDrno : 사업장등록번호
saeopjangNm : 사업장명
sangsiInwonCnt : 상시인원
seongripDt : 성립일자
saeopFg : 보험가입구분 (1: 계속, 3: 일괄계속, 4: 일괄유기, 7: 사업개시계속)
</pre>

<div id="disp"></div>