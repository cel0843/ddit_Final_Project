<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- jstree css -->
<link href="${pageContext.request.contextPath}/resources/assets/vendor/jstree/themes/default/style.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/vendor/daterangepicker/daterangepicker.css" type="text/css" />
<style>
.table{
	text-align: center;
}
div.dataTables_wrapper div.dataTables_filter{
    display: none;
}
#basic-datatable_length{
	display: none;
}
#basic-datatable_info{
	display: none;
}
.linetable td{
	padding: 2px;
}
.ib {
	display: inline-block;
}

.ml-10 {
	margin-left: 10px;
}
body {
	font-family: Arial, sans-serif;
}

.container {
	display: flex;
	flex-direction: column;
	width: 100%;
	height: 100%
	max-width: 800px;
	margin: 0 auto;
	border: 1px solid #ccc;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.tabs {
	display: flex;
	border-bottom: 1px solid #ccc;
	margin-bottom: 20px;
}

.tab {
	padding: 10px 20px;
	cursor: pointer;
}

.tab.active {
	border-bottom: 2px solid #007bff;
	font-weight: bold;
}

.content {
	display: flex;
}

.left-panel, .right-panel {
	flex: 1;
	padding: 20px;
	border: 1px solid #ccc;
	margin-right: 10px;
}

.right-panel {
	margin-right: 0;
}

.right-panel table {
	width: 100%;
	border-collapse: collapse;
}

.right-panel th, .right-panel td {
	border: 1px solid #ccc;
	padding: 10px;
	text-align: left;
}

.right-panel th {
	background-color: #f8f8f8;
	text-align: center;
}

.center-button {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    margin: 0 10px;
}

.center-button button {
    margin: 5px 0;
}
</style>

<!-- 알람 연결 -->
<script type="text/javascript">
	console.log("#11111# refId : " + "${aprvId}");
	if ("${aprvId}" != "0") {
		alarmSock.onopen = function() {
			console.log("#22222# refId : " + "${aprvId}");
			// 알람타입 | 알람타이틀 | 알람내용 | 사용자조회고유아이디 | 부가정보
			var alarm_msg_to_json = {
				alarmType : "ALARM03",
				alarmTitle : "전자결재", 
				alarmContent : "새로운 결재정보가 있습니다.",
				referenceId : "${aprvId}",
				referenceInfo : ""
			};
			
			alarmSock.send(JSON.stringify(alarm_msg_to_json));
			console.log("######### referenceId : " + alarm_msg_to_json.referenceId);
		};
	}
</script>
<!-- /알람 연결 -->


<c:set value="${sessionScope.emplInfo}" var="emplInfo"/>
<c:set var="bgngYmd" value="${proxy.bgngYmd}" />
<c:set var="endYmd" value="${proxy.endYmd}" />
<c:set var="formattedBgngYmd" value="${fn:substring(bgngYmd, 0, 4)}/${fn:substring(bgngYmd, 4, 6)}/${fn:substring(bgngYmd, 6, 8)}" />
<c:set var="formattedEndYmd" value="${fn:substring(endYmd, 0, 4)}/${fn:substring(endYmd, 4, 6)}/${fn:substring(endYmd, 6, 8)}" />
<div class="col-lg-1" style="width:200px">
	<ul class="side-nav">
		<li class="side-nav-item" onclick="goAprvList()">
			<a href="javascript:void(0)"  class="side-nav-link" >
				<i class=" uil-file-edit-alt"></i>
				<span>결재하기</span>
			</a>
		</li>
		<li class="side-nav-item">
			<a data-bs-toggle="collapse" href="#sidebarCrm" aria-expanded="false"aria-controls="sidebarCrm" class="side-nav-link">
				<i class=" uil-folder-medical"></i>
				<span>개인문서함</span>
			</a>
			<div class="collapse" id="sidebarCrm">
				<ul class="side-nav-second-level">
					<li><a href="${pageContext.request.contextPath}/egg/draftList">기안문서함</a></li>
					<li><a href="${pageContext.request.contextPath}/egg/rfrncList">참조문서함</a></li>
				</ul>
			</div>
		</li>
		<li class="side-nav-item">
			<a data-bs-toggle="collapse" href="#aprvLine" aria-expanded="false" aria-controls="sidebarEcommerce" class="side-nav-link" >
				<i class="uil-user-check"></i>
				<span>결재라인 관리</span>
			</a>
			<div class="collapse" id="aprvLine">
				<ul class="side-nav-second-level">
					<li>	
					 	<button type="button" class="btn btn-warning" id="lineModal">설정하기</button>							
					</li>
				</ul>
			</div>
		</li>
		<li class="side-nav-item">
			<a data-bs-toggle="collapse" href="#sidebarEcommerce" aria-expanded="false" aria-controls="sidebarEcommerce" class="side-nav-link" >
				<i class="uil-user-check"></i>
				<span>대결자</span>
			</a>
			<div class="collapse" id="sidebarEcommerce">
				<ul class="side-nav-second-level">
					<li>	
						 <c:if test="${empty proxy || proxy.useYn == 'N'}"><button type="button" class="btn btn-primary" id="proxyModal">설정하기</button></c:if>
						 <c:if test="${proxy.useYn == 'Y'}">
							 <div class="alert alert-success" role="alert" >
						    	<h4 class="alert-heading">대결자<br> 설정완료!</h4>
							    <p>
							    	<h5>대결자</h5>${proxy.emplNm }<br>
							    	<h5>대결기간</h5>							    
							    	${formattedBgngYmd} - ${formattedEndYmd}</p>
							   
							</div>		
						</c:if>
					</li>
				</ul>
			</div>
		</li>
	</ul>
