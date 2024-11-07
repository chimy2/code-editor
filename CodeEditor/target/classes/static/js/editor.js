/**
 *
 */
const CODE_URL = 'ws://localhost:8090/editor/vs/code/1';
let socket;
let editorInstances = {}; // Store editor instances by tab ID
let currentUserCursorPositions = {}; // Store each user's cursor position by tab

// Initialize WebSocket connection
$(document).ready(function () {
    socket = new WebSocket(CODE_URL);

    socket.onopen = function () {
        console.log("WebSocket connection established");
    };

    socket.onmessage = function (event) {
        const data = JSON.parse(event.data);

        const editorInstance = editorInstances[data.tabId];
        if (editorInstance) {
            // Apply received changes to the editor content
            editorInstance.executeEdits(null, [{
                range: new monaco.Range(
                    data.range.startLineNumber,
                    data.range.startColumn,
                    data.range.endLineNumber,
                    data.range.endColumn
                ),
                text: data.text
            }]);

            // Update the cursor position of other users
            if (data.cursorPosition) {
                renderUserCursor(data.userId, data.cursorPosition, data.tabId);
            }
        }
    };

    socket.onerror = function (error) {
        console.log("WebSocket error: ", error);
    };

    socket.onclose = function () {
        console.log("WebSocket connection closed");
    };

    let tabCounter = 1;

    // Initialize tabs
    $('.editor-tab').tabs();

    // Make tabs sortable
    $('.editor-tab ul').sortable({
        axis: 'x',
        containment: 'parent',
        scroll: false,
    });

    // Configure Monaco path once
    require.config({ paths: { vs: '/editor/resources/lib/monaco' } });

    // Add a new tab with Monaco editor
    $('#add-tab').on('click', function () {
        const tabId = 'tab' + tabCounter;
        const tabTemplate = `
        <li>
            <a href="#${tabId}">Tab ${tabCounter}</a>
            <span class="tab-close"><img src='/editor/resources/image/icon/settings-close.svg'></span>
        </li>`;
        const tabContent = `<div id="${tabId}" class="editor-container"></div>`;

        // Append new tab and content
        $('.editor-tab ul').append(tabTemplate);
        $('.editor-tab').append(tabContent);
        $('.editor-tab').tabs('refresh');
        $('.editor-tab').tabs('option', 'active', tabCounter - 1);


        require(['vs/editor/editor.main'], function () {
            const editor = monaco.editor.create(document.getElementById(tabId), {
                value: '// Start coding here...',
                language: 'java',
                theme: 'vs-dark',
            });

            // Detect cursor position change
            editor.onDidChangeCursorPosition((event) => {
                const position = event.position;
                const cursorData = {
                    tabId: tabId,
                    cursorLine: position.lineNumber,
                    cursorColumn: position.column,
                    content: editor.getValue(),
                    userId: 'User' + Math.floor(Math.random() * 1000) // Placeholder for user ID
                };

                if (socket.readyState === WebSocket.OPEN) {
                    socket.send(JSON.stringify(cursorData));
                }
            });

            // Handle WebSocket messages
            socket.onmessage = function (event) {
                const data = JSON.parse(event.data);

                if (data.tabId === tabId) {
                    const editorInstance = monaco.editor.getModels().find(model => model.uri.path.includes(data.tabId));
                    if (editorInstance) {
                        // Update content if changed
                        editorInstance.setValue(data.content);

                        // Display cursor position for other users
                        if (data.userId && data.userId !== 'currentUser') { // Replace with real user ID check
                            let range = new monaco.Range(data.cursorLine, data.cursorColumn, data.cursorLine, data.cursorColumn);
                            const decorationId = editor.deltaDecorations([], [{
                                range: range,
                                options: { className: 'cursorDecoration' }
                            }]);
                            cursorPositions[data.userId] = decorationId; // Track each user's cursor decoration
                        }
                    }
                }
            };
        });

        // Update tab counter
        tabCounter++;
    });

    // Close a tab on clicking 'x'
    $('.editor-tab').on('click', '.tab-close', function () {
        const panelId = $(this).prev('a').attr('href');
        $(this).closest('li').remove();
        $(panelId).remove();
        $('.editor-tab').tabs('refresh');
    });

    // Show close button for the active tab
    $('.editor-tab ul li.ui-tabs-active .tab-close').show();
});

