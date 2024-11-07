const button = document.querySelector(".chatsidebutton");
const sidebar = document.querySelector(".chat_sidebar");
const defaultchat = document.querySelector(".chatmenubartitle");
let isSidebarOpen = false;
let isSubmenuOpen = false; // 서브메뉴 열림 상태

sidebar.style.width = "0"; // 사이드바 초기 너비 설정


function openSubmenu(selector) {
  closeSubmenus(); // 다른 서브메뉴 닫기
  const submenu = document.querySelector(selector);
  if (submenu) {
    submenu.style.display = "block"; 
    isSubmenuOpen = true; // 서브메뉴 열림 상태 업데이트
    button.style.right = "296px"; // 버튼 위치 조정
    $('#toggle-chatbot').animate({ right: '390px'}, 300);
  }
}

function closeSubmenus() {
  const submenus = document.querySelectorAll(".chatsubmenu");
  submenus.forEach((submenu) => {
    submenu.style.display = "none"; // 모든 서브메뉴 닫기
  });

  isSubmenuOpen = false; // 서브메뉴 열림 상태 업데이트
  button.style.right = "25px"; // 버튼 위치 원래대로
}

const menuItems = document.querySelectorAll(".chatmenubar");

menuItems.forEach((menuItem) => {
  menuItem.addEventListener("click", () => {
    if (isSidebarOpen) {
      const submenu = menuItem.querySelector(".chatsubmenu");

      // 모든 서브메뉴 닫고, 클릭된 서브메뉴만 열기
      closeSubmenus();
      
      if (submenu) {
        submenu.style.display = "block"; // 클릭한 서브메뉴 열기
        isSubmenuOpen = true; // 서브메뉴 상태 업데이트
        button.style.right = "296px"; // 버튼 위치 조정
        $('#toggle-chatbot').animate({ right: '390px'}, 300);
      }
    }
  });

  menuItem.addEventListener("mouseout", () => {
    // mouseout 시 사이드바가 닫히지 않도록 기능을 제거합니다.
  });

  menuItem.addEventListener("mouseover", () => clearTimeout(timeoutId)); // mouseover 시 timeout 클리어
});



function openSubmenu(selector) {
  closeSubmenus(); // 다른 서브메뉴 닫기
  const submenu = document.querySelector(selector); // 선택자 사용
  if (submenu) {
    submenu.style.display = "block"; 
    isSubmenuOpen = true; // 서브메뉴 열림 상태 업데이트
    button.style.right = "296px"; // 버튼 위치 조정
  } else {
    console.log("서브메뉴를 찾을 수 없습니다:", selector); // 선택자가 올바른지 디버그
  }
}



button.addEventListener("click", () => {
  if (!isSidebarOpen) {
    // 사이드바가 닫혀있을 때
    sidebar.style.width = "80px"; // 사이드바 열기
    isSidebarOpen = true; // 사이드바 상태 업데이트
    $('#toggle-chatbot').animate({ right: '120px'}, 300);
    
    
  } else {
    // 사이드바가 열려있을 때
    if (!isSubmenuOpen) {
      // 서브메뉴가 열려있지 않다면
      
  		
  		
  		
 

  		
   	
      button.style.right = "296px"; // 버튼 위치 조정
      openSubmenu(".chattingsidebar");//채팅창 디폴트설정
      $('#toggle-chatbot').animate({ right: '390px'}, 300);
    } else {
      // 서브메뉴가 열려있다면
      closeSubmenus(); // 서브메뉴 닫기
      sidebar.style.width = "0"; // 사이드바도 닫기
      isSidebarOpen = false; // 사이드바 상태 업데이트
      $('#toggle-chatbot').animate({ right: '40px'}, 300);
    }
  }
});