<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<html>
<c:if test="${not empty message }">
	<script type="text/javascript">
		alert("${message}");
		<c:remove var="message" scope="request"/>
	</script>
</c:if>
<body>

	<div class="content">
		<div class="container-fluid">

			<!-- 페이지 타이틀 -->
			<!-- start page title -->
			<div class="row">
				<div class="col-12">
					<div class="page-title-box">
						<div class="page-title-right"></div>
						<h4 class="page-title">게시판 관리</h4>
					</div>
				</div>
			</div>
			<!-- end page title -->
			
			<c:choose>
				<c:when test="${bbsTyCd eq 'M010101'}"><c:set value="active" var="active1"/> <c:set value="공지사항" var="boardCategoryName"/> </c:when>
				<c:when test="${bbsTyCd eq 'M010102'}"><c:set value="active" var="active2"/> <c:set value="사내스터디" var="boardCategoryName"/> </c:when>
				<c:when test="${bbsTyCd eq 'M010103'}"><c:set value="active" var="active3"/> <c:set value="기술블로그" var="boardCategoryName"/> </c:when>
				<c:when test="${bbsTyCd eq 'M010104'}"><c:set value="active" var="active4"/> <c:set value="사내동호회" var="boardCategoryName"/> </c:when>
			</c:choose>
			<div class="row">
				<!-- 좌측 -->
				<div class="col-md-2">
					<h3>공지게시판</h3>
				    <a href="/egg/board" class="list-group list-group-item list-group-item-action ${active1 }">공지사항</a>
				    <h3 class="mt-3">사내게시판</h3>
					<div class="list-group">
					    <a href="/egg/board?bbsTyCd=M010102" class="list-group-item list-group-item-action ${active2 }">사내스터디</a>
					    <a href="/egg/board?bbsTyCd=M010103" class="list-group-item list-group-item-action ${active3 }">기술블로그</a>
					    <a href="/egg/board?bbsTyCd=M010104" class="list-group-item list-group-item-action ${active4 }">사내동호회</a>
					</div>
				</div> <!-- End col -->
				
				<!-- 우측 -->
				<div class="col-md-10">
					<div class="card">
						<div class="card-header">
							<h3>| ${boardVO.bbsTtl } </h3>
							<hr class="mt-3 mb-0">
						</div>
						<div class="card-body pt-0">
							<div class="mb-1">
                                <div class="d-flex justify-content-between mt-0">
                                    <h4 class="m-0 fw-normal mt-0 mb-0">작성자 : ${boardVO.emplNm }</h4>
                                    <p class="mt-0 mb-0">조회수 : ${boardVO.bbsHit }</p>
                                </div>
                                <div class="d-flex justify-content-end">
                                    <p class="text-muted mt-0 mb-0">작성일시 : ${fn:substring(boardVO.bbsCtrDt, 0, 16)}</p>
                                    <c:if test="${boardVO.bbsMdfcnDt ne null and boardVO.bbsMdfcnDt ne '' }">
	                                    <p class="text-muted mt-0 mb-0">&nbsp;&nbsp;|&nbsp;수정일시 : ${fn:substring(boardVO.bbsMdfcnDt, 0, 16)}</p>
                                    </c:if>
                                </div>
                            </div>
                                            
							<hr>

							${boardVO.bbsCn }

							<hr>
							
							<h5 class="mb-3">첨부파일</h5>
							<c:if test="${boardVO.fileGroupNo ne '' and boardVO.fileGroupNo ne '0' }">
							<c:if test="${boardVO.boardFileList[0].fileOrgnlNm ne null and boardVO.boardFileList[0].fileOrgnlNm ne ''}">
								<div class="row">
									<c:forEach items="${boardVO.boardFileList }" var="boardFile">
                                       <div class="col-xl-4">
                                           <div class="card mb-1 shadow-none border">
                                               <div class="p-2">
                                                   <div class="row align-items-center">
                                                       <div class="col-auto">
                                                           <div class="avatar-sm">
                                                               <span class="avatar-title bg-primary-lighten text-primary rounded">
                                                                   .${boardFile.fileType }
                                                               </span>
                                                           </div>
                                                       </div>
                                                       
                                                       <div class="col ps-0">
                                                           <c:choose>
												            <c:when test="${fn:length(boardFile.fileOrgnlNm) > 15}">
												                <a href="javascript:void(0);" class="text-muted fw-bold downloadBoardFileLink"
													                data-filename="${boardFile.fileStrgNm }" data-originalfilename="${boardFile.fileOrgnlNm }">
												                    ${fn:substring(boardFile.fileOrgnlNm, 0, 15)}...
												                </a>
												            </c:when>
												            <c:otherwise>
												                <a href="javascript:void(0);" class="text-muted fw-bold">
												                    ${boardFile.fileOrgnlNm}
												                </a>
												            </c:otherwise>
												        </c:choose>
                                                           <p class="mb-0">${boardFile.fileFancysize }</p>
                                                       </div>
                                                       <div class="col-auto">
                                                           <!-- Button -->
                                                           <a href="javascript:void(0);" class="btn btn-link btn-lg text-muted downloadBoardFileLink"
																data-filename="${boardFile.fileStrgNm }" data-originalfilename="${boardFile.fileOrgnlNm }">
                                                               <i class="ri-download-2-line"></i>
                                                           </a>
                                                       </div>
                                                   </div>
                                               </div>
                                           </div>
                                       </div> <!-- end col -->
									</c:forEach>
                               	</div> <!-- end row -->
							</c:if>
							</c:if>

							<hr>

							<!-- 버튼 -->
							<div class="float-end mb-1 me-3">
								<c:choose>
									<c:when test="${bbsTyCd eq 'M010101' }">
										<sec:authorize access="hasRole('ROLE_ADMIN')">
											<button id="boardModifyBtn" class="btn btn-primary" data-bbstycd="${bbsTyCd }" data-bbsno="${boardVO.bbsNo }">수정</button>
										</sec:authorize>
									</c:when>
									<c:otherwise>
										<c:if test="${boardVO.emplId eq emplInfo.emplId}">
											<button id="boardModifyBtn" class="btn btn-primary" data-bbstycd="${bbsTyCd }" data-bbsno="${boardVO.bbsNo }">수정</button>
										</c:if>
									</c:otherwise>
								</c:choose>
								<c:if test="${boardVO.emplId eq emplInfo.emplId or 
										pageContext.request.userPrincipal != null && pageContext.request.isUserInRole('ROLE_ADMIN')}">
										<form action="/egg/deleteBoard" method="post" id="delForm" style="display: none;">
											<input type="hidden" name="bbsNo" value="${boardVO.bbsNo }">
											<input type="hidden" name="bbsTyCd" value="${boardVO.bbsTyCd }">
											<sec:csrfInput/>
										</form>
										<button id="boardDeleteBtn" class="btn btn-danger">삭제</button>
								</c:if>
								<a href="/egg/board?bbsTyCd=${bbsTyCd}" class="btn btn-secondary">목록</a>
							</div>
						</div>
						<div class="card-footer mb-2">
							<!-- 댓글 -->
							<c:if test="${bbsTyCd ne 'M010101' }">
								<div class="card mb-3"> <!-- comment : End card -->
	                                <div class="card-body"> <!-- comment : End card-body -->
	                                    <h4 class="mt-0 mb-3">댓글</h4>
	
										<!-- 댓글 입력창 -->
	                                    <textarea class="form-control form-control-light mb-2" placeholder="댓글을 입력해주세요..." 
	                                    	id="comment-input-section" rows="3" name="cmntCn"></textarea>
	                                    <div class="text-end">
	                                        <div class="btn-group mb-2 ms-2">
	                                            <button id="insert-comment-btn" type="button" class="btn btn-primary btn-sm" data-emplid="${emplInfo.emplId }" data-bbsno="${boardVO.bbsNo }">
													<i class="mdi mdi-send">
														<span>등록</span> 
													</i>
												</button>
	                                        </div>
	                                    </div>
										<!-- /댓글 입력창 -->
										
	
										<!-- 댓글 리스트 -->
										<div id="comment-list">
											<c:if test="${not empty commentList }">
												<c:forEach items="${commentList }" var="comment">
													<div class="comment-item_${comment.cmntNo }">
					                                    <div class="d-flex align-items-start mt-2" idx="${comment.cmntNo }">
					                                        <div class="w-100 overflow-hidden">
					                                        	<div class="d-flex justify-content-between">
															        <div>
							                                        	<!-- 작성자 -->
															            <h5 class="mt-0 d-inline">${comment.emplNm}</h5>
							                                        	<!-- 작성일시 -->
																		<c:choose>
																			<c:when test="${comment.cmntMdfcnDt ne null and comment.cmntMdfcnDt ne '' }">
																	            <span class="ms-2">${fn:substring(comment.cmntMdfcnDt, 0, 16)}</span>
																			</c:when>
																			<c:otherwise>
																	            <span class="ms-2">${fn:substring(comment.cmntWrtDt, 0, 16)}</span>
																			</c:otherwise>
																		</c:choose>
															        </div>
															        <div>
																        <c:if test="${comment.emplId eq emplInfo.emplId}">
																            <a href="javascript:void(0);" class="text-muted me-2 comment-edit-btn" data-cmntNo="${comment.cmntNo }">수정</a>
																        </c:if>
															            <c:if test="${comment.emplId eq emplInfo.emplId or 
															            	pageContext.request.userPrincipal != null && pageContext.request.isUserInRole('ROLE_ADMIN')}">
															            	<a href="javascript:void(0);" class="text-muted comment-delete-btn" data-cmntNo="${comment.cmntNo }">삭제</a>
																		</c:if>
															        </div>
															    </div>
					                                            <!-- 댓글 내용 -->
																<div class="comment-content">
																	<span class="ms-3">${comment.cmntCn }</span>
																</div>
					                                        </div>
					                                    </div>
					                                    <hr>
													</div>
												</c:forEach>
											</c:if>
										</div>
										<!-- /댓글 리스트 -->
	                                </div> <!-- comment : End card-body -->
	                            </div> <!-- comment : End card -->
							</c:if>
							
						</div> <!-- End card-footer -->
					</div> <!-- End card -->
				</div> <!-- End col-md-10 -->
				
				
			</div> <!-- End row -->
		</div> <!-- End container-fluid -->
	</div> <!-- End Content -->
	

