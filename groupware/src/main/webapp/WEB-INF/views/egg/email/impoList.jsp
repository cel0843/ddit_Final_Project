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

    <!-- Start Content-->
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <div class="page-title-right" style="margin:20px">
                
                        <form action="${pageContext.request.contextPath}/egg/mail/impoList" method="GET">
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
                                <a href="${pageContext.request.contextPath}/egg/mail/reList" >
                                    <i class="ri-inbox-line me-2"></i>수신메일함
                                    <span class="badge badge-info-lighten float-end ms-2">${listCount}</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/egg/mail/impoList" class="text-danger fw-bold">
                                    <i class="ri-star-line me-2"></i>중요메일함
                                    <span class="badge badge-info-lighten float-end ms-2"></span>
                                </a>
                                <a href="${pageContext.request.contextPath}/egg/mail/drfList">
                                    <i class="ri-article-line me-2"></i>임시보관함
                                    <span class="badge badge-info-lighten float-end ms-2"></span>
                                </a>
                                <a href="${pageContext.request.contextPath}/egg/mail/sendList">
                                    <i class="ri-mail-send-line me-2"></i>보낸 메일함
                                    <span class="badge badge-info-lighten float-end ms-2"></span>
                                </a>
                                <a href="${pageContext.request.contextPath}/egg/mail/trashList">
                                    <i class="ri-delete-bin-line me-2"></i>휴지통
                                    <span class="badge badge-info-lighten float-end ms-2"></span>
                                </a>
                                <a href="${pageContext.request.contextPath}/egg/mail/mineList">
                                    <i class="ri-price-tag-3-line me-2"></i>내게 쓴 메일함
                                    <span class="badge badge-info-lighten float-end ms-2"></span>
                                </a>
                            </div>

                           

                            
                        </div>
                        <!-- End Left sidebar -->

                        <div class="page-aside-right">
                            <div class="btn-group">
                                <button type="button" class="btn btn-secondary check-toggle"><i class="ri-check-fill"></i></button>
                                <button type="button" class="btn btn-secondary mark-all-cancel-star"><i class="ri-reply-line"></i></button>
                                <button type="button" class="btn btn-secondary delete-selected"><i class="mdi mdi-delete email-action-icons-item"></i></button>
                            </div>
                           
                            <div class="mt-3">
                                <ul class="email-list">
                                    <c:choose>
                                        <c:when test="${empty impoList}">
                                            <li class="unread">
                                                <div class="email-sender-info">
                                                    <span class="email-title">조회하신 메일이 없습니다.</span>
                                                </div>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${impoList}" var="impo">
                                                <li>
                                                    <div class="email-sender-info">
                                                        <div class="checkbox-wrapper-mail">
                                                            <div class="form-check">
                                                                <input type="checkbox" class="form-check-input" id="mail${impo.mreNo}" data-mreno="${impo.mreNo}">
                                                                <label class="form-check-label" for="mail${impo.mreNo}"></label>
                                                            </div>
                                                        </div>
                                                        <!-- <span class="star-toggle mdi mdi-star-outline"></span>    -->
                                                        <a href="javascript: void(0);" class="email-title">${impo.emlTtl }</a>
                                                    </div>
                                                    <div class="email-content" data-mreno="${impo.mreNo}">
                                                        <div class="d-flex align-items-center mb-2">
                                                            <div class="flex-shrink-0 pb-3">
                                                                <span class="badge badge-outline-primary">${impo.emplNm }</span>
                                                            </div>
                                                            <div class="flex-grow-1 ms-2 email-subject emlcn">
                                                                ${impo.emlCn}
                                                            </div>
                                                            <h5 class="email-date align-middle pt-1">${impo.emlDt}</h5>
                                                        </div>
                                                    </div>
                                                    <div class="email-action-icons">
                                                        <ul class="list-inline">
                                                            <li class="list-inline-item">
                                                                <a href="javascript:void(0);" class="cancel-star" data-mreno="${impo.mreNo}"><i class="ri-reply-line"></i></a>
                                                            </li>
                                                            <li class="list-inline-item">
                                                                <a href="javascript:void(0);" class="delete-mail" data-mreno="${impo.mreNo}"><i class="mdi mdi-delete email-action-icons-item"></i></a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </li>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </ul>
                            </div>
                            
                            <!-- end .mt-4 -->
                            <div class="row">
                                <div class="col-12 pagination-container">
                                    <div class="btn-group">
                                        <ul class="pagination pagination-rounded mb-0">
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link" href="${pageContext.request.contextPath}/egg/mail/impoList?page=${currentPage - 1}" aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                    <a class="page-link" href="${pageContext.request.contextPath}/egg/mail/impoList?page=${i}">${i}</a>
                                                </li>
                                            </c:forEach>
                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link" href="${pageContext.request.contextPath}/egg/mail/impoList?page=${currentPage + 1}" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>  
                            
                            <!-- end row-->
                        </div>
                        <!-- end inbox-rightbar-->
                    </div>
                    <!-- end card-body -->
                    <div class="clearfix"></div>
                </div> <!-- end card-box -->

            </div> <!-- end Col -->
        </div><!-- End row -->

    </div> <!-- container -->

