<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>영화 실관람평</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
    <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
    <link href="<c:url value='/css/movie/movie.css' />" rel="stylesheet" type="text/css">
    <style>
    /* 헤더 배경 스타일 설정 */
    .header-background {
        background: rgb(2,0,36); /* 백업용 배경색 */
        background: linear-gradient(90deg, rgba(2,0,36,1) 30%, rgba(84,84,94,1) 52%, rgba(0,10,10,1) 75%); /* 그라데이션 배경 */
        color: #fff; /* 글자 색상 흰색 */
        padding-bottom: 20px; /* 아래쪽 패딩 */
    }

    /* 영화 헤더 스타일 설정 */
    .movie-header {
        display: flex; /* 플렉스 박스 사용 */
        justify-content: space-between; /* 공간을 균등하게 분배 */
        align-items: center; /* 수직 가운데 정렬 */
        padding: 20px; /* 모든 방향 패딩 */
    }

    /* 영화 포스터 스타일 설정 */
    .movie-poster {
        max-width: 300px; /* 최대 너비 설정 */
        margin-right: 20px; /* 오른쪽 마진 */
    }

    .movie-poster img {
        width: 100%; /* 너비 100% 설정 */
        border-radius: 10px; /* 둥근 테두리 */
    }

    /* 영화 정보 스타일 설정 */
    .movie-info {
        flex: 1; /* flex-grow 값 설정 */
        margin-left: 20px; /* 왼쪽 마진 */
    }

    .movie-info h1 {
        font-size: 3.5em; /* 제목 폰트 크기 설정 */
        margin-bottom: 10px; /* 아래쪽 마진 */
    }

    .movie-info p {
        font-size: 1.5em; /* 문단 폰트 크기 설정 */
        margin-bottom: 10px; /* 아래쪽 마진 */
    }

    /* 통계 컨테이너 스타일 설정 */
    .stats-container {
        display: flex; /* 플렉스 박스 사용 */
        justify-content: center; /* 가운데 정렬 */
        padding: 20px 0; /* 위아래 패딩 */
        gap: 50px; /* 요소 간격 */
    }

    .stat {
        text-align: center; /* 텍스트 가운데 정렬 */
    }

    .stat h2 {
        font-size: 1.2em; /* 통계 제목 폰트 크기 */
        margin-bottom: 10px; /* 아래쪽 마진 */
    }

    .stat p {
        font-size: 1.5em; /* 통계 내용 폰트 크기 */
        margin: 0; /* 마진 없음 */
    }

    /* 리뷰 아이템 스타일 설정 */
    .review-item {
        border-bottom: 1px solid #ddd; /* 아래쪽 테두리 */
        padding-bottom: 10px; /* 아래쪽 패딩 */
        margin-bottom: 10px; /* 아래쪽 마진 */
    }

    .review-user {
        font-weight: bold; /* 글자 굵게 */
    }

    .review-date {
        color: #888; /* 날짜 색상 */
        font-size: 0.9em; /* 폰트 크기 */
    }

    .review-text {
        margin-top: 10px; /* 위쪽 마진 */
    }

    /* 필터 버튼 그룹 스타일 설정 */
    .filter-btn-group {
        margin-top: 20px; /* 위쪽 마진 */
        margin-bottom: 20px; /* 아래쪽 마진 */
    }

    .btn-review {
        display: inline-block; /* 인라인 블록 요소 */
        padding: 6px 12px; /* 패딩 설정 */
        cursor: pointer; /* 커서 포인터 설정 */
        border: 1px solid transparent; /* 투명 테두리 */
        border-radius: 4px; /* 둥근 테두리 */
        background-color: #007bff; /* 배경색 파란색 */
        color: white; /* 글자색 흰색 */
        text-align: center; /* 텍스트 가운데 정렬 */
    }

    .btn-review:hover {
        background-color: #0056b3; /* 호버 시 배경색 어두운 파란색 */
    }

    /* 메인 콘텐츠 스타일 설정 */
    .main-content {
        background-color: #fff; /* 배경색 흰색 */
        color: #000; /* 글자색 검정색 */
        padding: 20px; /* 패딩 설정 */
        padding-left: 300px; /* 왼쪽 패딩 추가 */
    }

    .btn-primary {
        display: block; /* 블록 요소 */
        margin: 20px auto 0; /* 위쪽 마진, 중앙 정렬 */
        font-size: 1.2em; /* 폰트 크기 */
        padding: 10px 20px; /* 패딩 설정 */
    }

    .nav-tabs {
        margin-left: 20px; /* 왼쪽 마진 */
    }

    .tab-content {
        padding: 20px; /* 패딩 설정 */
    }

    /* 페이지네이션 스타일 설정 */
    .pagination {
        display: flex; /* 플렉스 박스 사용 */
        justify-content: center; /* 가운데 정렬 */
        margin-top: 20px; /* 위쪽 마진 */
    }

    .pagination li {
        margin: 0 5px; /* 좌우 마진 */
    }

    .pagination a {
        color: #000; /* 링크 색상 */
        text-decoration: none; /* 밑줄 제거 */
        border: 1px solid #dee2e6; /* 테두리 설정 */
        padding: 5px 10px; /* 패딩 설정 */
        border-radius: 4px; /* 둥근 테두리 */
    }

    .pagination a:hover {
        background-color: #f1f1f1; /* 호버 시 배경색 */
    }

    .pagination .active a {
        background-color: #007bff; /* 활성화된 페이지 배경색 */
        color: white; /* 글자색 흰색 */
        border-color: #007bff; /* 테두리 색상 */
    }
    /* 별점 스타일 추가 */
    .star-rating {
        direction: rtl;
        display: inline-flex;
        font-size: 2rem;
    }
    .star-rating input {
        display: none;
    }
    .star-rating label {
        color: #ddd;
        cursor: pointer;
        padding: 0 0.1em;
    }
    .star-rating input:checked ~ label,
    .star-rating label:hover,
    .star-rating label:hover ~ label {
        color: #f5b301;
    }
    
