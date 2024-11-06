# Code editor
Web Java Code Editor Spring Project 입니다.

### git 저장소 연결하기

---

#### 1. 원하는 디렉토리에 저장소 불러오기
- git clone <원격 저장소 주소> .
1. 원하는 디렉토리 경로로 git bash를 연다
2. 원격 저장소 주소는 가져오고 싶은 github 저장소 메인 페이지를 열고 <> code 클릭 > url을 복사해서 가져온다
3. 위 명령어를 입력하고 <원격 저장소 주소> 자리에 해당 주소를 붙여넣는다(마우스 우클릭 > 붙여넣기)
- . : 현재 디렉토리에 원격 저장소 내용을 불러옴

#### 2. elipse에서 해당 .git이 있는 디렉토리를 열고 프로젝트 불러오기
1. Project Explorer 우클릭 > Import 클릭
2. General > Existing Projects Into WorkSpace > Selected root directory > Browse > 해당 디렉토리 선택
3. Select All로 모든 Projects 선택 > Finish

---

### 로컬 저장소에서 원격 저장소에 올리기

---

1. git add로 staging area에 올린다
2. git commit으로 로컬 저장소에 저장한다(커밋 메세지 포함)
3. git pull(원격 저장소에 자신의 저장내용을 올리기 전에 원격저장소에 있는 내용을 받아옴)
4. git push(로컬저장소(자신의 컴퓨터)에 있는 내용을 저장함)


#### 1. 로컬  저장소의 내용을 추가 staging area에 올림
- git add .
- 이 때 git status로 본인이 올릴 파일 목록을 확인
- staging area에 올라간 목록을 초기화하고 싶다면 git reset


#### 2. 로컬 저장소에 저장할 소스를 진짜 저장한다
- git commit -m "원하는 메세지"
- 자신의 컴퓨터의 내용을 기록함


#### 3. 원격 저장소의 저장내용을 받아온다
- git pull
- conflict가 나면 해당 파일을 확인해서 꺽쇄 안에 내용을 비교해서 저장하고 로컬 저장소에 저장


#### 4. 원격 저장소에 로컬 저장소의 내용을 저장한다
- git push

---

##### Git 참고 자료
- https://training.github.com/downloads/ko/github-git-cheat-sheet/
