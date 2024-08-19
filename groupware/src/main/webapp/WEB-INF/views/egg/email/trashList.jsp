<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>

<style>
    .email-title {
        width: 200px; /* 원하는 너비로 설정 */
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
        display: inline-block;
        vertical-align: middle;
    }
    .emlcn {
        width: auto;
        max-width: 1400px;
        padding-left: 40px;
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
        display: inline-block;
        vertical-align: middle;
        text-align: middle;
        height: 50px;
    }
    .pagination-container {
        display: flex;
        justify-content: center;
        align-items: center;
    }
</style>
</head>
<body>
<div class="content-page" style="margin-left: 0px">
<div class="content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <div class="page-title-right" style="margin:20px">
                
                    <form action="${pageContext.request.contextPath}/egg/mail/trashList" method="GET">
					    <div class="input-group">
					        <input type="text" name="query" class="form-control" placeholder="Search..." value="${param.query}">
					        <button type="submit" class="btn btn-secondary">
					            <i class="uil uil-search"></i>
					        </button>
					    </div>
					</form>

                    
                </div>
                <div class="card">
                    <div class="card-body">
                        <div class="page-aside-left">
                            <div class="d-grid">
                                <a href="${pageContext.request.contextPath}/egg/mail/compose" class="btn btn-danger">Compose</a>
                            </div>
                            <div class="email-menu-list mt-3">
                                <a href="${pageContext.request.contextPath}/egg/mail/reList"><i class="ri-inbox-line me-2"></i>수신메일함<span class="badge badge-info-lighten float-end ms-2">${count}</span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/impoList"><i class="ri-star-line me-2"></i>중요메일함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/drfList"><i class="ri-article-line me-2"></i>임시보관함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/sendList"><i class="ri-mail-send-line me-2"></i>보낸 메일함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/trashList" class="text-danger fw-bold"><i class="ri-delete-bin-line me-2"></i>휴지통<span class="badge badge-danger-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/mineList"><i class="ri-price-tag-3-line me-2"></i>내게 쓴 메일함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                            </div>
                        </div>
                        <div class="page-aside-right">
                            <div class="btn-group">
                                <button type="button" class="btn btn-secondary check-toggle"><i class="ri-check-fill"></i></button>
                                <button type="button" class="btn btn-secondary mark-all-star"><i class="ri-star-line"></i></button>
                                <button type="button" class="btn btn-secondary delete-selected"><i class="mdi mdi-delete-variant font-16"></i></button>
                                <button type="button" class="btn btn-secondary cancel-delete-selected"><i class="ri-reply-line"></i></button>
                            </div>
                            <div class="mt-3">
                                <ul class="email-list">
                                    <c:choose>
                                        <c:when test="${empty trashList}">
                                            <tr>조회하실 메일이 없습니다</tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${trashList}" var="trash">
                                                <li>
                                                    <div class="email-sender-info">
                                                        <div class="checkbox-wrapper-mail">
                                                            <div class="form-check">
                                                                <input type="checkbox" class="form-check-input" id="mail${trash.mreNo}" data-mreno="${trash.mreNo}" data-gubun="${trash.gubun}" data-emlno="${trash.emlNo}">
                                                                <label class="form-check-label" for="mail${trash.mreNo}"></label>
                                                            </div>
                                                        </div>
                                                        <span class="${trash.gubun == 'MAIL_RE' ? 'star-toggle ri-mail-fill' : 'star-toggle ri-mail-send-fill'}"></span> 
                                                        <a href="javascript: void(0);" class="email-title">${trash.emlTtl}</a>
                                                    </div>
                                                    <div class="email-content" data-emlno="${trash.emlNo}" data-mreno="${trash.mreNo}">
                                                        <div class="d-flex align-items-center mb-2">
                                                            <div class="flex-shrink-0 pb-3">
                                                                <span class="badge badge-outline-primary">${trash.emplNm}</span>
                                                            </div>
                                                            <div class="flex-grow-1 ms-2 email-subject emlcn">
                                                                ${trash.emlCn}
                                                            </div>
                                                            <h5 class="email-date align-middle pt-1">${trash.emlDt}</h5>
                                                        </div>
                                                    </div>
                                                    <div class="email-action-icons">
                                                        <ul class="list-inline">
                                                            <li class="list-inline-item">
                                                                <a href="javascript:void(0);" class="mark-star" data-mreno="${trash.mreNo}" data-gubun="${trash.gubun}"><i class="ri-star-line me-2"></i></a>
                                                            </li>
                                                            <li class="list-inline-item">
                                                                <a href="javascript:void(0);" class="delete-mail" data-mreno="${trash.mreNo}" data-gubun="${trash.gubun}" data-emlno="${trash.emlNo}"><i class="ri-forbid-2-fill"></i></a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </li>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </ul>
                            </div>
                            <div class="row">
                                <div class="col-12 pagination-container">
                                    <div class="btn-group">
                                        <ul class="pagination pagination-rounded mb-0">
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link" href="${pageContext.request.contextPath}/egg/mail/trashList?page=${currentPage - 1}" aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                    <a class="page-link" href="${pageContext.request.contextPath}/egg/mail/trashList?page=${i}">${i}</a>
                                                </li>
                                            </c:forEach>
                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link" href="${pageContext.request.contextPath}/egg/mail/trashList?page=${currentPage + 1}" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){
    var csrfToken = $("meta[name='_csrf']").attr("content");
    var csrfHeader = $("meta[name='_csrf_header']").attr("content");

    function sendAjaxRequest(url, data, successMessage, errorMessage) {
        $.ajax({
            type: "POST",
            url: url,
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            beforeSend: function(xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success: function(response) {
                /* alert(successMessage); */
                document.location.href = document.location.href;
            },
            error: function(xhr, status, error) {
                /* alert(errorMessage); */
            }
        });
    }

    $('.mark-star').click(function(){
        var gubun = $(this).data('gubun');
        if (gubun === 'EMAIL_SEND') {
            /* alert('발신메세지는 중요 표시를 할 수 없습니다.'); */
            return;
        }

        var mreNo = $(this).data('mreno');
        sendAjaxRequest("${pageContext.request.contextPath}/egg/mail/markStar", { mreNos: [mreNo] }, '정상적으로 중요표시가 되었습니다', '왜 에러야 도대체');
    });

    $('.delete-mail').click(function(){
        var gubun = $(this).data('gubun');
        var mreNo = $(this).data('mreno');
        var emlNo = $(this).data('emlno');

        if (gubun === 'EMAIL_SEND') {
            if (confirm("정말로 선택한 메일을 영구 삭제하시겠습니까?")) {
                sendAjaxRequest("${pageContext.request.contextPath}/egg/mail/deleteSendMail", { emlNos: [emlNo] }, '성공스.', '왜 에러야 도대체');
            }
        } else {
            if (confirm("정말로 선택한 메일을 영구 삭제하시겠습니까?")) {
                sendAjaxRequest("${pageContext.request.contextPath}/egg/mail/deletePermanently", { mreNos: [mreNo] }, '성공스.', '왜 에러야 도대체');
            }
        }
    });

    $(".cancel-delete").click(function(){
        var mreNo = $(this).data('mreno');
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/egg/mail/deleteCancel",
            data: JSON.stringify({ mreNos: [mreNo] }),
            contentType: "application/json; charset=utf-8",
            beforeSend: function(xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success: function(response) {
                history.go(0);
            }
        });
    });

    $(".email-list").on("click", ".email-content", function(){
        var emlNo = $(this).data("emlno");
        var mreNo = $(this).data("mreno");
        location.href = "/egg/mail/trashDetail?emlNo=" + emlNo + "&mreNo=" + mreNo;
    });

    var allChecked = false;
    $(".check-toggle").click(function(){
        allChecked = !allChecked;
        $(".form-check-input").prop("checked", allChecked);
    });

    $(".mark-all-star").click(function(){
        var checkedMreNos = [];
        $(".form-check-input:checked").each(function(){
            if ($(this).data('gubun') === 'EMAIL_SEND') {
                alert('발신메세지는 가능하지 않습니다.');
            } else {
                checkedMreNos.push($(this).data('mreno'));
            }
        });
        console.log("checkedMreNos : " + checkedMreNos);
        if (checkedMreNos.length > 0) {
            sendAjaxRequest("${pageContext.request.contextPath}/egg/mail/markStar", { mreNos: checkedMreNos }, '성공스.', '왜 에러야 도대체');
        }
    });

    $(".delete-selected").click(function(){
        var checkedMreNos = [];
        var checkedEmlNos = [];
        $(".form-check-input:checked").each(function(){
            if ($(this).data('gubun') === 'EMAIL_SEND') {
                checkedEmlNos.push($(this).data('emlno'));
            } else {
                checkedMreNos.push($(this).data('mreno'));
            }
        });
        console.log("checkedEmlNos : " + checkedEmlNos);
        console.log("checkedMreNos : " + checkedMreNos);
        if (checkedMreNos.length > 0) {
            if (confirm("정말로 선택한 메일을 영구 삭제하시겠습니까?")) {
                sendAjaxRequest("${pageContext.request.contextPath}/egg/mail/deletePermanently", { mreNos: checkedMreNos }, '성공스.', '왜 에러야 도대체');
            }
        }
        if (checkedEmlNos.length > 0) {
            sendAjaxRequest("${pageContext.request.contextPath}/egg/mail/deleteSendMail", { emlNos: checkedEmlNos }, '성공스.', '왜 에러야 도대체');
        }
    });

    $(".cancel-delete-selected").click(function(){
        var checkedMreNos = [];
        var checkedEmlNos = [];
        $(".form-check-input:checked").each(function(){
            if ($(this).data('gubun') === 'EMAIL_SEND') {
                checkedEmlNos.push($(this).data('emlno'));
            } else {
                checkedMreNos.push($(this).data('mreno'));
            }
        });
        console.log("checkedEmlNos : " + checkedEmlNos);
        console.log("checkedMreNos : " + checkedMreNos);
        if (checkedMreNos.length > 0) {
            sendAjaxRequest("${pageContext.request.contextPath}/egg/mail/deleteCancel", { mreNos: checkedMreNos }, '성공스.', '왜 에러야 도대체');
        }
        if (checkedEmlNos.length > 0) {
            sendAjaxRequest("${pageContext.request.contextPath}/egg/mail/cancelDeleteSendMail", { emlNos: checkedEmlNos }, '성공스.', '왜 에러야 도대체');
        }
    });
});
</script>

</body>
</html>
