<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
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
    .emlcn{
      width: auto;
      max-width: 1400px;
      padding-left: 40px;
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
        display: inline-block;
        vertical-align: middle;
      text-align:middel;
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
                    
                        <form action="${pageContext.request.contextPath}/egg/mail/mineList" method="GET">
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
                        <!-- Left sidebar -->
                        <div class="page-aside-left">
                             <div class="d-grid">
								    <a href="${pageContext.request.contextPath}/egg/mail/compose" class="btn btn-danger">Compose</a>
							 </div>


                            <div class="email-menu-list mt-3">
                                <a href="${pageContext.request.contextPath}/egg/mail/reList" ><i class="ri-inbox-line me-2"></i>수신메일함<span class="badge badge-info-lighten float-end ms-2">${count }</span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/impoList"><i class="ri-star-line me-2"></i>중요메일함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/drfList"><i class="ri-article-line me-2"></i>임시보관함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/sendList"><i class="ri-mail-send-line me-2"></i>보낸 메일함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/trashList"><i class="ri-delete-bin-line me-2"></i>휴지통<span class="badge badge-info-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/mineList" class="text-danger fw-bold"><i class="ri-price-tag-3-line me-2"></i>내게 쓴 메일함<span class="badge badge-danger-lighten float-end ms-2"></span></a>
                            </div>

                            

                            

                        </div>
                        <!-- End Left sidebar -->

                        <div class="page-aside-right">

                            <div class="btn-group">
                                <button type="button" class="btn btn-secondary check-toggle"><i class="ri-check-fill"></i></button>
                                <button type="button" class="btn btn-secondary mark-all-star"><i class="ri-star-line"></i></button>
                                <button type="button" class="btn btn-secondary delete-selected"><i class="mdi mdi-delete email-action-icons-item"></i></button>
                            </div>
			                            <div class="mt-3">
			                                <ul class="email-list">
												<c:choose>
													 <c:when test="${empty mineList}">
													 	<tr>
													 		조회하실 메일이 없습니다
													 	</tr>
													 </c:when>
													 <c:otherwise>
													 	<c:forEach items="${mineList}" var="mine">
								                                    <li>
																        <div class="email-sender-info">
																            <div class="checkbox-wrapper-mail">
																                <div class="form-check">
																                    <input type="checkbox" class="form-check-input" id="mail${mine.mreNo}" data-mreno="${mine.mreNo}">
																                    <label class="form-check-label" for="mail${mine.mreNo}"></label>
																                </div>
																            </div>
																            <!-- <span class="star-toggle mdi mdi-star-outline"></span> -->
																            <a href="javascript: void(0);" class="email-title">${mine.emlTtl }</a>
																        </div>
																        <div class="email-content" data-mreno="${mine.mreNo}">
																            <div class="d-flex align-items-center mb-2">
																                <div class="flex-shrink-0 pb-3">
																                    <span class="badge badge-outline-primary">${mine.emplNm }</span>
																                </div>
																                <div class="flex-grow-1 ms-2 email-subject emlcn">
																                    ${mine.emlCn}
																                </div>
																                <h5 class="email-date align-middle pt-1">${mine.emlDt}</h5>
																            </div>
																        </div>
																        <div class="email-action-icons">
																            <ul class="list-inline">
																		        <li class="list-inline-item">
					                                                                <a href="javascript:void(0);" class="mark-star" data-mreno="${mine.mreNo}"><i class="ri-star-line me-2"></i></a>
					                                                            </li>
					                                                            <li class="list-inline-item">
					                                                                <a href="javascript:void(0);" class="delete-mail" data-mreno="${mine.mreNo}"><i class="mdi mdi-delete email-action-icons-item"></i></a>
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
							                    <a class="page-link" href="${pageContext.request.contextPath}/egg/mail/mineList?page=${currentPage - 1}" aria-label="Previous">
							                        <span aria-hidden="true">&laquo;</span>
							                    </a>
							                </li>
							                <c:forEach var="i" begin="${startPage}" end="${endPage}">
							                    <li class="page-item ${currentPage == i ? 'active' : ''}">
							                        <a class="page-link" href="${pageContext.request.contextPath}/egg/mail/mineList?page=${i}">${i}</a>
							                    </li>
							                </c:forEach>
							                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
							                    <a class="page-link" href="${pageContext.request.contextPath}/egg/mail/mineList?page=${currentPage + 1}" aria-label="Next">
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


<%-- <!-- Compose Modal -->
<div id="compose-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="compose-header-modalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header modal-colored-header bg-primary">
                <h4 class="modal-title" id="compose-header-modalLabel">New Message</h4>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="p-1">
                <div class="modal-body px-3 pt-3 pb-0">
                    <form>
                        <div class="mb-2">
                            <label for="msgto" class="form-label">To</label>
                            <input type="text" id="msgto" class="form-control" placeholder="Example@email.com">
                        </div>
                        <div class="mb-2">
                            <label for="mailsubject" class="form-label">Subject</label>
                            <input type="text" id="mailsubject" class="form-control" placeholder="Your subject">
                        </div>
                        <div class="write-mdg-box mb-3">
                            <label class="form-label">Message</label>
                            <textarea id="simplemde1" style="display: none;"></textarea><div class="editor-toolbar"><a title="Bold (Ctrl-B)" tabindex="-1" class="fa fa-bold"></a><a title="Italic (Ctrl-I)" tabindex="-1" class="fa fa-italic"></a><a title="Heading (Ctrl-H)" tabindex="-1" class="fa fa-header"></a><i class="separator">|</i><a title="Quote (Ctrl-')" tabindex="-1" class="fa fa-quote-left"></a><a title="Generic List (Ctrl-L)" tabindex="-1" class="fa fa-list-ul"></a><a title="Numbered List (Ctrl-Alt-L)" tabindex="-1" class="fa fa-list-ol"></a><i class="separator">|</i><a title="Create Link (Ctrl-K)" tabindex="-1" class="fa fa-link"></a><a title="Insert Image (Ctrl-Alt-I)" tabindex="-1" class="fa fa-picture-o"></a><i class="separator">|</i><a title="Toggle Preview (Ctrl-P)" tabindex="-1" class="fa fa-eye no-disable"></a><a title="Toggle Side by Side (F9)" tabindex="-1" class="fa fa-columns no-disable no-mobile"></a><a title="Toggle Fullscreen (F11)" tabindex="-1" class="fa fa-arrows-alt no-disable no-mobile"></a><i class="separator">|</i><a title="Markdown Guide" tabindex="-1" class="fa fa-question-circle" href="https://simplemde.com/markdown-guide" target="_blank"></a></div><div class="CodeMirror cm-s-paper CodeMirror-wrap CodeMirror-empty"><div style="overflow: hidden; position: relative; width: 3px; height: 0px;"><textarea autocorrect="off" autocapitalize="off" spellcheck="false" tabindex="0" style="position: absolute; padding: 0px; width: 1000px; height: 1em; outline: none;"></textarea></div><div class="CodeMirror-vscrollbar" cm-not-content="true"><div style="min-width: 1px;"></div></div><div class="CodeMirror-hscrollbar" cm-not-content="true"><div style="height: 100%; min-height: 1px;"></div></div><div class="CodeMirror-scrollbar-filler" cm-not-content="true"></div><div class="CodeMirror-gutter-filler" cm-not-content="true"></div><div class="CodeMirror-scroll" tabindex="-1"><div class="CodeMirror-sizer" style="margin-left: 0px;"><div style="position: relative;"><div class="CodeMirror-lines"><div style="position: relative; outline: none;"><pre class="CodeMirror-placeholder" style="height: 0px; overflow: visible;">Write something..</pre><div class="CodeMirror-measure"><pre><span>xxxxxxxxxx</span></pre></div><div class="CodeMirror-measure"></div><div style="position: relative; z-index: 1;"></div><div class="CodeMirror-cursors"></div><div class="CodeMirror-code"></div></div></div></div></div><div style="position: absolute; height: 30px; width: 1px;"></div><div class="CodeMirror-gutters" style="display: none;"></div></div></div><div class="editor-preview-side"></div>
                        </div>
                    </form>
                </div>
                <div class="px-3 pb-3">
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal"><i class="mdi mdi-send me-1"></i> Send Message</button>
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal --> --%>


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

    function sendAjaxRequest(url, mreNos) {
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
                /* alert('성공스.'); */
                document.location.href = document.location.href;
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

    $(".delete-mail").click(function(){
        var mreNo = $(this).data("mreno");
        if (confirm("정말로 이 메일을 휴지통에 넣겠습니까?")) {
            console.log("Deleting mail with mreNo: " + mreNo);
            sendAjaxRequest("${pageContext.request.contextPath}/egg/mail/deleteMail", [mreNo]);
        }
    });
    
    // 이메일 상세보기 이벤트
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

    $(".mark-all-star").click(function(){
        var checkedMreNos = [];
        $(".form-check-input:checked").each(function(){
            checkedMreNos.push($(this).data('mreno'));
        });
        console.log("Mark all star clicked, mreNos: " + checkedMreNos);
        if (checkedMreNos.length > 0) {
            sendAjaxRequest("${pageContext.request.contextPath}/egg/mail/markStar", checkedMreNos);
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

    $(".cancel-delete-selected").click(function(){
        var checkedMreNos = [];
        $(".form-check-input:checked").each(function(){
            checkedMreNos.push($(this).data('mreno'));
        });
        console.log("Cancel delete selected clicked, mreNos: " + checkedMreNos);
        if (checkedMreNos.length > 0) {
            sendAjaxRequest("${pageContext.request.contextPath}/egg/mail/deleteCancel", checkedMreNos);
        }
    });
});
</script>
</body>
</html>