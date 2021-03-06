<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mh.css'/>">
<script src="http://cdn.sockjs.org/sockjs-0.3.4.js"></script>
<div class="mhdiv">
	<input type="text" id="message" />
	<input type="button" id="sendBtn" value="전송" />
	<div id="data"></div>
</div>
<script type="text/javascript">
$(document).ready(function() {
    $("#sendBtn").click(function() {
            sendMessage();
            $('#message').val('')
    });

    $("#message").keydown(function(key) {
            if (key.keyCode == 13) {// 엔터
                   sendMessage();
                   $('#message').val('')
            }
    });
});

// 웹소켓을 지정한 url로 연결한다.
let sock = new SockJS("<c:url value="/echo"/>");
sock.onmessage = onMessage;
sock.onclose = onClose;

// 메시지 전송
function sendMessage() {
	var id = "${sessionScope.id }";
	var name = "";
	if(id == "admin@watflix.com"){
		name = "관리자 : "
	}else{
		name = "나 : "
	}
    sock.send(name + $("#message").val());
}

// 서버로부터 메시지를 받았을 때
function onMessage(msg) {
    var data = msg.data;
    $("#data").append(data + "<br/>");
}

// 서버와 연결을 끊었을 때
function onClose(evt) {
    $("#data").append("연결 끊김");
}
</script>