</div>
	<div class="col-lg-11" style="width:1400px">
		<c:if test="${draft != 'draft' && rfrnc != 'rfrnc' }">
		<div class="card">
			<div class="card-header">
				<div class="card-title">
					<h4>결재 리스트</h4>
				</div>
				<div class="card-tools">
					<p>
						결재 서류 개수: ${list.size() } 
					</p>
				</div>
				
				<p class="ib">문서상태</p>
				<select id="prgrsSttsTy" name="prgrsSttsTy"  class="ib" >
					<option value="">전체</option>
					<option value="SEC00103">대기</option>
					<option value="SEC00102">진행</option>
					<option value="SEC00101">완료</option>
				</select>
				
				<p class="ib ml-10">결재상태</p>
				<select id="aprvStatus" name="aprvStatus" class="ib" >
					<option value="">전체</option>
					<option value="SEC00202">승인</option>
					<option value="SEC00201">반려</option>
				</select>
				
			</div>
			
			<div class="card-body">
				<table  class="table table-hover table-centered mb-0" id="basic-datatable">
					<thead class="table-active">
						<tr>
							<th>NO</th>
							<th>제목</th>
							<th>기안자</th>
							<th>기안일</th>
							<th>결재일</th>
							<th>문서 상태</th>
							<th>결재 상태</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty list}">
								<tr>
									<td colspan="7" style="text-align: center;">${emplInfo.emplNm}님
										앞으로 조회된 결재 서류가 없습니다.</td>
								</tr>
							</c:when>
							<c:when test="${not empty list }">
								<c:forEach var="aprvDoc" items="${list}" varStatus="status">
									<tr class="detail" data-id="${aprvDoc.aprvId }" >
										<td>${status.count }</td>
										<td data-id="${aprvDoc.aprvId }">${aprvDoc.aprvTtl }</td>
										<td>${aprvDoc.emplNm }</td>
										<td><fmt:formatDate value="${aprvDoc.atrzDmndDt }"
												pattern="YYYY-MM-dd" /></td>
										<td><c:if test="${aprvDoc.atrzCmptnDt == null }">=======</c:if>
											<fmt:formatDate value="${aprvDoc.atrzCmptnDt}"
												pattern="YYYY-MM-dd" /></td>
										<td>
											<c:choose>
												<c:when test="${aprvDoc.prgrsSttsTy == 'SEC00101'}">
													<h3>
														<span class="badge badge-info-lighten">완료</span>
													</h3>
												</c:when>
												<c:when test="${aprvDoc.prgrsSttsTy == 'SEC00102'}">
													<h3>
														<span class="badge badge-success-lighten">진행</span>
													</h3>
												</c:when>
												<c:otherwise>
													<h3>
														<span class="badge badge-warning-lighten">대기</span>
													</h3>
												</c:otherwise>
											</c:choose>
										</td>
										<td>
											<c:choose>
												<c:when test="${aprvDoc.aprvStatus == 'SEC00202'}">
													<h3>
														<span class="badge badge-info-lighten">승인</span>
													</h3>
												</c:when>
												<c:when test="${aprvDoc.aprvStatus == 'SEC00201'}">
													<h3>
														<span class="badge badge-danger-lighten">반려</span>
													</h3>
												</c:when>
												<c:otherwise>
													<h3>
														<span class="badge badge-warning-lighten">대기</span>
													</h3>
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
							</c:when>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>
		</c:if>
		<c:if test="${draft == 'draft'}">
		<div class="card">
			<div class="card-header">
				<div class="card-title">
					<h4>기안문서함</h4>
				</div>
				<div class="card-tools">
					<p>
						기안 서류 개수: ${list.size() } 
						<button type="button" class="btn btn-soft-primary" id="addAprv" style="float: right;">+ 새 기안 등록</button>
					</p>
				</div>
			</div>
			
			<div class="card-body">
				<table  class="table table-hover table-centered mb-0" id="basic-datatable">
					<thead class="table-active">
						<tr>
							<th>NO</th>
							<th>제목</th>
							<th>기안자</th>
							<th>기안일</th>
							<th>결재일</th>
							<th>결재 상태</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty list}">
								<tr>
									<td colspan="6" style="text-align: center;">${emplInfo.emplNm}님이 기안한 문서가 없습니다.</td>
								</tr>
							</c:when>
							<c:when test="${not empty list }">
								<c:forEach var="aprvDoc" items="${list}" varStatus="status">
									<tr class="detail" data-id="${aprvDoc.aprvId }" >
										<td>${status.count }</td>
										<td data-id="${aprvDoc.aprvId }">${aprvDoc.aprvTtl }</td>
										<td>${aprvDoc.emplNm }</td>
										<td><fmt:formatDate value="${aprvDoc.atrzDmndDt }"
												pattern="YYYY-MM-dd" /></td>
										<td><c:if test="${aprvDoc.atrzCmptnDt == null }">=======</c:if>
											<fmt:formatDate value="${aprvDoc.atrzCmptnDt}"
												pattern="YYYY-MM-dd" /></td>
										<td>
											<c:choose>
												<c:when test="${aprvDoc.prgrsSttsTy == 'SEC00101'}">
													<h3>
														<span class="badge badge-info-lighten">완료</span>
													</h3>
												</c:when>
												<c:when test="${aprvDoc.prgrsSttsTy == 'SEC00102'}">
													<h3>
														<span class="badge badge-success-lighten">진행</span>
													</h3>
												</c:when>
												<c:otherwise>
													<h3>
														<span class="badge badge-warning-lighten">대기</span>
													</h3>
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
							</c:when>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>
		</c:if>
		<c:if test="${rfrnc == 'rfrnc'}">
			<div class="card">
				<div class="card-header">
					<div class="card-title">
						<h4>참조 문서함</h4>
					</div>
					<div class="card-tools">
						<p>참조 서류 개수: ${list.size() } </p>
					</div>
				</div>
				<div class="card-body">
					<table  class="table table-hover table-centered mb-0">
						<thead class="table-active">
							<tr>
								<th>NO</th>
								<th>제목</th>
								<th>기안자</th>
								<th>기안일</th>
								<th>결재일</th>
								<th>결재 상태</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty list}">
									<tr>
										<td colspan="6" style="text-align: center;">${emplInfo.emplNm}님
											앞으로 조회된 결재 서류가 없습니다.</td>
									</tr>
								</c:when>
								<c:when test="${not empty list }">
									<c:forEach var="aprvDoc" items="${list}" varStatus="status">
										<tr class="detail" data-id="${aprvDoc.aprvId }" >
											<td>${status.count }</td>
											<td data-id="${aprvDoc.aprvId }">${aprvDoc.aprvTtl }</td>
											<td>${aprvDoc.emplNm }</td>
											<td><fmt:formatDate value="${aprvDoc.atrzDmndDt }"
													pattern="YYYY-MM-dd" /></td>
											<td><c:if test="${aprvDoc.atrzCmptnDt == null }">=======</c:if>
												<fmt:formatDate value="${aprvDoc.atrzCmptnDt}"
													pattern="YYYY-MM-dd" /></td>
											<td>
												<c:choose>
													<c:when test="${aprvDoc.prgrsSttsTy == 'SEC00101'}">
														<h3>
															<span class="badge badge-info-lighten">완료</span>
														</h3>
													</c:when>
													<c:when test="${aprvDoc.prgrsSttsTy == 'SEC00102'}">
														<h3>
															<span class="badge badge-success-lighten">진행</span>
														</h3>
													</c:when>
													<c:otherwise>
														<h3>
															<span class="badge badge-warning-lighten">대기</span>
														</h3>
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
								</c:when>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
		</c:if>
		<c:if test="${draft != 'draft' && rfrnc != 'rfrnc' }">
			<div class="card">
				<div class="card-header">
					<div class="card-title">
						<h4>대결 리스트</h4>
					</div>
					<div class="card-tools">
						<p>
							결재 서류 개수: ${proxyDoc.size() } 
						</p>
					</div>
				</div>
				<div class="card-body">
					<table class="table table-hover table-centered mb-0">
						<thead class="table-active">
							<tr>
								<th>NO</th>
								<th>제목</th>
								<th>기안자</th>
								<th>기안일</th>
								<th>결재일</th>
								<th>문서 상태</th>
								<th>결재 상태</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty proxyDoc }">
									<tr>
										<td colspan="7" style="text-align: center;">${emplInfo.emplNm}님 앞으로 조회된 결재 서류가 없습니다.</td>
									</tr>
								</c:when>
								<c:when test="${proxyDoc != null }">
									<c:forEach var="proxyDoc" items="${proxyDoc }"
										varStatus="status">
										<tr class="agtDetail" data-id="${proxyDoc.aprvId }">
											<td>${status.count }</td>
											<td>${proxyDoc.aprvTtl }</td>
											<td>${proxyDoc.emplNm }</td>
											<td><fmt:formatDate value="${proxyDoc.atrzDmndDt }"
													pattern="YYYY-MM-dd" /></td>
											<td><c:if test="${proxyDoc.atrzCmptnDt == null }">=======</c:if>
												<fmt:formatDate value="${proxyDoc.atrzCmptnDt}"
													pattern="YYYY-MM-dd" /></td>
											<td>											
											<c:choose>
													<c:when test="${proxyDoc.prgrsSttsTy == 'SEC00101'}">
														<h3>
															<span class="badge badge-info-lighten">완료</span>
														</h3>
													</c:when>
													<c:when test="${proxyDoc.prgrsSttsTy == 'SEC00102'}">
														<h3>
															<span class="badge badge-success-lighten">진행</span>
														</h3>
													</c:when>
													<c:otherwise>
														<h3>
															<span class="badge badge-warning-lighten">대기</span>
														</h3>
													</c:otherwise>
												</c:choose>
											</td>
											<td>											
											<c:choose>
													<c:when test="${proxyDoc.aprvStatus == 'SEC00202'}">
														<h3>
															<span class="badge badge-info-lighten">승인</span>
														</h3>
													</c:when>
													<c:when test="${proxyDoc.aprvStatus == 'SEC00201'}">
														<h3>
															<span class="badge badge-danger-lighten">반려</span>
														</h3>
													</c:when>
													<c:otherwise>
														<h3>
															<span class="badge badge-warning-lighten">대기</span>
														</h3>
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
								</c:when>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
		</c:if>	
	</div>

	
	<div id="primary-header-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="primary-header-modalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header bg-primary">
	                <h4 class="modal-title" id="primary-header-modalLabel" >대결자 설정</h4>
	                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-hidden="true"></button>
	            </div>
	            <div class="modal-body">
	            <div class="alert alert-warning" role="alert">
						    <i class="ri-alert-line me-1 align-middle font-16"></i>
						    	대결자는 같은 직급의 사원만 지정할 수 있습니다.
				</div>
	             <form action="/egg/proxyInsert" id="agtForm" name="agtForm" method="post">
		              <div class="d-flex align-items-center">
		            	 <label for="agtId" class="form-label mb-0">대결자 지정</label>		            	 
				         <a id="searchAgt" class="badge bg-primary ms-2 d-flex align-items-center">
				            <i class="uil-search" style="font-size: 1.0rem;"></i>
				         </a>  
				      </div><br>          	
					    <input type="text" id="agtId" name="agtId" class="form-control">
					    <div id="jstree-99"></div>
					    <br>
					    <label for="bgngYmd" class="form-label">대결 시작일</label>					    
    					<input class="form-control" id="bgngYmd" type="date" name="bgngYmd">
    					<br>
					    <label for="endYmd" class="form-label">대결 종료일</label>					    
    					<input class="form-control" id="endYmd" type="date" name="endYmd">
					<sec:csrfInput/>
			  	 </form>	             
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
	                <button type="button" id="saveBtn" class="btn btn-primary">Save</button>
	            </div>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	<!-- 기안 등록시 결재 유형과 양식 선택 -->
	<div id="info-alert-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
	    <div class="modal-dialog modal-sm">
	        <div class="modal-content">
	            <div class="modal-body p-4">
	            <form action="/egg/projDoc" method="get" id="aprvDoc">
					<label for="formCd" class="form-label">결재 유형</label> 
					<select id="formCd" name="formCd" class="form-select">
						<option value="">결재유형을 선택하세요</option>
						<option value="AR">휴가신청</option>
						<option value="BP">프로젝트기안</option>
						<option value="HR">인사</option>
					</select>
				</form>
	            	<button type="button" class="btn btn-info my-2" data-bs-dismiss="modal" id="next">Next</button>
	            </div>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	<!-- 모달 컨트롤 시 사용할 HTML 코드 -->		
