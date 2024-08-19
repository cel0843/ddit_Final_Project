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
			
			<!-- del -->
			<c:choose>
				<c:when test="${bbsTyCd eq 'M010101'}"><c:set value="active" var="active1"/></c:when>
				<c:when test="${bbsTyCd eq 'M010102'}"><c:set value="active" var="active2"/></c:when>
				<c:when test="${bbsTyCd eq 'M010103'}"><c:set value="active" var="active3"/></c:when>
				<c:when test="${bbsTyCd eq 'M010104'}"><c:set value="active" var="active4"/></c:when>
			</c:choose>
			<div class="row">
				<!-- 좌측 -->
				<div class="col-md-2">
					<h3>공지게시판</h3>
				    <a href="/admin/board" class="list-group list-group-item list-group-item-action ${active1 }">공지사항</a>
				    <h3 class="mt-3">사내게시판</h3>
					<div class="list-group">
					    <a href="/admin/board?bbsTyCd=M010102" class="list-group-item list-group-item-action ${active2 }">사내스터디</a>
					    <a href="/admin/board?bbsTyCd=M010103" class="list-group-item list-group-item-action ${active3 }">기술블로그</a>
					    <a href="/admin/board?bbsTyCd=M010104" class="list-group-item list-group-item-action ${active4 }">사내동호회</a>
					</div>
				</div> <!-- End col -->
				
				<!-- 우측 -->
				<c:set value="등록" var="name"/>
				<c:if test="${status eq 'u' }">
					<c:set value="수정" var="name"/>	
				</c:if>
				
				<div class="col-md-10">
					<div class="card">
						<div class="card-header">
							<h3>공지사항 ${name }</h3>
						</div>
						<div class="card-body">

							<!-- 공지사항 등록 폼 -->
							<form action="/admin/registerBoard" method="post"
								enctype="multipart/form-data" id="boardForm">
								<c:if test="${status eq 'u' }">
									<input type="hidden" name="bbsNo" value="${boardVO.bbsNo }" />
									<input type="hidden" name="fileGroupNo" value="${boardVO.fileGroupNo }" />
								</c:if>
								<input type="hidden" name="bbsTyCd" value="${bbsTyCd }">
								<input type="hidden" name="emplId" value="${emplInfo.emplId }">
								
								<button type="button" onclick="testInsertContent()" class="btn btn-primary">시연데이터</button>
								
								<div class="form-group mb-3">
									<label for="bbsTtl">제목</label> <input type="text"
										class="form-control" id="bbsTtl" name="bbsTtl"
										placeholder="제목을 입력해주세요." value="${boardVO.bbsTtl }" />
								</div>
								<div class="form-group  mb-3">
									<label for="emplNm">작성자</label> <input type="text" readonly
										class="form-control" id="emplNm" value="${emplInfo.emplNm }" />
								</div>
								<div class="form-group mb-3">
									<label for="bbsCn">내용</label>
									<textarea id="bbsCn" name="bbsCn" class="form-control"
										rows="20">${boardVO.bbsCn }</textarea>
								</div>
								<div class="form-group">
									<label for="boFileArr">첨부파일</label> 
									<input type="file" class="form-control" id="boFileArr" name="boFileArr" multiple/>
								</div>
								<sec:csrfInput />
							</form>
							<!-- /공지사항 등록 폼-->

							<!-- 등록된 파일 보기 영역 -->
							<c:if test="${status eq 'u' }">
								<c:if test="${not empty boardVO.boardFileList }">
								<c:if test="${boardVO.boardFileList[0].fileOrgnlNm ne null and boardVO.boardFileList[0].fileOrgnlNm ne ''}">
									<div class="row mt-2 file-list-sections">
										<c:forEach items="${boardVO.boardFileList }" var="boardFile">
											<div class="col-xl-4 file-item">
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
																		<a href="javascript:void(0);" class="text-muted fw-bold">
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
																<a href="javascript:void(0);" class="btn btn-link btn-lg text-muted attachmentFileDel"
																	id="a-link_${boardFile.fileNo }"> 
																	<i class="mdi mdi-file-remove-outline"></i>
																</a>
															</div>
														</div>
													</div>
												</div>
											</div>
											<!-- end col -->
										</c:forEach>
									</div>
								</c:if>
								</c:if>
							</c:if>
						<!-- /등록된 파일 보기 영역 -->
						<div class="card-footer">
							
							<!-- 버튼 -->
							<div class="float-end mb-3 me-3">
								<button id="boardRegisterBtn" class="btn btn-primary">${name }</button>
								<c:choose>
									<c:when test="${status eq 'u'  }">
										<a href="/admin/boardDetail?bbsTyCd=${bbsTyCd }&bbsNo=${boardVO.bbsNo}" class="btn btn-secondary">취소</a>
									</c:when>
									<c:otherwise>
										<a href="/admin/board?bbsTyCd=${bbsTyCd}" class="btn btn-secondary">취소</a>
									</c:otherwise>
								</c:choose>
							</div>
							
						</div> <!-- End card-footer -->
					</div> <!-- End card -->
				</div> <!-- End col-md-10 -->
				
				
			</div> <!-- End row -->
		</div> <!-- End container-fluid -->
	</div> <!-- End Content -->
	

</body>

<script type="text/javascript">
	$(function() {

		// CKEDITOR 이미지 업로드 탭 생성
		CKEDITOR.replace("bbsCn",{
			filebrowserUploadUrl : '${pageContext.request.contextPath}/boardImageUpload.do?${_csrf.parameterName}=${_csrf.token}'
		});
		CKEDITOR.config.height = "500px";

		// 폼 제출 시 Dropzone 파일도 함께 전송
		$("#boardRegisterBtn").on("click", function(e) {
			e.preventDefault();

			var title = $("#bbsTtl").val();
			var content = CKEDITOR.instances.bbsCn.getData();

			if (title == null || title == "") {
				alert("제목을 입력해주세요!");
				$("#bbsTtl").focus();
				return false;
			}

			if (content == null || content == "") {
				alert("내용을 입력해주세요!");
				$("#bbsCn").focus();
				return false;
			}

			console.log("버튼 val : " + $(this).text());
			if ($(this).text() == "수정") {
				$("#boardForm").attr("action", "/admin/updateBoard");
			}

			$("#boardForm").submit();

		});

		//수정 시, 기존 파일 삭제 이벤트
		$(".attachmentFileDel").on("click", function(e) {
			e.preventDefault();
			var id = $(this).prop("id");
			var idx = id.indexOf("_");
			var boardFileNo = id.substring(idx + 1);
			var ptrn = "<input type='hidden' name='delFileNo' value='%V' />"; // %V ==> 치환자
			$("#boardForm").append(ptrn.replace("%V", boardFileNo));
			$(this).parents(".file-item:first").hide();
		});

	}); // $(function(){});
	
	function testInsertContent(){
		$("#bbsTtl").val("2024 사내 해커톤 개최");
		CKEDITOR.instances.bbsCn.setData("<p>자세한 내용은 첨부파일을 확인해주세요.</p><br/>");
	}
	
</script>

</html>