</div> <!-- content -->

<!-- Footer Start -->
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
<!-- end Footer -->

</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){
    var csrfToken = $("meta[name='_csrf']").attr("content");
    var csrfHeader = $("meta[name='_csrf_header']").attr("content");

    function sendAjaxRequest(url, mreNos, callback) {
        $.ajax({
            type: "POST",
            url: url,
            data: JSON.stringify({ mreNos: mreNos }),
            contentType: "application/json; charset=utf-8",
            beforeSend: function(xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success: function(response) {
                console.log("Success, response: " + response);
                if (callback) {
                    callback(response);
                } else {
                    /* alert('성공스.'); */
                    document.location.href = document.location.href;
                }
            },
            error: function(xhr, status, error) {
                console.log("왜 에러야 도대체: " + status + ", error: " + error);
            }
        });
    }

    $('.mark-star').click(function(){
        var mreNo = $(this).data('mreno');
        console.log("Mark star clicked, mreNo: " + mreNo);
        sendAjaxRequest("${pageContext.request.contextPath}/egg/mail/markStar", [mreNo]);
    });

    $('.cancel-star').click(function(){
        var mreNo = $(this).data('mreno');
        console.log("Cancel star clicked, mreNo: " + mreNo);
        sendAjaxRequest("${pageContext.request.contextPath}/egg/mail/cancelStart", [mreNo]);
    });

    $('.delete-mail').click(function(){
        var mreNo = $(this).data('mreno');
        console.log("Delete mail clicked, mreNo: " + mreNo);
        if (confirm("정말로 이 메일을 휴지통에 넣겠습니까?")) {
            sendAjaxRequest("${pageContext.request.contextPath}/egg/mail/deleteMail", [mreNo]);
        }
    });
    
    $(".email-list").on("click", ".email-content", function(){
        var mreNo = $(this).data("mreno");
        if (mreNo) {
            location.href = "${pageContext.request.contextPath}/egg/mail/detail?mreNo=" + mreNo;
        } else {
            console.log("mreNo is undefined or null.");
        }
    });

    var allChecked = false;
    $(".check-toggle").click(function(){
        allChecked = !allChecked;
        $(".form-check-input").prop("checked", allChecked);
    });

    $(".mark-all-cancel-star").click(function(){
        var checkedMreNos = [];
        $(".form-check-input:checked").each(function(){
            checkedMreNos.push($(this).data('mreno'));
        });
        console.log("Mark all cancel star clicked, mreNos: " + checkedMreNos);
        if (checkedMreNos.length > 0) {
            sendAjaxRequest("${pageContext.request.contextPath}/egg/mail/cancelStart", checkedMreNos);
        }
    });

    $(".delete-selected").click(function(){
        var checkedMreNos = [];
        $(".form-check-input:checked").each(function(){
            checkedMreNos.push($(this).data('mreno'));
        });
        console.log("Delete selected clicked, mreNos: " + checkedMreNos);
        if (checkedMreNos.length > 0) {
            if (confirm("정말로 선택한 메일을 휴지통에 넣겠습니까?")) {
                sendAjaxRequest("${pageContext.request.contextPath}/egg/mail/deleteMail", checkedMreNos);
            }
        }
    });
});
</script>

</body>
</html>
