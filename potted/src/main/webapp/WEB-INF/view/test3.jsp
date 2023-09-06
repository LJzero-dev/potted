<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head><body>
    <div id="messageDiv"></div>

    <script>
        const socket = new WebSocket("ws://localhost:8087/potted/websocket");

        socket.onmessage = function(event) {
            const messageDiv = document.getElementById("messageDiv");
            messageDiv.innerHTML += "<p>" + event.data + "</p>";
        };

        function sendMessage() {
            const message = document.getElementById("messageInput").value;
            socket.send(message);
        }
    </script>
</body>
</html>