</body>

<script type="text/javascript">

var originalCommentHTML = "";

$(function(){
	
	// 수정 버튼 클릭 시
    $(document).on("click", ".comment-edit-btn", function(e) {
    	e.preventDefault();
    	var cmntNo = $(this).data("cmntno");
    	// 취소시 복구할 html
        originalCommentHTML = $("#comment-list").find(".comment-item_" + cmntNo).html();
    	console.log(originalCommentHTML); // del
    	// 원본 댓글 내용
    	var originalContent = $("#comment-list").find(".comment-item_" + cmntNo).find(".comment-content span").text();
    	console.log(originalContent); // del

    	// 폼으로 변환
        var editFormHTML = "";
        editFormHTML += "<div class='d-flex align-items-start mt-2'>";
        editFormHTML += "	<div class='w-100 overflow-hidden'>";
        editFormHTML += "	<h5 class='mt-0 d-inline'>${emplInfo.emplNm}</h5>";
        editFormHTML += "		<form action='/egg/updateComment' method='post' class='edit-comment-form'>";
        editFormHTML += "			<input type='hidden' name='cmntNo' value='" + cmntNo + "'>";
        editFormHTML += "			<textarea class='form-control form-control-light mb-2' rows='2' name='cmntCn'>" + originalContent + "</textarea>";
        editFormHTML += "			<input type='button' class='btn btn-secondary float-end ms-2 comment-update-cancel-btn' data-cmntno='" + cmntNo + "' value='취소'/>";
        editFormHTML += "			<input type='button' class='btn btn-primary float-end comment-update-btn' value='수정'/>";
        editFormHTML += "		</form>";
        editFormHTML += "	</div>";
        editFormHTML += "</div>";
        
        $("#comment-list").find(".comment-item_" + cmntNo).html(editFormHTML);
    });
	
    // 삭제 버튼 클릭 시 (폼 제출)
    $(document).on("click", ".comment-delete-btn", function(e) {
    	e.preventDefault();
    	var cmntNo = $(this).data("cmntno");
    	if (!confirm("해당 댓글을 삭제하시겠습니까?")) {
			return false;
		}
    	// 삭제 ajax
    	$.ajax({
	        url: "/egg/deleteComment",
	        type: "POST",
	        data: { cmntNo: cmntNo },
	        beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
	        success: function(response) {
	            // 성공 시 댓글 삭제
	            console.log(response);
	            if (response) {
	                $("#comment-list").find(".comment-item_" + cmntNo).remove();
	                alert("댓글을 삭제했습니다.");
	            } else {
	                alert("댓글 삭제에 실패했습니다.");
	            }
	        },
	        error: function(error) {
	            alert("댓글 삭제에 실패했습니다.");
	        }
	    });
	    	
    });

    // 취소 버튼 클릭 시
    $(document).on("click", ".comment-update-cancel-btn", function() {
    	var cmntNo = $(this).data("cmntno");
    	$("#comment-list").find(".comment-item_" + cmntNo).html(originalCommentHTML);
        originalCommentHTML = "";
    });

    // 수정 버튼 클릭 시 (폼 제출)
    $(document).on("click", ".comment-update-btn", function(e) {
    	e.preventDefault();
    	var form = $(this).closest("form");
    	var cmntNo = form.find("input[name='cmntNo']").val();
        var cmntCn = form.find("textarea[name='cmntCn']").val();
        
        var commentData = {
			cmntNo: cmntNo,
			cmntCn: cmntCn
		};
    	
    	$.ajax({
	        url: "/egg/updateComment",
	        type: "post",
	        contentType: 'application/json',
	        data: JSON.stringify(commentData),
	        beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
	        success: function(response) {
	            // 성공 시 CommentVO 반환
	            console.log(response);
	            if (response != null) {
	                $("#comment-list").find(".comment-item_" + response.cmntNo).html(insertCommentHTML(response));
	            } else {
	                alert("댓글 수정에 실패했습니다.");
	            }
	        },
	        error: function(error) {
	            alert("댓글 수정에 실패했습니다.");
	        }
	    });
        
    });


	// 댓글입력 메서드
	$("#insert-comment-btn").on("click", function(){
		var commentContent = $("#comment-input-section").val();
		var emplId = $(this).data("emplid");
		var bbsNo = $(this).data("bbsno");
		
		
		if (commentContent == null || commentContent == "") {
			alert("입력된 내용이 없습니다.");
			$("#comment-input-section").focus();
			return false;
		}
		
		console.log("commentContent : " + commentContent);
		console.log("emplId : " + emplId);
		console.log("bbsNo : " + bbsNo);
		
		var data = {
			cmntCn: commentContent,
			emplId: emplId,
			bbsNo: bbsNo
		};
		
		// 댓글 등록 ajax 보내기
		$.ajax({
	        url: "/egg/insertComment",
	        type: "POST",
	        contentType: "application/json",
	        data: JSON.stringify(data),
	        beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
	        success: function(response) {
	            // 성공시 받은 데이터를 사용하여 댓글 리스트 업데이트
	            if (response != null) {
		            console.log(response);
		            var appendCode = insertCommentHTML(response);

		            console.log(appendCode);
		            $("#comment-list").prepend(appendCode);
		            $("#comment-input-section").val("");
				} else{
		            alert("댓글 등록에 실패했습니다.");
		            $("#comment-input-section").focus();
				}
	        },
	        error: function(error) {
	            alert("댓글 등록에 실패했습니다.");
	        }
	    });
	});
	
	// 댓글 prepend 매서드
	function insertCommentHTML(comment){
		var addCommentHTML = "<div class='comment-item_"+comment.cmntNo+"'>"; 
		addCommentHTML += "<div class='d-flex align-items-start mt-2'>";
		addCommentHTML += "<div class='w-100 overflow-hidden'>";
		addCommentHTML += "<div class='d-flex justify-content-between'>";
		addCommentHTML += "<div>";
		addCommentHTML += "<h5 class='mt-0 d-inline'>"+comment.emplNm+"</h5>";
		addCommentHTML += "<span class='ms-2'>"+(comment.cmntWrtDt).substr(0, 16)+"</span>";
		addCommentHTML += "</div>";
		addCommentHTML += "<div>";
		addCommentHTML += "<a href='javascript:void(0);' class='text-muted me-2 comment-edit-btn' data-cmntNo='"+comment.cmntNo+"'>수정</a>";
		addCommentHTML += "<a href='javascript:void(0);' class='text-muted comment-delete-btn' data-cmntNo='"+comment.cmntNo+"'>삭제</a>";
		addCommentHTML += "</div>";
		addCommentHTML += "</div>";
		addCommentHTML += "<div class='comment-content'>";
		addCommentHTML += "<span class='ms-3'>"+comment.cmntCn+"</span>";
		addCommentHTML += "</div>";
		addCommentHTML += "</div>";
		addCommentHTML += "</div>";
		addCommentHTML += "<hr>";
		addCommentHTML += "</div>";
		
		return addCommentHTML;
		
	};
	
	// 수정 메서드
	$("#boardModifyBtn").on("click", function() {
		var bbsTyCd = $(this).data("bbstycd");
		var bbsNo = $(this).data("bbsno");
		
		console.log("bbstycd : " + bbsTyCd);
		console.log("bbsNo : " + bbsNo);
		location.href = "/egg/boardUpdateForm?bbsTyCd="+bbsTyCd+"&bbsNo="+bbsNo;
	});
	
	// 삭제 메서드
	$("#boardDeleteBtn").on("click", function(){
		var bbsNo = $(this).data("bbsno");
		if (confirm("해당 게시글을 삭제 하시겠습니까?")) {
			$("#delForm").submit();
		}
	});
	
	// 파일 다운로드
    $(document).on('click', '.downloadBoardFileLink', function() {
        var fileName = $(this).data("filename");
        var originalFileName = $(this).data("originalfilename");
        $.ajax({
            url: "/egg/downloadFile",
            type: "POST",
            data: {
                fileName: fileName,
                originalFileName: originalFileName
            },
            beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
    			xhr.setRequestHeader(header, token);
    		},
            xhrFields: {
                responseType: 'blob'
            },
            success: function(blob, status, xhr) {
                var link = document.createElement('a');
                var url = window.URL.createObjectURL(blob);
                link.href = url;
                link.download = originalFileName;
                document.body.append(link);
                link.click();
                link.remove();
                window.URL.revokeObjectURL(url);
            },
            error: function(error) {
                console.log("Error downloading file: ", error);
                alert("파일 다운로드 중 오류가 발생했습니다.");
            }
        });
    });
	
	
	
}); // $(function(){});

</script>

</html>