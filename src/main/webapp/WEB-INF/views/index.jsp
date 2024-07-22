<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>Movio Home</title>
  <meta charset="utf-8">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/main/home.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <script src="<c:url value='/js/home.js'/>"></script>
</head>
<body>
 <%@ include file="../header.jsp" %>
 
  <!-- 메인 콘텐츠 -->
  <div id="movieCarousel" class="carousel slide" data-bs-ride="carousel">
      <div class="carousel-inner">
          <div class="carousel-item active">
              <img src="<c:url value='/images/poster/인사이드아웃2.png' />" class="d-block w-100" alt="영화 1">
          </div>
          <div class="carousel-item">
              <img src="<c:url value='/images/poster/핸섬가이즈.png' />" class="d-block w-100" alt="영화 2">
          </div>
          <div class="carousel-item">
              <img src="<c:url value='/images/poster/하이재킹.png' />" class="d-block w-100" alt="영화 3">
          </div>
      </div>
      <button class="carousel-control-prev" type="button" data-bs-target="#movieCarousel" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#movieCarousel" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
      </button>
  </div>

	<!-- 버튼을 누르면 맨 위로 올라감 추가 -->
	<button id="scrollTopBtn" onclick="scrollToTop()">TOP</button>

  <!-- 영화 섹션 -->
  <section class="movies-section">
	  <!-- 추가 -->
	  <div id="icon"> 
	    <div class="icon-item">
	    	<a href="<c:url value='/reservation/booking' />" >
          	<img src="<c:url value='/images/logo/티켓로고.png' />" alt="1번 아이콘">
	      	</a>
	      	<p>빠른 예매</p>
	    </div>
	    <div class="icon-item">
	    	<a href="<c:url value='/movie/movielist' />">
	      	<img src="<c:url value='/images/logo/필름로고.png' />" alt="2번 아이콘">
	      	</a>
	      	<p>박스오피스</p>
	    </div>
	  </div>
	  <div class="movie-poster">
	  	<div class="poster-container">
	      <img src="<c:url value='/images/poster/인사이드아웃v2.png' />" alt="인사이드 아웃 2" width="220px" height="330px">
	      <div class="number">1</div>
	      <div class="section-buttons">
	        <a class="btn btn-detail">상세정보</a>
	        <a class="btn btn-book" href="<c:url value='/reservation/booking' />">예매</a>
	      </div>
	    </div>
	    <div class="poster-container">
	      <img src="<c:url value='/images/poster/탈주세로v2.png' />" alt="탈주" width="220px" height="330px">
	      <div class="number">2</div>
	      <div class="section-buttons">
	        <a class="btn btn-detail">상세정보</a>
	        <a class="btn btn-book" href="<c:url value='/reservation/booking' />">예매</a>
	      </div>
	    </div>
	    <div class="poster-container">
	      <img src="<c:url value='/images/poster/핸섬가이즈_세로.png' />" alt="핸섬 가이즈" width="220px" height="330px">
	      <div class="number">3</div>
	      <div class="section-buttons">
	        <a class="btn btn-detail">상세정보</a>
	        <a class="btn btn-book" href="<c:url value='/reservation/booking' />" onclick="checkLogin(event)">예매</a>
	      </div>
	    </div>
	    <div class="poster-container">
	      <img src="<c:url value='/images/poster/하이재킹v2.png' />" alt="하이재킹" width="220px" height="330px">
	      <div class="number">4</div>
	      <div class="section-buttons">
	        <a class="btn btn-detail" >상세정보</a>
	        <a class="btn btn-book" href="<c:url value='/reservation/booking' />" onclick="checkLogin(event)">예매</a>
	      </div>
	    </div>
	  </div>
	 <div class="icons">
	     	  <div class="icon">
	              <a href="<c:url value='/customer/inquiryList' />">
	                  <img src="<c:url value='/images/logo/문의.png' />" alt="3번 아이콘">
	              </a>
	                  <p>1:1 문의</p>
	          </div>
	          <div class="icon">
	              <a href="<c:url value='/customer/home' />">
	                  <img src="<c:url value='/images/logo/고객센터.png' />" alt="4번 아이콘">
	              </a>
	                  <p>고객센터</p>
	          </div>
	          <div class="icon">
	              <a href="<c:url value='/customer/lostItem' />">
	                  <img src="<c:url value='/images/logo/분실물.png' />" alt="5번 아이콘">
	              </a>
	                  <p>분실물 문의</p>
	          </div>
      </div>
	</section>
  <!-- 메인 끝 -->
  <%@ include file="../footer.jsp" %>

</body>
</html>
