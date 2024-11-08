<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<div class="settings-body">
	<div class="settings-main">
		<div class="settings-header">
			<div>Setting</div>
			<img src="/editor/resources/image/icon/settings-close.svg"
				class="settings-close-icon">
		</div>

		<div class="settings-container">
			<ul class="settings-menu">
				<li class="settings-main-item">
					<button onclick="toggleSubMenu('theme')" id="theme-button">
						<img src="/editor/resources/image/icon/right-arrow.svg"
							class="arrow-icon"> Theme
					</button>
					<ul class="settings-sub-menu" id="theme" style="display: none;">
						<li onclick="getThemeData(); showContent('appearance')">Appearance</li>
						<li onclick="getColorData(); showContent('colors')">Colors</li>
						<li onclick="getFontData(); showContent('font')">Font</li>
					</ul>
				</li>
				<li class="settings-main-item">
					<button onclick="getTemplateData(); showContent('template')" id="template-button">
						Template</button>
					<ul class="settings-sub-menu" id="template" style="display: none;">
					</ul>
				</li>
			</ul>

			<div class="settings-content theme-content" id="appearance-content"
				style="display: none;">
				<h2>Appearance</h2>
				<hr>
				<h3>Theme</h3>
				<fieldset class="theme-selector">
					<div>
						<label for="dark-button" class="theme-mode"> <input
							type="radio" name="theme" value="dark" id="dark-button">
							Dark
						</label>
					</div>

					<div>
						<label for="light-button" class="theme-mode"> <input
							type="radio" name="theme" value="light" id="light-button">
							Light
						</label>
					</div>
				</fieldset>
			</div>
            <div class="settings-content" id="colors-content"
                style="display: none;">
                <h2>Colors</h2>
                <hr>
                <div class="colors-container">
                    <div class="colors-selector">
                        <div class="colors">
                            <input type="color" id="editor-background" value="">
                            <label>
                                Background color
                                <input type="hidden" class="color-category" value="editor.background">
                            </label>
                        </div>
                        <div class="colors">
                            <input type="color" id="editor-foreground" value=""> 
                            <label>
                                Font color
                                <input type="hidden" class="color-category" value="editor.foreground">
                            </label>
                        </div> 
                        <div class="colors">
                            <input type="color" id="java-comment" value="">
                            <label>
                                Comment color
                                <input type="hidden" class="color-category" value="java.comment">
                            </label>
                        </div>
                        <div class="colors">
                            <input type="color" id="java-keyword" value=""> 
                            <label>
                                Keyword color
                                <input type="hidden" class="color-category" value="java.keyword">
                            </label>
                        </div>
                        <div class="colors">
                            <input type="color" id="java-String" value=""> 
                            <label>
                                String Literal color
                                <input type="hidden" class="color-category" value="java.String">
                            </label>
                        </div>
                    </div>
                    <div class="btn-settings">
                        <button>Edit</button>
                    </div>
                </div>
            </div>

			<div class="settings-content" id="font-content"
				style="display: none;">
				<h2>Font</h2>
				<hr>
				<div class="font-selection">
					<div class="font-family">
						<h3>글꼴</h3>
						<div class="selected-font">
							<span>D2Coding</span> 
							<img src="/editor/resources/image/icon/bottom-arrow.svg" class="arrow-icon">
						</div>
						<ul class="select-font-family">
							<li>Consolas</li>
							<li>D2Coding</li>
							<li>나눔 고딕 코딩</li>
							<li>Monoplex KR</li>
							<input type="hidden" id="styleType_seq" value="2">
						</ul>
					</div>
					<div class="font-size">
						<h3>크기</h3>
						<div class="selected-size">
							<span>10</span> 
							<img src="/editor/resources/image/icon/bottom-arrow.svg" class="arrow-icon">
						</div>
						<ul class="select-font-size">
							<input type="hidden" id="styleType_seq" value="1">
							<c:forEach var="i" step="2" begin="8" end="30">
								<li>${i}</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="font-preview-container">
					<h3>보기</h3>
					<div class="font-preview">AaBbYyZz0oO</div>
				</div>
			</div>
			<div class="settings-content" id="template-content" style="display: none;">
				<h2>Template</h2>
				<hr>
				<div class="template-container">
					<div class="template-table">
						<table>
							<thead>
							    <tr>
							        <th>Keyword</th>
							        <th>Code</th>
							    </tr>
						 	</thead>	
						 	<tbody>
						 	
						 	</tbody>
						</table>
					</div>
					<div class="btn-settings">
						<div id="new-setting">
							<button>New</button>
						</div>
						<div id="edit-setting">
							<button>Edit</button>
						</div>
						<div id="delete-setting">
							<button>Delete</button>
						</div>
					</div>
				</div>
				<div>
					<h2>Preview</h2>
					<div class="template-preview" id="template-preview">
					<div></div>
					</div>
				</div>
			</div>
		</div>
		<div class="settings-footer">
			<button><img src="/editor/resources/image/icon/check-circle.svg"></button>
		</div>
	</div>
</div>

<div class="template-body new-template-body">
    <div class="template-main">
        <div class="template-header">
            <h2>New Template</h2>
            <button class="template-close-icon">
                <img src="/editor/resources/image/icon/settings-close.svg">
            </button>
        </div>
        <div class="template-content">
        	<table>
        		<tr>
        			<th>Name</th>
        			<td>
        				<input type="text" class="template-name-input"/>
       				</td>
        		</tr>
        		<tr>
        			<th>Code</th>
       				<td>
       					<textarea class="template-code-input"></textarea>
       				</td>
        		</tr>
        	</table>
        </div>
        <div class="template-footer">
            <img src="/editor/resources/image/icon/check-circle.svg">
        </div>
    </div>
