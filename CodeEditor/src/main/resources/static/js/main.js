document.querySelector('.logo').onclick = function(){
	location.href = '/editor/main';
}

const loginbox = document.querySelectorAll('.login_header_box');
loginbox[0].onclick = function(){
	location.href = '/editor/join';
}

loginbox[1].onclick = function(){
	location.href = '/editor/login';
}

document.querySelector('.join_box').onclick = function(){
	document.querySelector('.email_join').style.display = 'block';
}


document.querySelectorAll('.join_button button')[1].onclick = function(){
	document.querySelector('.email_join').style.display = 'none';
}


















