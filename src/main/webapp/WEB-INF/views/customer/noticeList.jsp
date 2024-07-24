<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>공지사항 목록</title>
  <meta charset="utf-8">
  <!-- 공통 시작 -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
  <!-- 공통 끝 -->
  <link href="<c:url value='/css/customer/customer_sidebar.css' />" rel="stylesheet" type="text/css">
  <script src="<c:url value='/js/notice.js' />"></script>
  <style>
    /* 전체 컨테이너 설정 */
    #container {
      padding: 20px; /* 전체 컨테이너에 20px 패딩을 추가하여 내부 여백을 줍니다. */
    }
    
    /* 메인 콘텐츠 영역 설정 */
    #main-content {
      width: 100%; /* 메인 콘텐츠의 너비를 100%로 설정합니다. */
      max-width: 900px; /* 메인 콘텐츠의 최대 너비를 900px로 제한합니다. */
      background-color: #fff; /* 메인 콘텐츠의 배경색을 흰색으로 설정합니다. */
      padding: 20px; /* 메인 콘텐츠 내부의 여백을 20px로 설정합니다. */
      border-radius: 8px; /* 모서리를 8px 반경으로 둥글게 만듭니다. */
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 약간의 그림자를 추가하여 입체감을 줍니다. */
    }

    /* 공지사항 상단 영역 설정 */
    .notice-top {
      width: 100%; /* 공지사항 상단의 너비를 100%로 설정합니다. */
      display: flex; /* 플렉스박스를 사용하여 내부 요소들을 배치합니다. */
      justify-content: space-between; /* 내부 요소들을 양 끝으로 정렬합니다. */
      margin-bottom: 20px; /* 아래쪽에 20px 간격을 둡니다. */
    }

    /* 검색 바 설정 */
    .search-bar {
      display: flex; /* 플렉스박스를 사용하여 내부 요소들을 배치합니다. */
      align-items: center; /* 내부 요소들을 수직 중앙에 정렬합니다. */            
    }

    /* 검색 바 안의 선택박스 및 입력박스 설정 */
    .search-bar .form-select,
    .search-bar .form-control {
      margin-right: 10px; /* 오른쪽에 10px 간격을 둡니다. */
    }

    /* 테이블 설정 */
    .table {
      width: 100%; /* 테이블의 너비를 100%로 설정합니다. */
      margin-top: 20px; /* 위쪽에 20px 간격을 둡니다. */
    }

    /* 테이블 헤더와 데이터 셀 설정 */
    .table th, .table td {
      text-align: center; /* 텍스트를 중앙 정렬합니다. */
      vertical-align: middle; /* 텍스트를 수직 중앙 정렬합니다. */
    }

    /* 페이지네이션 설정 */
    .pagination {
      margin-top: 20px; /* 위쪽에 20px 간격을 둡니다. */
    }

    /* 마진 탑 3 설정 */
    .mt-3 {
      margin-top: 20px; /* 위쪽에 20px 간격을 둡니다. */
    }

    /* 보조 버튼 설정 */
    .btn-secondary {
      background-color: #6c757d;
      border: none;
      color: white;
      padding: 10px 20px;
      cursor: pointer;
      white-space: nowrap;
    }

    .btn-secondary:hover {
      background-color: #000000; /* 버튼 배경색을 호버 상태에서 변경합니다. */
    }
  </style>
</head>
<body>
  <%@ include file="../../header.jsp" %>
  <div id="container" class="d-flex justify-content-center mt-3">
    <div id="sidebar" class="me-3">
      <%@ include file="customer_sidebar.jsp" %>
    </div>
    <div id="main-content">
      <h2>공지사항</h2>
      <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger" role="alert">
          ${errorMessage}
        </div>
      </c:if>
      <div class="notice-top">
        <!-- 관리자만 공지사항 작성 가능 -->
        <div class="admin-button-container" style="display: none;">
          <button class="btn btn-primary" onclick="window.location.href='/customer/noticeForm'">공지사항 작성</button>
        </div>

        <!-- 검색 바 -->
        <div class="search-bar">
          <select class="form-select" id="searchType">
            <option value="title">제목</option>
            <option value="content">내용</option>
          </select>
          <input type="text" class="form-control" id="searchKeyword" placeholder="검색어를 입력하세요">
          <button class="btn btn-secondary" onclick="searchNotices()">검색</button>
        </div>
      </div>
      <!-- 공지사항 테이블 -->
      <table class="table table-striped">
        <thead>
          <tr>
            <th>번호</th>
            <th>제목</th>
            <th>등록일</th>
            <th>조회수</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="notice" items="${notices}">
            <tr>
              <td>${notice.noticeNum}</td>
              <td><a href="/customer/noticeDetail?action=detail&noticeNum=${notice.noticeNum}">${notice.title}</a></td>
              <td><fmt:formatDate value="${notice.regdate}" pattern="yyyy-MM-dd HH:mm" /></td>
              <td>${notice.viewCount}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
      <!-- 페이지네이션 -->
   <nav>
    <ul class="pagination justify-content-center">
        <c:forEach var="i" begin="1" end="${totalPages}">
            <li class="page-item ${currentPage == i ? 'active' : ''}">
                <a class="page-link" data-page="${i}" href="#">${i}</a>
            </li>
        </c:forEach>
    </ul>
</nav>
    </div>
  </div>
  <%@ include file="../../footer.jsp" %>
  <script>
    function searchNotices() {
      var keyword = document.getElementById('searchKeyword').value;
      window.location.href = '/customer/noticeSearch?keyword=' + encodeURIComponent(keyword);
    }
  </script>
</body>
</html>
