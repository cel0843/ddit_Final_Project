<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<link href="${pageContext.request.contextPath}/resources/assets/vendor/jstree/themes/default/style.min.css" rel="stylesheet" type="text/css">
<style>
body {
	font-family: Arial, sans-serif;
}
.linetable td{
	padding: 2px;
}
.container {
	display: flex;
	flex-direction: column;
	width: 100%;
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
<c:set value="${sessionScope.emplInfo}" var="emplInfo"/> 
<div class="col-md-12">
	<div class="row">
		<div class="col-md-4">
			<div class="col-md-12">
				<div class="card">
					<div class="card-header"> 
						<h3>결재 메뉴</h3>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-md-12">
								<a class="uil-edit-alt btn btn-soft-primary" id="insert">결재 요청</a> 
								<a class="uil-user-check btn btn-soft-info " id="organization">결재 정보</a> 
								<a class="uil-user-check btn btn-soft-warning " id="lineTemp">결재라인 불러오기</a> 
								<a class="uil-times-circle btn btn-soft-danger" onclick="goAprvList()" >취소</a>
								<hr/>
							</div>
							<div class="col-md-8"></div>
							<div class="col-md-4">
							</div>
						</div>
					</div>
				</div>
			</div>
		
			<div class="col-md-12">
				<div class="card">
					<div class="card-header">
						<div class="card-title">
							<h3 style="float: left;">결재 정보</h3>
						</div>
					</div>
					<div class="card-body">
						<!-- 결재자 테이블(초기에는 숨김 처리) -->
						<div style="display: none;" id="approvalArea">
							<h4>결재라인</h4>
						<table class="table table-centered" id="approvalTable" style="text-align: center;">
						    <thead class="table-active">
						        <tr>
						            <th>결재 순서</th>
						            <th>부서</th>
						            <th>결재자</th>
						        </tr>
						    </thead>
						    <tbody>
						        <!-- 결재자 정보 여기에 추가 -->
						    </tbody>
						</table>
						</div>
						<!-- 참조자 테이블 (초기에는 숨김 처리) -->
						<div style="display: none;" id="referenceArea">
							<h4>참조자</h4>
						<table class="table table-centered" id="referenceTable" style="text-align: center;" >
						    <thead class="table-active">
						        <tr>
						            <th>부서</th>
						            <th>참조자</th>
						        </tr>
						    </thead>
						    <tbody>
						        <!-- 참조자 정보 여기에 추가 -->
						    </tbody>
						</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-8">
			<div class="card">
				<div class="card-header">
					<h3>결재 문서</h3>
					<button type="button" class="btn btn-soft-success" id="data" style="float: right;">시연 데이터</button>
				</div>
				<div class="card-body">
				<form action="/egg/addTransDoc" method="post" enctype="multipart/form-data" id="aprvDoc">
					<label for="aprvTtl">제목</label>
					<input type="text" id="aprvTtl" name="aprvTtl" class="form-control"><br>
			        <button type="button" class="btn btn-soft-warning" id="selEmpl" style="float: right;">+ 사원검색</button>
			        <table class="table table-bordered table-centered mb-0" style="text-align: center;">
			            <tr>
			                <th class="table-active" rowspan="2">부서이동 대상자</th>
			                <th class="table-active">직위</th>
			                <th class="table-active">성명</th>
			                <th class="table-active">발령 전 부서</th>
			                <th class="table-active">발령 후 부서</th>
			            </tr>
			            <tr height="50px">
			                <td>
			                	<input type="text" id="positionNm"  name="positionNm" class="form-control" >
			                </td>
			                <td>
			               		<input type="text" id="emplNm" name="emplNm" class="form-control" >
			                </td>
			                <td>
			                	<input type="text" id="deptNm" name="deptNm" class="form-control">
			                </td>
			                <td>
			                	<select class="form-control select2" data-toggle="select2" id="afterDeptCd" name="afterDeptCd">
			                		<c:forEach var="dept" items="${dept}">
			                			<option value="${dept.deptCd }">${dept.deptNm }</option>
			                		</c:forEach>
			                	</select>
			                </td>
			               
			            </tr>
			            <tr>
			            	<th class="table-active" colspan="5">상세내용</th>
			            </tr>
			            <tr>
				            <td colspan="5">
					            <textarea name="aprvCn" id="aprvCn" rows="10" cols="80" class="form-control">
					            </textarea>
				            </td>
			            </tr>
			            
			        </table>
					<div class="col-md-12 pt-3">
					    <label for="fileInput" class="form-label">첨부파일</label>
					     <input class="form-control" type="file" id="attachments" name="attachments" multiple>
					</div>
					<input type="hidden" id="fileGroupNo" name="fileGroupNo"> 
					<input type="hidden" id="rfrnc" name="rfrnc"> 
					<input type="hidden" id="selEmplId" name="selEmplId">
					<input type="hidden" id="formCd" name="formCd" value="HR">
					<input type="hidden" id="emplId" name="emplId">
					<input type="hidden" id="deptCd" name="deptCd">
					<sec:csrfInput />
				</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 사원검색모달 -->
<div id="primary-header-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="primary-header-modalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header bg-primary">
	                <h4 class="modal-title" id="primary-header-modalLabel" >사원 선택</h4>
	                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-hidden="true"></button>
	            </div>
	            <div class="modal-body">
					<select class="form-control select2" data-toggle="select2" id="transEmpl" name="transEmpl">
				    <optgroup label="보안 사업부">
				        <c:forEach var="emp" items="${transempl}">
				            <c:if test="${emp.deptCd == '보안 사업부'}">
				                <option value="${emp.emplId}">${emp.positionCdNm}_ ${emp.emplNm}</option>
				            </c:if>
				        </c:forEach>
				    </optgroup>
				    <optgroup label="기술 영업부">
				        <c:forEach var="emp" items="${transempl}">
				            <c:if test="${emp.deptCd == '기술 영업부'}">
				                <option value="${emp.emplId}">${emp.positionCdNm}_ ${emp.emplNm}</option>
				            </c:if>
				        </c:forEach>
				    </optgroup>
				    <optgroup label="사업부">
				        <c:forEach var="emp" items="${transempl}">
				            <c:if test="${emp.deptCd == '사업부'}">
				                <option value="${emp.emplId}">${emp.positionCdNm}_ ${emp.emplNm}</option>
				            </c:if>
				        </c:forEach>
				    </optgroup>
				    <optgroup label="QA 사업부">
				        <c:forEach var="emp" items="${transempl}">
				            <c:if test="${emp.deptCd == 'QA 사업부'}">
				                <option value="${emp.emplId}">${emp.positionCdNm}_ ${emp.emplNm}</option>
				            </c:if>
				        </c:forEach>
				    </optgroup>
				    <optgroup label="인사부">
				        <c:forEach var="emp" items="${transempl}">
				            <c:if test="${emp.deptCd == '인사부'}">
				                <option value="${emp.emplId}">${emp.positionCdNm}_ ${emp.emplNm}</option>
				            </c:if>
				        </c:forEach>
				    </optgroup>
				</select>
					
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
	                <button type="button" id="saveBtn" class="btn btn-primary">Save</button>
	            </div>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->

<!-- 결재정보(결재선, 참조자)모달 사용할 HTML 코드 -->		
<div class="modal fade" id="bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myLargeModalLabel">결재 정보</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
            </div>
			<div class="modal-body">
				<ul class="nav nav-tabs mb-3">
					<li class="nav-item">
						<a href="#aprvLine" data-bs-toggle="tab" aria-expanded="false" class="nav-link active"> 
							<i class="mdi mdi-home-variant d-md-none d-block"></i> 
							<span class="d-none d-md-block">결재선</span>
						</a>
					</li>
					<li class="nav-item"><a href="#selRfrnc" data-bs-toggle="tab"aria-expanded="true" class="nav-link"> 
					<i class="mdi mdi-account-circle d-md-none d-block"></i> 
					<span class="d-none d-md-block">참조자</span>
					</a>
					</li>
				</ul>

				<div class="tab-content">
					<div class="tab-pane show active" id="aprvLine">
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
					<div class="tab-pane" id="selRfrnc">
						<div class="container">
							<div class="content">
								<div class="left-panel">
									<div id="jstree-77" class="col-sm-3 mb-2 mb-sm-0"></div>
								</div>
								<div class="center-button">
									<button class="btn btn-dark" id="add">&gt;&gt;</button>
									<button class="btn btn-dark" id="min">&lt;&lt;</button>
								</div>
								<div class="right-panel">
									<table class="table table-hover table-centered">
										<thead>
											<tr>
												<th width="100px">부서</th>
												<th>이름</th>
												<th>직급</th>
											</tr>
										</thead>
										<tbody id="orderResultRfrnc"></tbody>
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
<!-- 결재라인 불러오기 모달 -->
<div class="modal fade" id="bs-example-modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModal" aria-hidden="true">
   <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myLargeModal">설정된 결재라인</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
            </div>
		<div class="modal-body">
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
		</div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
		
<script type="text/javascript">
$(function(){
	
	$("#data").on("click",function(){
		$("#aprvTtl").val("인턴 부서이동 요청");	
		 var demoData = `
			 <p>3. 이동 사유</p>

			 <p>&nbsp; &nbsp; &nbsp; 가. 대상자의 개인 역량 개발 및 경력 성장 기회 제공</p>

			 <p>&nbsp; &nbsp; &nbsp; 나. 기술영업팀의 인력 보강 필요성</p>

			 <p>&nbsp; &nbsp; &nbsp; 다. QA 경험을 바탕으로 한 개발 품질 향상 기대</p>

			 <p>4. 희망 이동 시기</p>

			 <p>&nbsp; &nbsp; &nbsp;2024년 6월 1일</p>

			 <p>5. 고려사항</p>

			 <p>&nbsp; &nbsp; &nbsp; 가. 이동 대상자의 동의를 얻었음</p>

			 <p>&nbsp; &nbsp; &nbsp; 나. QA사업부의 업무에 차질이 없도록 인수인계 계획 수립 예정</p>

			 <p>6. 요청사항 위 내용을 검토하시어 부서이동 승인을 요청드립니다.</p>
	            `;
	            CKEDITOR.instances.aprvCn.setData(demoData);
		
	});
	var selEmplIdArray = []; //결재자 정보 
	var rfrncArray = [];	//참조자 정보
	
	//결재라인 불러오기
	$("#lineTemp").on("click", function() {
	    $.ajax({
	        url: '/egg/lineTemplate',
	        type: 'get',
	        contentType: 'application/json',
	        beforeSend: function (xhr) {
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
	        success: function (res) {
	            console.log("성공", res);
	            var tbody = $('#approvalArea tbody');
	            if (res == null || res.length == 0) {
	                var frow = $('<tr>');
	                frow.append($('<td colspan="3" style="text-align: center;">').text("설정된 결재라인이 없습니다."));
	                tbody.append(frow);
	            } else if (res.length > 1) {
	                $("#bs-example-modal").modal('show');
	                displayModalContent(res);
	            } else {
	                displaySingleLineContent(res);
	            }
	            $("#approvalArea").show();
	        },
	        error: function (xhr, status, error) {
	            console.error('실패:', error);
	        }
	    });
	});

	function displayModalContent(data) {
	    var modalTbody = $('#lineList');
	    modalTbody.empty();

	    data.sort((a, b) => {
	        if (a.groupNo === b.groupNo) {
	            return a.aprvOrder - b.aprvOrder;
	        }
	        return a.groupNo - b.groupNo;
	    });

	    let currentGroupNo = null;
	    let rowspanCount = 0;
	    let displayGroupNo = 0;

	    data.forEach(function (lineItem, index) {
	        var row = $('<tr>');
	        
	        if (currentGroupNo !== lineItem.groupNo) {
	            if (rowspanCount > 0) {
	                modalTbody.find('tr').eq(index - rowspanCount).find('td:first').attr('rowspan', rowspanCount);
	                modalTbody.find('tr').eq(index - rowspanCount).find('td:nth-child(2)').attr('rowspan', rowspanCount);
	            }
	            currentGroupNo = lineItem.groupNo;
	            rowspanCount = 1;
	            displayGroupNo++;
	            
	            row.append($('<td>').append(
	                $('<input>', { type: 'radio', name: 'groupSelect', class: 'group-radio', 'data-group-no': lineItem.groupNo })
	            ));
	            
	            row.append($('<td>').text(displayGroupNo));
	        } else {
	            rowspanCount++;
	        }

	        row.append($('<td>').text(lineItem.aprvOrder));
	        row.append($('<td>').text(lineItem.deptNm));
	        row.append($('<td>').text(lineItem.lineEmplNm + "(" + lineItem.positionNm + ")"));
	        modalTbody.append(row);
	    });

	    if (rowspanCount > 0) {
	        modalTbody.find('tr').eq(data.length - rowspanCount).find('td:first').attr('rowspan', rowspanCount);
	        modalTbody.find('tr').eq(data.length - rowspanCount).find('td:nth-child(2)').attr('rowspan', rowspanCount);
	    }

	    // 기존 버튼 제거
	    $('#applyGroupButton').remove();

	    // 새 버튼 추가
	    $('<button>')
	        .text('선택 그룹 적용')
	        .addClass('btn btn-primary mt-3')
	        .attr('id', 'applyGroupButton')
	        .click(function() {
	            var selectedGroupNo = $('input[name="groupSelect"]:checked').data('group-no');
	            if (selectedGroupNo) {
	                applySelectedGroup(data, selectedGroupNo);
	            } else {
	                alert('그룹을 선택해주세요.');
	            }
	        })
	        .insertAfter(modalTbody);
	}

	function applySelectedGroup(data, groupNo) {
	    selEmplIdArray = []; // 기존 배열 초기화
	    var selectedLines = data.filter(item => item.groupNo === groupNo);
	    selectedLines.forEach(lineItem => {
	        selEmplIdArray.push(lineItem.lineEmplId);
	    });
	    
	    displaySingleLineContent(selectedLines);
	    
	    $("#bs-example-modal").modal('hide');
	    
	    $("#selEmplId").val(selEmplIdArray.join(","));
	    console.log("선택된 결재라인:", selEmplIdArray);
	}

	function displaySingleLineContent(data) {
	    var tbody = $('#approvalArea tbody');
	    tbody.empty();
	    
	    selEmplIdArray = []; // 배열 초기화
	    
	    data.forEach(function (lineItem) {
	        var row = $('<tr>');
	        row.append($('<td>').text(lineItem.aprvOrder));
	        row.append($('<td>').text(lineItem.deptNm));
	        row.append($('<td>').text(lineItem.lineEmplNm+"("+lineItem.positionNm+")"));
	        tbody.append(row);
	        selEmplIdArray.push(lineItem.lineEmplId); // lineEmplId를 배열에 추가
	    });
	    // selEmplId 입력 필드에 선택된 결재라인 ID들을 설정
	    $("#selEmplId").val(selEmplIdArray.join(","));
	    console.log("선택된 결재라인:", selEmplIdArray);
	    
	    $("#approvalArea").show();
	}
	
	$("#selEmpl").on("click",function(){
		$("#primary-header-modal").modal("show");
	});
	
	$("#saveBtn").on("click",function(){
		var emplId = $('#transEmpl').val();
		
		$.ajax({
	        url: '/egg/getEmplInfo',
	        type: 'get',
	        beforeSend: function (xhr) { // 데이터 전송전, 헤더에 csrf 값 설정
	            xhr.setRequestHeader(  "${_csrf.headerName }", "${_csrf.token }");
	        },
	        data : {
	        	emplId : emplId
	        },
	        success: function (res) {
	        	console.log("asdf", res);
	        	$('#positionNm').val(res.positionCdNm);
	        	$('#emplNm').val(res.emplNm);
	        	$('#deptNm').val(res.deptNm);
	        	$("#emplId").val(res.emplId);
	        	$("#deptCd").val(res.deptCd);
	        	
	        	 // 모달 창 닫기
                $("#primary-header-modal").modal("hide");
	        },
	        error: function (xhr, status, error) {
	            console.error('실패:', error);
	        }
	    });
		
		
	});
	
	var editor = CKEDITOR.replace("aprvCn", {
    height: "500px",
    extraAllowedContent: 'input[*];'
	});
	
	editor.on('instanceReady', function(evt) {
	    this.document.on('click', function(event) {
	        var element = event.data.getTarget();
	        if (element.is('input')) {
	            element.setAttribute('contenteditable', 'true');
	            var range = editor.createRange();
	            range.selectNode(element.$);
	            editor.getSelection().selectRanges([range]);
	        }
	    });
	});
	
	
	
	// 결재자 & 참조자 정보 저장
	$("#saveLine").on("click",function(){
		// 결재자 정보를 저장할 테이블의 tbody를 선택
	    var $approvalTableBody = $("#approvalTable tbody");

	    // 기존의 모든 행을 제거 (필요에 따라 유지할 수도 있음)
	    $approvalTableBody.empty();

	    // 결재자 정보를 저장할 배열
	    var selEmplIdArray = [];

	    // 결재자 정보 저장
	    $("#orderResult tr").each(function(index) {
	        var order = $(this).find("td:eq(0)").text(); 
	        var deptNm = $(this).find("td:eq(1)").text(); 
	        var name = $(this).find("td:eq(2)").text(); 
	        var position = $(this).find("td:eq(3)").text();  
	        var emplId = $(this).data("empl"); // 노드의 emplId 값 가져오기

	        // 새로운 행을 생성하고 데이터를 추가
	        var newRow = "<tr>" +
	            "<td>" + order + "</td>" +
	            "<td>" + deptNm + "</td>" +
	            "<td>" + name + " (" + position + ")" + "</td>" +
	            "</tr>";

	        // 새로운 행을 테이블에 추가
	        $approvalTableBody.append(newRow);

	        // 결재자 정보를 배열에 추가
	        selEmplIdArray.push(emplId);
	    });

	    // 참조자 정보를 저장할 테이블의 tbody를 선택
	    var $referenceTableBody = $("#referenceTable tbody");

	    // 기존의 모든 행을 제거 (필요에 따라 유지할 수도 있음)
	    $referenceTableBody.empty();

	    // 참조자 정보를 저장할 배열
	    var rfrncArray = [];

	    // 참조자 정보 저장
	    $("#orderResultRfrnc tr").each(function(index) {
	        var deptNm = $(this).find("td:eq(0)").text(); 
	        var name = $(this).find("td:eq(1)").text(); 
	        var position = $(this).find("td:eq(2)").text();  
	        var emplId = $(this).data("empl"); // 노드의 emplId 값 가져오기

	        // 새로운 행을 생성하고 데이터를 추가
	        var newRow = "<tr>" +
	            "<td>" + deptNm + "</td>" +
	            "<td>" + name + " (" + position + ")" + "</td>" +
	            "</tr>";

	        // 새로운 행을 테이블에 추가
	        $referenceTableBody.append(newRow);

	        // 참조자 정보를 배열에 추가
	        rfrncArray.push(emplId);
	        $("#bs-example-modal-lg").modal('hide');
	    });

	    // 참조자 정보가 있는 경우 참조자 테이블을 표시
	    if ($("#orderResultRfrnc tr").length > 0) {
	        $("#referenceArea").show();
	    } else {
	        $("#referenceArea").hide();
	    }

	    // 결재자 정보가 있는 경우 결재자 테이블을 표시
	    if ($("#orderResult tr").length > 0) {
	        $("#approvalArea").show();
	    } else {
	        $("#approvalArea").hide();
	    }

	    // hidden 필드에 결재자와 참조자 정보를 설정
	    $("#selEmplId").val(selEmplIdArray.join(","));
	    $("#rfrnc").val(rfrncArray.join(","));
	    
	    console.log("결재라인 ",$("#selEmplId").val());
	    console.log("참조자", $("#rfrnc").val());
	    
	    if(confirm("결재 라인을 마무리 하시겠습니까?")){
		    $("#bs-example-modal-lg").modal("hide");
	   	}
		
	})// 결재정보 저장 끝

		// jstree 초기화(결재선)
		$('#jstree-88').jstree({
			'core' : {
				'data' : []
			}
		});

		// jstree 초기화(참조자)
		$('#jstree-77').jstree({
			'core' : {
				'data' : []
			}
		});

		// 노드 클릭 이벤트 (결재선)
		$('#jstree-88').on('select_node.jstree', function(e, data) {
			selectedNode = data.node;
		});
		// 노드 클릭 이벤트 (참조자)
		$('#jstree-77').on('select_node.jstree', function(e, data) {
			selectedNode = data.node;
		});

		// >> 버튼 클릭 이벤트 핸들러 추가
		$('#addLine').on('click', function() {
			if (selectedNode) {
				addNodeToTableLine(selectedNode);
				selectedNode = null; // 선택된 노드를 초기화하여 중복 추가 방지
			}
		});
		// >> 버튼 클릭 이벤트 핸들러 추가
		$('#add').on('click', function() {
			if (selectedNode) {
				addNodeToTable(selectedNode);
				selectedNode = null; // 선택된 노드를 초기화하여 중복 추가 방지
			}
		});

		// 양식 불러오기 활성/비활성 조건 함수
		function displayForm() {
			if (aprvTyFlag && formTtlFlag) {
				$("#formLoad").show();
				$("#loadAprvLine").show();
			}
		}

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

		// 노드를 테이블에 추가하는 함수(참조자)
		function addNodeToTable(node) {
		    var orderResultRfrnc = $('#orderResultRfrnc');
		    var parentNode = $('#jstree-77').jstree('get_node', node.parent);
		    var nodeTextParts = node.text.split('_');
		    var position = nodeTextParts[0];
		    var name = nodeTextParts[1];
		    var newRow = "<tr data-empl='" + node.id + "'><td>" + parentNode.text + "</td> <td>" + name + "</td><td>" + position + "</td></tr>";
		    orderResultRfrnc.append(newRow);
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

		// 선택한 행 변수에 담기(참조자)
		$(document).on('click', '#orderResultRfrnc tr', function() {
			$('#orderResultRfrnc tr').removeClass('selected');
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

		$('#min').on('click', function() {
			if (selectedRow) {
				selectedRow.remove();
				selectedRow = null; // 선택된 행 초기화
			}
		});

		$("#organization").on("click", function () {
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

		            // jstree 데이터 설정 및 새로 고침(참조자)
		            $('#jstree-77').jstree(true).settings.core.data = treeData;
		            $('#jstree-77').jstree(true).refresh();
		        },
		        error: function (xhr, status, error) {
		            console.error('실패:', error);
		        }
		    }); //ajax 끝
		});

		$('#attachments').on('change',function () {
			    var form = new FormData();
			    var files = $('#attachments')[0].files;
			    for (var i = 0; i < files.length; i++) {
			        form.append('attachments', files[i]);
			    }
			    $.ajax({
			        url: '/egg/aprvUpload',
			        type: 'POST',
			        data: form,
			        processData: false,
			        contentType: false,
			        beforeSend: function (xhr) {
			            // 데이터 전송 전, 헤더에 CSRF 값 설정
			            xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}");
			        },
			        success: function (data) {
			            if (data.success) {
			                // 파일 그룹 넘버를 폼에 추가
			                $('#fileGroupNo').val( data.fileGroupNo);
			            } else {
			                alert('업로드 실패 : ' + data.message);
			            }
			        },
			        error: function (jqXHR, textStatus, errorThrown) {
			            console.error('Error:', errorThrown);
			        }
			    });
			});

		$("#insert").on("click", function() {
		    $("#formCd").val();
		    console.log("formCd value:", $("#formCd").val());
			$("#transEmpl").val();
			
		 
		    // CKEditor의 내용을 가져옵니다.
		    var editorContent = CKEDITOR.instances.aprvCn.getData();
		  	console.log(editorContent);
		  	
		
		    // 폼 제출
		    $("#aprvDoc").submit();
		});

});//ready 끝
function goAprvList() {
	window.location.href = '${pageContext.request.contextPath}' + '/egg/aprvList';
}
</script>