<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=expand_circle_down" />
<%
	String contextPath = request.getContextPath();
	String botIcon1 = contextPath + "/resources/asset/pic/sleepbot.png";
	String botIcon2 = contextPath + "/resources/asset/pic/bot.png";
    String seq = request.getParameter("seq");
%>

<!-- 챗봇 아이콘 및 대화창 -->
<img src="<%= botIcon1 %>" id="toggle-chatbot" alt="챗봇 열기 아이콘" />

<div id="chat-container">
    <div id="chat-messages">
        <c:forEach var="message" items="${chatHistory}">
            <div class="message">
                <c:choose>
                    <c:when test="${message.role == 'user'}">
                        <div class="user-message">${message.content}</div>
                    </c:when>
                    <c:otherwise>
                        <img src="<%= botIcon2 %>" class="bot-image" alt="Bot" />
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
</div>

<style>
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
        overflow-y: scroll;
        padding: 10px;
        display: flex;
        flex-direction: column;
        max-height: 650px;
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
        max-width: 90%;
        word-wrap: break-word;
        margin-left: auto;
    }
    .bot-message {
        align-self: flex-start;
        background-color: #f1f1f1;
        border-radius: 0 10px 10px 10px;
        padding: 10px;
        max-width: 90%;
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
	#scroll-button {
	    display: none;
	    position: absolute;
	    bottom: 100px;
	    right: 150px;
	    padding: 10px 40px;
	    background-color: #1e88e5;
	    color: white;
	    border: none;
	    border-radius: 8px;
	    cursor: pointer;
	}
	
	.bot-message {
	    align-self: flex-start;
	    background-color: #f1f1f1;
	    border-radius: 0 10px 10px 10px;
	    padding: 10px;
	    max-width: 80%;
	    word-wrap: break-word;
	    position: relative;
	    font-size: 14px; 
	    line-height: 1.6;
	    color: #333;
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

	.bot-message .message-content {
	    display: flex;
	    align-items: center;
	}
</style>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>
    const botIcon1 = "<%= botIcon1 %>";
    const botIcon2 = "<%= botIcon2 %>";
    const userSeq = "<%= seq %>";
    let chatOpen = false;

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
	                                <div class="bot-message">\${botMessage}</div>
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
            },
            error: function(xhr, status, error) {
                console.error("Error sending message:", error);
                alert("Error occurred while sending message: " + error);
            }
        });
    }

    $(document).ready(function() {
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