<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chat History Table</title>
<style>
    body {
        background-color: #000;
        color: #fff;
        font-family: Arial, sans-serif;
    }
    #chat-table {
        width: 80%;
        margin: 20px auto;
        border-collapse: collapse;
    }
    #chat-table th, #chat-table td {
        border: 1px solid #555;
        padding: 10px;
        text-align: center;
    }
    #chat-table th {
        background-color: #333;
    }
    #chat-table td {
    	background-color: white;
    	color: black;
    }
    .delete-button {
        background-color: white;
        color: black;
        border: none;
        padding: 5px 5px;
        border-radius: 4px;
        cursor: pointer;
    }
    .delete-button:hover {
        background-color: #FFA500;
    }
</style>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=delete" />
</head>
<body>
    <h1 style="text-align: center;">Chat History</h1>
    <table id="chat-table">
        <thead>
            <tr>
                <th>나의 질문</th>
                <th>챗봇 답변</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody id="chat-messages">
            <!-- Chat messages will be loaded here -->
        </tbody>
    </table>
	
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script>
	    const userSeq = "<%= request.getParameter("seq") %>";
	
	    function loadChatHistory() {
	        $.ajax({
	            type: "GET",
	            url: "/bot/gpt/chat",
	            data: { seq: userSeq },
	            dataType: "json",
	            success: function(response) {
	                const chatHistory = response.chatHistory || [];
	                $('#chat-messages').empty();
	
	                console.log(chatHistory);
	
	                for (let i = 0; i < chatHistory.length; i++) {
	                    if (chatHistory[i].role === 'user') {
	                        const userMessage = chatHistory[i].content;
	                        const botMessage = (chatHistory[i + 1] && chatHistory[i + 1].role === 'assistant') ? chatHistory[i + 1].content : '';
	                        const chatSeq = (chatHistory[i + 2] && chatHistory[i + 2].role === 'botConversation') ? chatHistory[i + 2].content : '';
	
	                        const messageHtml = `
	                            <tr>
	                                <td>\${userMessage}</td>
	                                <td>\${botMessage}</td>
	                                <td>
	                                    <button class="delete-button" onclick="deleteMessage(\${chatSeq})">
	                                        <span class="material-symbols-outlined">delete</span>
	                                    </button>
	                                </td>
	                            </tr>
	                        `;
	                        $('#chat-messages').append(messageHtml);
	
	                        i += 1;
	                    }
	                }
	            },
	            error: function(xhr, status, error) {
	                console.error("Error loading chat history:", error);
	                alert("An error occurred while loading chat history: " + error);
	            }
	        });
	    }
	
	    function deleteMessage(chatseq) {
	    	
	        if (confirm("정말 삭제하시겠습니까?")) {
	            $.ajax({
	                url: `/editor/delbot/\${chatseq}`,
	                type: 'DELETE',
	                success: function(response) {
	                    alert('삭제에 성공했습니다.');
	                    loadChatHistory(); 
	                },
	                error: function(error) {
	                    alert('삭제를 실패했습니다.');
	                }
	            });
	        }
	    }
	
	    $(document).ready(function() {
	        loadChatHistory();
	    });
	</script>

</body>
</html>