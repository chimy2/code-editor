<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" href="/editor/resources/css/chat.css" />

<!-- <html lang="en"> -->
<!-- <head> -->
    <meta charset="UTF-8">
   <!--  <title>Project Chat</title> --> <!-- 페이지 제목 -->
<!-- </head>
<body> -->
    <h2>Project Chat</h2> <!-- 페이지 헤더 -->

    <!-- Room ID 입력 및 채팅방 접속 버튼 -->
    <div>
        Project Name <input type="text" id="roomId" placeholder="Enter Project Name" > <!-- roomId 입력 필드 -->
        <button id="ProjectJoinButton" onclick="connectToRoom()">Join Room</button> <!-- 접속 버튼 클릭 시 connectToRoom() 함수 호출 -->
    </div>

    <!-- 채팅 메시지를 표시하는 영역 -->
    <div id="chatArea" ></div>

<!--style="border:1px solid #ccc; padding:10px; height:470px; overflow-y:scroll;"  -->


    <!-- 메시지 입력 필드 및 전송 버튼 -->
   
   <div id="chatsendform">
   
    <input type="text" id="messageInput" placeholder="메세지를 입력하세요">
    <button id="chatSendButton" onclick="sendMessage()">Send</button> <!-- 메시지 전송 버튼 클릭 시 sendMessage() 함수 호출 -->

   </div>
    <script>
        // WebSocket 객체를 전역 변수로 선언하여 여러 함수에서 접근 가능하게 설정
        let websocket = null;

       
        	
        // 채팅방에 접속하는 함수
        function connectToRoom() {
            // roomId 입력 필드의 값을 가져와 공백을 제거
            const roomId = document.getElementById("roomId").value.trim();
            
            console.log("Testing roomId variable:", roomId); // roomId 값 확인용 로그

            // roomId가 비어 있는지 확인
            if (!roomId) {
                alert("Please enter a room ID"); // roomId가 비어 있으면 경고 메시지 표시
                return;
            }

            // 기존 WebSocket 연결이 있다면 연결을 닫음
            if (websocket) {
                websocket.close();
            }

            // roomId를 쿼리 파라미터로 포함하여 WebSocket 연결 생성
           // websocket = new WebSocket(`ws://localhost:8090/chat/newchat?roomId=${roomId}`);
            
             websocket = new WebSocket('ws://localhost:8090/chat/newchat?roomId=' + roomId);
            
            
            
            // WebSocket 연결이 열리면 호출되는 이벤트 핸들러
            websocket.onopen = function() {
                console.log("Connected to the chat server with Room ID:", roomId);
                // 채팅 영역에 연결 성공 메시지 추가
                document.getElementById("chatArea").innerHTML += "<div>Project Name: " + roomId + "</div>";
            };

            // 서버에서 메시지가 수신되면 호출되는 이벤트 핸들러
            websocket.onmessage = function(event) {
                const chatArea = document.getElementById("chatArea"); // 채팅 메시지를 표시할 영역 가져오기
                chatArea.innerHTML += "<div>" + event.data + "</div>"; // 수신된 메시지를 새로운 div 요소로 추가
                // 새로운 메시지가 도착하면 자동으로 스크롤을 맨 아래로 이동
                chatArea.scrollTop = chatArea.scrollHeight;
            };

            // WebSocket 오류가 발생할 때 호출되는 이벤트 핸들러
            websocket.onerror = function(event) {
                console.error("WebSocket error:", event); // 오류 내용을 콘솔에 출력
                alert("Failed to connect to the chat server. Please try again."); // 연결 실패 시 경고 메시지 표시
            };

            // WebSocket 연결이 닫힐 때 호출되는 이벤트 핸들러
            websocket.onclose = function() {
                console.log("Disconnected from the chat server");
                // 연결이 종료되었음을 알리는 메시지를 채팅 영역에 추가
                document.getElementById("chatArea").innerHTML += "<div>Disconnected from chat room</div>";
            };
        }

        // 메시지를 서버로 전송하는 함수
        function sendMessage() {
            const messageInput = document.getElementById("messageInput"); // 메시지 입력 필드 가져오기
            const message = messageInput.value.trim(); // 메시지의 앞뒤 공백을 제거

            // 메시지가 비어 있는지 확인하여 비어 있으면 전송하지 않음
            if (!message) {
                return;
            }

            // WebSocket 연결이 열려 있는지 확인 후 메시지 전송
            if (websocket && websocket.readyState === WebSocket.OPEN) {
                websocket.send(message); // 메시지를 WebSocket을 통해 서버로 전송
                messageInput.value = ''; // 메시지 전송 후 입력 필드를 비움
            } else {
                alert("You are not connected to a room. Please join a room first."); // 연결되지 않은 경우 경고 메시지 표시
            }
        }

        // 메시지 입력 필드에서 Enter 키를 눌렀을 때 메시지를 전송하는 이벤트 리스너 추가
        document.getElementById("messageInput").addEventListener("keypress", function(event) {
            if (event.key === "Enter") {
                sendMessage(); // Enter 키가 눌리면 sendMessage() 함수 호출
            }
        });
        
        
        
        
    </script>
    
<!-- </body>
</html> -->
