<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
    <link rel="stylesheet" href="/editor/resources/css/chat.css" />
	<script src="/editor/resources/js/chat.js" defer></script>

	
	 <div class="container">
    <div class="sidebar" style="width: 300px; height: 100%;">
      
      
      
 <!--     
         <button class="button">
        
   		 <span class="small-square"></span>
		
         </button> -->
     
      
     
            <button class="button">
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
 <div class="nav-2"> 
        <div class="menubar">
  	  		<a id="serverButton" class="menubartitle">서버</a>
   		
   		 		<div class="submenu">
   		 			<div id="serversidebar" class="serversidebar">
      					
      					<div>
      					미구현
      					
      					</div>
      					
      		  	 
		 
		 
		 
    				</div>
				</div>
		</div>
          
     <div class="menubar">
  	  		<a id="chattingButton" class="menubartitle">채팅</a>
   		
   		 		<div class="submenu">
   		 			<div id="chattingsidebar" class="chattingsidebar">
      					
      					<div>
      					구현 예정
      					
      					</div>
      					
      		  	 		<input type="text" id="msg" placeholder="대화 내용을 입력하세요.">			
		 
		 
		 
    				</div>
				</div>
		</div>
     <div class="menubar">
  	  		<a id="voiceButton" class="menubartitle">음성</a>
   		
   		 		<div class="submenu">
   		 			<div id="voicesidebar" class="voicesidebar">
      					
      					<div>
      					구현 예정
      					
      					</div>
      					
      		  	 
		 
		 
		 
    				</div>
				</div>
		</div>


     <div class="menubar">
  	  		<a id="channelButton" class="menubartitle">채널</a>
   		
   		 		<div class="submenu">
   		 			<div id="channelsidebar" class="channelsidebar">
      					
      					<div>
      					미구현
      					
      					</div>
      					
      		  	 
		 
		 
		 
    				</div>
				</div>
		</div>


     <div class="menubar">
  	  		<a id="inviteButton" class="menubartitle">초대</a>
   		
   		 		<div class="submenu">
   		 			<div id="invitesidebar" class="invitesidebar">
      					
      					<div>
      					미구현
      					
      					</div>
      					
      		  	 
		 
		 
		 
    				</div>
				</div>
		</div>
     <div class="menubar">
  	  		<a id="settingButton" class="menubartitle">설정</a>
   		
   		 		<div class="submenu">
   		 			<div id="settingsidebar" class="settingsidebar">
      					
      					<div class="chat_settings-container">
						    <div class="settings-section">
						        <h2>설정</h2>
						    </div>
						
						    <div class="settings-section">
						        <h2>오디오 설정</h2>
						    </div>
						
						    <div class="settings-section">
						        <h3>오디오 장치</h3>
						        <select class="dropdown">
						            <option>Default (스피커(Senary Audio))</option>
						            <!-- 추가 옵션을 여기에 추가할 수 있습니다. -->
						        </select>
						        <label>오디오 음량</label>
						        <input type="range" min="0" max="100" value="50" class="slider">
						    </div>
						
						    <div class="settings-section">
						        <h3>마이크 설정</h3>
						        <select class="dropdown">
						            <option>Default (마이크 배열(Senary Audio))</option>
						            <!-- 추가 옵션을 여기에 추가할 수 있습니다. -->
						        </select>
						        <label>녹음 음량</label>
						        <input type="range" min="0" max="100" value="50" class="slider">
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