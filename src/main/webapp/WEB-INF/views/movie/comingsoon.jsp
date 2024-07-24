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
  <link href="<c:url value='/resources/css/movie/movie.css' />" rel="stylesheet" type="text/css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/movie/movie.css">
<style>
        .btn-primary {
            background-color: black !important; /* 배경색 검은색 */
            color: white !important; /* 글자색 흰색 */
            border-color: black !important; /* 테두리색 검은색 */
        }

        .btn-primary:hover {
            background-color: #333 !important; /* 호버시 배경색 조금 밝은 검은색 */
            border-color: #333 !important; /* 호버시 테두리색 조금 밝은 검은색 */
        }
    </style>
</head>
<body>
  	<%@ include file="../../header.jsp" %>
  	<!-- 메인 콘텐츠 시작 -->
  	<div class="container mt-4">
    </div>
    
    <nav class="navbar navbar-expand-sm navbar-light bg-light"> <!-- 밝은 배경색과 어두운 텍스트 -->
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

    <!-- 구분선 -->
    <div class="divider"></div>

  	<!-- 상영예정작 리스트 -->
    <div class="container mt-4">
        <div class="row">
            <c:forEach var="movie" items="${movies}">
                <div class="col-md-3">
                    <div class="card mb-4">
                        <a href="<c:url value='/movie/moviedetail?id=${movie.movie_id}' />">
                            <img src="<c:url value='${movie.poster_url}' />" class="card-img-top" alt="${movie.movie_title}">
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
                        			${movie.movie_title}
	                            </h5>
	                            <p class="card-text">개봉일 ${movie.release_date}</p>
	                            <a href="<c:url value='/reservation/movieBooking?id=${movie.movie_id}' />" class="btn btn-primary btn-block mb-4">예매</a>
	                        </div>
	                    </div>
	                </div>
	            </c:forEach>
	        </div>
	    </div>
  
  	<%@ include file="../../footer.jsp" %>
</body>
</html>
