<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OpenAI를 이용한 챗봇</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
        }
        #chat-container {
            width: 400px;
            height: 750px;
            display: none;
            flex-direction: column;
            border: 1px solid #ccc;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: white;
            
            position: fixed;
            bottom: 110px;
            right: 30px;
            z-index: 100;
        }
        #chat-messages {
            flex: 1;
            overflow-y: auto;
            padding: 10px;
            display: flex;
            flex-direction: column-reverse;
        }
        .message {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 10px;
            width: 100%;
        }
        .user-message {
            align-self: flex-end;
            background-color: #1e88e5;
            color: white;
            border-radius: 10px 0 10px 10px;
            padding: 10px;
            max-width: 70%;
            word-wrap: break-word;
            margin-left: auto;
        }
        .bot-message {
            align-self: flex-start;
            background-color: #f1f1f1;
            border-radius: 0 10px 10px 10px;
            padding: 10px;
            max-width: 70%;
            word-wrap: break-word;
            position: relative;
        }
        .bot-message::after {
            content: "";
            position: absolute;
            top: 10px;
            left: -10px;
            width: 0;
            height: 0;
            border-style: solid;
            border-width: 10px 10px 10px 0;
            border-color: transparent #f1f1f1 transparent transparent;
        }
        #user-input {
            display: flex;
            padding: 10px;
            border-top: 1px solid #ccc;
        }
        #user-input input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            outline: none;
        }
        #user-input button {
            border: none;
            background-color: #1e88e5;
            color: white;
            padding: 10px 15px;
            border-radius: 8px;
            cursor: pointer;
            margin-left: 10px;
        }
        .bot-image {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }
        
        #toggle-chatbot {
            position: fixed;
            bottom: 20px;
            right: 30px;
            cursor: pointer;
            z-index: 101;
            width: 75px;
            height: 75px;
        }
    </style>
</head>
<body>
    <%
        String botImageUrl = request.getContextPath() + "/resources/asset/pic/bot.png";
	    String botIcon1 = request.getContextPath() + "/resources/asset/pic/sleepbot.png";
	    String botIcon2 = request.getContextPath() + "/resources/asset/pic/bot.png";
    %>
    <img src="<%= botIcon1 %>" id="toggle-chatbot" alt="챗봇 열기 아이콘" />
    
    <div id="chat-container">
        <div id="chat-messages"></div>
        <div id="user-input">
            <input type="text" name="prompt" id="prompt" placeholder="메시지를 입력하세요." />
            <button type="button" id="btn-send">전송</button>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script>
	    const botIcon1 = "<%= botIcon1 %>";
	    const botIcon2 = "<%= botIcon2 %>";
        const botImageUrl = "<%= botImageUrl %>";
        let chatOpen = false;
        
        $('#toggle-chatbot').click(function() {
            chatOpen = !chatOpen;
            if (chatOpen) {
                $('#chat-container').css('display', 'flex'); // display를 flex로 변경
                setTimeout(() => {
                    $('#chat-container').css('opacity', '1'); // 약간의 지연 후에 opacity를 적용
                }, 10); 
                $('#toggle-chatbot').attr('src', botIcon2);
            } else {
                $('#chat-container').css('opacity', '0');
                setTimeout(() => {
                    $('#chat-container').css('display', 'none'); // opacity 0이 완료된 후 display를 none으로
                }, 300); // transition 속도에 맞춰 지연 시간 설정
                $('#toggle-chatbot').attr('src', botIcon1);
            }
        });


        $(document).ready(function() {
            $('#btn-send').click(function() {
                var prompt = $('#prompt').val();
                if (prompt.trim() === "") return;

                // 사용자의 질문 추가
                $('#chat-messages').prepend('<div class="message"><div class="user-message">' + prompt + '</div></div>');
                $('#prompt').val('');

                // 서버로 요청 전송
                $.ajax({
                    type: 'POST',
                    url: '/bot/gpt/chat',
                    data: { prompt: prompt },
                    dataType: 'json',
                    success: function(result) {
                        var response = result.response;
                        // 봇의 응답 추가
                        $('#chat-messages').prepend('<div class="message"><img src="' + botImageUrl + '" class="bot-image" alt="Bot" /><div class="bot-message">' + response + '</div></div>');
                    },
                    error: function(a, b, c) {
                        alert("오류 발생");
                        console.log(a, b, c);
                    }
                });
            });
        });
    </script>
</body>
</html>