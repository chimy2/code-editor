if (window.location.pathname.startsWith('/editor/join')) {
    // 카카오톡 로그인
    //Kakao.init('${54092e63c5822207d7811adc401f30b8}'); // 사용하려는 앱의 JavaScript 키 입력
    //Kakao.init('JAVASCRIPT_KEY');
    //Kakao.isInitialized(); //JavaScript SDK 초기화 함수를 호출

    document.querySelector('#email_duplicate button').onclick = function () {
        const email = $('#email_duplicate input[type=email]').val();
        duplicated_check(email, 'email');
    };

    const emailInput = document.querySelector(
        '#email_duplicate input[type=email]'
    );
    const duplicateEmailCheckMessage = document.querySelector(
        '#duplicate_check_email'
    );

    if (emailInput && duplicateEmailCheckMessage) {
        emailInput.addEventListener('change', () => {
            duplicateEmailCheckMessage.textContent = '중복 체크를 해주세요.';
            duplicateEmailCheckMessage.style.color = 'red';
        });
    }

    document.querySelector('#nick_duplicate button').onclick = function () {
        const nick = $('#nick_duplicate input[type=text]').val();
        duplicated_check(nick, 'nick');
    };

    const nickInput = document.querySelector(
        '#nick_duplicate input[type=text]'
    );
    const duplicateNickCheckMessage = document.getElementById(
        'duplicate_check_nick'
    );

    if (nickInput && duplicateNickCheckMessage) {
        nickInput.addEventListener('change', () => {
            duplicateNickCheckMessage.textContent = '중복 체크를 해주세요.';
            duplicateNickCheckMessage.style.color = 'red';
        });
    }

    document.querySelector('#password').addEventListener('input', function () {
        const password = this.value;
        const pwCheckDiv = document.querySelector('#pw_check');

        // 비밀번호 규칙: 8~12자리, 영문, 숫자, 특수문자 중 2종류 이상
        const pattern = /^(?=(.*[a-zA-Z]))(?=(.*\d))(?=(.*[^\w\d\s])).{8,12}$/;

        // 비밀번호 규칙에 맞는지 검사
        if (pattern.test(password)) {
            pwCheckDiv.textContent = '사용할 수 있는 비밀번호입니다.';
            pwCheckDiv.style.color = 'green'; // 글자 색을 초록색으로 설정
        } else {
            pwCheckDiv.textContent = '사용할 수 없는 비밀번호입니다.';
            pwCheckDiv.style.color = 'red'; // 글자 색을 빨간색으로 설정
        }

        document
            .querySelector('#password_check')
            .addEventListener('input', function () {
                const password = document.querySelector('#password').value;
                const passwordCheck = this.value;
                const pwAgainCheckDiv =
                    document.querySelector('#pw_again_check');

                // 비밀번호 확인이 일치하는지 확인
                if (password == passwordCheck && passwordCheck != '') {
                    pwAgainCheckDiv.textContent = '비밀번호가 동일합니다.';
                    pwAgainCheckDiv.style.color = 'green'; // 글자 색을 초록색으로 설정
                } else if (passwordCheck != '') {
                    pwAgainCheckDiv.textContent =
                        '비밀번호가 일치하지 않습니다.';
                    pwAgainCheckDiv.style.color = 'red'; // 글자 색을 빨간색으로 설정
                } else {
                    pwAgainCheckDiv.textContent = ''; // 비밀번호 확인이 비어 있으면 메시지 지우기
                }
            });

        const passwordChange = document.getElementById('password');
        const passwordChange_check = document.getElementById('pw_again_check');

        if (passwordChange && passwordChange_check) {
            passwordChange.addEventListener('change', () => {
                passwordChange_check.textContent = '비밀번호 체크를 해주세요.';
                passwordChange_check.style.color = 'red';
            });
        }
    });

    /*회원가입 활성화*/

    // 요소와 버튼 선택
    const emailCheckBox = document.querySelector('#duplicate_check_email');
    const nickCheckBox = document.querySelector('#duplicate_check_nick');
    const pwCheckBox = document.querySelector('#pw_check');
    const pwAgainCheckCheckBox = document.querySelector('#pw_again_check');
    const signupButton = document.querySelector(
        '.join_button button[type=submit]'
    );

    // 모든 요소의 색상이 초록색인지 확인하는 함수
    function checkPwAgainColor() {
        const emailColor = getComputedStyle(emailCheckBox).color;
        const nickColor = getComputedStyle(nickCheckBox).color;
        const pwColor = getComputedStyle(pwCheckBox).color;
        const pwAgainColor = getComputedStyle(pwAgainCheckCheckBox).color;

        if (
            emailColor == 'rgb(0, 128, 0)' &&
            nickColor == 'rgb(0, 128, 0)' &&
            pwColor == 'rgb(0, 128, 0)' &&
            pwAgainColor == 'rgb(0, 128, 0)'
        ) {
            signupButton.disabled = false;
            console.log('색이 모두 초록색입니다.');
        } else {
            signupButton.disabled = true;
            console.log('색이 모두 초록색이 아닙니다.');
        }
    }

    if (!document.querySelector('.email_join').style.display) {
        // 일정 시간마다 색상 확인 (0.5초마다 확인)
        const interval = setInterval(() => {
            checkPwAgainColor();

            // 버튼이 활성화된 경우 더 이상 확인할 필요 없으므로 정지
            if (!signupButton.disabled) {
                clearInterval(interval);
            }
        }, 500);
    }

    /*회원가입 정보 */
    document.querySelector('#join_button').onclick = function () {
        const email = $('#email_duplicate input[type=email]').val();
        const nick = $('#nick_duplicate input[type=text]').val();
        const password = $('#password').val();
        join(email, nick, password);
    };
}