<div class="modal fade" id="bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myLargeModalLabel">결재라인 관리</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
            </div>
		<div class="modal-body">
			<ul class="nav nav-tabs mb-3">
				<li class="nav-item">
					<a href="#setAprvLine" data-bs-toggle="tab" aria-expanded="true" class="nav-link active"> 
						<i class="mdi mdi-home-variant d-md-none d-block"></i> 
						<span class="d-none d-md-block">설정된 결재라인</span>
					</a>
				</li>
				<li class="nav-item">
					<a href="#lineSet" data-bs-toggle="tab" aria-expanded="false" class="nav-link"> 
						<i class="mdi mdi-account-circle d-md-none d-block"></i> 
							<span class="d-none d-md-block">결재라인 지정하기</span>
					</a>
				</li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane show active" id="setAprvLine">
					<div class="container">
						<div class="content">
							<table class="table table table-centered mb-0 linetable" style="text-align: center;" id="newLine">
								<thead class="table-active">
									<tr>
										<th>선택</th>
										<th>NO</th>
										<th>결재 순서</th>
										<th>부서</th>
										<th>결재자</th>
									</tr>
								</thead>
								<tbody id="lineList"></tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="tab-pane" id="lineSet">
					<div class="container">
						<div class="content">
							<div class="left-panel">
								<div id="jstree-88" class="col-sm-3 mb-2 mb-sm-0"></div>
							</div>
							<div class="center-button">
								<button class="btn btn-dark" id="addLine">&gt;&gt;</button>
								<button class="btn btn-dark" id="minLine">&lt;&lt;</button>
							</div>
							<div class="right-panel">
								<table class="table table-hover table-centered">
									<thead>
										<tr>
											<th>순서</th>
											<th width="100px">부서</th>
											<th>이름</th>
											<th>직급</th>
										</tr>
									</thead>
									<tbody id="orderResult"></tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				
			</div>
			<div style="text-align: right; margin-top: 20px;">
				<button class="btn btn-primary" id="saveLine">확인</button>
			</div>
			</div>
		</div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
	
