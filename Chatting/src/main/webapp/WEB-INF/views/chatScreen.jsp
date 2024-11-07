<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

	<meta charset="UTF-8">
	<title></title>
	<link rel="stylesheet" href="http://bit.ly/3WJ5ilK">
	<style>
		html, body {
			padding: 0 !important;
			margin: 0 !important;
			background-color: #FFF !important; 
			display: block;
			overflow: hidden;
		}
		
		body > div {
			margin: 0; 
			padding: 0; 
		}
	
		#main {
			width: 400px;
			height: 510px;
			margin: 3px;
			display: grid;
			grid-template-rows: repeat(12, 1fr);
		}
		
		#header {
		
		}
		
		#header > h2 {		
			margin: 0px;
			margin-bottom: 10px;
			padding: 5px;
		}
	
		#list {
			border: 1px solid var(--border-color);
			box-sizing: content-box;
			padding: .5rem;
			grid-row-start: 2;
			grid-row-end: 12;
			font-size: 14px;
			overflow: auto;
		}
		
		
		#msg {
			margin-top: 3px;
		}
		
		#list .item {
			font-size: 14px;
			margin: 15px 0;
		}
		
		#list .item > div:first-child {
			display: flex;
		}
		
		#list .item.me > div:first-child {
			justify-content: flex-end;
		}
		
		#list .item.other > div:first-child {
			justify-content: flex-end;
			flex-direction: row-reverse;
		}
		
		#list .item > div:first-child > div:first-child {
			font-size: 10px;
			color: #777;
			margin: 3px 5px;
		}
		
		#list .item > div:first-child > div:nth-child(2) {
			border: 1px solid var(--border-color);
			display: inline-block;
			min-width: 100px;
			max-width: 250px;
			text-align: left;
			padding: 3px 7px;
		}
		
		#list .state.item > div:first-child > div:nth-child(2) {
			background-color: #EEE;
		}
		
		#list .item > div:last-child {
			font-size: 10px;
			color: #777;
			margin-top: 5px;
		}
		
		#list .me {
			text-align: right;
		}
		
		#list .other {
			text-align: left;
		}
		
		#list .msg.me.item > div:first-child > div:nth-child(2) {
			background-color: rgba(255, 99, 71, .2);
		}
		
		#list .msg.other.item > div:first-child > div:nth-child(2) {
			background-color: rgba(100, 149, 237, .2);
		}
		
		#list .msg img {
			width: 150px;
		}
	</style>

	<!-- chat.jsp -->
	<div id="main">
		<div id="header"><h2>chatting-chatScreen <small>유저명</small></h2></div>
		<div id="list"></div>
		<input type="text" id="msg" placeholder="대화 내용을 입력하세요.">
	</div>
	
	
	<script src="https://cdn.jsdelivr.net/npm/dayjs@1.11.13/dayjs.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script src="https://bit.ly/4cMuheh"></script>
	<script>
	
		//alert(dayjs().format('YYYY-MM-DD HH:mm:ss'));
		
		/*
			
			프로토콜 설계
			- 전달 메시지 형식
				- code: 상태 코드
					- 1: 새로운 유저가 들어옴
					- 2: 기존 유저가 나감
					- 3: 메시지 전달
					- 4: 이모티콘 전달
				- sender: 메시지 보내는 유저명
				- receiver: 메시지 받는 유저명
				- content: 대화 내용(메시지)
				- regdate: 날짜/시간
		
		*/
	
	
		let name; //대화명
	
		//대화명 설정 + 서버 연결
		const url = 'ws://localhost:8090/chat/server';
		
		let ws;
		
		function connect(name) {
		    $('#header small').text(name);
		    this.name = name;

		    ws = new WebSocket(url);
		    log('서버에게 연결을 시도합니다.');

		    ws.onopen = evt => {
		        log('서버와 연결되었습니다.');

		        const message = {
		            code: 1,
		            sender: name,
		            receiver: '',
		            content: '',
		            regdate: dayjs().format('YYYY-MM-DD HH:mm:ss')
		        };

		        ws.send(JSON.stringify(message));
		    };

		    ws.onmessage = evt => {
		        log('메시지를 수신했습니다.');

		        const message = JSON.parse(evt.data);

		        if (message.code == '1') {
		            print('', `[${message.sender}]님이 들어왔습니다.`, 'other', 'state', message.regdate);
		        } else if (message.code == '2') {
		            print('', `[${message.sender}]님이 나갔습니다.`, 'other', 'state', message.regdate);
		        } else if (message.code == '3') {
		            print(message.sender, message.content, 'other', 'msg', message.regdate);
		        } else if (message.code == '4') {
		            printEmoticon(message.sender, message.content, 'other', 'msg', message.regdate);
		        }
		    };

		    ws.onclose = evt => {
		        log('서버와 연결이 종료되었습니다.');
		    };

		    ws.onerror = evt => {
		        log('에러가 발생했습니다. ' + evt);
		    };
		}

		function disconnect() {
		    const message = {
		        code: 2,
		        sender: this.name,
		        receiver: '',
		        content: '',
		        regdate: dayjs().format('YYYY-MM-DD HH:mm:ss')
		    };

		    ws.send(JSON.stringify(message));
		    ws.close();
		}

		$('#msg').keydown(evt => {
		    if (evt.keyCode == 13) {
		        const message = {
		            code: 3,
		            sender: this.name,
		            receiver: '',
		            content: $(evt.target).val(),
		            regdate: dayjs().format('YYYY-MM-DD HH:mm:ss')
		        };

		        if ($(evt.target).val().startsWith('/')) {
		            message.code = 4;
		        }

		        ws.send(JSON.stringify(message));
		        $(evt.target).val('');

		        if (message.code == '3') {
		            print(message.sender, message.content, 'me', 'msg', message.regdate);
		        } else if (message.code == '4') {
		            printEmoticon(message.sender, message.content, 'me', 'msg', message.regdate);
		        }
		    }
		});
		
		function scrollList() {
			$('#list').scrollTop($('#list')[0].scrollHeight + 1000);
		}
		
	
	</script>
</body>
</html>





