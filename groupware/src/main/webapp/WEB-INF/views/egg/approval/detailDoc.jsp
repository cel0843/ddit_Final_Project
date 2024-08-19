
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<c:set value="${sessionScope.emplInfo}" var="emplInfo"/>
<div class="col-md-12">
	<div class="row">
		<div class="col-md-8">
			<div class="col-md-12">
				<div class="card">
					<div class="card-header">
						<h3>결재 하기</h3>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-md-4">
								<table class="table table-bordered table-centered mb-0" style="text-align: center;">
									<tr>
										<th class="table-active">기안자</th>
										<td>${doc.emplNm }</td>
									</tr>
									<tr>
										<th class="table-active">기안 부서</th>
										<td>${doc.deptNm }</td>
									</tr>
									<tr>
										<th class="table-active">기안 일시</th>
										<td><fmt:formatDate value="${doc.atrzDmndDt }" pattern="YYYY-MM-dd"/></td>
									</tr>									
								</table>
							</div>
						</div><br><br>
						<div class="col-md-12">
						<c:choose>
							<c:when test="${proj != null }">
								<table class="table table-bordered table-centered mb-0" style="text-align: center;">
						            <tr>
						                <th class="table-active">프로젝트 명</th>
						                <td colspan="3">
						                	<input type="text"  name="projNm" class="form-control" disabled="disabled"
						                	value="${proj.projNm }">
						                </td>
						            </tr>
						            <tr>
						                <th class="table-active" colspan="4">프로젝트 예상 일정</th>
						            </tr>
						            <tr>
						            	<th class="table-active">프로젝트 생성일</th>
						            	<td colspan="3">
						            		<fmt:parseDate value="${proj.projCrtYmd}" pattern="yyyyMMdd" var="parsedDate" />
											<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd"/>
										</td>
						            </tr>
						            <tr>
						            	<th class="table-active">프로젝트 마감일</th>
						            	<td colspan="3" >
						            		<fmt:parseDate value="${proj.projDdlnYmd }" pattern="yyyyMMdd" var="parseDate"  />
											<fmt:formatDate value="${parseDate}" pattern="yyyy-MM-dd"/>
						            	</td>
						            </tr>
						            <tr>
						            	<th class="table-active" colspan="4">프로젝트 상세내용</th>
						            </tr>
						            <tr>
							            <td colspan="4">
								            <textarea name="projExpln"   rows="10" cols="80" class="form-control" disabled="disabled">
								            	${doc.aprvCn }
								            </textarea>
							            </td>
						            </tr>
						        </table>
					        </c:when>
					        <c:when test="${dept != null }">
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
						                	<input type="text" id="positionCdNm"  name="positionCdNm" disabled="disabled" class="form-control" value="${dept.positionCdNm }" >
						                </td>
						                <td>
						               		<input type="text" id="emplNm" name="emplNm" class="form-control" disabled="disabled" value="${dept.emplNm }">
						                </td>
						                <td>
						                	<input type="text" id="deptNm" name="deptNm" class="form-control" disabled="disabled" value="${dept.deptNm }" >
						                </td>
						                <td>
						                	<input type="text" id="afterdeptNm" name="afterdeptNm" class="form-control" disabled="disabled" value="${dept.afterDeptNm }">
						                </td>
						               
						            </tr>
						            <tr>
						            	<th class="table-active" colspan="5">상세내용</th>
						            </tr>
						            <tr>
							            <td colspan="5">
								            <textarea name="aprvCn" id="aprvCn" disabled="disabled" rows="10" cols="80" class="form-control">${doc.aprvCn }
								            </textarea>
							            </td>
						            </tr>
						        </table>
					        </c:when>
					        <c:when test="${vac != null }">
					        	<table class="table table-bordered table-centered mb-0" style="text-align: center;">
						         	<tr>
						         		<th class="table-active">휴가 구분</th>
						         		<td colspan="3">
						         			<c:choose>
						         				<c:when test="${vac.formHdfSe == 'H'}">연차</c:when>
						         				<c:when test="${vac.formHdfSe == 'D'}">반차 </c:when>
						         			</c:choose>
						         		</td>
						         	</tr>
						            <tr>
						            	<th class="table-active">연차 시작일</th>
						            	<td colspan="3">
						            	${vac.hdBgngHr }
										</td>
						            </tr>
						            <tr>
						            	<th class="table-active">연차 종료일</th>
						            	<td colspan="3">${vac.hdEndHr }
						            	</td>
						            </tr>
						            <tr>
						            	<th class="table-active" colspan="4">연차 사유</th>
						            </tr>
						            <tr>
							            <td colspan="4">
								            <textarea name="hdReson" id="hdReson" rows="10" cols="80" disabled="disabled" class="form-control">
								            	${doc.aprvCn }
								            </textarea>
							            </td>
						            </tr>
						        </table>
						        
					        </c:when>
						</c:choose>
						</div>
					</div>
					<div class="card-footer">
						<c:if test="${fileList != null }">
							<div class="accordion" id="accordionPanelsStayOpenExample">
								<div class="accordion-item">
									<h2 class="accordion-header" id="panelsStayOpen-headingOne">
										<button class="accordion-button" type="button"
											data-bs-toggle="collapse"
											data-bs-target="#panelsStayOpen-collapseOne"
											aria-expanded="true"
											aria-controls="panelsStayOpen-collapseOne">첨부파일</button>
									</h2>
									<div id="panelsStayOpen-collapseOne"
										class="accordion-collapse collapse show"
										aria-labelledby="panelsStayOpen-headingOne">
										<div class="accordion-body">
											<ul>
											<c:forEach var="file" items="${fileList}">
												<li>
													<a href='javascript:void(0);' class='text-muted fw-bold downloadDocFileLink' data-filename='${file.fileStrgNm }' data-originalfilename='${file.fileOrgnlNm }'>
													  ${file.fileOrgnlNm }
													</a>
												</li>
											</c:forEach>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-4">
			<div class="col-md-12">
				<div class="card">
					<c:if test="${type == 'gjhg' && aprvFlag == true}">
						<div class="card-header">
							<button id="gjBtn" class="uil-edit-alt approve btn btn-soft-primary"  type="button">결재승인</button>
							<button id="brBtn" class="uil-times-circle approve btn btn-soft-danger" type="button" >결재반려</button>						
						</div>
					</c:if>
						<div class="card-body">
							<div>
								<table class="table table-bordered table-centered mb-0" id="aprvLine"style="text-align: center;">
									<tr>
										<td rowspan="5" width="10%" class="table-active">결재</td>
										<c:forEach var="line" items="${line}">
											<td width="30%">
												<c:choose>
													<c:when test="${line.agtId == null }">${line.positionCdNm} ${line.emplNm}</c:when>
													<c:when test="${line.agtId != null && line.aprvStatus != 'SEC00103' }">${line.positionCdNm} ${line.lastEmplNm}</c:when>
													<c:when test="${line.agtId != null && line.aprvStatus == 'SEC00103' }">${line.positionCdNm} ${line.agtNm}</c:when>
													
												</c:choose>
											</td>
										</c:forEach>
									</tr>
									<tr height="80px">
										<c:forEach var="line" items="${line}">
											<td class="esgn esgn${line.aprvLineNo }" width="30%" >
												<c:choose>
													<c:when test="${line.aprvStatus != 'SEC00103' && line.agtId != null}">
														<img src="${line.lastEsgn }" style="width:30%;height:80px;"></img>
													</c:when>
													<c:when test="${line.aprvStatus != 'SEC00103' && line.agtId == null}">
														<img src="${line.lastEsgn }" style="width:30%;height:80px;"></img>
													</c:when>
												</c:choose>
											</td>
										</c:forEach>
									</tr>
										<tr>
											<c:forEach var="line" items="${line}">
												<td class="signDate" width="30%">
													${line.aprvStatusNm} <br>${line.aprvDt}
												</td>
											</c:forEach>
										</tr>
								</table>
							</div>
							<div></div>
							<br>
							<div class="col">
						        <div class="collapse multi-collapse" id="multiCollapseExample1">
						            <div class="card card-body mb-0">
						                <label for="aprvOpnn">결재의견</label>
						                <textarea rows="5" cols="10" id="aprvOpnn1" name="aprvOpnn" class="form-control"></textarea>
						            </div>
						            <button class="btn btn-soft-primary" id="siSave" style="float: right;" >승인</button>
						        </div>
						    </div>
						    <div class="col">
						        <div class="collapse multi-collapse" id="multiCollapseExample2">
						            <div class="card card-body mb-0">
						               <label for="aprvOpnn">반려의견</label>
						               <textarea rows="5" cols="10" id="aprvOpnn2" name="aprvOpnn" class="form-control"></textarea>
						            </div>
						            <button class="btn btn-soft-primary" id="brSave" style="float: right;" >반려</button>
						        </div>
						    </div> <!-- end col -->
						</div>
						<div class="card-footer">
						    <button class="btn btn-dark" style="float: right;" onclick="goAprvList()">목록</button>
						</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function(){
	
	var editor = CKEDITOR.replace("projExpln");
	CKEDITOR.replace("aprvCn");
	CKEDITOR.replace("hdReson");
	//결재버튼
	$('#gjBtn').on("click", function() {
		$("#multiCollapseExample1").show();
	})
	
	//승인버튼
	$("#siSave").on('click', function() {
		var aprvLineNo = '${myAprv.aprvLineNo}';
	        
        $.ajax({
            url: '/egg/saveAprvLine',
            type: 'post',
			beforeSend : function(xhr){		// 데이터 전송전, 헤더에 csrf 값 설정
				xhr.setRequestHeader("${_csrf.headerName }", "${_csrf.token }");
			},
			data : {
				aprvLineNo : aprvLineNo,
				aprvStatus : "SEC00202",
				aprvOpnn : $('#aprvOpnn1').val(),
				finalAprvYn : '${myAprv.finalAprvYn}',
				aprvId : '${doc.aprvId}',
				formCd : '${doc.formCd}'
			},
			success: function(res) {    
				
				// Swal 알림창 표시 및 확인 버튼 클릭 시 페이지 리로드
	            Swal.fire({
	            	title: "승인",
	  			 	 text: "승인이 완료되었습니다.",
	  			 	 icon: "success",
	                confirmButtonText: "확인"
	            }).then((result) => {
					// 알람
					if (res.aprvId != null && res.aprvId != "") {
						// 알람타입 | 알람타이틀 | 알람내용 | 사용자조회고유아이디 | 부가정보
						var alarm_msg_to_json = {
							alarmType : "ALARM03",
							alarmTitle : "전자결재", 
							alarmContent : "승인된 결재정보가 있습니다.",
							referenceId : res.aprvId,
							referenceInfo : ""
						};
						alarmSock.send(JSON.stringify(alarm_msg_to_json));
					}
					// /알람
					
	                // 알람들 보내고 결재 성공시
					setTimeout(function(){
						if (result.isConfirmed) {
		                    location.reload(); // 페이지 리로드
		                }
					}, 1500); // 1.5초 후에 리로드
	            });
            },
            error: function(xhr, status, error) {
                console.error('실패:', error);
            }
        });	//ajax 끝
	})
	
	$('#brBtn').on("click", function() {
		$("#multiCollapseExample2").show();
	});
	
	//반려버튼
	$('#brSave').on("click", function() {
		var aprvLineNo = '${myAprv.aprvLineNo}';
		
		 $.ajax({
            url: '/egg/saveAprvLine',
            type: 'post',
			beforeSend : function(xhr){		// 데이터 전송전, 헤더에 csrf 값 설정
				xhr.setRequestHeader("${_csrf.headerName }", "${_csrf.token }");
			},
			data : {
				aprvLineNo : aprvLineNo,
				aprvStatus : "SEC00201",
				aprvOpnn : $('#aprvOpnn2').val(),
				finalAprvYn : 'Y',
				aprvId : '${doc.aprvId}',
				formCd : '${doc.formCd}'
			},
			success: function(res) {   
//				 Swal 알림창 표시 및 확인 버튼 클릭 시 페이지 리로드
	            Swal.fire({
	                title: "반려",
	                text: "반려처리가 완료되었습니다.",
	                icon: "warning",
	                confirmButtonText: "확인"
	            }).then((result) => {
					// 알람
					if (res.aprvId != null && res.aprvId != "") {
						// 알람타입 | 알람타이틀 | 알람내용 | 사용자조회고유아이디 | 부가정보
						var alarm_msg_to_json = {
							alarmType : "ALARM03",
							alarmTitle : "전자결재", 
							alarmContent : "반려된 결재정보가 있습니다.",
							referenceId : res.aprvId,
							referenceInfo : ""
						};
						alarmSock.send(JSON.stringify(alarm_msg_to_json));
					}// /알람
					
					// 알람들 보내고 결재 성공시
					setTimeout(function(){
						if (result.isConfirmed) {
		                    location.reload(); // 페이지 리로드
		                }
					}, 1500); // 1.5초 후에 리로드
	            });
				
				

            },
            error: function(xhr, status, error) {
                console.error('실패:', error);
            }
        });
		
		 
	});
	
	
	// 다운로드 기능
    $('.downloadDocFileLink').on('click',function() {
        var fileName = $(this).data("filename");
        var originalFileName = $(this).data("originalfilename");
        $.ajax({
            url: "/egg/downloadFile",
            type: "POST",
            data: {
                fileName: fileName,
                originalFileName: originalFileName
            },
            beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
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
	
});//ready

function goAprvList() {
	window.location.href = '${pageContext.request.contextPath}' + '/egg/aprvList';
}
</script>