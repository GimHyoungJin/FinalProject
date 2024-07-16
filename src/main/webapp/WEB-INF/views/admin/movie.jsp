<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>영화 관리</title>
  <meta charset="utf-8">
  <!-- 공통 시작 -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
  <!-- 공통 끝 -->
  <style>
    .sidebar {
      height: 100%;
      padding-top: 20px;
      background-color: #f8f9fa;
      border-right: 1px solid #dee2e6;
    }
    .sidebar .list-group-item.active {
      background-color: #007bff;
      border-color: #007bff;
    }
    .main-content {
      padding: 20px;
    }
  </style>
</head>
<body>
  <%@ include file="../../header.jsp" %>
  <!-- 메인 콘텐츠 시작 -->
  <div class="container-fluid">
    <div class="row">
      <!-- 사이드바 -->
      <div class="container-fluid mypage-container">
        <div class="row">
          <div class="col-md-3 sidebar">
            <div class="list-group">
              <div class="list-group-item header" aria-current="true">
                관리자 페이지
              </div>
              <a href="<c:url value='/admin/theater' />" class="list-group-item list-group-item-action">영화관 관리</a>
              <a href="<c:url value='/admin/members' />" class="list-group-item list-group-item-action">회원 관리</a>
            </div>
          </div>
          <!-- 메인 콘텐츠 -->
          <div class="col-md-9 main-content">
            <h1>영화 관리</h1>
            <br><br><br>
            <h3 class="card-title">기본정보</h3>
            <div class="card">
              <div class="card-body">
                <!-- 영화 추가 폼 -->
                <form class="mb-4" action="<c:url value='/admin/movie/add' />" method="post" enctype="multipart/form-data">
                  <div class="mb-3">
                    <label for="movieTitle" class="form-label">영화 제목</label>
                    <input type="text" class="form-control" id="movieTitle" name="movieTitle" required>
                  </div>
                  <div class="mb-3">
                    <label for="releaseDate" class="form-label">개봉일</label>
                    <input type="date" class="form-control" id="releaseDate" name="releaseDate" required>
                  </div>
                  <div class="mb-3">
                    <label for="ageRating" class="form-label">연령등급</label>
                    <select class="form-select" id="ageRating" name="ageRating" required>
                      <option value="전체이용가">전체 이용가</option>
                      <option value="7세이용가">7세 이용가</option>
                      <option value="12세이용가">12세 이용가</option>
                      <option value="15세이용가">15세 이용가</option>
                      <option value="18세이용가">18세 이용가</option>
                    </select>
                  </div>
                  <div class="mb-3">
                    <label for="genre" class="form-label">장르</label>
                    <input type="text" class="form-control" id="genre" name="genre" required>
                  </div>
                  <div class="mb-3">
                    <label for="description" class="form-label">상세정보</label>
                    <textarea class="form-control" id="description" name="description" required></textarea>
                  </div>
                  <div class="mb-3">
                    <label for="posterUrl" class="form-label">대표 이미지</label>
                    <input type="file" class="form-control" id="posterUrl" name="posterUrl" required onchange="showImageFileName()">
                    <label id="imageFileName" class="form-label"></label>
                  </div>
                  <div class="mb-3">
                    <label for="trailerUrl" class="form-label">트레일러 URL</label>
                    <input type="url" class="form-control" id="trailerUrl" name="trailerUrl" required>
                  </div>
                  <button type="submit" class="btn btn-primary">추가</button>
                </form>

                <!-- 영화 목록 테이블 -->
                <table class="table table-bordered">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>제목</th>
                      <th>개봉일</th>
                      <th>연령등급</th>
                      <th>장르</th>
                      <th>상세정보</th>
                      <th>대표 이미지</th>
                      <th>트레일러 URL</th>
                      <th>총 관객수</th>
                      <th>상태</th>
                      <th>관리</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="movie" items="${movies}">
                      <tr>
                        <td>${movie.movieId}</td>
                        <td>${movie.movieTitle}</td>
                        <td>${movie.releaseDate}</td>
                        <td>${movie.ageRating}</td>
                        <td>${movie.genre}</td>
                        <td>${movie.description}</td>
                        <td><img src="<c:url value='${movie.posterUrl}' />" alt="${movie.movieTitle}" width="50"></td>
                        <td><a href="${movie.trailerUrl}" target="_blank">트레일러 보기</a></td>
                        <td>${movie.totalAudience}</td>
                        <td>
                          <form action="<c:url value='/admin/movie/updateStatus' />" method="post" class="d-inline">
                            <input type="hidden" name="movieId" value="${movie.movieId}">
                            <select name="status" class="form-select" onchange="this.form.submit()">
                              <option value="active" <c:if test="${movie.status == 'active'}">selected</c:if>>활성화</option>
                              <option value="inactive" <c:if test="${movie.status == 'inactive'}">selected</c:if>>비활성화</option>
                            </select>
                          </form>
                        </td>
                        <td>
                          <form action="<c:url value='/admin/movie/delete' />" method="post" class="d-inline">
                            <input type="hidden" name="movieId" value="${movie.movieId}">
                            <button type="submit" class="btn btn-danger">삭제</button>
                          </form>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- 메인 콘텐츠 끝 -->
  <%@ include file="../../footer.jsp" %>
  <script>
    function showImageFileName() {
      var input = document.getElementById('posterUrl');
      var label = document.getElementById('imageFileName');
      label.textContent = input.files[0].name;
    }
  </script>
</body>
</html>
