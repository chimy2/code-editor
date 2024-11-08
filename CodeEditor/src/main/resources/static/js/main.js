document.querySelector('#email_duplicate button').onclick = function() { // 클릭 이벤트 핸들러 등록
    const email = $('#email_duplicate input[type=email]').val(); // 이메일 입력 값 가져오기

    $.ajax({
        type: 'POST',
        url: '/editor/join',
        data: { email: email }, // 이메일 값 전송
        success: function(result) {
            if (result == 0) {
                $('#email_message').text('사용할 수 있는 아이디입니다.');
                $('#email_message').css('color', 'green');
            } else if (result == 1) {
                $('#email_message').text('이미 있는 아이디입니다.');
                $('#email_message').css('color', 'red');
            }
        },
        error: function(a, b, c) {
            console.log(a, b, c);
        }
    });
};






