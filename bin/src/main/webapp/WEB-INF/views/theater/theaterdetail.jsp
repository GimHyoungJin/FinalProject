<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>극장 상세 정보</title>
    <meta charset="utf-8">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
    <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
    <style>
        /* 헤더 배경 스타일 설정 */
        .header-background {
            background: rgb(2,0,36); /* 백업용 배경색 */
            background: linear-gradient(90deg, rgba(2,0,36,1) 30%, rgba(84,84,94,1) 52%, rgba(0,10,10,1) 75%); /* 그라데이션 배경 */
            color: #fff; /* 글자 색상 흰색 */
            padding: 20px; /* 모든 방향 패딩 */
        }

        /* 극장 헤더 스타일 설정 */
        .theater-header {
            text-align: center; /* 텍스트 가운데 정렬 */
            padding: 20px; /* 모든 방향 패딩 */
            color: #fff; /* 글자 색상 흰색 */
        }

        .theater-header h1 {
            font-size: 2.5em; /* 제목 폰트 크기 설정 */
            margin-bottom: 10px; /* 아래쪽 마진 */
        }

        /* 극장 정보 스타일 설정 */
        .theater-info {
            background-color: #fff; /* 배경색 흰색 */
            padding: 20px; /* 모든 방향 패딩 */
            border-radius: 10px; /* 둥근 테두리 */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
        }

        .theater-info p {
            font-size: 1.2em; /* 문단 폰트 크기 설정 */
            margin-bottom: 10px; /* 아래쪽 마진 */
        }

        /* 탭 컨테이너 스타일 설정 */
        .tabs-container {
            margin-top: 20px; /* 위쪽 마진 */
        }

        .nav-tabs {
            justify-content: center; /* 탭을 가운데 정렬 */
            margin-bottom: 20px; /* 아래쪽 마진 */
        }

        .tab-content {
            padding: 20px; /* 모든 방향 패딩 */
            background-color: #f9f9f9; /* 배경색 밝은 회색 */
            border-radius: 10px; /* 둥근 테두리 */
        }

        /* 시설 아이콘 스타일 설정 */
        .facility-icon {
            display: inline-block; /* 인라인 블록 요소 */
            margin-right: 15px; /* 오른쪽 마진 */
            text-align: center; /* 텍스트 가운데 정렬 */
        }

        .facility-icon img {
            width: 50px; /* 너비 설정 */
            height: 50px; /* 높이 설정 */
        }

        .facility-icon span {
            display: block; /* 블록 요소 */
            margin-top: 5px; /* 위쪽 마진 */
        }

        /* 섹션 제목 스타일 설정 */
        .section-title {
            font-weight: bold; /* 글자 굵게 */
            color: #6a1b9a; /* 글자 색상 */
            margin-bottom: 10px; /* 아래쪽 마진 */
        }

        /* 시설 목록 스타일 설정 */
        .facility-list {
            list-style: none; /* 리스트 스타일 없음 */
            padding-left: 0; /* 왼쪽 패딩 없음 */
        }

        .facility-list li {
            margin-bottom: 5px; /* 아래쪽 마진 */
        }

        .facility-list li::before {
            content: "•"; /* 리스트 아이템 앞에 점 추가 */
            color: #6a1b9a; /* 점 색상 */
            font-weight: bold; /* 점 굵게 */
            display: inline-block; /* 인라인 블록 요소 */
            width: 1em; /* 너비 설정 */
            margin-left: -1em; /* 왼쪽 마진 */
        }

        /* 지도 링크 스타일 설정 */
        .map-link {
            display: block; /* 블록 요소 */
            margin-top: 20px; /* 위쪽 마진 */
            text-align: center; /* 텍스트 가운데 정렬 */
            color: #6a1b9a; /* 링크 색상 */
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/header.jsp" %>

    <div class="header-background">
        <div class="theater-header">
            <h1>${theater.theater_name}</h1>
            <p>주소: ${theater.address}</p>
        </div>
    </div>

    <div class="container tabs-container">
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="info-tab" data-bs-toggle="tab" data-bs-target="#info" type="button" role="tab" aria-controls="info" aria-selected="true">극장정보</button>
            </li>
        </ul>
        <div class="tab-content" id="myTabContent">
            <div class="tab-pane fade show active" id="info" role="tabpanel" aria-labelledby="info-tab">
                <div class="theater-info">
                    <!-- 극장 정보 목록 -->
                    <c:forEach var="info" items="${theaterInfoList}">
                        <c:if test="${info.infoType == '극장정보'}">
                            <p>${info.infoContent}</p>
                        </c:if>
                        <c:if test="${info.infoType == '시설안내'}">
                            <h3>시설안내</h3>
                            <p>${info.infoContent}</p>
                        </c:if>
                        <c:if test="${info.infoType == '교통안내'}">
                            <h3>교통안내</h3>
                            <p>${info.infoContent}</p>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/footer.jsp" %>
</body>
</html>
