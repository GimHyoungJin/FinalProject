<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>스토어 교환권</title>
  <meta charset="utf-8">
  <!-- 공통 시작 -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/admin/sidebar.css' />" rel="stylesheet" type="text/css">
  <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
  <!-- 공통 끝 -->
  <style>
    .mypage-container {
      display: flex;
    }
    .sidebar {
      flex: 0 0 25%;
    }
    .content {
      flex: 1;
      padding-left: 20px;
    }
    .content-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .btn-small {
      font-size: 0.875rem;
      padding: 0.25rem 0.5rem;
    }
    .button-container {
      text-align: right;
    }
    .modal-body .instructions-title {
      font-weight: bold;
    }
    .modal-body .instructions-text {
      font-size: 0.875rem; /* 글자 크기 줄이기 */
    }
    .table {
      width: 100%;
      margin-top: 1rem;
    }
    .table th, .table td {
      text-align: center;
    }
    .dropdown-menu {
      min-width: auto;
    }
  </style>
</head>
<body>
  <%@ include file="/WEB-INF/header.jsp" %>
  <!-- 메인 콘텐츠 시작 -->

  <div class="container-fluid mypage-container">
    <div class="row w-100">
      <div class="col-md-3 sidebar">
        <div class="list-group">
          <a href="<c:url value='/mypage/mypage' />" class="list-group-item header" aria-current="true">
            나의 무비오
          </a>
          <a href="<c:url value='/mypage/bookinglist' />" class="list-group-item list-group-item-action">예매/구매 내역</a>
          <a href="<c:url value='/mypage/inquiry' />" class="list-group-item list-group-item-action">나의 문의내역</a>
          <a href="<c:url value='/mypage/profile' />" class="list-group-item list-group-item-action">회원정보</a>
          <a href="<c:url value='/mypage/store_vouchers' />" class="list-group-item list-group-item-action">스토어 교환권</a>
        </div>
      </div>
      <div class="col-md-9">
        <div class="container mt-5">
          <div class="content-header">
            <h2>스토어 교환권</h2>
            <div class="button-container">
              <button class="btn btn-outline-primary btn-small" data-bs-toggle="modal" data-bs-target="#voucherModal">스토어 교환권 등록</button>
            </div>
          </div>
          <p>보유하신 스토어교환권 내역입니다.</p>
          <p>소지하신 스토어교환권은 등록 후 이용하실 수 있습니다.</p>
          <div class="card mt-3">
            <div class="card-body">
              <h5 class="card-title">스토어 교환권</h5>
              <div class="d-flex justify-content-between align-items-center mb-2">
                <span>전체 0건</span>
                <div class="dropdown">
                  <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="statusDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    사용가능
                  </button>
                  <ul class="dropdown-menu" aria-labelledby="statusDropdown">
                    <li><a class="dropdown-item" href="#">사용가능</a></li>
                    <li><a class="dropdown-item" href="#">사용완료</a></li>
                    <li><a class="dropdown-item" href="#">기간만료</a></li>
                    <li><a class="dropdown-item" href="#">취소환불</a></li>
                  </ul>
                </div>
              </div>
              <div id="voucherList">
                <table class="table">
                  <thead>
                    <tr>
                      <th>구분</th>
                      <th>교환권명</th>
                      <th>유효기간</th>
                      <th>사용상태</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:if test="${not empty vouchers}">
                      <c:forEach var="voucher" items="${vouchers}">
                        <tr>
                          <td>${voucher.category}</td>
                          <td>${voucher.voucherName}</td>
                          <td>${voucher.expirationDate}</td>
                          <td>${voucher.status}</td>
                        </tr>
                      </c:forEach>
                    </c:if>
                    <c:if test="${empty vouchers}">
                      <tr>
                        <td colspan="4">등록된 교환권이 없습니다.</td>
                      </tr>
                    </c:if>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- 모달 시작 -->
  <div class="modal fade" id="voucherModal" tabindex="-1" aria-labelledby="voucherModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="voucherModalLabel">스토어 교환권 등록</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
		  <p>보유하신 스토어 교환권 18자리를 입력해주세요.</p>
		  <div class="mb-3">
		    <label for="voucherInput" class="form-label">스토어 교환권</label>
		    <input type="text" class="form-control" id="voucherInput" placeholder="숫자만 입력해 주세요">
		  </div>
		   <div class="mb-3">
   
    <label for="categoryId" class="form-label">카테고리</label>
    <select class="form-select" id="areaId" name="categoryId" required>
        <option value="">카테고리 선택</option>
        <option value="drink" <c:if test="${param.categoryId == 'drink'}">selected</c:if>>음료</option>
        <option value="package" <c:if test="${param.categoryId == 'package'}">selected</c:if>>세트</option>
         <option value="snack" <c:if test="${param.categoryId == 'snack'}">selected</c:if>>팝콘</option>
          <option value="ticket" <c:if test="${param.categoryId == 'ticket'}">selected</c:if>>관람권</option>
    </select>
</div>
		  <div class="mb-3">
		    <label for="voucherNameInput" class="form-label">교환권명</label>
		    <input type="text" class="form-control" id="voucherNameInput" placeholder="교환권명을 입력해 주세요">
		  </div>
		  <button type="button" class="btn btn-primary" id="registerVoucherBtn">등록</button>
		  <div class="mt-3">
		    <h6 class="instructions-title">이용안내</h6>
		    <p class="instructions-text">무비오 스토어에서 구매 또는 선물받은 스토어교환권을 등록하실 수 있습니다.</p>
		    <p class="instructions-text">선물받은 교환권은 등록 후 결제가 취소될 경우 자동 회수처리 되어 사용하실 수 없습니다.</p>
		  </div>
		</div>

        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>
  <!-- 모달 끝 -->

  <!-- 메인 콘텐츠 끝 -->
  <%@ include file="/WEB-INF/footer.jsp" %>

	  <!-- JavaScript 추가 -->
	  <script>
$(document).ready(function() {
    $('#registerVoucherBtn').click(function() {
        var voucherCode = $('#voucherInput').val().trim();
        var category = $('#categoryInput').val().trim();
        var voucherName = $('#voucherNameInput').val().trim();

        // 입력 값을 콘솔에 출력
        console.log("Voucher Code: " + voucherCode);
        console.log("Category: " + category);
        console.log("Voucher Name: " + voucherName);

        if (voucherCode.length === 18 && !isNaN(voucherCode) && category && voucherName) {
            $.ajax({
                url: '<c:url value="/mypage/store_vouchers/register" />',
                type: 'POST',
                data: {
                    voucherNumber: voucherCode,
                    category: category,
                    voucherName: voucherName
                },
                success: function(response) {
                    if (response.success) {
                        $('#voucherList').html(response.voucherListHtml);
                        $('#voucherModal').modal('hide');
                        alert('스토어 교환권이 등록되었습니다.');
                    } else {
                        alert('교환권 등록에 실패했습니다: ' + response.message);
                    }
                },
                error: function() {
                    alert('서버 오류가 발생했습니다. 나중에 다시 시도해주세요.');
                }
            });
        } else {
            alert('모든 필드를 올바르게 입력해 주세요.');
        }
    });

 	// 드롭다운 메뉴 선택 시 버튼 텍스트 변경
    $('.dropdown-menu a').on('mouseover click', function() {
        var selectedText = $(this).text();
        $('#statusDropdown').text(selectedText);
    });
});
</script>

</body>
</html>
