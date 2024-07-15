<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>영화 수정</title>
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
    .preview-img {
        max-width: 200px;
        max-height: 300px;
        margin-top: 10px;
    }
  </style>
</head>
<body>
  <%@ include file="../../header.jsp" %>
  <!-- 메인 콘텐츠 시작 -->
  <div class="container mt-5">
      <h1>영화 수정</h1>
      <form action="<c:url value='/movie/update' />" method="post" enctype="multipart/form-data">
          <input type="hidden" name="movie_id" value="${movie.movie_id}">
          <div class="mb-3">
              <label for="title" class="form-label">영화 제목</label>
              <input type="text" class="form-control" id="title" name="movie_title" value="${movie.movie_title}" required>
          </div>
          <div class="mb-3">
              <label for="releaseDate" class="form-label">개봉일</label>
              <input type="date" class="form-control" id="releaseDate" name="release_date" value="${movie.release_date}" required>
          </div>
          <div class="mb-3">
              <label for="description" class="form-label">설명</label>
              <textarea class="form-control" id="description" name="description" rows="3" required>${movie.description}</textarea>
          </div>
          <div class="mb-3">
              <label for="poster" class="form-label">포스터 이미지</label>
              <input type="file" class="form-control" id="poster" name="poster">
              <input type="hidden" id="existingPosterUrl" name="existingPosterUrl" value="${movie.poster_url}"> <!-- 기존 포스터 URL을 전달하는 숨겨진 입력 필드 추가 -->
              <img id="posterPreview" class="preview-img" src="${movie.poster_url}" alt="포스터 이미지">
          </div>
          <div class="mb-3">
              <label for="trailerUrl" class="form-label">예고편 URL</label>
              <input type="text" class="form-control" id="trailerUrl" name="trailer_url" value="${movie.trailer_url}" required>
          </div>
          <button type="submit" class="btn btn-primary">수정 완료</button>
      </form>
  </div>
  <!-- 메인 콘텐츠 끝 -->
  <%@ include file="../../footer.jsp" %>
  <script>
      // 이미지 파일 선택 시 미리보기 업데이트
      document.getElementById('poster').addEventListener('change', function(event) {
          const file = event.target.files[0];
          if (file) {
              const reader = new FileReader();
              reader.onload = function(e) {
                  document.getElementById('posterPreview').src = e.target.result;
              };
              reader.readAsDataURL(file);
          }
      });
  </script>
</body>
</html>
