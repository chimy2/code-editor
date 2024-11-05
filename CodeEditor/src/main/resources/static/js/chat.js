const button = document.querySelector(".button");
const sidebar = document.querySelector(".sidebar");
let isSidebarOpen = false;
let isSubmenuOpen = false; // 서브메뉴 열림 상태

sidebar.style.width = "0"; // 사이드바 초기 너비 설정

button.addEventListener("click", () => {
  if (!isSidebarOpen) {
    // 사이드바가 닫혀있을 때
    sidebar.style.width = "80px"; // 사이드바 열기
    isSidebarOpen = true; // 사이드바 상태 업데이트
  } else {
    // 사이드바가 열려있을 때
    if (!isSubmenuOpen) {
      // 서브메뉴가 열려있지 않다면
      openSubmenu(); // 서브메뉴 열기
      button.style.right = "296px"; // 버튼 위치 조정
    } else {
      // 서브메뉴가 열려있다면
      closeSubmenus(); // 서브메뉴 닫기
      sidebar.style.width = "0"; // 사이드바도 닫기
      isSidebarOpen = false; // 사이드바 상태 업데이트
    }
  }
});

function openSubmenu() {
  if (!isSubmenuOpen) {
    // 이미 서브메뉴가 열려있는 경우에는 동작하지 않도록 방지
    const submenus = document.querySelectorAll(".submenu");
    submenus.forEach((submenu) => {
      submenu.style.display = "block"; // 모든 서브메뉴 열기
      // 채팅창이 디폴트로 들어갈거임
    });

    isSubmenuOpen = true; // 서브메뉴 열림 상태 업데이트
    button.style.right = "296px"; // 버튼 위치 조정
  }
}

function closeSubmenus() {
  const submenus = document.querySelectorAll(".submenu");
  submenus.forEach((submenu) => {
    submenu.style.display = "none"; // 모든 서브메뉴 닫기
  });

  isSubmenuOpen = false; // 서브메뉴 열림 상태 업데이트
  button.style.right = "25px"; // 버튼 위치 원래대로
}

const menuItems = document.querySelectorAll(".menubar");

menuItems.forEach((menuItem) => {
  menuItem.addEventListener("click", () => {
    if (isSidebarOpen) {
      const submenu = menuItem.querySelector(".submenu");

      // 모든 서브메뉴 닫고, 클릭된 서브메뉴만 열기
      closeSubmenus();
      
      if (submenu) {
        submenu.style.display = "block"; // 클릭한 서브메뉴 열기
        isSubmenuOpen = true; // 서브메뉴 상태 업데이트
        button.style.right = "296px"; // 버튼 위치 조정
      }
    }
  });

  menuItem.addEventListener("mouseout", () => {
    // mouseout 시 사이드바가 닫히지 않도록 기능을 제거합니다.
  });

  menuItem.addEventListener("mouseover", () => clearTimeout(timeoutId)); // mouseover 시 timeout 클리어
});
