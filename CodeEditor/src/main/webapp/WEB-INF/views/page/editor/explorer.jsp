<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<style>
    
</style>
<div class="explorer_container">
    <div class="explorer_sidebar">
        <div class="package-explorer" id="packageExplorer">
            <div class="folder">
                <!-- Project 항목 -->
                <div class="project">
                    <button>
                        <img src="/editor/resources/image/icon/project.svg"> 
                        <span class="white-text">Test Project</span>
                    </button>
                </div>
                
                <!-- src 항목 -->
                <div class="src">
                    <button>
                        <img src="/editor/resources/image/icon/src.svg"> 
                        <span class="white-text">src</span>
                    </button>

                    <!-- src 내부의 패키지 -->
                    <div class="package">
                        <button>
                            <img src="/editor/resources/image/icon/package.svg"> 
                            <span class="white-text">com.test.main</span>
                        </button>

                        <!-- 클래스, 인터페이스, 파일 항목들 -->
                       <div class="class">
						    <button data-file-type="class" data-file-name="test.java">
						        <img src="/editor/resources/image/icon/class.svg">
						        <span class="white-text">test.java</span>
						    </button>
						</div>
						
						<div class="interface">
						    <button data-file-type="interface" data-file-name="inter.java">
						        <img src="/editor/resources/image/icon/interface.svg">
						        <span class="white-text">inter.java</span>
						    </button>
						</div>
						
						<div class="txt-file">
						    <button data-file-type="txt" data-file-name="test.txt">
						        <img src="/editor/resources/image/icon/txt.svg">
						        <span class="white-text">test.txt</span>
						    </button>
						</div>
						
						<div class="file">
						    <button data-file-type="file" data-file-name="file">
						        <img src="/editor/resources/image/icon/file.svg">
						        <span class="white-text">file</span>
						    </button>
						</div>

                    </div>

                    <!-- 추가 패키지 -->
                    <div class="package">
                        <button>
                            <img src="/editor/resources/image/icon/package.svg"> 
                            <span class="white-text">com.test.main.aaa</span>
                        </button>

                        <!-- 클래스 항목 -->
                        <div class="class">
                            <button>
                                <img src="/editor/resources/image/icon/class.svg">
                                <span class="white-text">AAA.java</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>    
        </div>
    </div>

    <!-- 사이드탭 버튼 -->
    <div class="explorer_sidetab">
        <button class="explorer_sidetabButton">
            <img src="/editor/resources/image/icon/side.svg" alt="Scroll Icon" class="explorer_sidetabImg">
        </button>
    </div>


    
        
</div>