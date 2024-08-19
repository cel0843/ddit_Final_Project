<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="${pageContext.request.contextPath}/resources/assets/vendor/jquery.rateit/scripts/jquery.rateit.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/assets/vendor/jquery.rateit/scripts/rateit.css" rel="stylesheet">
<script src="https://www.gstatic.com/charts/loader.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script> 








<style>

 #calendar { 
 	width:1100px; 
 	text-align: center; 
 	margin: auto; 
 } 

  .row-btn { 
 	 width:200px; 
	 
 } 

   .row-Sorting {
  	display:flex; /* 가로 정렬  */
  } 

.container { 	/* 회의실 선택 버튼 컨테이너  */
	display: flex;
	flex-wrap: wrap;
	gep: 20px;
}

.card {
	flex: 1 1 calc(20% - 20px);
	box-sizing: border-box;
/* 	margin: 10px; */
}

.card-body {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
}

.card-body-btn {
	text-align: center;
 	height: 50px;
}

/*수정모달창 버튼 시작*/
.btn-custom {
    width: 150px; /* 버튼의 너비를 통일 */
    height: 40px; /* 버튼의 높이 설정 */
/*수정모달창 버튼 끝*/
}

</style>




</head>
<body>
<script type="text/javascript">
</script>
<div class="header">
	
 		<div>
 			<h2><i class="ri-time-line"></i>예약및대여</h2>
 		</div>
			
				<!-- 가로 정렬 -->
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.customEmpl" var="customEmpl" />
</sec:authorize>

	<div class="row">
		<div class="col-12">
			<div class="card-body">
				<!-- /////////////// 비품 예약 현황 상세 시작 //////////////////// -->
				<div class="row col-md-12">
				  <!-- ///////// 왼쪽 비품 상세 영역 시작 //////////////////// -->
                  <div class="col-xl-5 col-lg-5">
                      <div class="card text-center">
                          <div class="card-body" style="justify-content:space-between;display:flex;">
                          	  <div style="float:left;">
			                      <h5 class="mb-3 text-uppercase bg-light p-2"><i class="mdi mdi-office-building me-1"></i> 비품 상세</h5>
	                              <h4 class="mb-0 mt-2">비품명 : ${fixuresVO.fixNm}</h4>
	                              <p class="text-muted font-14"> <img src="${fixuresVO.fixImg}" style="width:70%;" /></p>
                              </div>
                              <div style="float:right;">
                              </div>
                          </div> <!-- end card-body -->
                      </div> <!-- end card -->
                  </div> 
                  <!-- ///////// 왼쪽 비품 상세 영역 끝 //////////////////// -->
				  
				  <!-- ///////// 오른쪽 비품 예약 상세 영역 시작 //////////////////// -->
                  <div class="col-xl-7 col-lg-7">
                      <div class="card">
                          <div class="card-body">
                              <div class="tab-content" style="width:100%;">
                                  <div class="tab-pane active show" id="settings" role="tabpanel">
                                      <form>
                                          <h5 class="mb-3 text-uppercase bg-light p-2"><i class="mdi mdi-office-building me-1"></i> 비품 예약 상세</h5>
                                          <div class="row">
                                              <div class="col-md-6">
                                                  <div class="mb-6">
                                                      <label for="fixRsvtCd" class="form-label">예약번호</label>
                                                      <input type="text" class="form-control clsRsvt" id="fixRsvtCd" name="fixRsvtCd" 
                                                      	value="${fixuresVO.fixuresRsvtVOList[0].fixRsvtNo}" readonly style="width:100%;" />
                                                  </div>
                                              </div>
                                              <div class="col-md-6">
                                                  <div class="mb-6">
                                                      <label for="emplId" class="form-label">예약자</label>
                                                      <input type="text" class="form-control clsRsvt" id="emplId" name="emplId"
                                                      	 value="${fixuresVO.fixuresRsvtVOList[0].emplId}" readonly style="width:100%;" />
                                                  </div>
                                              </div> <!-- end col -->
                                          </div> <!-- end row -->
                                          <div class="row" style="margin-top:20px;">
                                              <div class="col-md-6">
                                                  <div class="mb-6">
                                                      <label for="fixRsvtBgngDt" class="form-label">예약시작일시</label>
                                                      <input type="text" class="form-control clsRsvt" id="fixRsvtBgngDt" name="fixRsvtBgngDt" 
                                                      	value="${fixuresVO.fixuresRsvtVOList[0].fixRsvtBgngDt}" readonly style="width:100%;" />
                                                  </div>
                                              </div>
                                              <div class="col-md-6">
                                                  <div class="mb-6">
                                                      <label for="fixRsvtEndDt" class="form-label">예약종료일시</label>
                                                      <input type="text" class="form-control clsRsvt" id="fixRsvtEndDt" name="fixRsvtEndDt"
                                                      	 value="${fixuresVO.fixuresRsvtVOList[0].fixRsvtEndDt}" readonly style="width:100%;" />
                                                  </div>
                                              </div> <!-- end col -->
                                          </div> <!-- end row -->
<%-- 											<p>${mettingRoomVO.mettingRoomRsvtVOList[0].emplId}</p> --%>
<%-- 											<p>${customEmpl.emplId}</p> --%>
	
	
	 

                                          <div class="text-end">
