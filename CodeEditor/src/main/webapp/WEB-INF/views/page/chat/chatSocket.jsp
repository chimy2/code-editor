<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
		<button type="button" class="in" id="btn-connect">연결하기</button>
		<button type="button" class="out" id="btn-disconnect">종료하기</button>
	</div>
	
	<hr>
	
	<div>
		<input type="text" class="long" id="msg" disabled>
		<button type="button" id="btn-echo" disabled>에코 테스트</button>
	</div>
	
	<hr>
	
	<div class="message full"></div>
	
	
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script src="https://bit.ly/4cMuheh"></script>
	<script>
	
		//- http://:80 or https://:443
		//- ws://:80 or wss://:443
	
		//서버측 주소
		//const url = 'ws://echo.websocket.org';
		//const url = 'ws://demos.kaazing.com/echo';
		const url = 'ws://localhost:8090/socket/server.do';
		
		
		//웹 소켓 객체
		let ws;
	
		$('#btn-connect').click(()=>{
			
			//1. 소켓 생성
			//2. 서버 접속(연결)
			//3. 통신
			//4. 서버 접속 종료
			
			//1. 소켓 생성 + 2. 서버 접속(연결)
			ws = new WebSocket(url);
			
			//소켓 이벤트
			//- 서버측에서 소켓 연결을 받아들이고 서로 연결이 되는 순간
			ws.onopen = evt => {
				log('서버와 연결되었습니다.');
				$('#btn-echo').prop('disabled', false);
				$('#msg').prop('disabled', false);
			};
			
			ws.onclose = evt => {
				log('서버와 연결이 종료되었습니다.');
				$('#btn-echo').prop('disabled', true);
				$('#msg').prop('disabled', true);
			};
			
			ws.onmessage = evt => {
				log('서버로부터 응답받은 데이터  chatsocket>> ' + evt.data);
			};
			
			ws.onerror = evt => {
				log('에러가 발생했습니다. >>> ' + evt);
			};
			
		});
		
		$('#btn-disconnect').click(()=>{
			//소켓 연결 종료
			ws.close();			
		});
		
		function log(msg) {
			$('.message').prepend(`<div>[\${new Date().toLocaleTimeString()}] \${msg}</div>`);
		}
		
		$('#btn-echo').click(()=>{
			
			//현재 연결중인 소켓으로 상대방(서버)에게 데이터 전송하기
			//ws.send('안녕하세요.');
			ws.send($('#msg').val());
			
			log('메시지를 전송했습니다.이건 chatsocket입니다');
			
		});
	
	</script>

</body>
</html>