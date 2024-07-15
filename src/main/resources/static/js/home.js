// 스크롤 이벤트 리스너 추가(사용자가 페이지를 스크롤할 때 호출함)
window.onscroll = function() {scrollFunction()};

function scrollFunction() {
  // 스크롤 위치가 20px을 초과하면 버튼 표시
  // 스크롤의 위치가 20px을 초과했는지 조건문을 통해 검사 한 후, 20px을 초과했으면 scrolltop 버튼을 표시
  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
    document.getElementById("scrollTopBtn").style.display = "block";
  } else {
	//그렇지 않다면 해당 버튼 숨김
    document.getElementById("scrollTopBtn").style.display = "none";
  }
}

// 맨 위로 스크롤하는 함수
function scrollToTop() {
  document.body.scrollTop = 0; //사파리 브라우저의 코드
  document.documentElement.scrollTop = 0; //크롬, firefox, IE, opera 등의 브라우저의 코드
}