function duplicated_check(check, type) {
    const token = $("meta[name='_csrf']").attr('content');
    const header = $("meta[name='_csrf_header']").attr('content');

    $.ajax({
        type: 'GET',
        url: '/editor/duplicated/join',
        dataType: 'json',
        data: { check: check },
        beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function (result) {
            console.log(type);
            if (result == 0) {
                if (type == 'email') {
                    $('#duplicate_check_email').text(
                        '사용할 수 있는 아이디입니다.'
                    );
                    $('#duplicate_check_email').css('color', 'green');
                } else if (type == 'nick') {
                    $('#duplicate_check_nick').text(
                        '사용할 수 있는 닉네임입니다.'
                    );
                    $('#duplicate_check_nick').css('color', 'green');
                }
            } else if (result == 1) {
                if (type == 'email') {
                    $('#duplicate_check_email').text('이미 있는 아이디입니다.');
                    $('#duplicate_check_email').css('color', 'red');
                } else if (type == 'nick') {
                    $('#duplicate_check_nick').text('이미 있는 닉네임입니다.');
                    $('#duplicate_check_nick').css('color', 'red');
                }
            }
        },
        error: function (a, b, c) {
            console.log(a, b, c);
        },
    });
}

function join(email, nick, password) {
    const token = $("meta[name='_csrf']").attr('content');
    const header = $("meta[name='_csrf_header']").attr('content');

    $.ajax({
        type: 'POST',
        url: '/editor/join',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify({
            id: email,
            nick: nick,
            pw: password,
        }),
        beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function (result) {
            console.log(type);
            if (result == 0) {
                console.log('회원가입 실패');
            } else if (result == 1) {
                console.log('회원가입 성공');
                location.href = '/editor/login';
            }
        },
        error: function (a, b, c) {
            console.log(a, b, c);
        },
    });
}

if (
    window.location.pathname.startsWith('/editor/code') ||
    window.location.pathname.startsWith('/editor/')
) {
    if (document.querySelector('#sign_up') != null) {
        document.querySelector('#sign_up').onclick = function () {
            location.href = '/editor/join';
        };
    }

    if (document.querySelector('#log_in') != null) {
        document.querySelector('#log_in').onclick = function () {
            location.href = '/editor/login';
        };
    } else if (document.querySelector('#log_out') != null) {
        document.querySelector('#logout_member_setting').onclick = function () {
            location.href = '/editor/logout';
        };
    }
}
function redirectTo() {
    if (window.location.href == 'http://localhost:8090/editor/join') {
        document.querySelector('#email_box').onclick = function () {
            document.querySelector('.email_join').style.display = 'block';
        };

        document.querySelector('.join_button button[type=button]').onclick =
            function () {
                document.querySelector('.email_join').style.display = 'none';
            };
    } else if (window.location.href == 'http://localhost:8090/editor/login') {
        document.querySelector('.setting_close').onclick = function () {
            location.href = '/editor/';
        };
        document.querySelectorAll('.login_button button')[1].onclick =
            function () {
                location.href = '/editor/join';
            };
    } else if (window.location.href == 'http://localhost:8090/editor/') {
        document.querySelectorAll('.main_menu_box')[0].onclick = function () {
            location.href = '/editor/document';
        };

        document.querySelectorAll('.main_menu_box')[1].onclick = function () {
            location.href = '/editor/code';
        };
    } else if (window.location.href == 'http://localhost:8090/editor/logout') {
        document.querySelectorAll('.logout_button button')[1].onclick =
            function () {
                history.back();
            };
    } else if (
        window.location.href == 'http://localhost:8090/editor/document'
    ) {
        document.querySelector('.document_content .contactUs').onclick =
            function () {
                location.href = 'https://github.com/chimy2/code-editor';
            };
    }
}