// Function to render cursor for other users
function renderUserCursor(userId, position, tabId) {
    const editorInstance = editorInstances[tabId];
    if (!editorInstance) return;

    // Use monaco's decorations to render cursors
    const decorations = [{
        range: new monaco.Range(position.lineNumber, position.column, position.lineNumber, position.column + 1),
        options: {
            className: `cursor-${userId}`,
            glyphMarginClassName: `user-cursor user-${userId}`, // Custom style for each user's cursor
        }
    }];
    editorInstance.deltaDecorations([], decorations);
}

/* editor header button event */
$('.btn_run').click(() => {
    $('.editor-container').addClass('active_console');
});

$('.btn_console').click(() => {
    $('.editor-container').toggleClass('active_console');
});

$('.btn_download').click(() => {
    alert('다운로드해 뭐하는거야');
});

$('.btn_record').click(() => {
    toggleDisplay($('.record-container'));
});

$('.btn_new').click(() => {
    toggleDisplay($('.new-container'));
});

$('.btn_version').click(() => {
    toggleDisplay($('.version-container'));
});

$('.btn_settings').click(() => {
    toggleDisplay($('.settings-body'));
});

$('#new-setting').click(() => {
    toggleDisplay($('.new-template-body'));
});

/*
$('#edit-setting').click(() => {
    toggleDisplay($('.edit-template-body'));
}); 
*/

/* console button event */
$('.btn_console_close').click(() => {
    $('.editor-container').removeClass('active_console');
});

/* popup button event */
$('.btn_popup_close').click(function () {
    toggleDisplay($(this).parents('.popup-container'));
});

$('.settings-close-icon').click(function () {
    $('.settings-body').hide();
});

$('.template-close-icon').click(function () {
    console.log('hello?');
    toggleDisplay($(this).parents('.template-body'));
});


/* function */
function toggleDisplay(element) {
    const display = element.css('display');

    if (display == 'none') {
        element.css('display', 'flex');
    } else {
        element.css('display', 'none');
    }
}

/* basic code */
$('.select_file_type').selectmenu();


/* settings */
function toggleSubMenu(menuId) {
    // 선택한 서브 메뉴와 버튼의 아이콘 찾기
    const menu = document.getElementById(menuId);
    const button = document.getElementById(menuId + '-button');
    const icon = button.querySelector('.arrow-icon');

    // 모든 서브 메뉴 숨기기 및 아이콘 초기화
    document.querySelectorAll('.settings-sub-menu').forEach(subMenu => {
        if (subMenu !== menu) {
            subMenu.style.display = 'none';
            const siblingIcon = subMenu.previousElementSibling.querySelector('.arrow-icon');
            if (siblingIcon) siblingIcon.src = '/editor/resources/image/icon/right-arrow.svg';
        }
    });

    // 선택한 서브 메뉴 토글 및 아이콘 변경
    if (menu.style.display === 'none') {
        menu.style.display = 'block';
        if (icon) icon.src = '/editor/resources/image/icon/bottom-arrow.svg'; // 아이콘 변경
    } else {
        menu.style.display = 'none';
        if (icon) icon.src = '/editor/resources/image/icon/right-arrow.svg'; // 아이콘 복원
    }
}

function showContent(contentId) {
    // 모든 콘텐츠를 숨김
    document.querySelectorAll('.settings-content').forEach(content => content.style.display = 'none');
    // 선택한 콘텐츠만 보이게 설정
    document.getElementById(contentId + '-content').style.display = 'block';
}

// Dark와 Light 버튼 클릭 시 선택 상태를 적용하는 함수
function toggleThemeSelection(theme) {
    const darkLabel = document.querySelector('label[for="dark-button"]');
    const lightLabel = document.querySelector('label[for="light-button"]');

    if (theme === 'dark') {
        darkLabel.classList.add('selected');
        lightLabel.classList.remove('selected');
    } else if (theme === 'light') {
        lightLabel.classList.add('selected');
        darkLabel.classList.remove('selected');
    }
}

