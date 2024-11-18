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
							    
<!-- 							    	<h1> WebSocket TEST</h1>
	
	<div>
		<button type="button" class="in" id="btn-connect">연결하기</button>
		<button type="button" class="out" id="btn-disconnect">종료하기</button>
	</div> -->
	
<!-- 	<hr>
	
	<div>
		<input type="text" class="long" id="msg" disabled>
		<button type="button" id="btn-echo" disabled>에코 테스트</button>
	</div>
	
	<hr> -->
	
<!-- 	<div class="message full"></div> -->
	
	<script>
	
	$(document).ready(function() {
        // chatIndex 호출
        //$('#load-Newchat-index').click(function() {
            $.ajax({
                url: "http://localhost:8090/chat/index.do", // chatting 프로젝트의 URL
                method: "GET",
                success: function(response) {
                    $('#Newchat-content').html(response); // 응답 데이터를 출력
                },
                error: function(xhr, status, error) {
                    console.log("Error occurred: " + error);
                }
            });
        //});
    });
	
	</script>
	
	
	<div id="Newchat-content"></div>

	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script src="https://bit.ly/4cMuheh"></script>
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
      							
<!-- 	     				<div class="chattingform-container">
							    <div class="chattingform-section">
							    
							    		
							    		
			      		  	 		<input type="text" id="msg" placeholder="대화 내용을 입력하세요.">			
							        	
							        	<button class="chatttingsendbutton">전송</button>
							   
							    </div>
			
						    </div> -->
						    
      					
		 
		 
		 
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
  	  		<a id="channelButton" class="menubartitle">채널</a>
   		
   		 		<div class="chatsubmenu">
   		 			<div id="channelsidebar" class="channelsidebar">
      					
      					<div>
      					미구현
      					
      						<script>
	$(document).ready(function() {
        // chatIndex 호출
        //$('#load-Newchat-index').click(function() {
            $.ajax({
                url: "http://localhost:8090/chat/index.do", // chatting 프로젝트의 URL
                method: "GET",
                success: function(response) {
                    $('#Newchat-content').html(response); // 응답 데이터를 출력
                },
                error: function(xhr, status, error) {
                    console.log("Error occurred: " + error);
                }
            });
        //});
    });
	
	</script>
      					
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