setTimeout(redirectTo, 100);

/*로그인 버튼 활성화*/
/*
	if(window.location.href == 'http://localhost:8090/editor/login'){
		document.addEventListener("DOMContentLoaded", function() {
	    const loginButton = document.querySelector('.login_button button');
	    const emailInput = document.querySelector('.login_id input[type=email]');
	    const passwordInput = document.querySelector('.login_password input[type=password]');
	
	    // 요소가 제대로 선택되었는지 확인
	    if (!loginButton || !emailInput || !passwordInput) {
	        return; // 이 return은 DOMContentLoaded 함수 안에서 실행됩니다.
	    }
	
	    // Hover 스타일 함수
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
	
	    // login_able 함수
	    function login_able() {
	        if (emailInput.value !== "" && passwordInput.value !== "") {
	            loginButton.disabled = false;
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
	
	    // input 이벤트 리스너
	    emailInput.addEventListener('input', function() { setTimeout(login_able, 200) });
	    passwordInput.addEventListener('input', function() { setTimeout(login_able, 200) });
		});
	}
	*/

/*mypage */
function iconSelect() {
    document.querySelectorAll('.teamBox_icon').forEach((icon) => {
        icon.addEventListener('click', function () {
            document.querySelectorAll('.teamBox_icon div').forEach((item) => {
                item.style.outline = 'none';
            });

            const innerDiv = this.querySelector('div');
            if (innerDiv) {
                innerDiv.style.outline = '4px solid var(--orange)';
            }
        });
    });
}
if (window.location.pathname.startsWith('/editor/mypage')) {
    setTimeout(iconSelect, 200);

    document.querySelector('.calendar_box .contact').onclick = function () {
        location.href = 'https://github.com/chimy2/code-editor';
    };

    document.addEventListener('DOMContentLoaded', function () {
        /*
	    const calendarEl = document.getElementById('calendar')
	    const calendar = new FullCalendar.Calendar(calendarEl, {
	      initialView: 'dayGridMonth'
	    })
	    */
        var calendarEl = document.getElementById('calendar');

        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            headerToolbar: {
                center: 'addEventButton',
            },
            customButtons: {
                addEventButton: {
                    text: '일정 추가',
                    click: function () {
                        var dateStr = prompt(
                            '날짜를 입력해주세요. (날짜 형식 : YYYY-MM-DD)'
                        );
                        var date = new Date(dateStr + 'T00:00:00'); // will be in local time

                        if (!isNaN(date.valueOf())) {
                            // valid?
                            calendar.addEvent({
                                title: 'UI 작업 완료하기',
                                start: date,
                                backgroundColor: 'gold',
                                textColor: 'black',
                                allDay: true,
                            });
                            alert('Great. Now, update your database...');
                        } else {
                            alert('Invalid date.');
                        }
                    },
                },
            },
        });

        calendar.render();
    });

    document.querySelector('#member_setting_box').onclick = function () {
        document.querySelector('#teamPlus').style.display = 'none';
        document.querySelector('#projectPlus').style.display = 'none';

        document.querySelector('#mypage_setting_box').style.display = 'block';
        document.querySelector('#content_memberSetting').style.display =
            'block';
        document
            .querySelector('.setting_name_edit input[class=setting_name]')
            .focus();

        document.querySelector(
            '.setting_name_edit .setting_name_close'
        ).onclick = function () {
            document.querySelector(
                '.setting_name_edit input[class=setting_name]'
            ).value = '';
        };

        if (document.querySelector('#content_memberSetting') != null) {
            document.querySelector('.chat_member_setting').onclick =
                function () {
                    console.log(memberSeq);
                    location.href = `http://localhost:8090/editor/stats?seq=${memberSeq}`;
                };

            document.querySelector('#logout_member_setting').onclick =
                function () {
                    location.href = '/editor/logout';
                };

            document.querySelector('.button_member_setting').onclick =
                function () {
                    document.querySelector(
                        '#mypage_setting_box'
                    ).style.display = 'none';
                    document.querySelector(
                        '#content_memberSetting'
                    ).style.display = 'none';
                };

            document.querySelector('#nick_edit').onclick = function () {
                const token = $("meta[name='_csrf']").attr('content');
                const header = $("meta[name='_csrf_header']").attr('content');
                const seq = document.querySelector('#mypageMemberSeq').value;
                const nick = document.querySelector(
                    '.setting_name_edit input[class = setting_name]'
                ).value;
                $.ajax({
                    type: 'POST',
                    url: '/editor/nickEdit/mypage',
                    dataType: 'json',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        nick: nick,
                        seq: seq,
                    }),
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader(header, token);
                    },
                    success: function (result) {
                        if (result == 0) {
                            console.log('닉네임 업데이트 실패');
                        } else if (result == 1) {
                            console.log('닉네입 업데이트 성공');
                            location.href = '/editor/mypage';
                        }
                    },
                    error: function (a, b, c) {
                        console.log(a, b, c);
                    },
                });
            };
        }
    };

    function getMemberProject() {
        $.ajax({
            url: '/editor/mypage/project',
            method: 'GET',
            dataType: 'json',
            success: function (data) {
                console.log(data);
                getProject(data);
            },
            error: function (a, b, c) {
                console.log(a, b, c);
            },
        });
    }

    window.onload = function () {
        getMemberProject();
    };

    function getProject(data) {
        const innerBoxContent = document.querySelector('#project-container');
        innerBoxContent.innerHTML = '';

        data.forEach((project) => {
            const projectHTML =
                '<div class="projectBox_icon" id ="projectBox" onclick="location.href=\'/editor/code/' +
                project.seq +
                '\'">' +
                '<div>' +
                '<img class="project2_icon" src="/editor/resources/image/icon/project2.svg">' +
                '</div>' +
                project.projectName +
                '</div>';
            console.log(projectHTML);
            innerBoxContent.innerHTML += projectHTML;
        });
    }

    // 프로젝트 헤더 변경
    if (document.querySelector('#mypage_setting_box').style.display == '') {
        document.querySelectorAll('.teamBox_icon div').forEach((item) => {
            item.onclick = function () {
                setTimeout(projectHeaderChange, 500);
                getMemberProject();
            };
        });
    }

    //project select
    function getMemberProject() {
        $.ajax({
            url: '/editor/mypage/project',
            method: 'GET',
            dataType: 'json',
            success: function (data) {
                console.log(data);
                getProject(data);
            },
            error: function (a, b, c) {
                console.log(a, b, c);
            },
        });
    }

    window.onload = function () {
        getMemberProject();
    };

    function getProject(data) {
        const innerBoxContent = document.querySelector('#project-container');
        innerBoxContent.innerHTML = '';

        data.forEach((project) => {
            const projectHTML =
                '<div class="projectBox_icon" onclick="location.href=\'/editor/code/' +
                project.seq +
                '\'">' +
                //'<div class="projectBox_icon" onclick="getExplorer(' + project.seq + ')' + '">' +
                '<div>' +
                '<img class="project2_icon" src="/editor/resources/image/icon/project2.svg">' +
                '</div>' +
                project.projectName +
                '</div>';
            console.log(projectHTML);
            innerBoxContent.innerHTML += projectHTML;
        });
    }

    function getSelProject(teamSeq) {
        console.log(teamSeq);
        $.ajax({
            url: '/editor/mypage/project/' + teamSeq,
            method: 'GET',
            dataType: 'json',
            success: function (data) {
                console.log(data);
                getProject(data);
            },
            error: function (a, b, c) {
                console.log(a, b, c);
            },
        });
    }

    /*팀 생성*/
    document.querySelectorAll(
        '.inner_box_header .team_project_plus'
    )[0].onclick = function () {
        document.querySelector('#content_memberSetting').style.display = 'none';
        document.querySelector('#projectPlus').style.display = 'none';
        document.querySelector('#teamPlus').style.display = 'block';

        document.querySelectorAll(
            '#teamPlus .button_member_setting button'
        )[1].onclick = function () {
            document.querySelector('#teamPlus').style.display = 'none';
        };
    };

    /*프로젝트 생성*/
    document.querySelectorAll(
        '.inner_box_header .team_project_plus'
    )[1].onclick = function () {
        document.querySelector('#content_memberSetting').style.display = 'none';
        document.querySelector('#teamPlus').style.display = 'none';
        document.querySelector('#projectPlus').style.display = 'block';

        document.querySelectorAll(
            '#projectPlus .button_member_setting button'
        )[1].onclick = function () {
            document.querySelector('#projectPlus').style.display = 'none';
        };
    };
}

