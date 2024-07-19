<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
   
<!-- 사이드바 시작 -->
<div id="sidebar">
    <!-- 사이드바 상단: 고객센터 제목 -->
    <div id="sidebar-top">
        <h2>고객센터</h2> <!-- 고객센터 제목 -->
    </div>
    
    <!-- 사이드바 메뉴 항목 리스트 -->
    <ul id="sidebar-menu">
        <!-- 홈 메뉴 아이템 -->
        <li class="sidebar-item">
            <a href="<c:url value='/customer/home' />" class="${fn:endsWith(pageContext.request.requestURI, '/customer/home') ? 'active' : ''}">
                <!-- 홈 아이콘 이미지 -->
                <div class="front">
                    <img src="<c:url value='/images/logo/home.png' />" alt="홈 아이콘">
                </div>
                <div class="back">
                    HOME
                </div>
            </a>
        </li>
        
        <!-- 공지사항 메뉴 아이템 -->
        <li class="sidebar-item">
            <a href="<c:url value='/customer/noticeList' />" class="${fn:endsWith(pageContext.request.requestURI, '/customer/notice') ? 'active' : ''}">
                <!-- 공지사항 아이콘 이미지 -->
                <div class="front">
                    <img src="<c:url value='/images/logo/notice.png' />" alt="공지사항 아이콘">
                </div>
                <div class="back">
                    NOTICE
                </div>
            </a>
        </li>
        
        <!-- 1:1문의 메뉴 아이템 -->
        <li class="sidebar-item">
            <a href="<c:url value='/customer/inquiryList' />" class="${fn:endsWith(pageContext.request.requestURI, '/customer/inquiryForm') ? 'active' : ''}">
                <!-- 1:1문의 아이콘 이미지 -->
                <div class="front">
                    <img src="<c:url value='/images/logo/inquiry.png' />" alt="1:1문의 아이콘">
                </div>
                <div class="back">
                    INQUIRY
                </div>
            </a>
        </li>
        
        <!-- 분실물 문의 메뉴 아이템 -->
        <li class="sidebar-item">
            <a href="<c:url value='/customer/lostItemList' />" class="${fn:endsWith(pageContext.request.requestURI, '/customer/lostItemList') ? 'active' : ''}">
                <!-- 분실물 문의 아이콘 이미지 -->
                <div class="front">
                    <img src="<c:url value='/images/logo/lostitem.png' />" alt="분실물 문의 아이콘">
                </div>
                <div class="back">
                    LOST ITEM
                </div>
            </a>
        </li>
        
        <!-- 이용 약관 메뉴 아이템 -->
        <li class="sidebar-item">
            <a href="<c:url value='/customer/terms' />" class="${fn:endsWith(pageContext.request.requestURI, '/customer/terms') ? 'active' : ''}">
                <!-- 이용 약관 아이콘 이미지 -->
                <div class="front">
                    <img src="<c:url value='/images/logo/terms.png' />" alt="이용 약관 아이콘">
                </div>
                <div class="back">
                    TERMS
                </div>
            </a>
        </li>
    </ul>
    
    <!-- 고객센터 정보 -->
    <div class="center-info">
        <p>무비오 고객센터</p> <!-- 고객센터 이름 -->
        <p>Movio Center</p> <!-- 고객센터 영어 이름 -->
        <p>⏰ 10:00~19:00</p> <!-- 고객센터 운영 시간 -->
    </div>
</div>
<!-- 사이드바 끝 -->
