<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&display=swap" />
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<link rel="stylesheet" href="/editor/resources/css/bot_editor.css"/>
<%
	String contextPath = request.getContextPath();
	String botIcon1 = "/editor/resources/image/bot/sleepbot.png";
	String botIcon2 = "/editor/resources/image/bot/bot.png";
    String seq = request.getParameter("seq");
%>

<!-- 챗봇 아이콘 및 대화창 -->
<img src="<%= botIcon1 %>" id="toggle-chatbot" alt="챗봇 열기 아이콘" />

<div id="chatbot-container">
    <div id="chatbot-messages">
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
    <div id="chatbotuser-input">
        <input type="text" name="prompt" id="prompt" placeholder="메시지를 입력하세요." />
        <button type="button" id="btn-send">전송</button>
    </div>
</div>
<style>
    
</style>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>
	let userSeq;
	
    const botIcon1 = "<%= botIcon1 %>";
    const botIcon2 = "<%= botIcon2 %>";
    let chatOpen = false;
    
    const token = $("meta[name='_csrf']").attr("content")
	const header = $("meta[name='_csrf_header']").attr("content");

    function scrollToBottom() {
        const chatMessages = document.getElementById('chatbot-messages');
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }

    function checkScrollPosition() {
        const chatMessages = document.getElementById('chatbot-messages');
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
	            $('#chatbot-messages').empty();
	            
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
	                                <div class="bot-message">
	                                	\${botMessage}
	                                </div>
	                            </div>
	                        `;
	                    }

	                    $('#chatbot-messages').append(userMessageHtml + botMessageHtml);

	                    i++;
	                }
	            }	
	
	            scrollToBottom();
	        },
	        error: function(xhr, status, error) {
	            console.error("Error loading chat history:", error);
	            /* 
	            alert("An error occurred while loading chat history: " + error);
	             */
	        }
	    });
	}

    function sendMessage() {
        const prompt = $('#prompt').val();
        if (prompt.trim() === "") return;

        $('#chatbot-messages').append('<div class="message"><div class="user-message">' + prompt + '</div></div>');
        $('#prompt').val('');

        $.ajax({
            type: 'POST',
            url: '/bot/gpt/chat',
            data: { prompt: prompt, seq: userSeq },
            dataType: 'json',
            success: function(result) {
                const response = result.response;
                $('#chatbot-messages').append('<div class="message"><img src="' + botIcon2 + '" class="bot-image" alt="Bot" /><div class="bot-message">' + response + '</div></div>');
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
                	$('#toggle-chatbot').animate({ right: '340px'}, 300);
                	$('#chatbot-container').css({ display: 'flex', opacity: '0', right: '-330px' }).animate({
                        right: '10px',
                        opacity: '1'
                    }, 300);
                	scrollToBottom();
                    $('#toggle-chatbot').attr('src', botIcon2);
                } else {
                	if(isSidebarOpen) {
	                	$('#toggle-chatbot').animate({ right: '390px' }, 300);
	
	                    $('#chatbot-container').animate({
	                        right: '-330px',
	                        opacity: '0'
	                    }, 300, function() {
	                        $(this).css('display', 'none');
	                    });
	
	                    $('#toggle-chatbot').attr('src', botIcon1);
                	} else {
                		$('#toggle-chatbot').animate({ right: '40px' }, 300);
                		
	                    $('#chatbot-container').animate({
	                        right: '-330px',
	                        opacity: '0'
	                    }, 300, function() {
	                        $(this).css('display', 'none');
	                    });
	
	                    $('#toggle-chatbot').attr('src', botIcon1);
                	}
                }
            });

            $('#chatbot-messages').on('scroll', checkScrollPosition);
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