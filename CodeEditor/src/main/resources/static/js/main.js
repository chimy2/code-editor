
const loginbox = document.querySelectorAll('.login_header_box');
loginbox[0].onclick = function(){
	location.href = '/editor/join';
}

loginbox[1].onclick = function(){
	location.href = '/editor/login';
}

function redirectTo() {

	if(window.location.href == 'http://localhost:8090/editor/join'){
    	document.querySelectorAll('.join_box')[0].onclick = function() {
                    document.querySelector('.email_join').style.display = 'block';
        }
    	
        document.querySelectorAll('.join_button button')[1].onclick = function() {
        	document.querySelector('.email_join').style.display = 'none';
        }

    }else if(window.location.href == 'http://localhost:8090/editor/login'){
    	
		document.querySelector('.setting_close').onclick = function() {
        	location.href = '/editor/';
        }
        document.querySelectorAll('.login_button button')[1].onclick = function() {
        	location.href = '/editor/join';
        }
           
	}else if(window.location.href == 'http://localhost:8090/editor/'){
    	
		document.querySelectorAll('.main_menu_box')[0].onclick = function() {
        	location.href = '/editor/document';
        }
        
		document.querySelectorAll('.main_menu_box')[1].onclick = function() {
        	location.href = '/editor/code';
        }
    }
}

setTimeout(redirectTo, 100);










