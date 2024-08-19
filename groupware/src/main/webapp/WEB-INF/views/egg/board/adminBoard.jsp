<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<html>
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
				<c:when test="${bbsTyCd eq 'M010101'}"><c:set value="active" var="active1"/></c:when>
				<c:when test="${bbsTyCd eq 'M010102'}"><c:set value="active" var="active2"/></c:when>
				<c:when test="${bbsTyCd eq 'M010103'}"><c:set value="active" var="active3"/></c:when>
				<c:when test="${bbsTyCd eq 'M010104'}"><c:set value="active" var="active4"/></c:when>
			</c:choose>
			<div class="row">
				<!-- 죄측 -->
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
				<div class="col-md-10">
					<div class="card">
						<div class="card-header">
							<!-- 검색 폼 -->
							<div class="row">
								<div class="col-lg-8"></div>
								<div class="col-lg-4">
		                            <form id="searchForm">
		                            <input type="hidden" name="bbsTyCd" value="${bbsTyCd }"/>
		                            <input type="hidden" name="page" id="page"/>
		                            	<div class="input-group">
		                            		<div>
												<select class="form-select" id="searchSelectBox" name="searchType">
												    <option value="title" <c:if test="${searchType eq 'title' }">selected</c:if>>제목</option>
												    <option value="writer" <c:if test="${searchType eq 'writer' }">selected</c:if>>작성자</option>
												</select>
		                            		</div>
											<input type="text" name="searchWord" class="form-control" placeholder="Search..." value="${searchWord }">
											<input class="btn btn-primary" type="submit" value="검색" style="margin-left: 3px;">
										</div>
		                            </form>
								</div>
							</div>
						</div>
						<div class="card-body">
							<!-- boardList -->
							<table class="table table-hover table-centered mb-0">
							    <thead>
							        <tr>
							            <th class="text-center">#</th>
							            <th>제목</th>
							            <th class="text-center">작성자</th>
							            <th class="text-center">작성일시</th>
							            <th class="text-center">조회수</th>
							        </tr>
							    </thead>
							    <tbody>
							    	<c:set value="${pagingVO.dataList }" var="boardList"/>
							    	<c:choose>
										<c:when test="${empty boardList }">
											<tr>
												<td colspan="5">조회하실 게시글이 존재하지 않습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${boardList }" var="board">
										        <tr>
										            <td class="text-center">${board.RNum }</td>
										            <td class="text-muted">
										            	<a href="/admin/boardDetail?bbsTyCd=${bbsTyCd }&bbsNo=${board.bbsNo}">${board.bbsTtl }</a>
										            </td>
										            <td class="text-center">${board.emplNm }</td>
										            <td class="text-center">${fn:substring(board.bbsCtrDt, 0, 16)}</td>
										            <td class="text-center"><span class="badge bg-primary">${board.bbsHit }</span></td>
										        </tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
							    </tbody>
							</table>
							
							<!-- board register btn -->
							<div class="float-end mt-2">
								<c:if test="${bbsTyCd eq 'M010101'}">
									<sec:authorize access="hasRole('ROLE_ADMIN')">
										<button id="boardRegisterFormBtn" class="btn btn-secondary" data-bbstycd="${bbsTyCd }">글작성</button>
									</sec:authorize>
								</c:if>
								<c:if test="${bbsTyCd ne 'M010101'}">
									<button id="boardRegisterFormBtn" class="btn btn-secondary" data-bbstycd="${bbsTyCd }">글작성</button>
								</c:if>
							</div>
							
						</div>
								<c:if test="${boardVO.emplId eq emplInfo.emplId or 
										pageContext.request.userPrincipal != null && pageContext.request.isUserInRole('ROLE_ADMIN')}">
								</c:if>
						
						<div id="pagingArea" class="card-footer">
							<nav>
								<!-- pagination -->
								${pagingVO.pagingHTML }
							</nav>
						</div> <!-- End card-footer -->
					</div> <!-- End card -->
				</div> <!-- End col-md-10 -->
				
				
			</div> <!-- End row -->
		</div> <!-- End container-fluid -->
	</div> <!-- End Content -->

</body>

<script type="text/javascript">
$(function(){
	var pagingArea = $("#pagingArea");
	var searchForm = $("#searchForm");
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault(); // 페이징에 들어있는 a태그 block
		var pageNo = $(this).data("page");
		// 검색 시 사용할 form태그안에 넣어준다.
		// 검색 시 사용할 rom태그를 활용해서 검색도 하고 피이징 처리도 같이 진행함
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	$("#boardRegisterFormBtn").on("click", function(){
		var bbsTyCd = $(this).data("bbstycd");
		location.href="/admin/boardRegisterForm?bbsTyCd="+bbsTyCd;
	});
});
</script>

</html>