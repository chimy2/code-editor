
/*
const header = document.querySelectorAll('.headerImg img');

header[0].onclick = function(event) {
	alert(event.target);
	//마이페이지로 이동
};

header[1].onclick = function(event) {
	alert(event.target);
	//개인 설정 창이 떠야 함 > child 창
};
*/

/*main -> join*/
document.querySelector('.logo').onclick = function(){
	location.href = '/editor/main'
}

const loginbox = document.querySelectorAll('.login_box');
loginbox[0].onclick = function(){
	location.href = '/editor/join'
}

loginbox[1].onclick = function(){
	location.href = '/editor/login'
}



























