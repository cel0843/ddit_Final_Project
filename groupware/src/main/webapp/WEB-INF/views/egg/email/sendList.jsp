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
        width: auto; /* 원하는 너비로 설정 */
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

    <!-- Start Content-->
    <div class="container-fluid">

        <!-- start page email-title -->
        <!-- start page title -->
        <!-- end page title -->
        <!-- end page email-title -->

        <div class="row">

            <!-- Right Sidebar -->
            <div class="col-12">
                    <div class="page-title-right" style="margin:20px">
                    
                        <form method="get" action="${pageContext.request.contextPath}/egg/mail/sendList">
					        <div class="input-group">
					            <input type="text" name="query" class="form-control" placeholder="Search..." value="${query}">
					            <button class="input-group-text btn btn-secondary" type="submit">
					                <i class="uil uil-search"></i>
					            </button>
					        </div>
					    </form>
					    
                    </div>
                <div class="card">
                    <div class="card-body">
                        <!-- Left sidebar -->
                        <div class="page-aside-left">
                                <div class="d-grid">
								    <a href="${pageContext.request.contextPath}/egg/mail/compose" class="btn btn-danger">Compose</a>
								</div>

                            <div class="email-menu-list mt-3">
                                <a href="${pageContext.request.contextPath}/egg/mail/reList"><i class="ri-inbox-line me-2"></i>수신메일함<span class="badge badge-info-lighten float-end ms-2">${count }</span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/impoList"><i class="ri-star-line me-2"></i>중요메일함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/drfList"><i class="ri-article-line me-2"></i>임시보관함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/sendList"  class="text-danger fw-bold"><i class="ri-mail-send-line me-2"></i>보낸 메일함<span class="badge badge-danger-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/trashList"><i class="ri-delete-bin-line me-2"></i>휴지통<span class="badge badge-info-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/mineList"><i class="ri-price-tag-3-line me-2"></i>내게 쓴 메일함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                            </div>

                            

                            

                        </div>
                        <!-- End Left sidebar -->

                        <div class="page-aside-right">

                            <div class="btn-group">
                                <button type="button" class="btn btn-secondary check-toggle"><i class="ri-check-fill"></i></button>
                                <button type="button" class="btn btn-secondary delete-selected"><i class="mdi mdi-delete email-action-icons-item"></i></button>
                            </div>
                            
									<div class="mt-3">
										<ul class="email-list">
											<c:choose>
												<c:when test="${empty sendList}">
													<tr>
														<td>조회하실 메일이 없습니다</td>
													</tr>
												</c:when>
												<c:otherwise>
												
													<c:forEach items="${sendList}" var="send">
														<li>
													        <div class="email-sender-info">
													            <div class="checkbox-wrapper-mail">
													                <div class="form-check">
													                     <input type="checkbox" class="form-check-input" id="mail${send.emlNo}" data-emlno="${send.emlNo}">
		        														<label class="form-check-label" for="mail${send.emlNo}"></label>
													                </div>
													            </div>
													            <!-- <span class="star-toggle mdi mdi-star-outline"></span> -->
													            <a href="javascript: void(0);" class="email-title">${send.emlTtl }</a>
													        </div>
													        <div class="email-content" data-emlno="${send.emlNo}">
													            <div class="d-flex align-items-center mb-2">
													                <div class="flex-shrink-0 pb-3">
													                    <span class="badge badge-outline-primary"></span>
													                </div>
													                <div class="flex-grow-1 ms-2 email-subject emlcn">
													                    ${send.emlCn} 
													                </div>
													                <h5 class="email-date align-middle pt-1">${send.emlDt}</h5>
													            </div>
													        </div>
													         <%-- <div class="email-action-icons">
													            <ul class="list-inline">
															        <li class="list-inline-item">
															            <a href="javascript:void(0);" class="mark-star" data-mreno="${send.mreNo}"><i class="ri-star-line me-2"></i></a>
															        </li>
															        <li class="list-inline-item">
															            <a href="javascript:void(0);" class="delete-mail" data-mreno="${send.mreNo}"><i class="mdi mdi-delete email-action-icons-item"></i></a>
															        </li>
															        <li class="list-inline-item">
															            <a href="javascript:void(0);"><i class="mdi mdi-clock email-action-icons-item"></i></a>
															        </li>
															    </ul>
													        </div>  --%>
													    </li>
													</c:forEach>
													
												</c:otherwise>
											</c:choose>
										</ul>
									</div>

									<!-- end .mt-4 -->

                            <!-- 페이지네이션 UI 추가 -->
										<div class="row">
										    <div class="col-12 pagination-container">
										        <div class="btn-group">
										            <ul class="pagination pagination-rounded mb-0">
										                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
										                    <a class="page-link" href="${pageContext.request.contextPath}/egg/mail/sendList?page=${currentPage - 1}" aria-label="Previous">
										                        <span aria-hidden="true">&laquo;</span>
										                    </a>
										                </li>
										                <c:forEach var="i" begin="${startPage}" end="${endPage}">
										                    <li class="page-item ${currentPage == i ? 'active' : ''}">
										                        <a class="page-link" href="${pageContext.request.contextPath}/egg/mail/sendList?page=${i}">${i}</a>
										                    </li>
										                </c:forEach>
										                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
										                    <a class="page-link" href="${pageContext.request.contextPath}/egg/mail/sendList?page=${currentPage + 1}" aria-label="Next">
										                        <span aria-hidden="true">&raquo;</span>
										                    </a>
										                </li>
										            </ul>
										        </div>
										    </div>
										</div>
										<!-- end row-->

                            
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
<script>
$(document).ready(function() {
    var csrfToken = $("meta[name='_csrf']").attr("content");
    var csrfHeader = $("meta[name='_csrf_header']").attr("content");

    // 이메일 상세보기 이벤트
    $(".email-list").on("click", ".email-content", function(){
        var emlNo = $(this).data("emlno");
        if (emlNo) {
            location.href = "${pageContext.request.contextPath}/egg/mail/sendDetail?emlNo=" + emlNo;
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
    $(".delete-selected").click(function() {
        var selectedMails = $(".form-check-input:checked").map(function() {
            return $(this).data("emlno");
        }).get();
		console.log("메일 번호들"+selectedMails)
        if (selectedMails.length > 0) {
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/egg/mail/archiveMail",
                contentType: "application/json",
                data: JSON.stringify({ emlNos: selectedMails }),
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                },
                success: function(response) {
                    if (response === "success") {
                        location.reload();
                        /* alert("아작스보내는거는 성공") */
                    } else {
            /*             alert("휴지통 보내기 실패"); */
                    }
                }
            });
        } else {
            /* alert("휴지통으로 보낼 메일을 선택해주세요"); */
        }
    });
});

</script>

</body>
</html>