/*마이페이지 팀박스에서 우클릭했을 때 txt 가져오기 */
document.addEventListener('contextmenu', function (event) {
    // 우클릭한 요소가 .teamBox_icon인지 확인
    const teamBoxIcon = event.target.closest('.teamBox_icon');
    const projectBoxIcon = event.target.closest('.projectBox_icon');

    const teamDel = document.querySelector('#team_delete');
    const teamEdit = document.querySelector('#teamSetting');
    const projectDel = document.querySelector('#project_delete');
    const projectEdit = document.querySelector('#projectSetting');

    if (teamBoxIcon) {
        // 우클릭한 .teamBox_icon 요소의 텍스트를 가져오기
        const text = teamBoxIcon.textContent.trim();
        console.log('우클릭한 태그에서 텍스트:', text);
    } else if (projectBoxIcon) {
        // 우클릭한 .projectBoxIcon 요소의 텍스트를 가져오기
        const text = projectBoxIcon.textContent.trim();
        console.log('우클릭한 태그에서 텍스트:', text);
    }

    // 우클릭한 요소가 .team_project 내부일 때만 실행
    if (event.target.closest('#teamBox')) {
        event.preventDefault(); // 기본 우클릭 메뉴를 막음

        let contextBox = document.querySelector('.teamcontextBox');
        let projectContextBox = document.querySelector('.projectcontextBox');

        projectContextBox.style.display = 'none';
        teamDel.style.display = 'none';
        teamEdit.style.display = 'none';
        projectDel.style.display = 'none';
        projectEdit.style.display = 'none';

        const x = event.pageX;
        const y = event.pageY;

        // .contextBox의 위치 설정
        contextBox.style.position = 'absolute';
        contextBox.style.left = `${x}px`;
        contextBox.style.top = `${y}px`;

        contextBox.style.display = 'block';

        // 팀 삭제 버튼 클릭 시
        contextBox.querySelector('.teamContextDelete').onclick = function () {
            contextBox.style.display = 'none';
            teamDel.style.display = 'block';

            teamDel.querySelector(
                '.logout_button button[type=button]'
            ).onclick = function () {
                teamDel.style.display = 'none';
            };
        };

        // 팀 설정 버튼 클릭 시
        contextBox.querySelector('.teamContextSetting').onclick = function () {
            contextBox.style.display = 'none';
            teamEdit.style.display = 'block';

            teamEdit.querySelectorAll(
                '.button_member_setting button'
            )[1].onclick = function () {
                teamEdit.style.display = 'none';
            };
        };
    }

    // 우클릭한 요소가 .project_project 내부일 때만 실행
    if (event.target.closest('.projectBox_icon')) {
        event.preventDefault(); // 기본 우클릭 메뉴를 막음

        let teamContextBox = document.querySelector('.teamcontextBox');
        let contextBox = document.querySelector('.projectcontextBox');

        teamContextBox.style.display = 'none';
        projectDel.style.display = 'none';
        projectEdit.style.display = 'none'; // projectDel 중복을 수정
        teamDel.style.display = 'none';
        teamEdit.style.display = 'none';

        const x = event.pageX;
        const y = event.pageY;

        // .contextBox의 위치 설정
        contextBox.style.position = 'absolute';
        contextBox.style.left = `${x}px`;
        contextBox.style.top = `${y}px`;

        contextBox.style.display = 'block';

        // 프로젝트 삭제 버튼 클릭 시
        contextBox.querySelector('.projectContextDelete').onclick =
            function () {
                contextBox.style.display = 'none';
                projectDel.style.display = 'block';

                projectDel.querySelector(
                    '.logout_button button[type=button]'
                ).onclick = function () {
                    projectDel.style.display = 'none';
                };
            };

        // 프로젝트 설정 버튼 클릭 시
        contextBox.querySelector('.projectContextSetting').onclick =
            function () {
                contextBox.style.display = 'none';
                projectEdit.style.display = 'block';

                projectEdit.querySelectorAll(
                    '.button_member_setting button'
                )[1].onclick = function () {
                    projectEdit.style.display = 'none';
                };
            };
    }
});

function projectHeaderChange() {
    document.addEventListener('click', function (event) {
        const teamBoxIcon = event.target.closest('.teamBox_icon');
        if (teamBoxIcon != null) {
            const nick = teamBoxIcon.innerText.trim();
            const id = teamBoxIcon.id;
            const projectBoxHeaderIcon = document.querySelector(
                '.projectBoxHeaderIcon'
            );
            const teamName = document.querySelector('#teamName');
            console.log(id);
            if (id == 'teamBox') {
                projectBoxHeaderIcon.innerHTML =
                    '<img class="team_icon" src="/editor/resources/image/icon/team.svg">';
            } else if (id == 'userBox') {
                projectBoxHeaderIcon.innerHTML =
                    '<img class="user_icon" src="/editor/resources/image/icon/user.svg">';
            }

            teamName.innerHTML = nick;
        }
    });
}
