<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>고객센터 홈</title>
  <meta charset="utf-8">
  <!-- 공통 시작 -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
  <!-- 공통 끝 -->
  
  <link href="<c:url value='/css/customer/home.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/customer/customer_sidebar.css' />" rel="stylesheet" type="text/css">
    
</head>
<body>
  <%@ include file="../../header.jsp" %>

  <!-- 메인 콘텐츠 시작 -->
	<div id="container">
		<div class="row">
			<div id="sidebar">
				<%@ include file="customer_sidebar.jsp"%>
			</div>
			<div class="col-9">
				<div id="customer-home">
					<h1>고객센터 홈</h1>
					<div id="inquiry-sections">
						<div class="section">
							<a href="<c:url value='/customer/inquiryForm' />"> <img
								src="<c:url value='/images/logo/문의.png' />" alt="1:1 문의">
								<p>1:1 문의</p>
								<p class="description">해결되지 않은 문제가 있나요? 1:1문의로 문의주세요</p>
							</a>
						</div>
						<div class="section">
							<a href="<c:url value='/customer/lostItemList' />"> <img
								src="<c:url value='/images/logo/분실물.png' />" alt="분실물 문의">
								<p>분실물 문의</p>
								<p class="description">잃어버린 물건을 접수해 주시면 신속히 찾아드리겠습니다.</p>
							</a>
						</div>
						<div class="section">
							<a href="<c:url value='/customer/terms' />"> <img
								src="<c:url value='/images/logo/이용약관.png' />" alt="이용 약관">
								<p>이용 약관</p>
								<p class="description">이용 약관을 확인해 보세요.</p>
							</a>
						</div>
					</div>
					<!-- 실선 추가 -->
					<div id="divider-line"></div>
					<!-- 공지사항 섹션 시작 -->
					<div id="notice-section">
						<h2>공지사항</h2>
						<!-- 공지사항 글씨를 중앙에 정렬하기 위해 CSS에서 텍스트 정렬 설정 -->
						<div id="notice-list">
							<table class="table">
								<thead>
									<tr>
										<!-- 제목과 날짜 컬럼 제거 -->
									</tr>
								</thead>
								<tbody>
									<c:forEach var="notice" items="${notices}">
										<tr>
											<td><a
												href="<c:url value='/customer/noticeDetail?notice_num=${notice.noticeNum}' />">${notice.title}</a></td>
											<td>${notice.regDate}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<a id="more-notices" href="<c:url value='/customer/noticeList' />">더보기</a>
						<!-- 더보기 링크의 글씨 크기 조정 -->
					</div>
					<!-- 공지사항 섹션 끝 -->
				</div>
			</div>
		</div>
	</div>
  <!-- 메인 콘텐츠 끝 -->
  
  <%@ include file="../../footer.jsp" %>
</body>
</html>