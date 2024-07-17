<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 상단 헤더 -->
<header id="header" class="bg-light py-0 border-bottom header-hidden">
    <div class="container-fluid d-flex justify-content-end">
        <nav class="navbar navbar-expand">
            <ul class="navbar-nav">
            	<div id="admin-button-container" style="display: none;">
            	<li class="nav-item">
                    <a id="admin-link" href="<c:url value='/admin/members' />" class="nav-link small custom-small-font">관리자페이지</a>
                </li>
                </div>
                <li class="nav-item">
                    <a id="login-link" class="nav-link small custom-small-font" href="#" data-bs-toggle="modal" data-bs-target="#loginModal">로그인</a>
                </li>
                <li class="nav-item">
                    <a id="register-link" class="nav-link small custom-small-font" href="<c:url value='/member/agreement' />">회원가입</a>
                </li>
                <li class="nav-item">
                    <a id="quick-reserve-link" class="nav-link small custom-small-font" href="<c:url value='/reservation/booking' />" onclick="checkLogin(event)">예매</a>
                </li>
                <li class="nav-item">
                    <a id="support-link" class="nav-link small custom-small-font" href="<c:url value='/customer/home' />">고객센터</a>
                </li>
            </ul>
        </nav>
    </div>   
    <div>
        <!-- 네비게이션 바 -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <button class="navbar-toggler d-block" type="button" data-bs-toggle="modal" data-bs-target="#menuModal" aria-controls="menuModal" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-center">
                    <ul id="nav-bar" class="navbar-nav custom-navbar-nav">
                        <li class="nav-item">
                            <a id="movies-link" class="nav-link custom-large-font" href="<c:url value='/movie/movielist'/>">영화</a>
                        </li>
                        <li class="nav-item">
                            <a id="reserve-link" class="nav-link custom-large-font" href="<c:url value='/reservation/booking' />" onclick="checkLogin(event)">예매</a>
                        </li>
                        <li class="nav-item logo-item">
                            <a class="navbar-brand" href="<c:url value='/' />">
                                <img id="logo-image" src="<c:url value='/images/logo/movio logo.png' />" alt="Movio" width="50">
                            </a>
                        </li>
                        <li class="nav-item">
                            <a id="theaters-link" class="nav-link custom-large-font" href="<c:url value='/theater/list' />">극장</a>
                        </li>
                        <li class="nav-item">
                            <a id="store-link" class="nav-link custom-large-font" href="<c:url value='/product/list' />">스토어</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>
</header>

