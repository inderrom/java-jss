<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=07456a9f4803641615581d7b53fb0ee3&libraries=services"></script>
<!-- 회사 위치 띄울때 사용 -->
<div id="enterPriseMap" style="width:500px;height:400px;"></div>
	<script>
	let enterPriseAddress = '대전광역시 중구 계룡로 846'; // 기업 주소
	let enterPriseName = '대덕인재개발원'; // 기업명

	let mapContainer = document.getElementById('enterPriseMap'), // 지도를 표시할 div
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

	// 지도를 생성합니다
	let map = new kakao.maps.Map(mapContainer, mapOption);

	// 주소-좌표 변환 객체를 생성합니다
	let geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(enterPriseAddress, function(result, status) {

	    // 정상적으로 검색이 완료됐으면
		if (status === kakao.maps.services.Status.OK) {

		let coords = new kakao.maps.LatLng(result[0].y, result[0].x);

		// 결과값으로 받은 위치를 마커로 표시합니다
		let marker = new kakao.maps.Marker({
		    map: map,
		    position: coords
		});

		// 인포윈도우로 장소에 대한 설명을 표시합니다
		let infowindow = new kakao.maps.InfoWindow({
		    content: '<div style="width:150px;text-align:center;padding:6px 0;">' + enterPriseName + '</div>'
		});
		infowindow.open(map, marker);

		// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		map.setCenter(coords);
		}

	});
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 마커를 표시할 위치와 title 객체 배열입니다
	let positions = [
	    {
	        title: '카카오',
	        latlng: new kakao.maps.LatLng(33.450705, 126.570677)
	    },
	    {
	        title: '생태연못',
	        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
	    },
	    {
	        title: '텃밭',
	        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
	    },
	    {
	        title: '근린공원',
	        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
	    }
	];

	// 마커 이미지의 이미지 주소입니다
	let imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

    // 마커 이미지의 이미지 크기 입니다
    let imageSize = new kakao.maps.Size(24, 35);

    // 마커 이미지를 생성합니다
    let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

	geocoder.addressSearch('대전 중구 계룡로 858', function(result, status){
		if (status ===kakao.maps.services.Status.OK){
			a = {title: '홈플러스', latlng: new kakao.maps.LatLng(result[0].y, result[0].x)};
			positions.push(a);

			for (let i = 0; i < positions.length; i ++) {
			    // 마커를 생성합니다
			    let marker = new kakao.maps.Marker({
			        map: map, // 마커를 표시할 지도
			        position: positions[i].latlng, // 마커를 표시할 위치
			        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			        image : markerImage // 마커 이미지
			    });
			}
		}
	});

</script>

<!-- <!-- 내 위치 띄울때 사용 --> -->
<!-- <div id="myMap" style="width:500px;height:400px;"></div> -->
<!-- <script> -->
// let mapContainer = document.getElementById('myMap'), // 지도를 표시할 div
//     mapOption = {
//         center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
//         level: 10 // 지도의 확대 레벨
//     };

// let map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// // HTML5의 geolocation으로 사용할 수 있는지 확인합니다
// if (navigator.geolocation) {

//     // GeoLocation을 이용해서 접속 위치를 얻어옵니다
//     navigator.geolocation.getCurrentPosition(function(position) {

//         let lat = position.coords.latitude, // 위도
//             lon = position.coords.longitude; // 경도

//         let locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
//             message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다

//         // 마커와 인포윈도우를 표시합니다
//         displayMarker(locPosition, message);

//       });

// } else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

//     let locPosition = new kakao.maps.LatLng(33.450701, 126.570667),
//         message = 'geolocation을 사용할수 없어요..'

//     displayMarker(locPosition, message);
// }

// // 지도에 마커와 인포윈도우를 표시하는 함수입니다
// function displayMarker(locPosition, message) {

//     // 마커를 생성합니다
//     let marker = new kakao.maps.Marker({
//         map: map,
//         position: locPosition
//     });

//     let iwContent = message, // 인포윈도우에 표시할 내용
//         iwRemoveable = true;

//     // 인포윈도우를 생성합니다
//     let infowindow = new kakao.maps.InfoWindow({
//         content : iwContent,
//         removable : iwRemoveable
//     });

//     // 인포윈도우를 마커위에 표시합니다
//     infowindow.open(map, marker);

//     // 지도 중심좌표를 접속위치로 변경합니다
//     map.setCenter(locPosition);
// }
<!-- </script> -->