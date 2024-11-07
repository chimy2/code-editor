<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<meta charset="UTF-8">
	
 	<style>
 		html, body {
			padding: 0 !important;
			margin: 0 !important;
			background-color: #FFF !important; 
			display: block;
			overflow: hidden;
		} 
	
 		.div {
			margin: 0; 
			padding: 0; 
		} 
	
		#chatScreenMain {
			width: 200px;
			height: 510px;
			margin: 3px;
			display: grid;
			grid-template-rows: repeat(12, 1fr);
		}
		
		#chatScreenheader {
		
		}
		
		#chatScreenheader > h2 {		
			margin: 0px;
			margin-bottom: 10px;
			padding: 5px;
		}
	
		#chatScreenList {
			border: 1px solid var(--border-color);
			box-sizing: content-box;
			padding: .5rem;
			grid-row-start: 2;
			grid-row-end: 12;
			font-size: 14px;
			overflow: auto;
		}
		
		
		#chatScreenMsg {
			margin-top: 3px;
		}
		
		#chatScreenList .item {
			font-size: 14px;
			margin: 15px 0;
		}
		
		#chatScreenList .item > div:first-child {
			display: flex;
		}
		
		#chatScreenList .item.me > div:first-child {
			justify-content: flex-end;
		}
		
		#chatScreenList .item.other > div:first-child {
			justify-content: flex-end;
			flex-direction: row-reverse;
		}
		
		#chatScreenList .item > div:first-child > div:first-child {
			font-size: 10px;
			color: #777;
			margin: 3px 5px;
		}
		
		#chatScreenList .item > div:first-child > div:nth-child(2) {
			border: 1px solid var(--border-color);
			display: inline-block;
			min-width: 100px;
			max-width: 250px;
			text-align: left;
			padding: 3px 7px;
		}
		
		#chatScreenList .state.item > div:first-child > div:nth-child(2) {
			background-color: #EEE;
		}
		
		#chatScreenList .item > div:last-child {
			font-size: 10px;
			color: #777;
			margin-top: 5px;
		}
		
		#chatScreenList .me {
			text-align: right;
		}
		
		#chatScreenList .other {
			text-align: left;
		}
		
		#chatScreenList .chatScreenMsg.me.item > div:first-child > div:nth-child(2) {
			background-color: rgba(255, 99, 71, .2);
		}
		
		#chatScreenList .chatScreenMsg.other.item > div:first-child > div:nth-child(2) {
			background-color: rgba(100, 149, 237, .2);
		}
		
		#chatScreenList .chatScreenMsg img {
			width: 150px;
		}
	</style>

	<!-- chat.jsp -->
	<div id="chatScreenMain">
		<div id="chatScreenheader"><h2>chatting-chatScreen <small>유저명</small></h2></div>
		<div id="chatScreenList"></div>
		<input type="text" id="chatScreenMsg" placeholder="대화 내용을 입력하세요.">
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
		    $('#chatScreenheader small').text(name);
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
		            print(message.sender, message.content, 'other', 'chatScreenMsg', message.regdate);
		        } else if (message.code == '4') {
		            printEmoticon(message.sender, message.content, 'other', 'chatScreenMsg', message.regdate);
		        }
		    };

	
		    ws.onclose = evt => {
		        log('서버와 연결이 종료되었습니다.');
		    };
		    


		    ws.onerror = evt => {
		        log('에러가 발생했습니다. ' + evt);
		    };
		}
		
		
		
		function log(chatScreenMsg) {
			console.log(`[\${new Date().toLocaleTimeString()}] \${chatScreenMsg}`);
		}
		
		
		window.onunload = () => {
			
			$(opener.document).find('#name').prop('readOnly', false);
			$(opener.document).find('#name').val('');
			$(opener.document).find('#name').focus();
			$(opener.document).find('.in').prop('disabled', false);
			$(opener.document).find('.in').css('opacity', 1);
			
			//서버에게 종료한다고 알리기
			disconnect();
						
		};
		

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

function print(name, chatScreenMsg, side, state, time) {
			
			let temp = `
				<div class="item \${state} \${side}">
					<div>
						<div>\${name}</div>
						<div>\${chatScreenMsg}</div>
					</div>
					<div>${time}</div>
				</div>
			`;
			
			$('#list').append(temp);
			
			scrollList();
			
		}//print
		
		function printEmoticon(name, chatScreenMsg, side, state, time) {
			
			let temp = `
				<div class="item \${state} \${side}">
					<div>
						<div>\${name}</div>
						<div style="background-color: #FFF; border: 0;"><img src="/socket/resources/emoticon/\${chatScreenMsg}.png"></div>
					</div>
					<div>${time}</div>
				</div>
			`;
			
			$('#list').append(temp);
			
			setTimeout(scrollList, 100);
			
		}//printEmoticon
		
		$('#chatScreenMsg').keydown(evt => {
			
			if (evt.keyCode == 13) {
				
				//대화 내용을 서버로 전송하기
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
					print(message.sender, message.content, 'me', 'chatScreenMsg', message.regdate);
				} else if (message.code == '4') {
					printEmoticon(message.sender, message.content, 'me', 'chatScreenMsg', message.regdate);
				}
				
			}
			
		});
		
		function scrollList() {
			$('#list').scrollTop($('#list')[0].scrollHeight + 1000);
		}
	
	</script>



