/**
 *
 */
let socket;
const editorInstances = {};
let isServerChange = false;

const exampleCode = {
    class: 'public class HelloWorld {\n\n    public static void main(String[] args) {\n\n        System.out.println("Hello World!");\n\n    }\n\n}',
    interface: 'public interface Hello {\n\n    void sayHello();\n\n}',
    text: 'Hello, world!',
    file: 'this is file',
};

function startTabMonitoring() {
    // URL 경로 예시: http://localhost:8090/editor/code/1
    const pathname = window.location.pathname;

    // 정규표현식을 사용하여 /editor/code/ 다음의 숫자 추출
    const match = pathname.match(/\/editor\/code\/(\d+)/);
    const projectSeq = match ? match[1] : null;
    let CODE_URL = 'ws://' + location.host + '/editor/vs/code/' + projectSeq;

    // 감지할 부모 요소를 선택
    const targetNode = document.querySelector('.editor-tab');
    let childCount = targetNode.children.length;

    // MutationObserver 생성
    const observer = new MutationObserver((mutationsList) => {
        mutationsList.forEach((mutation) => {
            const addedNodes = mutation.addedNodes.length;
            const removedNodes = mutation.removedNodes.length;

            // 자식 요소가 추가된 경우
            if (addedNodes) {
                childCount += addedNodes; // 자식 추가 시 count 증가
            }

            // 자식 요소가 제거된 경우
            if (removedNodes) {
                childCount -= removedNodes; // 자식 제거 시 count 감소
            }

            // 자식 요소가 2개로 변경되면 WebSocket 연결
            if (childCount === 2 && addedNodes) {
                if (!socket) {
                    socket = new WebSocket(CODE_URL); // WebSocket 연결
                    initSocketEvent();
                }
            }

            // 자식 요소가 1개로 변경되면 WebSocket 연결 종료
            if (childCount === 1 && removedNodes) {
                socket.close(); // WebSocket 연결 종료
                socket = null; // socket 변수 초기화
            }
        });
    });

    // 감지할 설정 (자식 요소의 추가/제거를 감지, 자손의 감지는 제거)
    const config = { childList: true, subtree: false };

    // 감지 시작
    if (targetNode) {
        observer.observe(targetNode, config);
    }
}
startTabMonitoring();

function initSocketEvent() {
    socket.onopen = function () {
        console.log('WebSocket connection established');
    };

    socket.onmessage = function (event) {
        const data = JSON.parse(event.data);

        console.log('socket on message', event);

        isServerChange = true;

        if (data.type == 'cursor') {
            const cursor = data.cursor;
        } else if (data.type == 'code') {
            const code = data.code;
            const editorInstance = editorInstances[code.tabId]; // Ensure you have the correct editor instance

            if (editorInstance) {
                // Save current scroll position and cursor position
                const currentScrollTop = editorInstance.getScrollTop();
                const currentScrollLeft = editorInstance.getScrollLeft();
                const currentPosition = editorInstance.getPosition();

                // Apply received changes to the editor content
                editorInstance.executeEdits(null, [
                    {
                        range: new monaco.Range(
                            code.range.startLineNumber,
                            code.range.startColumn,
                            code.range.endLineNumber,
                            code.range.endColumn
                        ),
                        text: code.text,
                        forceMoveMarkers: true, // Ensure markers like breakpoints move with the edit
                    },
                ]);

                // Restore scroll and cursor positions
                if (currentPosition) {
                    editorInstance.setPosition(currentPosition);
                }
                editorInstance.setScrollTop(currentScrollTop);
                editorInstance.setScrollLeft(currentScrollLeft);

                editorInstance.pushUndoStop();
            }
        }

        isServerChange = false;
    };

    socket.onerror = function (error) {
        console.log('WebSocket error: ', error);
    };

    socket.onclose = function () {
        console.log('WebSocket connection closed');
    };
}

// Initialize tabs
$('.editor-tab').tabs();

// Make tabs sortable
$('.editor-tab ul').sortable({
    axis: 'x',
    containment: 'parent',
    scroll: false,
});

let templates = [];

