<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>영화 관리</title>
    <meta charset="utf-8">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
    <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
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
    <div class="container-fluid">
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
            <div class="col-md-9 main-content">
                <h1>영화 관리</h1>
                <br><br><br>
                <h3 class="card-title">기본정보</h3>
                <div class="card">
                    <div class="card-body">
                        <!-- 영화 수정 폼 -->
                        <form class="mb-4" action="<c:url value='/admin/movie/update' />" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="movie_id" value="${movie.movie_id}">
                            <input type="hidden" name="existingPosterUrl" value="${movie.poster_url}">
                            <div class="mb-3">
                                <label for="movieTitle" class="form-label">영화 제목</label>
                                <input type="text" class="form-control" id="movieTitle" name="movie_title" value="${movie.movie_title}" required>
                            </div>
                            <div class="mb-3">
                                <label for="releaseDate" class="form-label">개봉일</label>
                                <input type="date" class="form-control" id="releaseDate" name="release_date" value="${movie.release_date}" required>
                            </div>
                            <div class="mb-3">
                                <label for="ageRating" class="form-label">연령등급</label>
                                <select class="form-select" id="ageRating" name="age_rating" required>
                                    <option value="전체이용가" <c:if test="${movie.age_rating == '전체이용가'}">selected</c:if>>전체 이용가</option>
                                    <option value="7세이용가" <c:if test="${movie.age_rating == '7세이용가'}">selected</c:if>>7세 이용가</option>
                                    <option value="12세이용가" <c:if test="${movie.age_rating == '12세이용가'}">selected</c:if>>12세 이용가</option>
                                    <option value="15세이용가" <c:if test="${movie.age_rating == '15세이용가'}">selected</c:if>>15세 이용가</option>
                                    <option value="18세이용가" <c:if test="${movie.age_rating == '18세이용가'}">selected</c:if>>18세 이용가</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="genre" class="form-label">장르</label>
                                <input type="text" class="form-control" id="genre" name="genre" value="${movie.genre}" required>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">상세정보</label>
                                <textarea class="form-control" id="description" name="description" required>${movie.description}</textarea>
                            </div>
                            <div class="mb-3">
                                <label for="posterUrl" class="form-label">대표 이미지</label>
                                <input type="file" class="form-control" id="posterUrl" name="poster" onchange="showImageFileName()">
                                <label id="imageFileName" class="form-label">${movie.poster_url}</label>
                            </div>
                            <div class="mb-3">
                                <label for="trailerUrl" class="form-label">트레일러 URL</label>
                                <input type="url" class="form-control" id="trailerUrl" name="trailer_url" value="${movie.trailer_url}" required>
                            </div>
                            <button type="submit" class="btn btn-primary">수정</button>
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
                                    <th>관리</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="movie" items="${movies}">
                                    <tr>
                                        <td>${movie.movie_id}</td>
                                        <td>${movie.movie_title}</td>
                                        <td>${movie.release_date}</td>
                                        <td>${movie.age_rating}</td>
                                        <td>${movie.genre}</td>
                                        <td>${movie.description}</td>
                                        <td><img src="<c:url value='${movie.poster_url}' />" alt="${movie.movie_title}" width="50"></td>
                                        <td><a href="${movie.trailer_url}" target="_blank">트레일러 보기</a></td>
                                        <td>${movie.total_audience}</td>
                                        <td>
                                            <form action="<c:url value='/admin/movie/delete' />" method="post" class="d-inline">
                                                <input type="hidden" name="id" value="${movie.movie_id}">
                                                <button type="submit" class="btn btn-danger">삭제</button>
                                            </form>
                                            <a href="<c:url value='/admin/movie/edit?id=${movie.movie_id}' />" class="btn btn-primary">수정</a>
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