window.addEventListener('DOMContentLoaded', () => {
    const initialThemeInput = document.querySelector('input[name="theme"]:checked');
    if (initialThemeInput) {
        const initialTheme = initialThemeInput.value;
        toggleThemeSelection(initialTheme);
    } else {
        console.log("Theme input not found.");
    }
});


document.getElementById('dark-button').addEventListener('click', () => toggleThemeSelection('dark'));
document.getElementById('light-button').addEventListener('click', () => toggleThemeSelection('light'));




let selectedRowData = null;

// 테이블 행(tr) 클릭 시 선택한 데이터를 저장
$('.template-table tr').click(function () {
    console.log('hello');
    const keyword = $(this).find('td').eq(0).text();
    const code = $(this).find('td').eq(1).text();

    selectedRowData = { keyword, code };

    $('.template-table tr').removeClass('selected-row'); // 기존 선택 제거
    $(this).addClass('selected-row');                    // 현재 선택 추가
});

// Edit 버튼 클릭 시 처리
$('#edit-setting').click(() => {
    if (!selectedRowData) {
        alert('선택해 뭐하는거야');
        return;
    }

    // 선택된 항목이 있으면 Edit 모드로 전환
    toggleDisplay($('.edit-template-body'));

    const formattedContent = selectedRowData.code
        .replace(/\\n/g, "<br>")    // '\n' 그대로 사용된 경우
        .replace(/\n/g, "<br>");    // 실제 개행 문자의 경우

    // 선택된 항목의 데이터를 Edit 창에 표시
    $('.edit-template-body .template-name-input').val(selectedRowData.keyword);
    $('.edit-template-body textarea').val(selectedRowData.code);
    // // 개행을 유지하여 원본 코드 표시
});



function getThemeData() {
    $.ajax({
        url: "/editor/theme", // URI를 그대로 유지
        method: "GET",
        success: function (data) {
            if (data === "0") {
                $("#dark-button").prop("checked", true);
                toggleThemeSelection("dark")
            } else if (data === "1") {
                $("#light-button").prop("checked", true);
                toggleThemeSelection("light");
            }
        },
        error: function (a, b, c) {
            console.log(a, b, c);
        }
    });
}

$(document).ready(function () {
    getThemeData();
});



/* font */
document.addEventListener("DOMContentLoaded", function () {
    initializeFontSelection();
    getFontData();
});

// 폰트 선택 초기화 함수
function initializeFontSelection() {
    const fontItems = document.querySelectorAll(".select-font-family li");
    const sizeItems = document.querySelectorAll(".select-font-size li");
    const selectedFont = document.querySelector(".selected-font span");
    const selectedSize = document.querySelector(".selected-size span");
    const fontPreview = document.querySelector(".font-preview");

    // 기본 선택 항목 설정
    const defaultFontItem = fontItems[0];
    const defaultSizeItem = sizeItems[0];

    defaultFontItem.classList.add("selected");
    selectedFont.textContent = defaultFontItem.textContent;
    defaultSizeItem.classList.add("selected");
    selectedSize.textContent = defaultSizeItem.textContent;

    // 기본 폰트 크기를 즉시 미리 보기 요소에 적용
    updateFontPreview(fontPreview, selectedFont.textContent, selectedSize.textContent);

    // 클릭 시 선택된 항목 업데이트
    fontItems.forEach(item => {
        item.addEventListener("click", () => {
            updateSelectedItem(fontItems, item, selectedFont);
            updateFontPreview(fontPreview, selectedFont.textContent, selectedSize.textContent);
        });
    });

    sizeItems.forEach(item => {
        item.addEventListener("click", () => {
            updateSelectedItem(sizeItems, item, selectedSize);
            updateFontPreview(fontPreview, selectedFont.textContent, selectedSize.textContent);
        });
    });
}

// 선택 항목 업데이트 함수
function updateSelectedItem(items, selectedItem, displayElement) {
    items.forEach(item => item.classList.remove("selected"));
    selectedItem.classList.add("selected");
    displayElement.textContent = selectedItem.textContent;
}

