/**
 * 
 */
 
 var stompClient = null;

function setConnected(connected) {
    $("#connect").prop("disabled", connected);
    $("#disconnect").prop("disabled", !connected);
    $("#sendToBot").prop("disabled", !connected);
    
    if (connected) {
        $("#conversation").show();
    }
    else {
        $("#conversation").hide();
    }
    $("#msg").html("");
}

function connect() {
    var socket = new SockJS('/ws');
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function (frame) {
        setConnected(true);
        console.log('Connected: ' + frame);
        stompClient.subscribe('/topic/public', function (message) {
            showMessage(message.body, "받음");
        });
    });
}

function disconnect() {
    if (stompClient !== null) {
        stompClient.disconnect();
    }
    setConnected(false);
    console.log("Disconnected");
}

function sendMessage() {
    let message = $("#msgBot").val();
    $("#msgBot").val("");
    showMessage(message, "보냄");

    stompClient.send("/app/sendMessage", {}, JSON.stringify(message)); //서버에 보낼 메시지
}

function showMessage(message, str) {
    let msg = message.replaceAll("\n", "<br>"); 

    if(str == "보냄"){
        $("#communicate").append("<div class='row justify-content-end'><div class='col-auto'><h6 class='NanumSquareNeo text-end border-radius-lg shadow-lg p-2' style='display: inline-block;background-color:#82b8ff;'>" + message + "</h6></div></div>");
    }
    else{
        $("#communicate").append("<div class='row justify-content-start'><div class='col-auto'><h6 class='NanumSquareNeo bg-gray-200 border-radius-lg shadow-lg p-2' style='display: inline-block;'>" + msg + "</h6></div></div>");
    }
    $("#communicate").scrollTop($("#communicate")[0].scrollHeight);
}

$(function () {
    $("form").on('submit', function (e) {
        e.preventDefault();
    });
    $( "#connect" ).click(function() { connect(); });
    $( "#disconnect" ).click(function() { disconnect(); });
    $( "#sendToBot" ).click(function() { sendMessage(); });
});