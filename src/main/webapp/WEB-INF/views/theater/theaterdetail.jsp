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
        .header-background {
            background: rgb(2,0,36);
            background: linear-gradient(90deg, rgba(2,0,36,1) 30%, rgba(84,84,94,1) 52%, rgba(0,10,10,1) 75%);
            color: #fff;
            padding: 20px;
        }

        .theater-header {
            text-align: center;
            padding: 20px;
            color: #fff;
        }

        .theater-header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }

        .theater-info {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .theater-info p {
            font-size: 1.2em;
            margin-bottom: 10px;
        }

        .tabs-container {
            margin-top: 20px;
        }

        .nav-tabs {
            justify-content: center;
            margin-bottom: 20px;
        }

        .tab-content {
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 10px;
        }

        .facility-icon {
            display: inline-block;
            margin-right: 15px;
            text-align: center;
        }

        .facility-icon img {
            width: 50px;
            height: 50px;
        }

        .facility-icon span {
            display: block;
            margin-top: 5px;
        }

        .section-title {
            font-weight: bold;
            color: #6a1b9a;
            margin-bottom: 10px;
        }

        .facility-list {
            list-style: none;
            padding-left: 0;
        }

        .facility-list li {
            margin-bottom: 5px;
        }

        .facility-list li::before {
            content: "•";
            color: #6a1b9a;
            font-weight: bold;
            display: inline-block;
            width: 1em;
            margin-left: -1em;
        }

        .map-link {
            display: block;
            margin-top: 20px;
            text-align: center;
            color: #6a1b9a;
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
                            <div class="section-title">극장정보</div>
                            <p>${info.infoContent}</p>
                        </c:if>
                        <c:if test="${info.infoType == '시설안내'}">
                            <div class="section-title">시설안내</div>
                            <p>${info.infoContent}</p>
                        </c:if>
                        <c:if test="${info.infoType == '교통안내'}">
                            <div class="section-title">교통안내</div>
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