</div>

<div class="template-body edit-template-body">
    <div class="template-main">
        <div class="template-header">
            <h2>Edit Template</h2>
            <button class="template-close-icon">
                <img src="/editor/resources/image/icon/settings-close.svg">
            </button>
        </div>
        <div class="template-content">
        	<table>
        		<tr>
        			<th>Name</th>
        			<td>
        				<input type="text" class="template-name-input"/>
       				</td>
        		</tr>
        		<tr>
        			<th>Code</th>
       				<td>
       					<textarea></textarea>
       				</td>
        		</tr>
        	</table>
        </div>
        <div class="template-footer">
            <button><img src="/editor/resources/image/icon/check-circle.svg"></button>
        </div>
    </div>
</div>
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<sec:authentication property="principal.member.seq"/>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	
let themeModified = false;
let fontModified = false; 
let colorModified = false;
let isModified = false;

$('input[name="theme"]').on('change', function() {
	isModified = true;
	themeModified = true;
});

$('input[type="color"]').on('input', function() {
	isModified = true;
	colorModified = true;
});

$('.select-font-family li, .select-font-size li').on('click', function() {
	isModified = true;
	fontModified = true;
});

function closeSettings() {
    $('.settings-body').hide(); 
}

$('.settings-footer button').on('click', function() {
    if (isModified) {
    	
    	if (themeModified) {
    		updateTheme();
    	}

		if (fontModified) {
			getSelFont();
		}

		if (colorModified) {
			getSelColor();
		}
        
		closeSettings();
		
    } else {
        closeSettings(); 
    }
});


function updateTheme(selectedTheme) {
	
	const token = $("meta[name='_csrf']").attr("content")
	const header = $("meta[name='_csrf_header']").attr("content");
	
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
        beforeSend : function(xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function() {
            console.log('업뎃 성공요');
        },
        error: function(a,b,c) {
            console.log(a, b, c);
        }
    });
}


function getSelFont() { 
	
	const selFont = document.querySelector(".selected-font span").textContent;
	const selSize = document.querySelector(".selected-size span").textContent;

	const fontSeq = document.querySelector(".select-font-family input[type='hidden']").value;
	const sizeSeq = document.querySelector(".select-font-size input[type='hidden']").value;

	console.log("폰트: ", selFont);
	console.log("크기: ", selSize);	
	console.log("폰트 seq: ", fontSeq);
	console.log("크기 seq: ", sizeSeq);	

	updateFont(selFont, selSize, fontSeq, sizeSeq);

}

function getSelColor() {

    const backgroundElement = document.querySelector("#editor-background");
    const foregroundElement = document.querySelector("#editor-foreground");
    const commentElement = document.querySelector("#java-comment");
    const keywordElement = document.querySelector("#java-keyword");
    const stringElement = document.querySelector("#java-String");

    // 요소가 존재하는지 확인
    if (!backgroundElement) {
	    console.error("backgroundElement not found!");
	}
    
	if (!foregroundElement) {
	    console.error("foregroundElement not found!");
	}
	
	if (!commentElement) {
	    console.error("commentElement not found!");
	}
	
	if (!keywordElement) {
	    console.error("keywordElement not found!");
	}
	
	if (!stringElement) {
	    console.error("stringElement not found!");
	}
	
    if (!backgroundElement || !foregroundElement || !commentElement || !keywordElement || !stringElement) {
        console.error("Some elements were not found!");
        return;
    }

    const background = backgroundElement.value;
    const foreground = foregroundElement.value;
    const comment = commentElement.value;
    const keyword = keywordElement.value;
    const string = stringElement.value;
    
	console.log("background: ", background);
	console.log("foreground: ", foreground);
	console.log("comment: ", comment);
	console.log("keyword: ", keyword);
	console.log("string: ", string);

	updateColor(background, foreground, comment, keyword, string);

}

function updateFont(selFont, selSize, fontSeq, sizeSeq) {
	
	const token = $("meta[name='_csrf']").attr("content")
	const header = $("meta[name='_csrf_header']").attr("content");
	
	$.ajax({
		url: "/editor/font",
		method: "PUT",
		contentType: "application/json",
		data: JSON.stringify([
			{ value: selFont, styleType_seq: fontSeq },
			{ value: selSize, styleType_seq: sizeSeq }
		]),
		beforeSend : function(xhr) {
            xhr.setRequestHeader(header, token);
        },
		success: function (data) {
			console.log("업데이트 성공: ", data)
		},
		error: function(a,b,c) {
			console.log(a,b,c);
		}
	});
}


function updateColor(background, foreground, comment, keyword, string) {
	
	const token = $("meta[name='_csrf']").attr("content")
	const header = $("meta[name='_csrf_header']").attr("content");
	
	$.ajax({
		url: "/editor/color",
		method: "PUT",
		contentType: "application/json",
		data: JSON.stringify([
			{ value: background, styleType_seq: "3" },
			{ value: foreground, styleType_seq: "4" },
			{ value: comment, styleType_seq: "5" },
			{ value: keyword, styleType_seq: "6" },
			{ value: string, styleType_seq: "7" }
		]),
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function (data) {
			console.log("업데이트 성공: ", data)
		},
		error: function(a,b,c) {
			console.log(a,b,c);
		}
	});
}


</script>



