<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />

<script src="https://unpkg.com/peerjs@1.4.7/dist/peerjs.min.js"></script>

<video id="mine" playsinline autoplay></video>
<video id="your" playsinline autoplay muted></video>

<button id="conn" >연결</button>


<script type="text/javascript">

let $_mine = document.querySelector("#mine");
let $_your = document.querySelector("#your");
let localStream;

let userId = "${memVO.memId}";

// var getUserMedia = navigator.mediaDevices.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.mzGetUserMedia;

navigator.mediaDevices.getUserMedia({video: true}).then((stream) => {
      console.log("getUserMedia 성공");
      localStream = stream;
      $_mine.srcObject = localStream;
   }).catch((err) => {
      console.log('getUserMedia 실패' ,err);
   });

var peer = new Peer(userId);
peer.on('open', function(id) {
   console.log("peer open, id : " + id);
});
   
peer.on('call', function(call) {
   console.log('call이 옴');
    call.answer(localStream);
    call.on('stream', function(remoteStream) {
      $_your.srcObject = remoteStream;
      console.log("media데이터 받음");
    });
  });
// .catch((err) => {
//     console.log('.on(call) 에러 : ' ,err);
//   })
   
$("#conn").on("click", function() {
   var call = peer.call('test_tea', localStream);
   console.log("상대에게 call");
   call.on('stream', function(remoteStream) {
      // 받은 stream을 
      $_your.srcObject = remoteStream;
      console.log("응답이 옴");
   });
});
</script>