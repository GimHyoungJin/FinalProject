<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>상영관 관리</title>
    <meta charset="utf-8">
    <!-- 공통 리소스 -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
    <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
    <link href="<c:url value='/css/admin/sidebar.css' />" rel="stylesheet" type="text/css">
    <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
</head>
<body>
    <%@ include file="../../header.jsp"%>
    <!-- 메인 콘텐츠 시작 -->
    <div class="container-fluid">
        <div class="row">
            <!-- 사이드바 -->
            <div class="col-md-3 sidebar">
                <div class="list-group">
                    <div class="list-group-item header" aria-current="true">관리자 페이지</div>
                    <a href="<c:url value='/admin/members' />" class="list-group-item list-group-item-action">회원 관리</a>
                    <a href="<c:url value='/admin/movie' />" class="list-group-item list-group-item-action">영화 관리</a>
                    <a href="<c:url value='/admin/theater' />" class="list-group-item list-group-item-action">영화관 관리</a>
                </div>
            </div>
            <!-- 메인 콘텐츠 -->
            <div class="col-md-9 main-content">
                <h1>영화관 관리</h1>
                <div class="card">
                    <div class="card-body">
                        <!-- 영화관 추가 폼 -->
                        <form action="<c:url value='/admin/theater/add' />" method="post">
                        
                         <div class="mb-3">
        						<label for="theaterId" class="form-label">상영관 ID</label>
        						<input type="text" class="form-control" id="theaterId" name="theaterId" value="${param.theaterId}" required>
    					</div>
                            <div class="mb-3">
                                <label for="theaterName" class="form-label">상영관 이름</label>
                                <input type="text" class="form-control" id="theaterName" name="theaterName" value="${param.theaterName}" required>
                            </div>
                           <div class="mb-3">
   
    <label for="regionId" class="form-label">지역</label>
    <select class="form-select" id="regionId" name="regionId" required>
        <option value="">지역 선택</option>
        <option value="seoul" <c:if test="${param.regionId == 'seoul'}">selected</c:if>>서울</option>
        <option value="busan_daegu" <c:if test="${param.regionId == 'busan_daegu'}">selected</c:if>>부산/대구</option>
        <option value="daejeon_chungcheong" <c:if test="${param.regionId == 'daejeon_chungcheong'}">selected</c:if>>대전/충청</option>
        <option value="gangwon" <c:if test="${param.regionId == 'gangwon'}">selected</c:if>>강원</option>
        <option value="gwangju_jeolla" <c:if test="${param.regionId == 'gwangju_jeolla'}">selected</c:if>>광주/전라</option>
        <option value="gyeonggi" <c:if test="${param.regionId == 'gyeonggi'}">selected</c:if>>경기</option>
        <option value="incheon" <c:if test="${param.regionId == 'incheon'}">selected</c:if>>인천</option>
    </select>
</div>

                            <div class="mb-3">
                                <label for="address" class="form-label">주소</label>
                                <input type="text" class="form-control" id="address" name="address" value="${param.address}" required>
                            </div>
                            <div class="mb-3">
                                <label for="theatersNum" class="form-label">상영관 수</label>
                                <input type="number" class="form-control" id="theatersNum" name="theatersNum" value="${param.theatersNum}" required>
                            </div>
                            <div class="mb-3">
                                <label for="totalSeats" class="form-label">좌석 수</label>
                                <input type="number" class="form-control" id="totalSeats" name="totalSeats" value="${param.totalSeats}" required>
                            </div>
                            <div class="mb-3">
                                <label for="latitude" class="form-label">위도</label>
                                <input type="number" step="0.000001" class="form-control" id="latitude" name="latitude" value="${param.latitude}" required>
                            </div>
                            <div class="mb-3">
                                <label for="longitude" class="form-label">경도</label>
                                <input type="number" step="0.000001" class="form-control" id="longitude" name="longitude" value="${param.longitude}" required>
                            </div>
                            <button type="submit" class="btn btn-dark">추가</button>
                        </form>
                    </div>
                </div>
                <br>
                <!-- 영화관 목록 -->
                <h3 class="card-title">영화관 목록</h3>
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>지역</th>
                                <th>영화관 명</th>
                                <th>주소</th>
                                <th>상영관수</th>
                                <th>좌석수</th>
                                <th>위도</th>
                                <th>경도</th>
                                <th>삭제</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="theater" items="${theaters}">
                                <tr>
                                    <td>${theater.theater_id}</td>
                                    <td>${theater.region_id}</td>
                                    <td>${theater.theater_name}</td>
                                    <td>${theater.address}</td>
                                    <td>${theater.theaters_num}</td>
                                    <td>${theater.total_seats}</td>
                                    <td>${theater.latitude}</td>
                                    <td>${theater.longitude}</td>
                                    <td>
                                        <form action="<c:url value='/admin/theater/delete' />" method="post">
                                            <input type="hidden" name="theaterId" value="${theater.theater_id}">
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
    <!-- 메인 콘텐츠 끝 -->
    <%@ include file="../../footer.jsp"%>
</body>
</html>