$('.package-explorer').on('click', '.btn_open_editor', function () {
    // Configure Monaco path once
    const fileSeq = $(this).data('file-seq');
    const fileName = $(this).find('span').text();
    const tabCount = $('.monaco-editor').length;
    const fileIcon = $(this).find('img').prop('outerHTML');
    const filePath = $(this)
        .parents('.package')
        .children()
        .first()
        .find('span')
        .text()
        .replaceAll(/[.]/g, '__');
    const tabId = filePath + '__' + fileName.replaceAll(/[.]/g, '__');

    if ($('#' + tabId).length > 0) {
        $(`a[href='#${tabId}']`).click();
        return;
    }

    const tabTemplate = `
    <li>
        <a href="#${tabId}">${fileIcon}${fileName}</a>
        <span class="tab-close"><img src='/editor/resources/image/icon/settings-close.svg'></span>
    </li>`;
    const tabContent = `<div id="${tabId}" class="editor-tab-container"></div>`;

    // Append new tab and content
    $('.editor-tab ul').append(tabTemplate);
    $('.editor-tab').append(tabContent);
    $('.editor-tab').tabs('refresh');
    $('.editor-tab').tabs('option', 'active', tabCount);

    let editor;

    require(['vs/editor/editor.main'], function () {
        getTemplateData();
        getThemeData(function (themeData) {
            getColorData(themeData);
        });

        getProjectFileData(fileSeq, function (projectFileData) {
            const currentFileData = projectFileData.code;
            const fileType = fileName.endsWith('.java') ? 'java' : 'text/plain';
            const codeValue =
                // currentFileData && currentFileData.code
                currentFileData
                    ? // ? currentFileData.code.replace(/\\n/g, '\n') // Replace escaped newlines
                      currentFileData.replace(/\\n/g, '\n') // Replace escaped newlines
                    : fileType == 'java'
                    ? '// Start coding here...'
                    : 'Start here...';

            // Create the editor and assign it to the global variable
            editor = monaco.editor.create(document.getElementById(tabId), {
                value: codeValue,
                language: fileType,
                theme: 'custom-theme',
                minimap: {
                    enabled: false,
                },
                automaticLayout: true,
                fontFamily: 'Courier',
                fontSize: 14,
                wordBasedSuggestions: true,
            });

            getFontData();

            editorInstances[tabId] = editor;

            // Detect cursor position change
            // editor.onDidChangeCursorPosition((event) => {
            //     const position = event.position;
            //     const cursorData = {
            //         tabId: tabId,
            //         cursorLine: position.lineNumber,
            //         cursorColumn: position.column,
            //         content: editor.getValue(),
            //     };

            // Completion Item Provider 등록
            monaco.languages.registerCompletionItemProvider('java', {
                provideCompletionItems: function (model, position) {
                    const text = model.getValue();
                    const words = Array.from(new Set(text.match(/\b\w+\b/g)));
                    const wordSuggestions = words.map((word) => ({
                        label: word,
                        kind: monaco.languages.CompletionItemKind.Text,
                        insertText: word,
                    }));
                },
            });

            // Completion Item Provider 등록
            monaco.languages.registerCompletionItemProvider('java', {
                provideCompletionItems: function (model, position) {
                    const text = model.getValue();
                    const words = Array.from(new Set(text.match(/\b\w+\b/g)));
                    const wordSuggestions = words.map((word) => ({
                        label: word,
                        kind: monaco.languages.CompletionItemKind.Text,
                        insertText: word,
                    }));

                    const templateSuggestions = templates.map((template) => ({
                        label: template.keyword,
                        kind: monaco.languages.CompletionItemKind.Snippet,
                        insertText: template.code.replace(/\\n/g, '\n'),
                        insertTextRules:
                            monaco.languages.CompletionItemInsertTextRule
                                .InsertAsSnippet,
                        documentation: `Insert ${template.code}`,
                    }));

                    return {
                        suggestions: [
                            ...wordSuggestions,
                            ...templateSuggestions,
                        ],
                    };
                },
            });

            // Detect cursor position change
            // editor.onDidChangeCursorPosition((event) => {
            //     const position = event.position;
            //     const cursorData = {
            //         tabId: tabId,
            //         cursorLine: position.lineNumber,
            //         cursorColumn: position.column,
            //         content: editor.getValue(),
            //     };

            //     if (socket.readyState === WebSocket.OPEN) {
            //         socket.send(JSON.stringify(cursorData));
            //     }
            // });

            editor.onDidChangeModelContent((event) => {
                if (isServerChange) {
                    return;
                }
                // console.log(this);
                // console.log(editor);
                // console.log(event);
                // console.log(monaco);
                const editorDomNode = editor.getDomNode();

                event.changes.forEach((change) => {
                    const changeFileData = {
                        type: 'code',
                        sender: member,
                        code: {
                            tabId: tabId,
                            text: change.text,
                            range: change.range, // 변경 범위
                            sendDate: new Date(),
                        },
                    };
                    console.log('ready to send server', changeFileData);

                    // 변경 사항을 서버에 전송
                    if (socket.readyState === WebSocket.OPEN) {
                        socket.send(JSON.stringify(changeFileData));
                    }
                });
            });
        });

        function fetchSettings(url, onSuccess) {
            $.ajax({
                url: url,
                method: 'GET',
                dataType: 'json',
                success: onSuccess,
                error: function (a, b, c) {
                    console.error(a, b, c);
                },
            });
        }

        function getThemeData(onComplete) {
            fetchSettings('/editor/theme', function (themeData) {
                onComplete(themeData);
            });
        }

        function getColorData(themeData) {
            fetchSettings('/editor/color', function (data) {
                getColor(themeData, data); // 두 값을 함께 넘겨줌
            });
        }

        function getFontData() {
            fetchSettings('/editor/font', function (data) {
                getFont(data);
                console.log(data);
            });
        }

        function getTemplateData() {
            fetchSettings('/editor/template', function (data) {
                templates = data.map((template) => ({
                    keyword: template.keyword,
                    code: template.code,
                }));
                applyTemplateData(data);
            });
        }

        function getProjectFileData(seq, callback) {
            $.ajax({
                url: '/editor/version-file/' + encodeURIComponent(seq),
                method: 'GET',
                dataType: 'json',
                success: function (data) {
                    callback(data);
                },
                error: function (a, b, c) {
                    console.error(a, b, c);
                },
            });
        }

        function getFont(data) {
            const theme = 'vs-dark';

            if (data === '0') {
                theme = 'vs-dark';
            } else if (data === '1') {
                theme = 'vs';
            }
        }

        function applyTemplateData(data) {
            const templateList = $('.template-list');
            templateList.empty();

            data.forEach((template) => {
                const templateItem = `<li class="template-item" data-code="${template.code}">${template.keyword}</li>`;
                templateList.append(templateItem);
            });

            $('.template-item').on('click', function () {
                let code = $(this).data('code');

                code = code.replace(/\\n/g, '\n');

                if (editor) {
                    editor.setValue(code);
                }
            });
        }

        function getColor(themeData, data) {
            let background = '#FFFFFF';
            let foreground = '#000000';
            let comment = '#FF0000';
            let keyword = '#FF0000';
            let string = '#FF0000';

            let theme = 'vs-dark';

            if (themeData == 0) {
                theme = 'vs-dark';
            } else if (themeData == 1) {
                theme = 'vs';
            }

            data.forEach((item) => {
                if (item.styleType.category === 'editor.background') {
                    background = item.value;
                } else if (item.styleType.category === 'editor.foreground') {
                    foreground = item.value;
                } else if (item.styleType.category === 'java.comment') {
                    comment = item.value;
                } else if (item.styleType.category === 'java.keyword') {
                    keyword = item.value;
                } else if (item.styleType.category === 'java.string') {
                    string = item.value;
                }
            });

            monaco.editor.defineTheme('custom-theme', {
                base: theme,
                inherit: true,
                rules: [
                    { token: 'comment', foreground: comment },
                    { token: 'keyword', foreground: keyword },
                    { token: 'string', foreground: string },
                ],
                colors: {
                    'editor.background': background,
                    'editor.foreground': foreground,
                },
            });

            // Apply the theme
            monaco.editor.setTheme('custom-theme');
        }

        function getFont(data) {
            let fontFamily = 'Courier'; // Default font
            let fontSize = 14; // Default font size

            data.forEach((item) => {
                if (item.styleType.category === 'fontFamily') {
                    fontFamily = item.value;
                } else if (item.styleType.category === 'fontSize') {
                    fontSize = parseInt(item.value, 10);
                }
            });

            if (editor) {
                editor.updateOptions({
                    fontFamily: fontFamily,
                    fontSize: fontSize,
                });
            } else {
                console.error('Editor is not defined');
            }
        }
    });
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

// Function to render cursor for other users
function renderUserCursor(userId, position, tabId) {
    const editorInstance = editorInstances[tabId];
    if (!editorInstance) return;

    // Use monaco's decorations to render cursors
    const decorations = [
        {
            range: new monaco.Range(
                position.lineNumber,
                position.column,
                position.lineNumber,
                position.column + 1
            ),
            options: {
                className: `cursor-${userId}`,
                glyphMarginClassName: `user-cursor user-${userId}`, // Custom style for each user's cursor
            },
        },
    ];
    editorInstance.deltaDecorations([], decorations);
}

/* editor header button event */
$('.btn_run').click(() => {
    $('#toggle-chatbot').animate({ bottom: '310px' }, 300);
    $.ajax({
        url: '/editor/code/execute',
    });

    executeCode();

    $('.editor-container').addClass('active_console');
});

$('.btn_console').click(() => {
    $('.editor-container').toggleClass('active_console');
    if ($('.editor-container').hasClass('active_console')) {
        $('#toggle-chatbot').animate({ bottom: '310px' }, 300);
    } else {
        $('#toggle-chatbot').animate({ bottom: '20px' }, 300);
    }
});

$('.btn_download').click(() => {
    // alert('다운로드해 뭐하는거야');
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
    $('#toggle-chatbot').animate({ bottom: '20px' }, 300);
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

document.addEventListener('DOMContentLoaded', function () {
    require.config({ paths: { vs: '/editor/resources/lib/monaco' } });
});

/* settings */
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

document.addEventListener('DOMContentLoaded', function () {
    getTemplateData();
    getColorData();
    initializeFontSelection();
    getFontData();
    getThemeData();
    initializeTheme();
    handleRowClick();
    handleEditButtonClick();
    getProjectFile();
});

function toggleSubMenu(menuId) {
    // 선택한 서브 메뉴와 버튼의 아이콘 찾기
    const menu = document.getElementById(menuId);
    const button = document.getElementById(menuId + '-button');
    const icon = button.querySelector('.arrow-icon');

    // 모든 서브 메뉴 숨기기 및 아이콘 초기화
    document.querySelectorAll('.settings-sub-menu').forEach((subMenu) => {
        if (subMenu !== menu) {
            subMenu.style.display = 'none';
            const siblingIcon =
                subMenu.previousElementSibling.querySelector('.arrow-icon');
            if (siblingIcon)
                siblingIcon.src =
                    '/editor/resources/image/icon/right-arrow.svg';
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
    document
        .querySelectorAll('.settings-content')
        .forEach((content) => (content.style.display = 'none'));
    // 선택한 콘텐츠만 보이게 설정
    document.getElementById(contentId + '-content').style.display = 'block';
}

/* Theme */
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

function initializeTheme() {
    const initialThemeInput = document.querySelector(
        'input[name="theme"]:checked'
    );
    if (initialThemeInput) {
        const initialTheme = initialThemeInput.value;
        toggleThemeSelection(initialTheme);
    }
}

document
    .getElementById('dark-button')
    .addEventListener('click', () => toggleThemeSelection('dark'));
document
    .getElementById('light-button')
    .addEventListener('click', () => toggleThemeSelection('light'));

let selectedRowData = null;

function getThemeData() {
    $.ajax({
        url: '/editor/theme', // URI를 그대로 유지
        method: 'GET',
        success: function (data) {
            if (data === '0') {
                $('#dark-button').prop('checked', true);
                toggleThemeSelection('dark');
            } else if (data === '1') {
                $('#light-button').prop('checked', true);
                toggleThemeSelection('light');
            }
        },
        error: function (a, b, c) {
            console.log(a, b, c);
        },
    });
}

/* font */
// 폰트 선택 초기화 함수
function initializeFontSelection() {
    const fontItems = document.querySelectorAll('.select-font-family li');
    const sizeItems = document.querySelectorAll('.select-font-size li');
    const selectedFont = document.querySelector('.selected-font span');
    const selectedSize = document.querySelector('.selected-size span');
    const fontPreview = document.querySelector('.font-preview');

    // 기본 선택 항목 설정
    const defaultFontItem = fontItems[0];
    const defaultSizeItem = sizeItems[0];

    defaultFontItem.classList.add('selected');
    selectedFont.textContent = defaultFontItem.textContent;
    defaultSizeItem.classList.add('selected');
    selectedSize.textContent = defaultSizeItem.textContent;

    // 기본 폰트 크기를 즉시 미리 보기 요소에 적용
    updateFontPreview(
        fontPreview,
        selectedFont.textContent,
        selectedSize.textContent
    );

    // 클릭 시 선택된 항목 업데이트
    fontItems.forEach((item) => {
        item.addEventListener('click', () => {
            updateSelectedItem(fontItems, item, selectedFont);
            updateFontPreview(
                fontPreview,
                selectedFont.textContent,
                selectedSize.textContent
            );
        });
    });

    sizeItems.forEach((item) => {
        item.addEventListener('click', () => {
            updateSelectedItem(sizeItems, item, selectedSize);
            updateFontPreview(
                fontPreview,
                selectedFont.textContent,
                selectedSize.textContent
            );
        });
    });
}

// 선택 항목 업데이트 함수
function updateSelectedItem(items, selectedItem, displayElement) {
    items.forEach((item) => item.classList.remove('selected'));
    selectedItem.classList.add('selected');
    displayElement.textContent = selectedItem.textContent;
}

// 폰트 데이터 가져오는 함수
function getFontData() {
    $.ajax({
        url: '/editor/font',
        method: 'GET',
        dataType: 'json',
        success: function (data) {
            if (data && data.length > 0) {
                applyFontData(data);
            }
        },
        error: function (a, b, c) {
            console.error(a, b, c);
        },
    });
}

// 폰트 데이터를 적용하는 함수
function applyFontData(data) {
    const fontSizeData = data.find(
        (item) => item.styleType.category === 'fontSize'
    );
    const fontFamilyData = data.find(
        (item) => item.styleType.category === 'fontFamily'
    );

    const fontItems = document.querySelectorAll('.select-font-family li');
    const sizeItems = document.querySelectorAll('.select-font-size li');
    const selectedFont = document.querySelector('.selected-font span');
    const selectedSize = document.querySelector('.selected-size span');
    const fontPreview = document.querySelector('.font-preview');

    if (fontFamilyData) {
        updateFontFamily(fontItems, fontFamilyData.value, selectedFont);
    }

    if (fontSizeData) {
        updateFontSize(sizeItems, fontSizeData.value, selectedSize);
    }

    // 미리 보기 업데이트
    updateFontPreview(
        fontPreview,
        selectedFont.textContent,
        selectedSize.textContent
    );
}

// 폰트 패밀리 업데이트 함수
function updateFontFamily(items, value, displayElement) {
    items.forEach((item) => {
        if (item.textContent === value) {
            item.classList.add('selected');
            displayElement.textContent = item.textContent;
            scrollToSelectedItem(item.parentElement, item);
        } else {
            item.classList.remove('selected');
        }
    });
}

// 폰트 크기 업데이트 함수
function updateFontSize(items, value, displayElement) {
    items.forEach((item) => {
        if (item.textContent === value) {
            item.classList.add('selected');
            displayElement.textContent = item.textContent;
            scrollToSelectedItem(item.parentElement, item); // 스크롤 위치 조정
        } else {
            item.classList.remove('selected');
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
        container.scrollTop =
            selectedItem.offsetTop - container.clientHeight * 2;
    }
}

/* Color */
// 색상 데이터를 가져오는 함수
function getColorData() {
    $.ajax({
        url: '/editor/color',
        method: 'GET',
        dataType: 'json',
        success: function (data) {
            if (data && data.length > 0) {
                applyColorData(data);
            }
        },
        error: function (a, b, c) {
            console.error(a, b, c);
        },
    });
}

// 색상 데이터를 적용하는 함수
function applyColorData(data) {
    // 모든 color input 요소를 선택
    const colorInputs = document.querySelectorAll(
        ".colors input[type='color']"
    );

    colorInputs.forEach((colorInput) => {
        // 이제 hidden input을 class로 쉽게 찾을 수 있습니다.
        const hiddenInput = colorInput
            .closest('.colors')
            .querySelector('.color-category');

        if (hiddenInput) {
            const category = hiddenInput.value; // hidden input의 value가 category

            // 데이터에서 일치하는 항목을 찾기
            const colorData = data.find(
                (item) => item.styleType.category === category
            );

            // 일치하는 데이터가 있으면 color input의 value를 업데이트
            if (colorData) {
                colorInput.value = colorData.value;
            }
        }
    });
}

/* Template */
// 템플릿 데이터를 가져오는 함수
function getTemplateData() {
    $.ajax({
        url: '/editor/template',
        method: 'GET',
        dataType: 'json',
        success: function (data) {
            const tableBody = $('.template-table tbody');
            tableBody.empty();

            data.forEach(function (template) {
                const row = `
                    <tr>
                        <td>${template.keyword}</td>
                        <td>${template.code}</td>
                        <td>
                            <input type="hidden" class="template-seq" value="${template.seq}"> 
                        </td>
                    </tr>

                `;
                tableBody.append(row);
            });

            attachRowClickEvent();
            handleRowClick();
            handleEditButtonClick();
        },
        error: function (a, b, c) {
            console.error(a, b, c);
        },
    });
}

function attachRowClickEvent() {
    const templatePreview = document.getElementById('template-preview');
    let selectedRow = null;

    document.querySelectorAll('.template-table tr').forEach((row) => {
        const codeCell = row.cells[1];

        if (codeCell) {
            row.addEventListener('click', function () {
                if (selectedRow) {
                    selectedRow.classList.remove('selected-row');
                }

                selectedRow = row;
                row.classList.add('selected-row');

                const formattedContent = codeCell.innerHTML
                    .replace(/\\n/g, '<br>')
                    .replace(/\n/g, '<br>');
                templatePreview.innerHTML = formattedContent;
            });
        }
    });
}

// 테이블 행 클릭 이벤트 핸들러
function handleRowClick() {
    $('.template-table tr').click(function () {
        const keyword = $(this).find('td').eq(0).text();
        const code = $(this).find('td').eq(1).text();
        const seq = $(this).find('.template-seq').val(); // 수정된 부분

        selectedRowData = { keyword, code, seq };

        $('.template-table tr').removeClass('selected-row'); // 기존 선택 제거
        $(this).addClass('selected-row'); // 현재 선택 추가
    });
}

// Edit 버튼 클릭 이벤트 핸들러
function handleEditButtonClick() {
    $('#edit-setting').off('click');

    $('#edit-setting').click(() => {
        if (!selectedRowData) {
            alert('선택해 뭐하는거야');
            return;
        }

        toggleDisplay($('.edit-template-body'));

        const formattedContent = selectedRowData.code
            .replace(/<br>/g, '\n')
            .replace(/\\n/g, '\n');

        $('.edit-template-body .template-name-input').val(
            selectedRowData.keyword
        );
        $('.edit-template-body textarea').val(formattedContent);
        $('.template-table input[type="hidden"]').val(selectedRowData.seq);
    });
}

// update, delete, create
let themeModified = false;
let fontModified = false;
let colorModified = false;
let templateModified = false;
let isModified = false;

$('input[name="theme"]').on('change', function () {
    isModified = true;
    themeModified = true;
});

$('input[type="color"]').on('input', function () {
    isModified = true;
    colorModified = true;
});

$('.select-font-family li, .select-font-size li').on('click', function () {
    isModified = true;
    fontModified = true;
});

function closeSettings() {
    $('.settings-body').hide();
}

function closeTemplate() {
    $('.template-body').hide();
}

$('.settings-footer button').on('click', function () {
    if (isModified) {
        if (themeModified) {
            updateTheme();
            confiemReload();
        }

        if (fontModified) {
            getSelFont();
            confiemReload();
        }

        if (colorModified) {
            getSelColor();
            confiemReload();
        }

        if (templateModified) {
            confiemReload();
        }
    } else {
        closeSettings();
    }
});

function confiemReload() {
    const confirmReload = confirm('설정 적용하려면 새로고침 해야되걸랑');

    if (confirmReload) {
        history.go(0);
    } else {
        closeSettings();
    }
}

function updateTheme(selectedTheme) {
    const token = $("meta[name='_csrf']").attr('content');
    const header = $("meta[name='_csrf_header']").attr('content');

    console.log($('input[name="theme"]:checked').val());
    const theme = $('input[name="theme"]:checked').val();
    let themeNumber;

    if (theme === 'dark') {
        themeNumber = '0';
    } else if (theme === 'light') {
        themeNumber = '1';
    }

    $.ajax({
        url: '/editor/theme',
        method: 'PUT',
        contentType: 'application/json',
        data: JSON.stringify({ theme: themeNumber }),
        beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function () {
            console.log('업뎃 성공요');
        },
        error: function (a, b, c) {
            console.log(a, b, c);
        },
    });
}

function getSelFont() {
    const selFont = document.querySelector('.selected-font span').textContent;
    const selSize = document.querySelector('.selected-size span').textContent;

    const fontSeq = document.querySelector(
        ".select-font-family input[type='hidden']"
    ).value;
    const sizeSeq = document.querySelector(
        ".select-font-size input[type='hidden']"
    ).value;

    updateFont(selFont, selSize, fontSeq, sizeSeq);
}

function getSelColor() {
    const backgroundElement = document.querySelector('#editor-background');
    const foregroundElement = document.querySelector('#editor-foreground');
    const commentElement = document.querySelector('#java-comment');
    const keywordElement = document.querySelector('#java-keyword');
    const stringElement = document.querySelector('#java-string');

    if (
        !backgroundElement ||
        !foregroundElement ||
        !commentElement ||
        !keywordElement ||
        !stringElement
    ) {
        console.error('Some elements were not found!');
        return;
    }

    const background = backgroundElement.value;
    const foreground = foregroundElement.value;
    const comment = commentElement.value;
    const keyword = keywordElement.value;
    const string = stringElement.value;

    updateColor(background, foreground, comment, keyword, string);
}

function updateFont(selFont, selSize, fontSeq, sizeSeq) {
    const token = $("meta[name='_csrf']").attr('content');
    const header = $("meta[name='_csrf_header']").attr('content');

    $.ajax({
        url: '/editor/font',
        method: 'PUT',
        contentType: 'application/json',
        data: JSON.stringify([
            { value: selFont, styleType_seq: fontSeq },
            { value: selSize, styleType_seq: sizeSeq },
        ]),
        beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function (data) {
            console.log('업데이트 성공: ', data);
        },
        error: function (a, b, c) {
            console.log(a, b, c);
        },
    });
}

function updateColor(background, foreground, comment, keyword, string) {
    const token = $("meta[name='_csrf']").attr('content');
    const header = $("meta[name='_csrf_header']").attr('content');

    $.ajax({
        url: '/editor/color',
        method: 'PUT',
        contentType: 'application/json',
        data: JSON.stringify([
            { value: background, styleType_seq: '3' },
            { value: foreground, styleType_seq: '4' },
            { value: comment, styleType_seq: '5' },
            { value: keyword, styleType_seq: '6' },
            { value: string, styleType_seq: '7' },
        ]),
        beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function (data) {
            console.log('업데이트 성공: ', data);
        },
        error: function (a, b, c) {
            console.log(a, b, c);
        },
    });
}

function getTemplateVal() {
    const keyword = $('.edit-template-body .template-name-input').val();
    const selCode = $('.edit-template-body textarea').val();
    const template_seq = $('.template-table input[type="hidden"]').val();

    const code = selCode.replace(/\n/g, '\\n');

    updateTemplate(keyword, code, template_seq);
}

function updateTemplate(keyword, code, template_seq) {
    const token = $("meta[name='_csrf']").attr('content');
    const header = $("meta[name='_csrf_header']").attr('content');

    $.ajax({
        url: '/editor/template',
        method: 'PUT',
        contentType: 'application/json',
        data: JSON.stringify({
            keyword: keyword,
            code: code,
            seq: template_seq,
        }),
        beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function (data) {
            console.log('업데이트 성공 ' + data);
            $('.template-preview').empty();
            getTemplateData();
            closeTemplate();
            isModified = true;
            templateModified = true;
        },
        error: function (a, b, c) {
            console.log(a, b, c);
        },
    });
}

function addTemplate() {
    const token = $("meta[name='_csrf']").attr('content');
    const header = $("meta[name='_csrf_header']").attr('content');

    const keyword = $('.new-template-body .template-name-input').val();
    const selCode = $('.new-template-body textarea').val();

    const code = selCode.replace(/\n/g, '\\n');

    $.ajax({
        url: '/editor/template',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ keyword: keyword, code: code }),
        beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function (data) {
            console.log('업로드 성공 ' + data);
            getTemplateData();
            closeTemplate();
            isModified = true;
            templateModified = true;
        },
        error: function (a, b, c) {
            console.log(a, b, c);
        },
    });
}

function selDeleteSeq() {
    const template_seq = $('.template-table tr.selected-row')
        .find('input[type="hidden"]')
        .val();
    deleteTemplate(template_seq);
}

function deleteTemplate(template_seq) {
    const token = $("meta[name='_csrf']").attr('content');
    const header = $("meta[name='_csrf_header']").attr('content');

    $.ajax({
        url: '/editor/template/' + template_seq,
        method: 'DELETE',
        contentType: 'application/json',
        data: JSON.stringify({ seq: template_seq }),
        beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function (data) {
            console.log('삭제 성공 ' + template_seq);
            getTemplateData();
            $('.template-preview').empty();
            isModified = true;
            templateModified = true;
        },
        error: function (a, b, c) {
            console.log(a, b, c);
        },
    });
}

function createFileItem(item) {
    let fileTypeClass = '';
    let fileTypeIcon = '';
    let fileName = item.name ? item.name : 'Unnamed File';
    let fileType = item.fileType_seq ? parseInt(item.fileType_seq) : -1;

    switch (fileType) {
        case 4:
            fileTypeClass = 'class';
            fileTypeIcon = 'class.svg';
            break;
        case 5:
            fileTypeClass = 'interface';
            fileTypeIcon = 'interface.svg';
            break;
        case 6:
            fileTypeClass = 'txt-file';
            fileTypeIcon = 'txt.svg';
            break;
        case 7:
            fileTypeClass = 'file';
            fileTypeIcon = 'file.svg';
            break;
        default:
            fileTypeClass = 'file';
            fileTypeIcon = 'file.svg';
            break;
    }

    let fileDiv = document.createElement('div');
    fileDiv.classList.add(fileTypeClass);

    fileDiv.innerHTML =
        `
        <button class="btn_open_editor" data-file-type="` +
        fileTypeClass +
        `" data-file-name="` +
        fileName +
        `">
            <img src="/editor/resources/image/icon/` +
        fileTypeIcon +
        `" alt="` +
        fileTypeClass +
        `">
            <span class="white-text">` +
        fileName +
        `</span>
            <input type="hidden" class="file-seq" value="` +
        item.seq +
        `">
        </button>
    `;

    return fileDiv;
}

document.addEventListener('DOMContentLoaded', function () {
    const versionItems = document.querySelectorAll(
        '.version-list-container li'
    );
    const fileContentDisplay = document.getElementById('fileContentDisplay');

    versionItems.forEach((item) => {
        item.addEventListener('click', function () {
            versionItems.forEach((i) => i.classList.remove('selected'));
            this.classList.add('selected');

            const versionDate = this.querySelector('.version-date').innerText;
            const versionMessage =
                this.querySelector('.version-message').innerText;

            fileContentDisplay.innerHTML = `<h3>선택된 버전</h3><p>날짜: ${versionDate}</p><p>내용: ${versionMessage}</p>`;
        });
    });

    const restoreButton = document.querySelector('.btn_submit_version');
    restoreButton.addEventListener('click', function () {
        const selectedVersion = document.querySelector(
            '.version-list-container .selected'
        );
        if (selectedVersion) {
            const versionDate =
                selectedVersion.querySelector('.version-date').innerText;
            fetch('/restoreVersion', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ versionDate: versionDate }),
            })
                .then((response) => response.json())
                .then((data) => {
                    if (data.success) {
                        alert('Version restored successfully!');
                    } else {
                        alert('Failed to restore version.');
                    }
                })
                .catch((error) =>
                    console.error('Error restoring version:', error)
                );
        } else {
            alert('Please select a version to restore.');
        }
    });
});

// 사이드탭 확장 이벤트
let clickCount = 0;

document
    .querySelector('.explorer_sidetabButton')
    .addEventListener('click', function () {
        clickCount++;

        const sidebar = document.querySelector('.explorer_sidebar');
        const sidetab = document.querySelector('.explorer_sidetab');

        if (clickCount === 1) {
            sidebar.classList.add('expanded');
            sidetab.classList.add('expanded');
        } else if (clickCount === 2) {
            sidebar.classList.remove('expanded');
            sidetab.classList.remove('expanded');
            clickCount = 0;
        }
    });

function openVersionPopup() {
    document.querySelector('.version-container').style.display = 'block';
}

function closeVersionPopup() {
    document.querySelector('.popup-container version-container').style.display =
        'none';
}

//마우스 우클릭 바 생성해서 New / Delete 선택하기
document.addEventListener('DOMContentLoaded', function () {
    const explorerSidebar = document.querySelector('.explorer_sidebar');

    // explorer_sidebar 내에서만 우클릭 메뉴 표시
    explorerSidebar.addEventListener('contextmenu', function (event) {
        event.preventDefault(); // 기본 우클릭 메뉴 비활성화
        removeExistingCustomContextMenu(); // 기존 컨텍스트 메뉴 제거
        showCustomContextMenu(event); // 새 컨텍스트 메뉴 표시
    });

    // 문서 클릭 시 컨텍스트 메뉴 제거
    document.addEventListener('click', function () {
        removeExistingCustomContextMenu();
    });
});

// 기존 컨텍스트 메뉴 제거 함수
function removeExistingCustomContextMenu() {
    const existingMenu = document.querySelector('.custom-context-menu');
    if (existingMenu) {
        existingMenu.remove();
    }
}

// 컨텍스트 메뉴 표시 함수
function showCustomContextMenu(event) {
    const contextMenu = document.createElement('div');
    contextMenu.classList.add('custom-context-menu');

    // New 메뉴 생성
    const newMenuItem = document.createElement('div');
    newMenuItem.classList.add('custom-context-menu-item');
    newMenuItem.innerText = 'New >';

    // 서브메뉴 생성
    const submenu = document.createElement('div');
    submenu.classList.add('custom-submenu');

    // 서브메뉴 항목 추가
    addCustomMenuItem(
        submenu,
        'Project',
        createNewProject,
        '/editor/resources/image/icon/project.svg'
    );
    addCustomMenuItem(
        submenu,
        'Package',
        createNewPackage,
        '/editor/resources/image/icon/package.svg'
    );
    addCustomMenuItem(
        submenu,
        'Class',
        () => createNewFile('class'),
        '/editor/resources/image/icon/class.svg'
    );
    addCustomMenuItem(
        submenu,
        'Interface',
        () => createNewFile('interface'),
        '/editor/resources/image/icon/interface.svg'
    );
    addCustomMenuItem(
        submenu,
        'Text-File',
        () => createNewFile('txt-file'),
        '/editor/resources/image/icon/txt.svg'
    );
    addCustomMenuItem(
        submenu,
        'File',
        () => createNewFile('file'),
        '/editor/resources/image/icon/file.svg'
    );

    // 서브메뉴를 New 항목에 추가
    newMenuItem.appendChild(submenu);
    contextMenu.appendChild(newMenuItem);

    // Delete 메뉴 추가
    addCustomMenuItem(contextMenu, 'Delete', () =>
        confirmAndDeleteItem(event.target)
    );

    // 컨텍스트 메뉴를 문서에 추가하고 위치 설정
    document.body.appendChild(contextMenu);
    contextMenu.style.top = `${event.clientY}px`;
    contextMenu.style.left = `${event.clientX}px`;
}

// 메뉴 항목 추가 함수
function addCustomMenuItem(menu, text, action, iconPath) {
    const item = document.createElement('div');
    item.classList.add('custom-context-menu-item');

    // 아이콘이 있는 경우 추가
    if (iconPath) {
        const icon = document.createElement('img');
        icon.src = iconPath;
        icon.classList.add('custom-menu-icon');
        item.appendChild(icon);
    }

    // 메뉴 텍스트 추가
    const itemText = document.createElement('span');
    itemText.innerText = text;
    item.appendChild(itemText);

    // 클릭 이벤트 리스너 추가
    item.addEventListener('click', (e) => {
        e.stopPropagation();
        action();
        removeExistingCustomContextMenu();
    });

    // 메뉴 항목을 메뉴에 추가
    menu.appendChild(item);
}

// 삭제 확인 후 삭제 함수
function confirmAndDeleteItem(element) {
    console.log('Element class list:', element.classList); // 클래스 목록 확인용

    let itemName;

    if (element.classList.contains('project')) {
        itemName = '프로젝트 파일';
    } else if (element.classList.contains('src')) {
        itemName = '소스 파일';
    } else if (element.classList.contains('package')) {
        itemName = '패키지 파일';
    } else if (element.classList.contains('class')) {
        itemName = '클래스 파일';
    } else if (element.classList.contains('interface')) {
        itemName = '인터페이스 파일';
    } else if (element.classList.contains('txt-file')) {
        itemName = '텍스트 파일';
    } else if (element.classList.contains('file')) {
        itemName = '일반 파일';
    } else {
        itemName = element.querySelector('span')?.textContent || 'item';
    }

    const isConfirmed = confirm(`${itemName}을(를) 삭제하시겠습니까?`);

    if (isConfirmed) {
        console.log(`${itemName} 삭제됨`);
        // 실제 삭제 로직 추가
    } else {
        console.log(`${itemName} 삭제 취소됨`);
    }
}

// 예제용 함수들
function createNewProject() {
    console.log('New Project created');
}

function createNewPackage() {
    console.log('New Package created');
}

function createNewFile(type) {
    console.log(`New ${type} created`);
}

// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

// 페이지 로드 후 컨텍스트 메뉴 이벤트 설정
document.addEventListener('DOMContentLoaded', function () {
    const explorerSidebar = document.querySelector('.explorer_sidebar');

    // explorer_sidebar 내에서 우클릭 메뉴 표시
    explorerSidebar.addEventListener('contextmenu', function (event) {
        event.preventDefault(); // 기본 우클릭 메뉴 비활성화
        removeExistingContextMenu(); // 기존 커스텀 메뉴 제거
        showCustomContextMenu(event); // 커스텀 메뉴 표시
    });

    // 문서 클릭 시 커스텀 메뉴 제거
    document.addEventListener('click', removeExistingContextMenu);
});

// 기존 커스텀 메뉴 제거 함수
function removeExistingContextMenu() {
    const existingMenu = document.querySelector('.custom-context-menu');
    if (existingMenu) existingMenu.remove();
}

// 커스텀 컨텍스트 메뉴 표시 함수
function showCustomContextMenu(event) {
    const contextMenu = document.createElement('div');
    contextMenu.classList.add('custom-context-menu');
    contextMenu.style.top = `${event.clientY}px`;
    contextMenu.style.left = `${event.clientX}px`;

    // New 메뉴 생성
    const newMenuItem = document.createElement('div');
    newMenuItem.classList.add('custom-context-menu-item');
    newMenuItem.innerText = 'New >';

    // 서브메뉴 생성
    const submenu = document.createElement('div');
    submenu.classList.add('custom-submenu');

    // 서브메뉴 항목 추가
    addCustomMenuItem(
        submenu,
        'Project',
        openProjectModal,
        '/editor/resources/image/icon/project.svg'
    );
    addCustomMenuItem(
        submenu,
        'Package',
        () => createNewItem('package'),
        '/editor/resources/image/icon/package.svg'
    );
    addCustomMenuItem(
        submenu,
        'Class',
        () => createNewFile('class'),
        '/editor/resources/image/icon/class.svg'
    );
    addCustomMenuItem(
        submenu,
        'Interface',
        () => createNewFile('interface'),
        '/editor/resources/image/icon/interface.svg'
    );
    addCustomMenuItem(
        submenu,
        'Text-File',
        () => createNewFile('txt-file'), // 수정된 부분
        '/editor/resources/image/icon/txt.svg'
    );
    addCustomMenuItem(
        submenu,
        'File',
        () => createNewFile('file'),
        '/editor/resources/image/icon/file.svg'
    );

    // 서브메뉴를 New 항목에 추가
    newMenuItem.appendChild(submenu);
    contextMenu.appendChild(newMenuItem);

    // Delete 메뉴 추가
    addCustomMenuItem(contextMenu, 'Delete', () =>
        confirmAndDeleteItem(event.target)
    );

    // 컨텍스트 메뉴를 문서에 추가하고 위치 설정
    document.body.appendChild(contextMenu);
}

// 메뉴 항목 추가 함수
function addCustomMenuItem(menu, text, action, iconPath) {
    const item = document.createElement('div');
    item.classList.add('custom-context-menu-item');

    // 아이콘이 있는 경우 추가
    if (iconPath) {
        const icon = document.createElement('img');
        icon.src = iconPath;
        icon.classList.add('custom-menu-icon');
        item.appendChild(icon);
    }

    // 메뉴 텍스트 추가
    const itemText = document.createElement('span');
    itemText.innerText = text;
    item.appendChild(itemText);

    // 클릭 이벤트 리스너 추가
    item.addEventListener('click', (e) => {
        e.stopPropagation();
        action();
        removeExistingContextMenu();
    });

    // 메뉴 항목을 메뉴에 추가
    menu.appendChild(item);
}

// 삭제 확인 후 삭제 함수
function confirmAndDeleteItem(element) {
    const isConfirmed = confirm('Are you sure you want to delete this item?');
    if (isConfirmed && element) {
        // 정확한 클래스명을 찾도록 수정
        element
            .closest(
                '.project-container, .source-folder, .package-folder, .file, .txt-file, .interface, .class'
            )
            .remove();
    }
}

// 모달 열기 함수
function openProjectModal() {
    document.getElementById('projectDialog').style.display = 'block';
}

// 모달 닫기 함수
function closeProjectModal() {
    document.getElementById('projectDialog').style.display = 'none';
}

// 프로젝트 생성 함수
function createProject() {
    const projectName = document.getElementById('newProjectNameInput').value;
    if (projectName) {
        const projectContainer = addProjectToExplorer(projectName); // 프로젝트 추가
        addSourceFolderToProject(projectContainer); // 기본 src 디렉토리 추가
        closeProjectModal(); // 모달 닫기
    } else {
        alert('Please enter a project name');
    }
}

// 패키지 익스플로러에 프로젝트 추가 함수
function addProjectToExplorer(projectName) {
    const explorerPanel = document.querySelector(
        '.explorer_sidebar #packageExplorer'
    );

    // 새로운 프로젝트 div 생성
    const projectContainer = document.createElement('div');
    projectContainer.classList.add('project-container');
    projectContainer.style.marginLeft = '0px'; // 프로젝트 기본 들여쓰기 설정

    // 프로젝트 버튼 생성 및 추가
    const projectButton = document.createElement('button');
    projectButton.classList.add('open-editor-button');
    projectButton.innerHTML = `
        <img src="/editor/resources/image/icon/project.svg" />
        <span class="white-text">${projectName}</span>
    `;
    projectContainer.appendChild(projectButton);

    // 프로젝트를 패키지 익스플로러에 추가
    explorerPanel.appendChild(projectContainer);
    return projectContainer;
}

// 프로젝트에 기본 src 디렉토리 추가 함수
function addSourceFolderToProject(projectContainer) {
    const sourceFolderDiv = document.createElement('div');
    sourceFolderDiv.classList.add('source-folder');
    sourceFolderDiv.style.marginLeft = '20px'; // src 들여쓰기 설정

    // src 버튼 생성 및 추가
    const sourceFolderButton = document.createElement('button');
    sourceFolderButton.classList.add('open-editor-button');
    sourceFolderButton.innerHTML = `
        <img src="/editor/resources/image/icon/src.svg" />
        <span class="white-text">src</span>
    `;
    sourceFolderDiv.appendChild(sourceFolderButton);

    // src를 프로젝트에 추가
    projectContainer.appendChild(sourceFolderDiv);
}

// 패키지 또는 파일 생성 함수
function createNewItem(itemType) {
    const srcContainer = document.querySelector('.source-folder'); // src에 패키지 생성
    if (itemType === 'package' && srcContainer) {
        const packageName = prompt('Enter package name:');
        if (packageName) {
            addPackageToSourceFolder(srcContainer, packageName);
        }
    }
}

// src 내에 패키지 추가 함수
function addPackageToSourceFolder(srcDiv, packageName) {
    const packageDiv = document.createElement('div');
    packageDiv.classList.add('package-folder');
    packageDiv.style.marginLeft = '25px'; // 패키지 들여쓰기 설정

    // 패키지 버튼 생성 및 추가
    const packageButton = document.createElement('button');
    packageButton.classList.add('btn_open_editor');
    packageButton.innerHTML = `
        <img src="/editor/resources/image/icon/package.svg" />
        <span class="white-text">${packageName}</span>
    `;
    packageDiv.appendChild(packageButton);

    // 컨텍스트 메뉴에서 파일 추가 가능하게 설정
    packageButton.addEventListener('contextmenu', (event) => {
        event.preventDefault();
        showCustomContextMenu(event);
    });

    srcDiv.appendChild(packageDiv);
}

// 파일 생성 함수
function createNewFile(fileType) {
    const packageContainer = document.querySelector('.package-folder');
    const fileName = prompt(`Enter ${fileType} name:`);
    if (fileName && packageContainer) {
        addFileToPackage(packageContainer, fileType, fileName);
    }
}

// 패키지에 파일 추가 함수
function addFileToPackage(packageDiv, fileType, fileName) {
    let fileExtension = '';
    let iconPath = '';

    switch (fileType) {
        case 'class':
            fileExtension = '.java';
            iconPath = '/editor/resources/image/icon/class.svg';
            break;
        case 'interface':
            fileExtension = '.java';
            iconPath = '/editor/resources/image/icon/interface.svg';
            break;
        case 'txt-file': // txt-file로 일관성 있게 사용
            fileExtension = '.txt';
            iconPath = '/editor/resources/image/icon/txt.svg';
            break;
        case 'file':
            fileExtension = '.file';
            iconPath = '/editor/resources/image/icon/file.svg';
            break;
    }

    const fileDiv = document.createElement('div');
    fileDiv.classList.add(`${fileType}-file`);
    fileDiv.style.marginLeft = '27px'; // 파일 기본 들여쓰기 설정

    const fileButton = document.createElement('button');
    fileButton.classList.add('btn_open_editor');
    fileButton.innerHTML = `
        <img src="${iconPath}" alt="${fileType} icon" />
        <span class="white-text">${fileName}${fileExtension}</span>
    `;
    fileDiv.appendChild(fileButton);

    packageDiv.appendChild(fileDiv);
}

// 코드 실행함수
function executeCode() {
    const token = $("meta[name='_csrf']").attr('content');
    const header = $("meta[name='_csrf_header']").attr('content');
    const activeTab = $('.editor-tab .ui-tabs-active')[0];

    if (!activeTab) {
        alert('열려 있는 탭이 없습니다.');
        return;
    }

    const tabId = $(activeTab).attr('aria-controls');
    const editorInstance = editorInstances[tabId];
    const paths = tabId.split('__');

    if (paths[paths.length - 1] !== 'java') {
        alert('Java File만 실행 가능합니다.');
        return;
    }

    $.ajax({
        url: '/editor/code/execute',
        method: 'POST',
        data: JSON.stringify({
            className: paths[paths.length - 2],
            code: editorInstance.getValue(),
        }),
        contentType: 'application/json',

        beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function (data) {
            const result = JSON.parse(data.replace(/\n|\r/g, ''));

            $('.console-area').html(result.result);
        },
        error: function (a, b, c) {},
    });
}

function adjustEditorTabPosition() {
    const explorer = document.querySelector('.explorer_sidetab');
    const editorTab = document.querySelector('.editor-tab');
    const explorerWidth = explorer.offsetWidth;

    editorTab.style.marginLeft = explorerWidth + 'px';
}

// 창 크기가 변경될 때마다 조정
window.addEventListener('resize', adjustEditorTabPosition);

// 페이지 로드 시 초기 조정
adjustEditorTabPosition();