// 폰트 데이터 가져오는 함수
function getFontData() {
    $.ajax({
        url: "/editor/font",
        method: "GET",
        dataType: "json",
        success: function (data) {
            if (data && data.length > 0) {
                applyFontData(data);
            }
        },
        error: function (a, b, c) {
            console.error(a, b, c);
        }
    });
}

// 폰트 데이터를 적용하는 함수
function applyFontData(data) {
    const fontSizeData = data.find(item => item.styleType.category === "fontSize");
    const fontFamilyData = data.find(item => item.styleType.category === "fontFamily");

    const fontItems = document.querySelectorAll(".select-font-family li");
    const sizeItems = document.querySelectorAll(".select-font-size li");
    const selectedFont = document.querySelector(".selected-font span");
    const selectedSize = document.querySelector(".selected-size span");
    const fontPreview = document.querySelector(".font-preview");

    if (fontFamilyData) {
        updateFontFamily(fontItems, fontFamilyData.value, selectedFont);
    }

    if (fontSizeData) {
        updateFontSize(sizeItems, fontSizeData.value, selectedSize);
    }

    // 미리 보기 업데이트
    updateFontPreview(fontPreview, selectedFont.textContent, selectedSize.textContent);
}

// 폰트 패밀리 업데이트 함수
function updateFontFamily(items, value, displayElement) {
    items.forEach(item => {
        if (item.textContent === value) {
            item.classList.add("selected");
            displayElement.textContent = item.textContent;
            scrollToSelectedItem(item.parentElement, item);
        } else {
            item.classList.remove("selected");
        }
    });
}

// 폰트 크기 업데이트 함수
function updateFontSize(items, value, displayElement) {
    items.forEach(item => {
        if (item.textContent === value) {
            item.classList.add("selected");
            displayElement.textContent = item.textContent;
            scrollToSelectedItem(item.parentElement, item); // 스크롤 위치 조정
        } else {
            item.classList.remove("selected");
        }
    });
}

// 폰트 미리 보기 업데이트 함수
function updateFontPreview(previewElement, fontFamily, fontSize) {
    previewElement.style.fontFamily = `'${fontFamily}', sans-serif`;
    previewElement.style.fontSize = `${fontSize}px`;
}

// 스크롤 위치 조정 함수
function scrollToSelectedItem(container, selectedItem) {
    if (selectedItem) {
        container.scrollTop = selectedItem.offsetTop - container.clientHeight * 2;
    }
}



// 컬러 
// 색상 데이터를 가져오는 함수
function getColorData() {
    $.ajax({
        url: "/editor/color",
        method: "GET",
        dataType: "json",
        success: function (data) {
            if (data && data.length > 0) {
                applyColorData(data);
            }
        },
        error: function (a, b, c) {
            console.error(a, b, c);
        }
    });
}

// 색상 데이터를 적용하는 함수
function applyColorData(data) {
    // 모든 color input 요소를 선택
    const colorInputs = document.querySelectorAll(".colors input[type='color']");

    colorInputs.forEach(colorInput => {
        // 이제 hidden input을 class로 쉽게 찾을 수 있습니다.
        const hiddenInput = colorInput.closest(".colors").querySelector(".color-category");

        if (hiddenInput) {
            console.log('hiddenInput 찾음:', hiddenInput);
            const category = hiddenInput.value; // hidden input의 value가 category

            // 데이터에서 일치하는 항목을 찾기
            const colorData = data.find(item => item.styleType.category === category);

            // 일치하는 데이터가 있으면 color input의 value를 업데이트
            if (colorData) {
                colorInput.value = colorData.value;
            }
        } else {
            console.log('hiddenInput을 찾을 수 없습니다.');
        }
    });

}

// DOMContentLoaded 이벤트가 발생했을 때 getColorData 함수 호출
document.addEventListener("DOMContentLoaded", function () {
    getColorData();
});