</style>

</head>
<body>
    <%@ include file="/WEB-INF/header.jsp" %>

    <div class="header-background">
        <div class="container mt-4">
            <div class="movie-header">
                <div class="movie-info">
                    <h1>${title}</h1>
                    <p><strong>개봉일:</strong> ${releaseDate}</p>
                </div>
                <div class="movie-poster">
                    <img src="${posterUrl}" class="img-fluid" alt="${title}">
                    <a href="<c:url value='/reservation/movieBooking?id=${movieId}' />" class="btn btn-primary">예매</a>
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
                <p>${movieGrade}%</p>
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
                <a class="nav-link" id="main-info-tab" href="moviedetail?id=${movieId}" role="tab" aria-controls="main-info" aria-selected="false">주요정보</a>
            </li>
            <li class="nav-item" role="presentation">
                <a class="nav-link active" id="reviews-tab" href="comment?id=${movieId}" role="tab" aria-controls="reviews" aria-selected="true">실관람평</a>
            </li>
            <li class="nav-item" role="presentation">
                <a class="nav-link" id="trailer_url-tab" href="${pageContext.request.contextPath}/movie/trailer?id=${movieId}" role="tab" aria-controls="trailer_url" aria-selected="false">트레일러 URL</a>
            </li>
        </ul>

        <div class="tab-content mt-3" id="myTabContent">
            <div class="tab-pane fade show active" id="reviews" role="tabpanel" aria-labelledby="reviews-tab">
                <h2>실관람평</h2>

                <!-- 리뷰 작성 폼 항상 표시 -->
                <form id="reviewForm" action="${pageContext.request.contextPath}/review/insert" method="post" class="mt-3">
                    <input type="hidden" name="movie_id" value="${movieId}">
                    <input type="hidden" name="mem_id" value="${sessionScope.mem_id}">
                    <div class="mb-3">
                        <label for="reviewText" class="form-label">관람평 작성</label>
                        <textarea name="review_text" id="reviewText" class="form-control" rows="10"></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="rating" class="form-label">평점</label>
                        <div class="star-rating">
                            <input type="radio" id="5-stars" name="rating" value="5" />
                            <label for="5-stars" class="star">&#9733;</label>
                            <input type="radio" id="4-stars" name="rating" value="4" />
                            <label for="4-stars" class="star">&#9733;</label>
                            <input type="radio" id="3-stars" name="rating" value="3" />
                            <label for="3-stars" class="star">&#9733;</label>
                            <input type="radio" id="2-stars" name="rating" value="2" />
                            <label for="2-stars" class="star">&#9733;</label>
                            <input type="radio" id="1-stars" name="rating" value="1" />
                            <label for="1-stars" class="star">&#9733;</label>
                        </div>
                    </div>
                    <button type="button" class="btn btn-primary" onclick="checkLoginAndSubmit()">등록</button>
                </form>


                <p>총 ${reviewCount}건의 관람평이 있습니다.</p>
                <div class="filter-btn-group">
                    <a href="${pageContext.request.contextPath}/movie/comment?id=${movieId}&sort=date" class="btn btn-light">최신순</a>
                    <a href="${pageContext.request.contextPath}/movie/comment?id=${movieId}&sort=rating" class="btn btn-light">평점순</a>
                </div>

                <!-- 리뷰 리스트를 렌더링 -->
                <c:forEach var="review" items="${reviewList}">
                    <div class="review-item">
                        <div class="review-user">${review.mem_id} <span class="review-date">(${review.review_date})</span></div>
                        <div class="review-text">${review.review_text}</div>
                        <div class="review-rating">평점: ${review.rating}</div> <!-- 여기서 Rating을 평점으로 변경 -->
                        <c:if test="${review.mem_id == sessionScope.mem_id}">
                            <button class="btn btn-warning btn-sm" onclick="editReview('${review.review_id}', '${review.review_text}', ${review.rating}, '${review.review_date}')">수정</button>
                            <button class="btn btn-danger btn-sm" onclick="deleteReview('${review.review_id}', '${movieId}')">삭제</button>
                        </c:if>
                    </div>
                </c:forEach>

                <!-- 페이지네이션 -->
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/movie/comment?id=${movieId}&page=${currentPage - 1}">&laquo; 이전</a>
                            </li>
                        </c:if>
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/movie/comment?id=${movieId}&page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/movie/comment?id=${movieId}&page=${currentPage + 1}">다음 &raquo;</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>

            </div>
        </div>
    </div>

    <script>
        // 리뷰 삭제 함수
        function deleteReview(review_id, movie_id) {
            $.ajax({
                url: '${pageContext.request.contextPath}/review/delete',
                type: 'POST',
                data: {
                    review_id: review_id,
                    movie_id: movie_id
                },
                success: function(response) {
                    location.reload(); // 성공 시 페이지 새로고침
                },
                error: function(xhr, status, error) {
                    console.error('Failed to delete review:', error);
                    alert('리뷰 삭제에 실패했습니다.');
                }
            });
        }

     // 리뷰 수정 함수
        function editReview(review_id, review_text, rating, review_date) {
            document.getElementById("editReviewId").value = review_id;
            document.getElementById("editReviewText").value = review_text;
            document.getElementById("editReviewDate").value = review_date;
            document.getElementById("editMovieId").value = '${movieId}';
            
            // 평점 설정
            const ratingInputs = document.getElementsByName("rating");
            ratingInputs.forEach(input => {
                if (input.value == rating) {
                    input.checked = true;
                }
            });

            $('#editReviewModal').modal('show');
        }

        // 로그인 확인 후 폼 제출 함수
        function checkLoginAndSubmit() {
            var mem_id = '${sessionScope.mem_id}';
            if (!mem_id) {
                $('#loginModal').modal('show'); // 로그인 모달 표시
            } else {
                document.getElementById('reviewForm').submit(); // 폼 제출
            }
        }
    </script>

    <%@ include file="/WEB-INF/footer.jsp" %>

    <!-- 수정 모달 -->
    <div id="editReviewModal" class="modal fade" tabindex="-1" aria-labelledby="editReviewModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editReviewModalLabel">리뷰 수정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editReviewForm" action="${pageContext.request.contextPath}/review/update" method="post">
                        <input type="hidden" name="review_id" id="editReviewId">
                        <input type="hidden" name="movie_id" id="editMovieId">
                        <input type="hidden" name="review_date" id="editReviewDate">
                        <div class="mb-3">
                            <label for="editReviewText" class="form-label">관람평 수정</label>
                            <textarea name="review_text" id="editReviewText" class="form-control" rows="10"></textarea>
                        </div>
                        <div class="mb-3">
						    <label for="editrating" class="form-label">평점</label>
						    <div class="star-rating">
						        <input type="radio" id="edit-5-stars" name="rating" value="5" />
						        <label for="edit-5-stars" class="star">&#9733;</label>
						        <input type="radio" id="edit-4-stars" name="rating" value="4" />
						        <label for="edit-4-stars" class="star">&#9733;</label>
						        <input type="radio" id="edit-3-stars" name="rating" value="3" />
						        <label for="edit-3-stars" class="star">&#9733;</label>
						        <input type="radio" id="edit-2-stars" name="rating" value="2" />
						        <label for="edit-2-stars" class="star">&#9733;</label>
						        <input type="radio" id="edit-1-stars" name="rating" value="1" />
						        <label for="edit-1-stars" class="star">&#9733;</label>
                        </div>
                        <button type="submit" class="btn btn-primary">수정</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