<!-- 메뉴 모달 창 -->
<div class="modal fade" id="menuModal" tabindex="-1" aria-labelledby="menuModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content menu-modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="menuModalLabel">메뉴</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div id="movies-column" class="col-md-3">
                            <h6>영화</h6>
                            <ul class="list-unstyled">
                                <li><a id="all-movies-link" href="<c:url value='/movie/movielist' />">전체영화</a></li>
                            </ul>
                        </div>
                        <div id="reserve-column" class="col-md-3">
                            <h6>예매</h6>
                            <ul class="list-unstyled">
                                <li><a id="quick-reserve-modal-link" href="<c:url value='/reservation/booking' />" onclick="checkLogin(event)">빠른 예매</a></li>
                            </ul>
                        </div>
                        <div id="theaters-column" class="col-md-3">
                            <h6>극장</h6>
                            <ul class="list-unstyled">
                                <li><a id="all-theaters-link" href="<c:url value='/theater/list' />">극장</a></li>
                            </ul>
                        </div>
                        <div id="store-column" class="col-md-3">
                            <h6>스토어</h6>
                            <ul class="list-unstyled">
                                <li><a id="store-items-link" href="<c:url value='/product/list' />">스토어</a></li>
                            </ul>
                        </div>
                        <div id="benefits-column" class="col-md-3">
                            <h6>혜택</h6>
                            <ul class="list-unstyled">
                                <li><a id="membership-info-link" href="<c:url value='/membership/info' />">멤버십 안내</a></li>
                            </ul>
                        </div>
                        <div id="support-column" class="col-md-3">
                            <h6>고객센터</h6>
                            <ul class="list-unstyled">
                                <li><a id="support-home-link" href="<c:url value='/customer/home' />">고객센터 홈</a></li>
                                <li><a id="lost-items-link" href="<c:url value='/customer/lostItemList' />">분실물 문의</a></li>
                                <li><a id="notices-link" href="<c:url value='/customer/noticeList' />">공지사항</a></li>
                                <li><a id="inquiry-link" href="<c:url value='/customer/inquiryForm' />">1:1문의</a></li>
                                <li><a id="inquiry-link" href="<c:url value='/customer/terms' />">이용약관</a></li>
                                <!-- 관리자 페이지 링크 (관리자 등급 사용자만) -->
                                <div id="admin-button-container" style="display: none;">
                                    <li class="nav-item">
                                        <a id="admin-link" href="<c:url value='/admin/members' />" class="nav-link small custom-small-font">관리자 페이지</a>
                                    </li>
                               	</div>
                            </ul>
                        </div>
                        <div id="mypage-column" class="col-md-3">
                          <h6>MyPage</h6>
                          <ul class="list-unstyled">
                              <li><a id="mypage-home-link" href="<c:url value='/mypage/mypage' />" onclick="checkLogin(event)">나의 무비오</a></li>
                              <li><a id="bookinglist-link" href="<c:url value='/mypage/bookinglist' />" onclick="checkLogin(event)">예매/구매내역</a></li>
                              <li><a id="vouchers-link" href="<c:url value='/mypage/vouchers' />" onclick="checkLogin(event)">영화관람권</a></li>
                              <li><a id="store-vouchers-link" href="<c:url value='/mypage/store_vouchers' />" onclick="checkLogin(event)">스토어교환권</a></li>
                              <li><a id="my-inquiries-link" href="<c:url value='/mypage/inquiry' />" onclick="checkLogin(event)">나의문의내역</a></li>
                              <li><a id="profile-link" href="<c:url value='/mypage/profile' />" onclick="checkLogin(event)">회원정보</a></li>
                          </ul>
                      </div>
                    </div>
                    <div class="row mt-4 justify-content-center">
                        <div id="login-buttons" class="col-md-4 text-center">
                            <button id="modal-login-button" class="btn btn-primary w-150" onclick="showLoginModal()">로그인</button>
                            <p class="text-center mt-2 mb-2">로그인 후 다양한 혜택을 <br> 확인하세요.</p>
                            <button id="modal-register-button" class="btn btn-outline-primary w-150" onclick="window.location.href='<c:url value='/member/agreement' />'">회원가입</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 로그인 모달 창 -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content login-modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="loginModalLabel">로그인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="login-form" class="login-form">
                    <form id="loginForm">
                        <div class="mb-3">
                            <label for="mem_id" class="form-label">아이디</label>
                            <input type="text" class="form-control" id="mem_id" name="mem_id" required>
                        </div>
                        <div class="mb-3">
                            <label for="passwd" class="form-label">비밀번호</label>
                            <input type="password" class="form-control" id="passwd" name="passwd" required>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                            <label class="form-check-label" for="rememberMe">아이디 저장</label>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary" onclick="submitLoginForm(); return false;">로그인</button>
                        </div>
                    </form>
                    <div class="text-center mt-3">
                        <a id="find-id-pw-link" href="<c:url value='/member/findIdPw' />">ID/PW찾기</a> | <a id="register-link-modal" href="<c:url value='/member/agreement' />">회원가입</a>
                    </div>
                    <div class="login-buttons mt-3">
                        <a href="javascript:void(0)" id="kakaobtn"><img src="<c:url value='/images/logo/kakao_login.png' />" alt="카카오 로그인"></a>
                        <div id="g_id_onload"
                             data-client_id="1051773193513-6ue0j504qgi80d191t7si0bpoahig155.apps.googleusercontent.com"
                             data-login_uri="http://localhost:8080/member/googleLogin"
                             data-auto_prompt="false">
                        </div>
                        <div class="g_id_signin"
                             data-type="standard"
                             data-size="large"
                             data-theme="outline"
                             data-text="sign_in_with"
                             data-shape="rectangular"
                             data-logo_alignment="left">
                        </div>
                    </div>
                </div>
                <div id="poster-wrapper" class="poster-wrapper">
                    <img id="posterImage" src="<c:url value='/images/poster/우마무스메.png' />" alt="포스터 이미지">
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://accounts.google.com/gsi/client" async></script>
<script src="<c:url value='/js/header.js'/>"></script>
