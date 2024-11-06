

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
        

    }else if(window.location.href == 'http://localhost:8090/editor/logout'){
    	
		document.querySelectorAll('.logout_button')[0].onclick = function() {
        	location.href = '/editor';
        }
        
        document.querySelectorAll('.logout_button')[1].onclick = function() {
        	history.back();
        }
    }
}

setTimeout(redirectTo, 100);

/*로그인 버튼 활성화*/

const loginButton = document.querySelectorAll('.login_button button')[0];
const emailInput = document.querySelector('.login_id input[type=email]');
const passwordInput = document.querySelector('.login_password input[type=password]');

const hoverInHandler = function() {
    loginButton.style.cursor = 'pointer';
    loginButton.style.color = 'var(--white)';
    loginButton.style.outline = '0.5px solid var(--orange)';
    loginButton.style.backgroundColor = 'var(--orange)';
};

const hoverOutHandler = function() {
    loginButton.style.backgroundColor = 'var(--white)';
    loginButton.style.border = '0';
    loginButton.style.outline = '0.5px solid var(--orange)';
    loginButton.style.borderRadius = '5px';
    loginButton.style.width = '406px';
    loginButton.style.height = '40px';
    loginButton.style.marginTop = '8px';
    loginButton.style.marginBottom = '8px';
    loginButton.style.color = 'var(--black)';
    loginButton.style.opacity = 1;
    loginButton.style.cursor = 'default';
};

function login_able() {
    if (emailInput.value != "" && passwordInput.value != "") {
        loginButton.disabled = false;

        // 버튼에 CSS 스타일 추가
        loginButton.style.backgroundColor = 'var(--white)';
        loginButton.style.border = '0';
        loginButton.style.outline = '0.5px solid var(--orange)';
        loginButton.style.borderRadius = '5px';
        loginButton.style.width = '406px';
        loginButton.style.height = '40px';
        loginButton.style.marginTop = '8px';
        loginButton.style.marginBottom = '8px';
        loginButton.style.color = 'var(--black)';
        loginButton.style.opacity = 1;

        // Hover 이벤트 리스너 추가
        loginButton.addEventListener('mouseenter', hoverInHandler);
        loginButton.addEventListener('mouseleave', hoverOutHandler);
    } else {
        loginButton.disabled = true;

        loginButton.style.backgroundColor = 'var(--gray6)';
        loginButton.style.color = 'var(--gray9)';
        loginButton.style.opacity = 0.6;
        loginButton.style.outline = '0.5px solid var(--gray4)';

        // Hover 이벤트 리스너 제거
        loginButton.removeEventListener('mouseenter', hoverInHandler);
        loginButton.removeEventListener('mouseleave', hoverOutHandler);
    }
}

emailInput.addEventListener('input', function() { setTimeout(login_able, 200) });
passwordInput.addEventListener('input', function() { setTimeout(login_able, 200) });



