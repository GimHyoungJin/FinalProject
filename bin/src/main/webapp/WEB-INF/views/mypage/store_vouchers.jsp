<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>스토어 교환권</title>
  <meta charset="utf-8">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/admin/sidebar.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/style.css' />" rel="stylesheet" type="text/css">
  <style>
    .mypage-container {
      margin-top: 20px;
    }
    .content-wrapper {
      background-color: #fff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    .card {
      margin-top: 20px;
    }
  </style>
</head>
<body>
  <%@ include file="/WEB-INF/header.jsp" %>

  <div class="container-fluid mypage-container">
    <div class="row">
      <div class="col-md-3 sidebar">
        <div class="list-group">
          <a href="<c:url value='/mypage/mypage' />" class="list-group-item header" aria-current="true">
            나의 무비오
          </a>
        <a href="<c:url value='/mypage/bookinglist' />" class="list-group-item list-group-item-action">예매 내역</a>
          <a href="<c:url value='/mypage/vouchers' />" class="list-group-item list-group-item-action">영화 관람권</a>
          <a href="<c:url value='/mypage/store_vouchers' />" class="list-group-item list-group-item-action">스토어 교환권</a>
          <a href="<c:url value='/mypage/inquiry' />" class="list-group-item list-group-item-action">나의 문의내역</a>
          <a href="<c:url value='/mypage/profile' />" class="list-group-item list-group-item-action">회원정보</a>
        </div>
      </div>

      <!-- 메인 콘텐츠 시작 -->
      <div class="col-md-9">
        <div class="content-wrapper">
          <h2>스토어 교환권</h2>
          <p>보유하신 스토어 교환권 내역입니다. 소지하신 교환권은 등록 후 이용하실 수 있습니다.</p>
          <button type="button" class="btn btn-primary" onclick="openVoucherModal()">교환권 등록</button>
          <div class="card mt-3">
            <div class="card-body">
              <table class="table table-bordered">
                <thead>
                  <tr>
                    <th>교환권명</th>
                    <th>유효기간</th>
                    <th>사용상태</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td colspan="3">조회된 교환권 내역이 없습니다.</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <!-- 교환권 등록 모달 -->
          <div class="modal fade" id="voucherModal" tabindex="-1" aria-labelledby="voucherModalLabel" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="voucherModalLabel">스토어 교환권 등록</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <form id="voucherForm" method="post" action="<c:url value='/mypage/store_vouchers/register' />">
                    <div class="form-group">
                      <label for="voucherNumber">스토어 교환권 번호</label>
                      <input type="text" class="form-control" id="voucherNumber" name="voucherNumber" required>
                    </div>
                    <p class="mt-3">- 보유하신 스토어 교환권 18자리를 입력해주세요.<br>
                      - 교환권 등록 후 결제가 취소될 경우 자동 회수처리 되어 사용하실 수 없습니다.<br></p>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                      <button type="submit" class="btn btn-primary">등록</button>
                    </div>
                  </form>
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
                                  <a id="find-id-pw-link" href="<c:url value='/member/findIdPw' />">ID/PW 찾기</a> | <a id="register-link-modal" href="<c:url value='/member/agreement' />">회원가입</a>
                              </div>
                              <div class="login-buttons mt-3">
                                  <a href="javascript:void(0)" id="kakaobtn"><img src="<c:url value='/images/logo/kakao_login.png' />" alt="카카오 로그인"></a>
                                  <!-- 클라이언트 아이디,  google 콜백 url -->                            
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

          <c:if test="${not empty error}">
            <div class="alert alert-danger mt-3">${error}</div>
          </c:if>

          <c:if test="${not empty message}">
            <div class="alert alert-success mt-3">${message}</div>
          </c:if>
          
        </div>
      </div>
    </div>
  </div>
  <%@ include file="/WEB-INF/footer.jsp" %>

  <script>
    function checkLoginStatus(callback) {
        $.ajax({
            url: '<c:url value="/member/status" />',
            method: 'GET',
            success: function(response) {
                if (response.loggedIn) {
                    callback(true);
                } else {
                    callback(false);
                }
            },
            error: function() {
                callback(false);
            }
        });
    }

    function openVoucherModal() {
        checkLoginStatus(function(loggedIn) {
            if (loggedIn) {
                $('#voucherModal').modal('show');
            } else {
                $('#loginModal').modal('show');
            }
        });
    }

    function submitLoginForm() {
        var loginData = {
            mem_id: $('#mem_id').val(),
            passwd: $('#passwd').val()
        };
        
        $.ajax({
            url: '<c:url value="/member/login" />',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(loginData),
            success: function(response) {
                if (response.success) {
                    $('#loginModal').modal('hide');
                    alert('로그인 성공');
                    $('#voucherModal').modal('show');
                } else {
                    alert('로그인 실패: ' + response.message);
                }
            },
            error: function() {
                alert('로그인 요청 중 오류가 발생했습니다.');
            }
        });
    }

    document.getElementById("voucherForm").addEventListener("submit", function(event) {
        var voucherNumber = document.getElementById("voucherNumber").value;
        if (!/^\d{18}$/.test(voucherNumber)) {
            event.preventDefault();
            alert("유효하지 않은 번호입니다. 18자리 숫자를 입력하세요.");
        }
    });
  </script>
</body>
</html>
