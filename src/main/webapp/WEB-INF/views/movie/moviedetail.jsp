<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>영화 상세 정보</title>
    <meta charset="utf-8">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
    <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
    <link href="<c:url value='/css/movie/movie.css' />" rel="stylesheet" type="text/css">
    <style>
        .header-background {
            background: rgb(2,0,36);
            background: linear-gradient(90deg, rgba(2,0,36,1) 30%, rgba(84,84,94,1) 52%, rgba(0,10,10,1) 75%);
            color: #fff;
            padding-bottom: 20px;
        }

        .movie-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
        }

        .movie-poster {
            max-width: 300px;
            margin-right: 20px;
        }

        .movie-poster img {
            width: 100%;
            border-radius: 10px;
        }

        .movie-info {
            flex: 1;
            margin-left: 20px;
        }

        .movie-info h1 {
            font-size: 3.5em;
            margin-bottom: 10px;
        }

        .movie-info p {
            font-size: 1.5em;
            margin-bottom: 10px;
        }

        .stats-container {
            display: flex;
            justify-content: center;
            padding: 20px 0;
            gap: 50px;
        }

        .stat {
            text-align: center;
        }

        .stat h2 {
            font-size: 1.2em;
            margin-bottom: 10px;
        }

        .stat p {
            font-size: 1.5em;
            margin: 0;
        }

        .description {
            overflow: hidden;
            max-height: 3em;
            line-height: 1.5em;
            position: relative;
            color: #000;
        }

        .description.show {
            max-height: none;
        }

        .read-more {
            display: block;
            cursor: pointer;
            color: blue;
            border: 1px solid #ddd;
            padding: 5px 10px;
            border-radius: 4px;
            background-color: #f9f9f9;
            margin: 10px auto;
            width: fit-content;
            text-align: center;
        }

        .main-content {
            background-color: #fff;
            color: #000;
            padding: 20px;
            padding-left: 300px;
        }

        .btn-primary, .btn-danger {
            font-size: 1.2em;
            padding: 10px 20px;
        }

        .nav-tabs {
            margin-left: 20px;
        }

        .tab-content {
            padding: 20px;
        }

        .actions {
            margin-top: 20px;
            text-align: right;
        }

        .actions .btn {
            margin: 0 10px;
        }
    </style>
</head>
<body>
    <%@ include file="../../header.jsp" %>

    <div class="header-background">
        <div class="container mt-4">
            <div class="movie-header">
                <div class="movie-info">
                    <h1>${title}</h1>
                    <p><strong>개봉일:</strong> ${releaseDate}</p>
                </div>
                <div class="movie-poster">
                    <img src="${posterUrl}" class="img-fluid" alt="${title}">
                    <a href="<c:url value='/reservation/booking' />" class="btn btn-primary">예매</a>
                </div>
            </div>
        </div>

        <div class="stats-container">
            <div class="stat">
                <h2>실관람 평점</h2>
                <p>${rating}</p>
            </div>
            <div class="stat">
                <h2>예매율</h2>
                <p><fmt:formatNumber value="${movieGrade}" type="number" maxFractionDigits="1" />%</p>
            </div>
            <div class="stat">
                <h2>누적 관객수</h2>
                <p>${totalAudience}명</p>
            </div>
        </div>
    </div>
    
    <div class="main-content">
        <!-- 탭 메뉴 -->
        <ul class="nav nav-tabs mt-3" id="myTab" role="tablist">
            <li class="nav-item" role="presentation">
                <a class="nav-link active" id="main-info-tab" href="?id=${movieId}" role="tab" aria-controls="main-info" aria-selected="true">주요정보</a>
            </li>
            <li class="nav-item" role="presentation">
                <a class="nav-link" id="reviews-tab" href="comment?id=${movieId}" role="tab" aria-controls="reviews" aria-selected="false">실관람평</a>
            </li>
            <li class="nav-item" role="presentation">
                <a class="nav-link" id="trailer_url-tab" href="${pageContext.request.contextPath}/movie/trailer?id=${movieId}" role="tab" aria-controls="trailer_url" aria-selected="false">트레일러 URL</a>
            </li>
        </ul>

        <div class="tab-content mt-3" id="myTabContent">
            <div class="tab-pane fade show active" id="main-info" role="tabpanel" aria-labelledby="main-info-tab">
                <h2>${title}</h2>
                <div class="description" id="description">
                    ${description}
                </div>
                <span class="read-more" id="read-more">더보기 ▼</span>
            </div>
            <div class="tab-pane fade" id="reviews" role="tabpanel" aria-labelledby="reviews-tab">
                <h2>실관람평</h2>
                <p>실관람평 내용</p>
            </div>

        </div>

        <div class="actions">
            <!-- 관리자만 볼 수 있게 하는 것 해당 로직은 header.js에 들어가 있습니다. -->
            <div class="admin-button-container" style="display: none;">
                <a href="<c:url value='/movie/edit?id=${movieId}' />" class="btn btn-primary">영화 수정</a>
                <form action="<c:url value='/movie/delete' />" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="${movieId}">
                    <button type="submit" class="btn btn-danger">영화 삭제</button>
                </form>
            </div>
        </div>
    </div>

    <%@ include file="../../footer.jsp" %>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var description = document.getElementById('description');
            var readMore = document.getElementById('read-more');

            // 더보기 버튼 클릭 시 동작
            readMore.addEventListener('click', function () {
                if (description.classList.contains('show')) {
                    description.classList.remove('show');
                    readMore.innerHTML = '더보기 ▼';
                } else {
                    description.classList.add('show');
                    readMore.innerHTML = '접기 ▲';
                }
            });
        });
    </script>
</body>
</html>
