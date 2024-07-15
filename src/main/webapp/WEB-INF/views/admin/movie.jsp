<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>movie</title>
  <meta charset="utf-8">
  <script src="<c:url value='/js/jquery-3.7.1.min.js' />"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/admin/sidebar.css' />" rel="stylesheet" type="text/css">
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
  <%@ include file="/WEB-INF/header.jsp" %>
  <div class="container-fluid">
    <div class="row">
      <!-- 사이드바 -->
      <div class="col-md-3 sidebar">
        <div class="list-group">
          <div class="list-group-item header" aria-current="true">
            관리자 페이지
          </div>
          <a href="<c:url value='/admin/members' />" class="list-group-item list-group-item-action">회원 관리</a>
          <a href="<c:url value='/admin/theater' />" class="list-group-item list-group-item-action">영화관 관리</a>
        </div>
      </div>
      <!-- 메인 콘텐츠 -->
      <div class="col-md-9 main-content">
        <h1> 영화 관리 </h1>
        <br><br><br> 
        <h3 class="card-title">기본정보</h3>
        <div class="card">
          <div class="card-body">

            <!-- 영화 추가 폼 -->
            <form class="mb-4" action="<c:url value='/admin/movie/add' />" method="post" enctype="multipart/form-data">
              <div class="mb-3">
                <label for="title" class="form-label">영화 제목</label>
                <input type="text" class="form-control" id="title" name="title" required>
              </div>
              <div class="mb-3">
                <label for="releaseDate" class="form-label">개봉일</label>
                <input type="date" class="form-control" id="releaseDate" name="releaseDate" required>
              </div>
              <div class="mb-3">
                <label for="ageRating" class="form-label">연령등급</label>
                <select class="form-select" id="ageRating" name="ageRating" required>
                  <option value="all">전체 관람가</option>
                  <option value="7">7세 이상</option>
                  <option value="15">15세 이상</option>
                  <option value="18">18세 이상</option>
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
                <label for="image" class="form-label">대표 이미지</label>
                <input type="file" class="form-control" id="image" name="image" required onchange="showImageFileName()">
                <label id="imageFileName" class="form-label"></label>
              </div>
              <div class="mb-3">
                <label for="trailerUrl" class="form-label">트레일러 URL</label>
                <input type="url" class="form-control" id="trailerUrl" name="trailerUrl" required>
              </div>
              <div class="mb-3">
                <label for="status" class="form-label">상태</label>
                <select class="form-select" id="status" name="status" required>
                  <option value="active">활성화</option>
                  <option value="inactive">비활성화</option>
                </select>
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
                  <th>상태</th>
                  <th>관리</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="movie" items="${movies}">
                  <tr>
                    <td>${movie.id}</td>
                    <td>${movie.title}</td>
                    <td>${movie.releaseDate}</td>
                    <td>${movie.ageRating}</td>
                    <td>${movie.genre}</td>
                    <td>${movie.description}</td>
                    <td><img src="<c:url value='/images/${movie.image}' />" alt="${movie.title}" width="50"></td>
                    <td><a href="${movie.trailerUrl}" target="_blank">트레일러 보기</a></td>
                    <td>${movie.status}</td>
                    <td>
                      <!-- 상태 업데이트 폼 -->
                      <form action="<c:url value='/admin/movie/updateStatus' />" method="post" class="d-inline">
                        <input type="hidden" name="movieId" value="${movie.id}">
                        <select name="status" class="form-select" onchange="this.form.submit()">
                          <option value="active" <c:if test="${movie.status == 'active'}">selected</c:if>>활성화</option>
                          <option value="inactive" <c:if test="${movie.status == 'inactive'}">selected</c:if>>비활성화</option>
                        </select>
                      </form>
                      <!-- 삭제 폼 -->
                      <form action="<c:url value='/admin/movie/delete' />" method="post" class="d-inline">
                        <input type="hidden" name="movieId" value="${movie.id}">
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
  <%@ include file="/WEB-INF/footer.jsp" %>
  <script>
    function showImageFileName() {
      var input = document.getElementById('image');
      var label = document.getElementById('imageFileName');
      label.textContent = input.files[0].name;
    }
  </script>
</body>
</html>