<!-- Daterangepicker js -->
<script src="${pageContext.request.contextPath}/resources/assets/vendor/daterangepicker/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/vendor/daterangepicker/daterangepicker.js"></script>	

<script type="text/javascript">
$(function(){
	
	let type = "${type}";
	
	//검색조건 세팅
	$('#prgrsSttsTy').val('${prgrsSttsTy}').prop("selected", true);
	$('#aprvStatus').val('${aprvStatus}').prop("selected", true);
	
	$('#prgrsSttsTy').on('change', function() {
		let prgrsSttsTy = $(this).val();
		let aprvStatus = $('#aprvStatus').val();
		window.location.href = '${pageContext.request.contextPath}' + '/egg/aprvList?prgrsSttsTy='+prgrsSttsTy + '&aprvStatus=' + aprvStatus;
	})
	
	$('#aprvStatus').on('change', function() {
		let prgrsSttsTy = $('#prgrsSttsTy').val();
		let aprvStatus = $(this).val();
		window.location.href = '${pageContext.request.contextPath}' + '/egg/aprvList?prgrsSttsTy='+prgrsSttsTy + '&aprvStatus=' + aprvStatus;
	})
	
	
	//기안 등록
	$("#addAprv").on("click",function(){
		 $("#info-alert-modal").modal('show');  
	});
	
	$("#next").on("click",function(){
		var formCd = $("#formCd").val();
		if( formCd == null || formCd ==""){
			alert("결재 유형을 선택해주세요!");
		}
		
		if( formCd == "BP"){
			$("#aprvDoc").submit();
		}else if( formCd == "HR"){
			$("#aprvDoc").attr("action","/egg/transDoc");
			$("#aprvDoc").submit();
		}else {
			$("#aprvDoc").attr("action","/egg/vacDoc");
			$("#aprvDoc").submit();
		}
	});
	
	// 모달 show
	$("#proxyModal").on("click",function(){
        $("#primary-header-modal").modal('show');        
	});	

	 // jstree 초기화
    $('#jstree-99').jstree({
        'core' : {
            'data' : []
        }
    });


	// 대결자 검색버튼 클릭이벤트-조직도 나오게
	$("#searchAgt").on("click",function(){		 
		
		$.ajax({
            url: '/egg/emplList',
            type: 'get',
            contentType: 'application/json',
			beforeSend : function(xhr){		// 데이터 전송전, 헤더에 csrf 값 설정
				xhr.setRequestHeader("${_csrf.headerName }", "${_csrf.token }");
			},
			 success: function(res) {                    
	                console.log(res);
	                var treeData = [];
	                var deptMap = {};

	                // 부서별로 그룹화
	                res.forEach(function(empl) {
	                    if (!deptMap[empl.deptCd]) {
	                        deptMap[empl.deptCd] = [];
	                    }
	                    deptMap[empl.deptCd].push(empl);
	                });

	                // 트리 데이터 생성
	                Object.keys(deptMap).forEach(function(deptCd, index) {
	                    var children = deptMap[deptCd].map(function(empl) {
	                        return {
	                        	'id' : empl.emplId,
	                            'text': empl.positionCdNm + "_" + empl.emplNm,
	                            "icon": "ri-user-line text-danger"
	                        };
	                    });

	                    treeData.push({
	                        "id": "node" + index,
	                        "icon": "ri-folder-line icon-lg text-success",
	                        "text": deptCd,
	                        "state": { "opened": false },
	                        'children': children
	                    });
	                });

	                // jstree 데이터 설정 및 새로 고침
	                $('#jstree-99').jstree(true).settings.core.data = treeData;
	                $('#jstree-99').jstree(true).refresh();
	            },
            error: function(xhr, status, error) {
                console.error('실패:', error);
            }
        });	//ajax 끝
		
	});	//click 끝
	
	 var myId = "${emplInfo.emplId}";		// 로그인 한 아이디
	 var myPnm = "${emplInfo.positionNm}";	// 로그인 한  직급
	 
	 // 노드 클릭 이벤트 
    $('#jstree-99').on('select_node.jstree', function(e, data) {
        var node = data.node;
        
        if(node.id == myId || extractPositionNm(node.text) != myPnm ){
    		alert("대결 대상이 아닙니다.");
    	}
        else if (node.icon === "ri-user-line text-danger") {
            alert(node.text+"님을 선택하셨습니다.");         
            $("#agtId").val(node.id);
            $('#jstree-99').hide();
        }
    });
	
	//modal 대리자 설정 insert
    $("#saveBtn").on("click",function(){
    	$("#agtForm").submit();
    });
	
	// tr 클릭시 결재문서 상세보기
	$(".detail").on("click",function(){
		aprvId = $(this).data("id");
		location.href = "${pageContext.request.contextPath }/egg/detailDoc?aprvId="+aprvId + "&type=" + type;
	});
	// 대결리스트 tr 클릭시 결재문서 상세보기
	$(".agtDetail").on("click",function(){
		aprvId = $(this).data("id");
		location.href = "${pageContext.request.contextPath }/egg/agtDetailDoc?aprvId="+aprvId + "&type=" + type;
	});
	
	// jstree 초기화(결재라인)
	$('#jstree-88').jstree({
		'core' : {
			'data' : []
		}
	});
	
	// 노드 클릭 이벤트 (결재라인)
	$('#jstree-88').on('select_node.jstree', function(e, data) {
		selectedNode = data.node;
	});
	
	// >> 버튼 클릭 이벤트 핸들러 추가
	$('#addLine').on('click', function() {
		if (selectedNode) {
			addNodeToTableLine(selectedNode);
			selectedNode = null; // 선택된 노드를 초기화하여 중복 추가 방지
		}
	});
	
	// 노드를 테이블에 추가하는 함수(결재선)
	function addNodeToTableLine(node) {
	    var orderResult = $('#orderResult');
	    var parentNode = $('#jstree-88').jstree('get_node', node.parent);
	    var nodeTextParts = node.text.split('_');
	    var position = nodeTextParts[0];
	    var name = nodeTextParts[1];
	    var newRow = "<tr data-empl='" + node.id + "'><td>" + (orderResult.children().length + 1) + "</td>";
	    newRow += "   <td>" + parentNode.text + "</td> <td>" + name + "</td><td>" + position + "</td></tr>";
	    orderResult.append(newRow);
	}
	
	// 순서 업데이트 함수
	function updateOrder() {
		$('#orderResult tr').each(function(index) {
			$(this).find('td:first').text(index + 1);
		});
	}
	
	var selectedRow = null;

	// 선택한 행 변수에 담기(결재선)
	$(document).on('click', '#orderResult tr', function() {
		$('#orderResult tr').removeClass('selected');
		$(this).addClass('selected');
		selectedRow = $(this);
	});
	
	$('#minLine').on('click', function() {
		if (selectedRow) {
			selectedRow.remove();
			updateOrder();
			selectedRow = null; // 선택된 행 초기화
		}
	});
	
	//결재라인 관리 모달
	$("#lineModal").on("click", function () {
	    $("#bs-example-modal-lg").modal('show');

	    $.ajax({
	        url: '/egg/emplList',
	        type: 'get',
	        contentType: 'application/json',
	        beforeSend: function (xhr) { // 데이터 전송전, 헤더에 csrf 값 설정
	            xhr.setRequestHeader(
	                "${_csrf.headerName }",
	                "${_csrf.token }");
	        },
	        success: function (res) {
	            var treeData = [];
	            var deptMap = {};

	            // 부서별로 그룹화
	            res.forEach(function (empl) {
	                if (!deptMap[empl.deptCd]) {
	                    deptMap[empl.deptCd] = [];
	                }
	                deptMap[empl.deptCd].push(empl);
	            });

	            // 트리 데이터 생성
	            Object.keys(deptMap).forEach(function (deptCd, index) {
	                var children = deptMap[deptCd].map(function (empl) {
	                        return {
	                            'id': empl.emplId,
	                            'text': empl.positionCdNm + "_" + empl.emplNm,
	                            'icon': "ri-user-line text-danger"
	                        };
	                    });

	                treeData.push({
	                    "id": "node"+ index,
	                    "icon": "ri-folder-line icon-lg text-success",
	                    "text": deptCd,
	                    "state": {
	                        "opened": false
	                    },
	                    'children': children
	                });
	            });

	            // jstree 데이터 설정 및 새로 고침(결재선)
	            $('#jstree-88').jstree(true).settings.core.data = treeData;
	            $('#jstree-88').jstree(true).refresh();

	        },
	        error: function (xhr, status, error) {
	            console.error('실패:', error);
	        }
	    }); //ajax 끝
	    
	 // 설정된 결재라인 확인하기
	    $.ajax({
	        url: '/egg/lineTemplate',
	        type: 'get',
	        contentType: 'application/json',
	        beforeSend: function (xhr) {
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
	        success: function (res) {
	            console.log("성공", res);

	            var tbody = $('#lineList');
	            if (res == null || res.length == 0) {
	                var frow = $('<tr>');
	                frow.append($('<td colspan="6" style="text-align: center;">').text("설정된 결재라인이 없습니다."));
	                tbody.append(frow);
	            } else {
	                res.sort((a, b) => {
	                    if (a.groupNo === b.groupNo) {
	                        return a.aprvOrder - b.aprvOrder;
	                    }
	                    return a.groupNo - b.groupNo;
	                });
	                
	                tbody.empty();

	                let currentGroupNo = null;
	                let rowspanCount = 0;
	                let displayGroupNo = 0;

	                res.forEach(function (lineItem, index) {
	                    var row = $('<tr>');
	                    
	                    if (currentGroupNo !== lineItem.groupNo) {
	                        if (rowspanCount > 0) {
	                            tbody.find('tr').eq(index - rowspanCount).find('td:first').attr('rowspan', rowspanCount);
	                            tbody.find('tr').eq(index - rowspanCount).find('td:nth-child(2)').attr('rowspan', rowspanCount);
	                        }
	                        currentGroupNo = lineItem.groupNo;
	                        rowspanCount = 1;
	                        displayGroupNo++;
	                        
	                        // 체크박스 열 추가 (그룹당 하나)
	                        row.append($('<td>').append(
	                            $('<input>', { type: 'checkbox', class: 'group-checkbox','data-group-no': lineItem.groupNo })
	                        ));
	                        
	                        row.append($('<td>').text(displayGroupNo));
	                    } else {
	                        rowspanCount++;
	                    }

	                    row.append($('<td>').text(lineItem.aprvOrder));
	                    row.append($('<td>').text(lineItem.deptNm));
	                    row.append($('<td>').text(lineItem.lineEmplNm + "(" + lineItem.positionNm + ")"));
	                    tbody.append(row);
	                });

	                if (rowspanCount > 0) {
	                    tbody.find('tr').eq(res.length - rowspanCount).find('td:first').attr('rowspan', rowspanCount);
	                    tbody.find('tr').eq(res.length - rowspanCount).find('td:nth-child(2)').attr('rowspan', rowspanCount);
	                }
					
	             // 기존 버튼 제거
	        	    $('#delBtn').remove();
	                // 삭제 버튼 추가
	                $('<button>')
	                    .text('선택 삭제')
	                    .addClass('btn btn-danger mt-3')
	                    .attr('id','delBtn')
	                    .click(function() {
	                        var selectedGroups = [];
	                        $('.group-checkbox:checked').each(function() {
	                            selectedGroups.push($(this).data('group-no'));
	                        });
	                        if (selectedGroups.length > 0) {
	                            deleteSelectedGroups(selectedGroups);
	                        } else {
	                            alert('삭제할 그룹을 선택해주세요.');
	                        }
	                    })
	                    .insertAfter(tbody);
	            }
	        },
	        error: function (xhr, status, error) {
	            console.error('실패:', error);
	        }
	    });

	    function deleteSelectedGroups(groupNos) {
	        $.ajax({
	            url: '/egg/deleteLineTemplates',
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify(groupNos),
	            beforeSend: function (xhr) {
	                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	            },
	            success: function(response) {
	                console.log('삭제 성공:', response);
	                // 삭제 후 목록 새로고침
	                location.reload();
	            },
	            error: function(xhr, status, error) {
	                console.error('삭제 실패:', error);
	                alert('삭제 중 오류가 발생했습니다.');
	            }
	        });
	    }
	    
	});
	
	// 결재라인 설정하기
	$("#saveLine").on("click",function(){
		// 결재자 정보를 저장할 테이블의 tbody를 선택
	    var newLine = $("#newLine tbody");
		
	    // 기존의 모든 행을 제거 (필요에 따라 유지할 수도 있음)
	    newLine.empty();

	    // 결재자 정보를 저장할 배열
	    var newLineArray = [];

	    // 결재자 정보 저장
	    $("#orderResult tr").each(function(index) {
	        var order = $(this).find("td:eq(0)").text(); 
	        var deptNm = $(this).find("td:eq(1)").text(); 
	        var name = $(this).find("td:eq(2)").text(); 
	        var position = $(this).find("td:eq(3)").text();  
	        var emplId = $(this).data("empl"); // 노드의 emplId 값 가져오기

	    	 // 결재자 정보를 배열에 추가
	        newLineArray.push({
	            aprvOrder: order,
	            lineEmplId: emplId
	        });
	        
	        // 새로운 행을 생성하고 데이터를 추가
// 	        var newRow = "<tr>" +
// 	            "<td>" + order + "</td>" +
// 	            "<td>" + deptNm + "</td>" +
// 	            "<td>" + name + " (" + position + ")" + "</td>" +
// 	            "</tr>";
	    });
	        console.log("결재라인 ",newLineArray);
	        
	     // 결재라인insert
		    $.ajax({
		        url: '/egg/insertLineTemp',
		        type: 'post',
		        contentType: 'application/json', // JSON 형식으로 데이터 전송
		        data: JSON.stringify({
		        	emplId : "${emplInfo.emplId}",
		            newLineArray: newLineArray
		        }) ,
		        beforeSend: function (xhr) { // 데이터 전송전, 헤더에 csrf 값 설정
		            xhr.setRequestHeader(
		                "${_csrf.headerName }",
		                "${_csrf.token }");
		        },
		        success: function (res) {
					console.log("성공", res);
					 location.reload();
		        },
		        error: function (xhr, status, error) {
		            console.error('실패:', error);
		        }
		    }); //ajax 끝
	   
	});
	
});//ready

function goAprvList() {
	window.location.href = '${pageContext.request.contextPath}' + '/egg/aprvList';
}

//node text에서 직급과 이름 분리하는 함수
function extractPositionNm(text) {
    return text.split('_')[0];
}
</script>
