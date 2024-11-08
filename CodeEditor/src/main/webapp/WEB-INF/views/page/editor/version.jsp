  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!-- <div class="popup-container version-container">
	<div class="popup-main version-main">
		<div class="popup-content version-content">
			<div>
				여기다 explorer 넣으시오
			</div>
			<div>
				여기다 선택하면 파일 내용 보이도록 넣으시오
			</div>
		</div>
		<nav class="popup-nav version-nav">
			<div class="version-header">
				<div>버전 기록</div>
				<div>
		            <button class="btn_popup_close">
		                <img src="/editor/resources/image/icon/x.svg" />
		            </button>
				</div>
			</div>
			<div class="version-list-container">
				<ul>
					<li>
						<div>
							<div class="version-date">2024-11-01  09:25</div>
							<div class="version-member">최종민</div>
						</div>
						<div class="version-message">테스트입니다. test version. testesteset</div>
					</li>
					<li>
						<div>
							<div class="version-date">2024-11-01  09:25</div>
							<div class="version-member">홍길동</div>
						</div>
						<div class="version-message">기록 내용 기록 내용인데? 기록 내용이야 기록긱록기곩</div>
					</li>
					<li>
						<div>
							<div class="version-date">2024-11-01  09:25</div>
							<div class="version-member">홍길동</div>
						</div>
						<div class="version-message">기록 내용</div>
					</li>
					<li>
						<div>
							<div class="version-date">2024-11-01  09:25</div>
							<div class="version-member">홍길동</div>
						</div>
						<div class="version-message">기록 내용 기록 내용인데? 기록 내용이야 기록긱록기곩</div>
					</li>
					<li>
						<div>
							<div class="version-date">2024-11-01  09:25</div>
							<div class="version-member">홍길동</div>
						</div>
						<div class="version-message">기록 내용</div>
					</li>
					<li>
						<div>
							<div class="version-date">2024-11-01  09:25</div>
							<div class="version-member">홍길동</div>
						</div>
						<div class="version-message">기록 내용 기록 내용인데? 기록 내용이야 기록긱록기곩</div>
					</li>
					<li>
						<div>
							<div class="version-date">2024-11-01  09:25</div>
							<div class="version-member">홍길동</div>
						</div>
						<div class="version-message">기록 내용</div>
					</li>
					<li>
						<div>
							<div class="version-date">2024-11-01  09:25</div>
							<div class="version-member">홍길동</div>
						</div>
						<div class="version-message">기록 내용 기록 내용인데? 기록 내용이야 기록긱록기곩</div>
					</li>
					<li>
						<div>
							<div class="version-date">2024-11-01  09:25</div>
							<div class="version-member">홍길동</div>
						</div>
						<div class="version-message">기록 내용</div>
					</li>
					<li>
						<div>
							<div class="version-date">2024-11-01  09:25</div>
							<div class="version-member">홍길동</div>
						</div>
						<div class="version-message">기록 내용 기록 내용인데? 기록 내용이야 기록긱록기곩</div>
					</li>
					<li>
						<div>
							<div class="version-date">2024-11-01  09:25</div>
							<div class="version-member">홍길동</div>
						</div>
						<div class="version-message">기록 내용</div>
					</li>
					<li>
						<div>
							<div class="version-date">2024-11-01  09:25</div>
							<div class="version-member">홍길동</div>
						</div>
						<div class="version-message">기록 내용 기록 내용인데? 기록 내용이야 기록긱록기곩</div>
					</li>
				</ul>
			</div>
			<div class="version-footer">
				<button class="btn_submit_version">
			        복원
				</button>
			</div>
		</nav>
	</div>
</div> 
 -->

 
 <div class="popup-container version-container" id="versionPopup">
    <div class="popup-main version-main">
        <div class="popup-content version-content">
            <div>
                <div class="explorer">
                    <ul>
                        <!-- versionFiles 리스트에서 파일 구조 출력 -->
                        <c:forEach var="file" items="${versionFiles}">
                            <li>
                                <div class="file-item">
                                    <c:out value="${file.name}" />
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <div id="fileContentDisplay">여기다 선택하면 파일 내용 보이도록 넣으시오</div>
        </div>
        <nav class="popup-nav version-nav">
            <div class="version-header">
                <div>버전 기록</div>
                <div>
                    <button class="btn_popup_close" onclick="closeVersionPopup()">
                        <img src="/editor/resources/image/icon/x.svg" />
                    </button>
                </div>
            </div>
            <div class="version-list-container">
                <ul>
                    <!-- versionInfos 리스트에서 각 버전 정보 출력 -->
                    <c:forEach var="versionInfo" items="${versionInfos}">
                        <li>
                            <div>
                                <div class="version-date">
                                    <c:out value="${versionInfo.date}" />
                                </div>
                                <div class="version-member">
                                    <c:out value="${versionInfo.member}" />
                                </div>
                            </div>
                            <div class="version-message">
                                <c:out value="${versionInfo.message}" />
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="version-footer">
                <button class="btn_submit_version" onclick="">복원</button>
            </div>
        </nav>
    </div>
</div>

 

 