<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
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
    .emlcn{
        width: 1100px; /* 원하는 너비로 설정 */
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
        display: inline-block;
        vertical-align: middle;
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
                    <form action="${pageContext.request.contextPath}/egg/mail/drfList" method="GET">
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
                                <a href="${pageContext.request.contextPath}/egg/mail/reList"><i class="ri-inbox-line me-2"></i>수신메일함<span class="badge badge-info-lighten float-end ms-2">${count }</span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/impoList"><i class="ri-star-line me-2"></i>중요메일함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/drfList"  class="text-danger fw-bold"><i class="ri-article-line me-2"></i>임시보관함<span class="badge badge-danger-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/sendList"><i class="ri-mail-send-line me-2"></i>보낸 메일함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/trashList"><i class="ri-delete-bin-line me-2"></i>휴지통<span class="badge badge-info-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/mineList"><i class="ri-price-tag-3-line me-2"></i>내게 쓴 메일함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                            </div>
                            
                            
                        </div>
                        <div class="page-aside-right">
                            <div class="btn-group">
                                <button type="button" class="btn btn-secondary check-toggle"><i class="ri-check-fill"></i></button>
                                <button type="button" class="btn btn-secondary delete-button"><i class="ri-eraser-fill"></i></button>
                            </div>
                            
                            
                            
                            <div class="mt-3">
                                <ul class="email-list">
                                    <c:choose>
                                        <c:when test="${empty drfList}">
                                            <tr>조회하실 메일이 없습니다</tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${drfList}" var="drf">
                                            
                                                <li>
												    <div class="email-sender-info">
												        <div class="checkbox-wrapper-mail">
												            <div class="form-check">
												                <input type="checkbox" class="form-check-input" id="mail2">
												                <label class="form-check-label" for="mail2"></label>
												            </div>
												        </div>
												        <a href="javascript: void(0);" class="email-title">${drf.emlTtl }</a>
												    </div>
												    <div class="email-content" data-emlno="${drf.emlNo}">
												        <div class="d-flex align-items-center mb-2">
												            <div class="flex-shrink-0 pb-3">
												                <span class="badge badge-outline-primary"></span>
												            </div>
												            <div class="flex-grow-1 ms-2 email-subject emlcn">
												                ${drf.emlCn}
												            </div>
												            <h5 class="email-date align-middle pt-1">${drf.emlDt}</h5>
												        </div>
												    </div>
												</li>

                                                
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </ul>
                            </div>
                            <div class="row">
                                <div class="col-12 pagination-container" >
                                    <div class="btn-group float-end">
                                        <ul class="pagination pagination-rounded mb-0">
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link" href="${pageContext.request.contextPath}/egg/mail/drfList?page=${currentPage - 1}" aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                    <a class="page-link" href="${pageContext.request.contextPath}/egg/mail/drfList?page=${i}">${i}</a>
                                                </li>
                                            </c:forEach>
                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link" href="${pageContext.request.contextPath}/egg/mail/drfList?page=${currentPage + 1}" aria-label="Next">
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

<footer class="footer">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-6">
                <script>document.write(new Date().getFullYear())</script>2024 © Hyper - Coderthemes.com
            </div>
            <div class="col-md-6">
                <div class="text-md-end footer-links d-none d-md-block">
                    <a href="javascript: void(0);">About</a>
                    <a href="javascript: void(0);">Support</a>
                    <a href="javascript: void(0);">Contact Us</a>
                </div>
            </div>
        </div>
    </div>
</footer>

<script>
$(document).ready(function(){
    // CSRF 토큰 설정
    var csrfToken = $("meta[name='_csrf']").attr("content");
    var csrfHeader = $("meta[name='_csrf_header']").attr("content");

    // 이메일 상세보기 이벤트
    $(".email-list").on("click", ".email-content", function(){
        var emlNo = $(this).data("emlno");
        if (emlNo) {
            location.href = "${pageContext.request.contextPath}/egg/mail/drfDetail?emlNo=" + emlNo;
        } else {
            console.log("emlNo is undefined or null.");
        }
    });

    var allChecked = false;
    $(".check-toggle").click(function(){
        allChecked = !allChecked;
        $(".form-check-input").prop("checked", allChecked);
    });

    // 삭제 버튼 클릭 이벤트
    $(".delete-button").click(function(){
        var selectedEmails = [];
        $(".form-check-input:checked").each(function(){
            var emlno = $(this).closest('li').find('.email-content').data('emlno');
            console.log("Email No:", emlno); // 각 이메일의 번호를 콘솔에 출력
            selectedEmails.push(emlno);
        });

        console.log("Selected draftIds:", selectedEmails); // 선택된 draftId를 콘솔에 출력

        if(selectedEmails.length > 0){
            $.ajax({
                url: "${pageContext.request.contextPath}/egg/mail/deleteDrfMails",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({ draftIds: selectedEmails }),
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 토큰을 헤더에 포함
                },
                success: function(response) {
                    if(response.success){
                        location.reload(); // 삭제 후 페이지 새로고침
                    } else {
                        /* alert("삭제 중 오류가 발생했습니다: " + response.message); */
                    }
                },
                error: function(xhr, status, error) {
                    console.error("AJAX 오류: ", status, error);
                    /* alert("삭제 중 오류가 발생했습니다."); */
                }
            });
        } else {
            /* alert("삭제할 항목을 선택해주세요."); */
        }
    });


});
</script>
</body>
</html>

