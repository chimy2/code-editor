<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
                            <input type="color" id="java-string" value=""> 
                            <label>
                                String Literal color
                                <input type="hidden" class="color-category" value="java.string">
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
							<button onclick="selDeleteSeq();">Delete</button>
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
            <img src="/editor/resources/image/icon/check-circle.svg" onclick="addTemplate();">
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
            <button><img src="/editor/resources/image/icon/check-circle.svg" onclick="getTemplateVal();"></button>
        </div>
    </div>
</div>