<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&display=swap" />
<link rel="stylesheet" href="/editor/resources/css/bot.css"/>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<%
	String contextPath = request.getContextPath();
	String botIcon1 = "/editor/resources/image/bot/sleepbot.png";
	String botIcon2 = "/editor/resources/image/bot/bot.png";
	String delIcon = "/editor/resources/image/bot/delete_bot.png";
    String seq = request.getParameter("seq");
%>
<!-- 챗봇 아이콘 및 대화창 -->
<img src="/editor/resources/image/bot/sleepbot.png" id="toggle-chatbot" alt="챗봇 열기 아이콘" />

<div id="chat-container">
    <div id="chat-messages">
        <c:forEach var="message" items="${chatHistory}">
            <div class="message">
                <c:choose>
                    <c:when test="${message.role == 'user'}">
                        <div class="user-message">${message.content}</div>
                    </c:when>
                    <c:otherwise>
                        <img src="/editor/resources/image/bot/bot.png" class="bot-image" alt="Bot" />
                        <div class="bot-message">${message.content}</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:forEach>
    </div>
    <button id="scroll-button" onclick="scrollToBottom()">
    	<span class="material-symbols-outlined">expand_circle_down</span>
    </button>
    <div id="user-input">
        <input type="text" name="prompt" id="prompt" placeholder="메시지를 입력하세요." />
        <button type="button" id="btn-send">전송</button>
    </div>
    <div id="del-onoff-Switch">
	    <span class="material-symbols-outlined" id="toggle-icon" title="대화 내역 삭제">toggle_off</span>
	</div>
</div>

<style>
	
</style>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>
	let userSeq;
	
    const botIcon1 = "<%= botIcon1 %>";
    const botIcon2 = "<%= botIcon2 %>";
    const delIcon = "<%= delIcon %>";
    const userSeq = "<%= seq %>";
    let chatOpen = false;
    
    const token = $("meta[name='_csrf']").attr("content")
	const header = $("meta[name='_csrf_header']").attr("content");
    
    let isOn = false;

    $('#del-onoff-Switch').click(function() {
        isOn = !isOn;
        $('#toggle-icon').text(isOn ? 'toggle_on' : 'toggle_off');
        
        if (isOn) {
            $('.delete-button').css('display', 'flex');
            $('#del-onoff-Switch').css('color','tomato');
            $('.message').css('gap','0px');
            $('.bot-image').css( 'filter' , 'brightness(0) invert(1)');
        } else {
            $('.delete-button').css('display', 'none');
            $('#del-onoff-Switch').css('color','#1e88e5');
            $('.message').css('gap','10px');
            $('.bot-image').css('filter', 'none');
        }
    });

    function scrollToBottom() {
        const chatMessages = document.getElementById('chat-messages');
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }

    function checkScrollPosition() {
        const chatMessages = document.getElementById('chat-messages');
        const scrollButton = document.getElementById('scroll-button');
        if (chatMessages.scrollTop + chatMessages.clientHeight < chatMessages.scrollHeight) {
            scrollButton.style.display = 'block';
        } else {
            scrollButton.style.display = 'none';
        }
    }
    
	function deleteMessage(chatseq) {
	    	
        if (confirm(`정말 삭제하시겠습니까?`)) {
            $.ajax({
                url: `/editor/delbot/\${chatseq}`,
                type: 'DELETE', 
                dataType : 'json',
                contentType: 'application/json; charset=utf-8',
                beforeSend : function(xhr) {
                    xhr.setRequestHeader(header, token);
                },
                success: function(response) {
                	loadChatHistory();
                },
                error: function(a,b,c) {
                	loadChatHistory();
                }
            });
        }
    }
    
    function loadChatHistory() {
	    $.ajax({
	        type: "GET",
	        url: "/bot/gpt/chat",
	        data: { seq: userSeq },
	        dataType: "json",
	        success: function(response) {
	            const chatHistory = response.chatHistory || [];
	            $('#chat-messages').empty();
	            
	            for (let i = 0; i < chatHistory.length; i++) {
	                if (chatHistory[i].role === 'user') {
	                    const userMessage = chatHistory[i].content;
	                    const botMessage = (chatHistory[i + 1] && chatHistory[i + 1].role === 'assistant') ? chatHistory[i + 1].content : '';
	                    const chatSeq = (chatHistory[i + 2] && chatHistory[i + 2].role === 'botConversation') ? chatHistory[i + 2].content : '';

	                    const userMessageHtml = `
	                        <div class="message">
	                            <div class="user-message">\${userMessage}</div>
	                        </div>
	                    `;

	                    let botMessageHtml = '';
	                    if (botMessage) {
	                        botMessageHtml = `
	                            <div class="message">
	                                <img src="\${botIcon2}" class="bot-image" alt="Bot" />
	                                	<button class="delete-button" type="button" style="display: ${isOn ? 'flex' : 'none'};" onclick="deleteMessage('\${chatSeq}')">
	                                        <img src="\${delIcon}" alt="삭제 아이콘" title="이 대화 삭제하기"/>
	                                    </button>	
	                                <div class="bot-message">
	                                	\${botMessage}
	                                </div>
	                            </div>
	                        `;
	                    }

	                    $('#chat-messages').append(userMessageHtml + botMessageHtml);

	                    i++;
	                }
	            }	
	
	            scrollToBottom();
	        },
	        error: function(xhr, status, error) {
	            console.error("Error loading chat history:", error);
	            alert("An error occurred while loading chat history: " + error);
	        }
	    });
	}

    function sendMessage() {
        const prompt = $('#prompt').val();
        if (prompt.trim() === "") return;

        $('#chat-messages').append('<div class="message"><div class="user-message">' + prompt + '</div></div>');
        $('#prompt').val('');

        $.ajax({
            type: 'POST',
            url: '/bot/gpt/chat',
            data: { prompt: prompt, seq: userSeq },
            dataType: 'json',
            success: function(result) {
                const response = result.response;
                $('#chat-messages').append('<div class="message"><img src="' + botIcon2 + '" class="bot-image" alt="Bot" /><div class="bot-message">' + response + '</div></div>');
                scrollToBottom();
                loadChatHistory();
            },
            error: function(xhr, status, error) {
                console.error("Error sending message:", error);
                alert("Error occurred while sending message: " + error);
            }
        });
    }

    $(document).ready(function() {
    	
    	const member = {
    	    	seq: '${member.seq}'
    	    };
        	
        	userSeq = member.seq || "null";
        	
        	console.log(userSeq);
    	
        if (!userSeq || userSeq === "null") {
            $('#toggle-chatbot').hide();
        } else {
            loadChatHistory();
            $('#toggle-chatbot').click(function() {
                chatOpen = !chatOpen;
                if (chatOpen) {
                    $('#chat-container').css('display', 'flex');
                    setTimeout(() => {
                        $('#chat-container').css('opacity', '1');
                        scrollToBottom();
                    }, 10);
                    $('#toggle-chatbot').attr('src', botIcon2);
                } else {
                    $('#chat-container').css('opacity', '0');
                    setTimeout(() => {
                        $('#chat-container').css('display', 'none');
                    }, 300);
                    $('#toggle-chatbot').attr('src', botIcon1);
                }
            });

            $('#chat-messages').on('scroll', checkScrollPosition);
            $('#btn-send').click(sendMessage);
            $('#prompt').keydown(function(event) {
                if (event.key === "Enter") {
                    event.preventDefault();
                    sendMessage();
                }
            });
        }
    });
</script>