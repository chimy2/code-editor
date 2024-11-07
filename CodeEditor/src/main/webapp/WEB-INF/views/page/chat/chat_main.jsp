<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
    <link rel="stylesheet" href="/editor/resources/css/chat.css" />
	<script src="/editor/resources/js/chat.js" defer></script>

	
	 <div class="chat_container">
    <div class="chat_sidebar" style="width: 300px; height: 100%;">
      
      
 <!--     
         <button class="button">
        
   		 <span class="small-square"></span>
		
         </button> -->
     
      
     
            <button class="chatsidebutton">
                <img src="/editor/resources/image/icon/side.svg" alt="Scroll Icon" class="sidetab-img">
            </button>
      
      
      
      
<!--       <div class="content"> -->
        <!-- <nav class="nav">
          <div class="nav-1">
            <div class="head_logo">
              <a href="/">
                <img class="logo_text" src="car.png" alt="로고" />
              </a>
            </div>
          </div> -->
 <div class="chatnav"> 
        <div class="chatmenubar">
  	  		<a id="serverButton" class="menubartitle">서버</a>
   		
   		 		<div class="chatsubmenu">
   		 			<div id="serversidebar" class="serversidebar">
      					
      					<div>
      					미구현
      					
      					</div>
      					
      		  	 
		 
		 
		 
    				</div>
				</div>
		</div>
          
     <div class="chatmenubar">
  	  		<a id="chattingButton" class="chatmenubartitle">채팅</a>
   		
   		 		<div class="chatsubmenu">
   		 			<div id="chattingsidebar" class="chattingsidebar">
      					
      							
	     				<div class="chatting-container">
							    <div class="chatting-section">
							    
							    	<h1> CHAT TEST</h1>
	
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
		const url = 'ws://localhost:8090/chat/server';
		
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
				log('서버로부터 응답받은 데이터 >> ' + evt.data);
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
			
			log('메시지를 전송했습니다. 이건 chatmain입니다');
			
		});
	
	</script>
<!-- 		    <script>
        $(document).ready(function() {
            $('#load-chat').click(function() {
                // AJAX 요청
                $.ajax({
                    url: "http://localhost:8090/chat/server.do", // chatting 프로젝트의 ChatController URL
                    method: "GET",
                    success: function(response) {
                        // 응답 데이터 표시
                        $('#chat-content').html(response);
                    },
                    error: function(xhr, status, error) {
                        console.log("에러 발생: " + error);
                    }
                });
            });
        });
    </script>		 -->			        
						    
      					
      					    </div>
			
						    </div>
      							
	     				<div class="chattingform-container">
							    <div class="chattingform-section">
							    
							    		
							    		
			      		  	 		<input type="text" id="msg" placeholder="대화 내용을 입력하세요.">			
							        	
							        	<button class="chatttingsendbutton">전송</button>
							   
							    </div>
			
						    </div>
						    
      					
		 
		 
		 
    				</div>
				</div>
		</div>
     <div class="chatmenubar">
  	  		<a id="voiceButton" class="menubartitle">음성</a>
   		
   		 		<div class="chatsubmenu">
   		 			<div id="voicesidebar" class="voicesidebar">
      					
      	      						
	     				<div class="voiceonline-container">
							    <div class="online-section">
							        <h2>온라인</h2>
							   
							    </div>
			
						    </div>
						    
	     						

						<div class="voiceoffline-container">
							    <div class="offline-section">
							        <h2>오프라인</h2>
							   
							    </div>
			
						    </div> 
		 
						</div>
		 
    				</div>
				</div>
	

     <div class="chatmenubar">
  	  		<a id="channelButton" class="menubartitle">test</a>
   		
   		 		<div class="chatsubmenu">
   		 			<div id="channelsidebar" class="channelsidebar">
      					
      					<div>
      					미구현 인데 채팅창 ajax 용도로 사용
      					</div>
      					<div class="chatting-container">
							    <div class="chatting-section">
      		  	 	
		  <h1>CodeEditorProject-chat-main</h1>
    <button id="load-chat-index">Load Chat Index</button>
    <button id="load-chat-screen">Load ChatScreen</button>
    <div id="chat-content"></div>

    <script>
        $(document).ready(function() {
            // chatIndex 호출
            $('#load-chat-index').click(function() {
                $.ajax({
                    url: "http://localhost:8090/chat/chatIndex", // chatting 프로젝트의 URL
                    method: "GET",
                    success: function(response) {
                        $('#chat-content').html(response); // 응답 데이터를 출력
                    },
                    error: function(xhr, status, error) {
                        console.log("Error occurred: " + error);
                    }
                });
            });

            // chatScreen 채팅창 호출
            $('#load-chat-screen').click(function() {
                $.ajax({
                    url: "http://localhost:8090/chat/chatScreen.do", // chatting 프로젝트의 URL
                    method: "GET",
                    success: function(response) {
                        $('#chat-content').html(response); // 응답 데이터를 출력
                    },
                    error: function(xhr, status, error) {
                        console.log("Error occurred: " + error);
                    }
                });
            });
        });
    </script>
		 
		 
    				</div>
				</div>
		</div>
</div>
</div>

     <div class="chatmenubar">
  	  		<a id="inviteButton" class="menubartitle">초대</a>
   		
   		 		<div class="chatsubmenu">
   		 			<div id="invitesidebar" class="invitesidebar">
      					
      					<div>
      					미구현
      					
      					</div>
      					
      		  	 
		 
		 
		 
    				</div>
				</div>
		</div>
     <div class="chatmenubar">
  	  		<a id="settingButton" class="menubartitle">설정</a>
   		
   		 		<div class="chatsubmenu">
   		 			<div id="settingsidebar" class="settingsidebar">
      					
      					<div class="chat_settings-container">
						    <div class="settings-section">
						        <h3>설정</h3>
						    </div>
								<br>
								<br>
						    <div class="audiosettings-section">
						        <h2>오디오 설정</h2>
						    </div>
								<br>							    
							
								
						    <div class="audiodevicesettings-section">
						        <h3>오디오 장치</h3>
						        <br>
						        <select class="chatdropdown">
						            <option>Default (스피커(Senary Audio))</option>
						            <!-- 추가 옵션을 여기에 추가할 수 있습니다. -->
						        </select>
						        	<br>
						        	<br>
						        <label class="chatlabel">오디오 음량</label>
						        <input type="range" min="0" max="100" value="50" class="chatslider">
						    </div>
								<br>
						    <div class="micsettings-section">
						        <h2>마이크 설정</h2>
						 
						 		<br>       
						        <div class="micdevicesettings-section">
						        <h1>녹음 장치</h1>
						        <br>
						        <select class="chatdropdown">
						            <option>Default (마이크 배열(Senary Audio))</option>
						            <!-- 추가 옵션을 여기에 추가할 수 있습니다. -->
						        </select>
						        <br>
								<br>					        
						        <label class="chatlabel">녹음 음량</label>
						        <input type="range" min="0" max="100" value="50" class="chatslider">
						    </div>
						</div>
		 
    				</div>
				</div>
		</div>
    </div>

   
   
   
        </div> <!-- nav-2 -->
        <br>
        <br>
   
        </div> <!-- sidebar -->
     </div> <!-- container -->
     
  <!-- </div> --> 