// 템플릿 데이터를 가져오는 함수
function getTemplateData() {
    $.ajax({
        url: "/editor/template",
        method: "GET",
        dataType: "json",
        success: function (data) {
            console.log("successfully");

            const tableBody = $(".template-table tbody");
            tableBody.empty();

            data.forEach(function (template) {
                const row = `
                    <tr>
                        <td>${template.keyword}</td>
                        <td>${template.code}</td>
                    </tr>

                `;
                tableBody.append(row);
            });

            attachRowClickEvent();
        },
        error: function (a, b, c) {
            console.error(a, b, c);
        }
    });
}

function attachRowClickEvent() {
    const templatePreview = document.getElementById("template-preview");
    let selectedRow = null;

    // 새로 추가된 <tr> 요소에 대해 클릭 이벤트 리스너를 추가합니다.
    document.querySelectorAll(".template-table tr").forEach(row => {
        const codeCell = row.cells[1]; // index가 1이어야 코드 셀이 맞습니다

        if (codeCell) {
            row.addEventListener("click", function () {
                console.log('click햇닫햇닫닫닫다ㅏㄷ'); // 클릭 이벤트 확인

                if (selectedRow) {
                    selectedRow.classList.remove("selected-row");
                }

                selectedRow = row;
                row.classList.add("selected-row");

                // 개행을 <br> 태그로 변환하여 templatePreview에 HTML 형식으로 표시
                const formattedContent = codeCell.innerHTML
                    .replace(/\\n/g, "<br>")    // '\n' 그대로 사용된 경우
                    .replace(/\n/g, "<br>");    // 실제 개행 문자의 경우
                templatePreview.innerHTML = formattedContent;
            });
        }
    });
}

// 페이지가 로드되면 템플릿 데이터를 가져옵니다.
document.addEventListener("DOMContentLoaded", function () {
    getTemplateData();
});


// 패키지 익스플로러 탭 클릭 이벤트

let clickCount = 0;

document.querySelector('.explorer_sidetabButton').addEventListener('click', function () {
    clickCount++;

    const sidebar = document.querySelector('.explorer_sidebar');
    const sidetab = document.querySelector('.explorer_sidetab');

    if (clickCount === 1) {
        // 첫 번째 클릭: 사이드바 확장 (400px)
        sidebar.classList.add('expanded');
        sidetab.classList.add('expanded');
    } else if (clickCount === 2) {
        // 두 번째 클릭: 사이드바 숨기기
        sidebar.classList.remove('expanded');
        sidetab.classList.remove('expanded');
        clickCount = 0; // 클릭 횟수 초기화
    }
});




document.addEventListener("DOMContentLoaded", function () {
    const versionItems = document.querySelectorAll(".version-list-container li");
    const fileContentDisplay = document.getElementById("fileContentDisplay");

    // 버전 기록 클릭 시 선택된 항목 표시 및 파일 내용 표시
    versionItems.forEach(item => {
        item.addEventListener("click", function () {
            versionItems.forEach(i => i.classList.remove("selected"));
            this.classList.add("selected");

            const versionDate = this.querySelector(".version-date").innerText;
            const versionMessage = this.querySelector(".version-message").innerText;

            // 선택된 버전의 내용을 표시
            fileContentDisplay.innerHTML = `<h3>선택된 버전</h3><p>날짜: ${versionDate}</p><p>내용: ${versionMessage}</p>`;
        });
    });

    // 복원 버튼 클릭 이벤트
    const restoreButton = document.querySelector(".btn_submit_version");
    restoreButton.addEventListener("click", function () {
        const selectedVersion = document.querySelector(".version-list-container .selected");
        if (selectedVersion) {
            const versionDate = selectedVersion.querySelector(".version-date").innerText;
            fetch("/restoreVersion", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({ versionDate: versionDate })
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert("Version restored successfully!");
                    } else {
                        alert("Failed to restore version.");
                    }
                })
                .catch(error => console.error("Error restoring version:", error));
        } else {
            alert("Please select a version to restore.");
        }
    });
});

function openVersionPopup() {
    document.querySelector('.version-container').style.display = 'block';
}

function closeVersionPopup() {
    document.querySelector('.version-container').style.display = 'none';
}







