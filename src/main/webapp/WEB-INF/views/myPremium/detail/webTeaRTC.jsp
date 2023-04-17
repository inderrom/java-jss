<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />

<script src="https://unpkg.com/peerjs@1.4.7/dist/peerjs.min.js"></script>

<div id="videos">
   <video id="mine" playsinline autoplay muted></video>
   <video id="your" playsinline autoplay ></video>
</div>
<button id="conn" >연결</button>


<script type="text/javascript">

let $_mine = document.querySelector("#mine");
let $_your = document.querySelector("#your");
let localStream;

// var getUserMedia = navigator.mediaDevices.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.mzGetUserMedia;
// media 정보를 가져와서 내 화면에 띄우기
navigator.mediaDevices.getUserMedia({video: true})
   .then((stream) => {
   console.log("getUserMedia 성공");
   localStream = stream;
   $_mine.srcObject = localStream;
}).catch((err) => {
  console.log('getUserMedia 실패' ,err);
});

//peer 객체 초기화, peer 객체 open
var peer = new Peer("test_tea");
peer.on('open', function(id) {
   console.log("peer open, id : " + id);
});

peer.on('call', function(call) {
   console.log('call이 옴');
    call.answer(localStream);
    call.on('stream', function(remoteStream) {
       let newVideo = document.createElement("VIDEO");
       newVideo.setAttribute("autoplay", "autoplay");
       newVideo.srcObject = remoteStream;
      $("#videos").append(newVideo);
      $_your.srcObject = remoteStream;
      console.log("영상 데이터를 받음");
    });
  });
// .catch((err) => {
//     console.log('.on(call) 에러 : ' ,err);
//   })

// 연결 버튼 클릭 시
$("#conn").on("click", function() {
   // 상대방에게 call
   var call = peer.call('201901009', localStream);
   console.log("상대에게 call");
   call.on('stream', function(remoteStream) {
      // 받은 stream을 
      $_your.srcObject = remoteStream;
      console.log("응답이 옴");
   });
   
});
</script>