<%--                                           	  <p>예약자(DB)-성윤미 (20240623) : ${mettingRoomRsvtVOList[0].emplId}</p> --%>
<%--                                           	  <p>customEmpl(시큐리티)-20240623 : ${customEmpl.emplId}</p> --%>
											  <c:set var="emplId" value="${fn:substring(fixuresRsvtVOList[0].emplId, 4, 12)}" />
                                              <c:if test="${customEmpl.emplId eq  emplId}">
                                              <button type="button" id="resUd" class="btn btn-success mt-2"><i class="mdi mdi-content-paste"></i> 수정하기</button>
                                             	 <button type="button" id="resDt" class="btn btn-success mt-2"><i class="mdi mdi-content-cut"></i> 예약취소</button>
										      </c:if>
										      
                                          </div>
                                      </form>
                                  </div>
                                  <!-- end settings content-->

                              </div> <!-- end tab-content -->
                          </div> <!-- end card body -->
                      </div> <!-- end card -->
                  </div> 
                  <!-- ///////// 오른쪽 비품 예약 상세 영역 끝 //////////////////// -->
              </div>
                <!-- /////////////// 비품 예약 현황 상세  끝 //////////////////// -->
            </div>
		</div> 
	</div>
</div>
<p>${fixuresRsvtVOList}</p>
<div class="modal fade" id="event-modal" tabindex="-1">
							<div class="modal-dialog">
								<div class="modal-content">
									<form action="/egg/fixuresUpdateRes" class="needs-validation" name="event-form" id="form-event" novalidate method="post">
										<div class="modal-header py-3 px-4 border-bottom-0">
											<h5 class="modal-title" id="modal-title">예약 수정</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body px-4 pb-4 pt-0">
											<div class="row">
												<input type="text" hidden="true" id="event-no" name="no"  >
												<div class="col-12">
													<div class="mb-3">
														<label class="control-label form-label">예약번호</label>
														 <input type="text" class="form-control clsRsvt" id="fixRsvtNo" name="fixRsvtNo" 
                                                      	value="${fixuresRsvtVOList[0].fixRsvtNo}" readonly style="width:100%;" />
													</div>
												</div>
												<div class="col-12">
													<div class="mb-3">
														<label class="control-label form-label">예약자</label>
														<input type="text" class="form-control clsRsvt" id="emplId" name="emplId"
                                                      	 value="${fixuresRsvtVOList[0].emplId}" readonly style="width:100%;" />
													</div>
												</div>
												<div class="col-12">
													<div class="mb-3">
														<label class="control-label form-label">예약시작일시</label>
														<input type="datetime-local" id="fixRsvtBgngDt" name="fixRsvtBgngDt"
														value="${fixuresRsvtVOList[0].fixRsvtBgngDt}" style="width:100%;">

														
													</div>
												</div> 
												<div class="col-12">
													<div class="mb-3">
														<label class="control-label form-label">예약종료일시</label>
														
														<input type="datetime-local" id="fixRsvtEndDt" name="fixRsvtEndDt"
														value="${fixuresRsvtVOList[0].fixRsvtEndDt}" style="width:100%;">
														
													
													</div>
												</div>
											</div>
											<div class="row justify-content-end">
												<div class="col-6 d-flex justify-content-end">
													<button type="submit" class="btn btn-success btn-custom" id="btn-save-event">수정완료</button>
													<button type="button" class="btn btn-light me-1 btn-custom" data-bs-dismiss="modal">닫기</button>
												</div>
											</div>
										</div>
										<sec:csrfInput/>
									</form>
								</div>
								<!-- end modal-content-->
							</div>
							</div>




<script type="text/javascript">
//서버에서 발행된 헤더네임과 토큰갑사 저장
//const header = '${_csrf.headerName}';
//const token =  '${_csrf.token}';

$(document).ready(function(){
	var resUd = $("#resUd");
	var resDt = $("#resDt");
	var fixRsvtNo = $('#fixRsvtNo');
	
	//예약 취소 
	var resDt = $("#resDt");
	
	// 취소 이벤트 
	resDt.on("click", function(){
		if(confirm("예약을 취소하시겠습니까?")){
			var fixRsvtNo = $("#fixRsvtNo").val();
			
			//var data = {"rsvtNo" : parseInt(rsvtNo) }
	
			//alert(parseInt(rsvtNo));
			 $.ajax({
	    	        url: "/egg/fixdeleteReservation",
	    	        type: "POST",
	    	        contentType: "application/json;charset=utf-8",
	    	        beforeSend : function(xhr) {
	    	            xhr.setRequestHeader(header, token);
	    	        },
	    	        data: fixRsvtNo,
	    	        dataType: 'text',
	    	        success: function(res) {
	    	        	console.log("혼식 못함:",res);
	    	        	alert("취소되었습니다!")
	    	        	location.href="/egg/fixuresRes"
	    	            
	    	        },
	    	        error: function(xhr) {
	    	            alert("오류가 발생했습니다: " + xhr.status);
	    	        }
	    	    });
		}
	})
	
	resUd.on("click",function(){
		console.log("수정버튼을 클릭하였습니다!");
		
 		console.log(fixRsvtNo);
//  		$("#rsvtNo").val(rsvtNo)
		$("#event-modal").modal('show');
		
	});
	
	
	resDt.on("click",function(){
		console.log("삭제 버튼을 클릭하였습니다!")
	});
	
});

</script>

</body>
</html>