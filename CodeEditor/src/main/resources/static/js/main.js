
if (window.location.pathname.startsWith("/editor/")) {
	const loginbox = document.querySelectorAll('.login_header_box');
	if (loginbox.length > 0) {
		loginbox[0].onclick = function(){
			location.href = '/editor/join';
		}
		
		loginbox[loginbox.length].onclick = function(){
			location.href = '/editor/login';
		}

		
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
	        
	
	    }else if(window.location.href == 'http://localhost:8090/editor/logout'){
	        
	        document.querySelectorAll('.logout_button button')[1].onclick = function() {
	        	history.back();
	        }
	    }else if(window.location.href == 'http://localhost:8090/editor/document'){
	    	
			document.querySelector('.document_content .contactUs').onclick = function() {
	        	location.href = 'https://github.com/chimy2/code-editor';
	        }
	    }
	}
	
	setTimeout(redirectTo, 100);
	
}



/*mypage */
function iconSelect(){
	document.querySelectorAll('.teamBox_icon').forEach((icon) => {
	    icon.addEventListener('click', function () {
	        
	        document.querySelectorAll('.teamBox_icon div').forEach((item) => {
	            item.style.outline = 'none';
	        });
	
	       
	        const innerDiv = this.querySelector('div');
	        if (innerDiv) {
	            innerDiv.style.outline = '3px solid var(--orange)';
	        }
	    });
	});
}
if (window.location.pathname.startsWith("/editor/mypage")) {
	setTimeout(iconSelect, 200);
	
	document.querySelector('.calendar_box .contact').onclick = function() {
    	location.href = 'https://github.com/chimy2/code-editor';
    }
	
}