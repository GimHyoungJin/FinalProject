<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>영화 페이지</title>
    <meta charset="utf-8">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
    <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
    <link href="<c:url value='/css/movie/movie.css' />" rel="stylesheet" type="text/css">
    <script src="<c:url value='/js/home.js'/>"></script>
    <style>
        .card-title {
            white-space: nowrap;
            overflow: hidden;
            display: block;
            max-width: 100%;
        }
        /* 맨 위로 버튼 스타일 */
		#scrollTopBtn {
		  display: none; /* 기본적으로 버튼 숨기기 */
		  position: fixed; /* 고정 위치 */
		  bottom: 20px; /* 하단에서 20px */
		  right: 20px; /* 우측에서 20px */
		  z-index: 99; /* 다른 요소 위에 표시 */
		  border: none; /* 테두리 없음 */
		  outline: none; /* 외곽선 없음 */
		  background-color: #555; /* 배경색 설정 */
		  color: white; /* 텍스트 색상 */
		  cursor: pointer; /* 마우스 커서 포인터 */
		  padding: 15px; /* 내부 여백 */
		  border-radius: 50%; /* 원형 버튼 */
		  box-shadow: 0px 0px 10px rgba(0,0,0,0.3); /* 그림자 추가 */
		}
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const titles = document.querySelectorAll('.card-title span');
            titles.forEach(title => {
                const maxWidth = title.parentElement.clientWidth - 2; // 부모 요소의 너비 가져오기 (더 작은 여유 공간)
                let text = title.textContent;
                while (title.scrollWidth > maxWidth && text.length > 0) {
                    text = text.slice(0, -1); // 텍스트 한 글자씩 줄이기
                    title.textContent = text + '····'; // 생략 기호 추가
                }
            });
        });
    </script>
</head>
<body>
    <%@ include file="../../header.jsp" %>
    
    <!-- 영화 페이지 메인 콘텐츠 -->
    <div class="container mt-4 d-flex justify-content-between align-items-center">
        <h1>박스오피스</h1>
        <!-- 관리자만 해당 버튼 보임 -->
        <div class="admin-button-container" style="display: none;">
            <a href="<c:url value='/movie/write' />" class="btn btn-primary">영화등록</a>
        </div>
    </div>

    <nav class="navbar navbar-expand-sm navbar-light bg-light">
        <div class="container-fluid">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="/movie/movielist">박스오피스</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/movie/comingsoon">상영예정작</a>
                </li>
            </ul>
        </div>
    </nav>

	<button id="scrollTopBtn" onclick="scrollToTop()">TOP</button>
    <!-- 구분선 -->
    <div class="divider"></div>
    
    <!-- 박스오피스 리스트 -->
    <div class="container mt-4">
        <div class="row">
            <c:forEach var="movie" items="${movies}">
                <div class="col-md-3">
                    <div class="card mb-4">
                        <a href="<c:url value='/movie/moviedetail?id=${movie.movie_id}' />">
                            <img src="${movie.poster_url}" title="${movie.movie_title}" class="card-img-top" alt="${movie.movie_title}">
                        </a>
                        <div class="card-body">
                            <h5 class="card-title d-flex align-items-center">
                                <c:choose>
                                    <c:when test="${movie.age_rating == '전체이용가'}">
                                        <img src="/images/logo/ageall.png" alt="연령 등급" style="width: 20px; height: 20px; margin-right: 5px;">
                                    </c:when>
                                    <c:when test="${movie.age_rating == '12세 이용가'}">
                                        <img src="/images/logo/age12.png" alt="연령 등급" style="width: 20px; height: 20px; margin-right: 5px;">
                                    </c:when>
                                    <c:when test="${movie.age_rating == '15세 이용가'}">
                                        <img src="/images/logo/age15.png" alt="연령 등급" style="width: 20px; height: 20px; margin-right: 5px;">
                                    </c:when>
                                    <c:when test="${movie.age_rating == '청소년 관람불가'}">
                                        <img src="/images/logo/age19.png" alt="연령 등급" style="width: 20px; height: 20px; margin-right: 5px;">
                                    </c:when>
                                    <c:otherwise>
                                        <span>연령 등급 정보 없음</span>
                                    </c:otherwise>
                                </c:choose>
                                <span>${movie.movie_title}</span>
                            </h5>
                            <p class="card-text">개봉일 ${movie.release_date}</p>
                            <a href="<c:url value='/reservation/booking' />" class="btn btn-primary btn-block mb-4">예매</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    
    <%@ include file="../../footer.jsp" %>
</body>
</html>
