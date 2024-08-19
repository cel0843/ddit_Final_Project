<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/assets/vendor/jquery.rateit/scripts/jquery.rateit.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/assets/vendor/jquery.rateit/scripts/rateit.css" rel="stylesheet">
<script src="https://www.gstatic.com/charts/loader.js"></script>

<style>
/* .res-resbtn { */
/*  	text-align: center; */
  	/* white-space: pre; */ 
/* 	text-indent: 100px; */ 
/* } */

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

.addBtn {
   width: 150px; /* 버튼의 너비를 통일 */
   height: 40px; /* 버튼의 높이 설정 */
}
.cloBtn{
   width: 150px; /* 버튼의 너비를 통일 */
   height: 40px; /* 버튼의 높이 설정 */
}

</style>


</head>
<body>
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.customEmpl" var="customEmpl" />
</sec:authorize>
<!-- 
 -->	
 		<div>
 			<h2><i class="ri-time-line"></i>예약및대여</h2>
 		</div>
			
				<!-- 가로 정렬 -->
 				<div class="row-Sorting"> 
				
				<!--회의실,비품 선택 버튼  -->
				<div class="row-btn">
				    <div class="col-sm-3 mb-2 mb-sm-0">
				        <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
				            <a href="/egg/mettingRoomRes" class="nav-link" style="width:100px;font-size:12pt;">
				                <i class="mdi mdi-home-variant d-md-none d-block"></i>
				                <span class="d-none d-md-block">회의실</span>
				            </a>
				            <a href="/egg/fixuresRes" class="nav-link active show" style="width:100px;font-size:12pt;">
				                <i class="mdi mdi-account-circle d-md-none d-block"></i>
				                <span class="d-none d-md-block">비품</span>
				            </a>
				        </div>
				    </div> <!-- end col-->
				
				    <div class="col-sm-9">
				        <div class="tab-content" id="v-pills-tabContent">
				            <div class="tab-pane fade active show" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
				            </div>
				            <div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
				            </div>
				            <div class="tab-pane fade" id="v-pills-settings" role="tabpanel" aria-labelledby="v-pills-settings-tab">
				            </div>
				        </div> <!-- end tab-content-->
				    </div> <!-- end col-->
				</div>
				<!-- end row-->
				
				<!--비품 선택 버튼-->
				<div class="res-row">
                     <div class="container" id="container">
                     	<c:forEach var="list" items="${fixuresRes }" varStatus="status">
                          <div class="card tilebox-one">
                              <div class="card-body">
                              	<input type="hidden" class="clsFixNo" name="fixNo" value="${list.fixNo}"/>
                              	<input type="hidden" class="clsFixNm" name="fixNm" value="${list.fixNm}"/>
                              	<input type="hidden" class="clsFixImg" name="fixImg" value="${list.fixImg}"/>
                                  <i class="ri-shopping-basket-2-line float-end text-muted"></i>
                                  <h2 class="m-b-20">${list.fixNm }</h2>
                              </div> <!-- end card-body-->
                          </div> <!--end card-->
                     	</c:forEach>
                     </div><!-- end col -->
                 </div>
    
 </div>

	<div class="row">
		<div class="col-12">
			<div class="card-body">
				<!-- /////////////// 회의실 예약 현황 시작 //////////////////// -->
<%-- 				<p>${mettingRoomRes}</p> --%>
				<table 
					class="table table-striped dt-responsive nowrap w-100 dataTable no-footer dtr-inline"
					style="width: 100%;">
                     <thead>
                         <tr>
<!--  	                         <th class="sorting" style="width: 10%;">순번</th> -->
	                         <th class="sorting" style="width: 10%;">순번</th>
	                         <th class="sorting" style="width: 20%;">비품명</th>
	                         <th class="sorting" style="width: 20%;">예약자(사번)</th>
	                         <th class="sorting" style="width: 25%;">예약시작일시</th>
	                         <th class="sorting" style="width: 25%;">예약종료일시</th>
                        </tr>
                     </thead>
                     <tbody>
                     	<!-- 
                     	stat.index : 0,1,2,...
                     	stat.count : 1,2,3...
                     	
                     	mettingRoomRes : List<MettingRoomVO>
                     	 -->
                     	<c:forEach var="fixuresRsvtVO" items="${fixuresResList}"
                     	 varStatus="stat">
	    
	                     <tr class="odd">
  	                       <td>${stat.count}</td>
  	                       <td><a href="/egg/fixuresResDet?fixRsvtNo=${fixuresRsvtVO.fixRsvtNo}">${fixuresRsvtVO.fixuresVO.fixNm}</a></td>
	                       <td>${fixuresRsvtVO.emplId}</td>
	                       
	                       <td>${fixuresRsvtVO.fixRsvtBgngDt}</td>
	                       <td>${fixuresRsvtVO.fixRsvtEndDt}</td>
	                     </tr>
	                    </c:forEach>
                    </tbody>
                 </table>
                 <!-- /////////////// 회의실 예약 현황 끝 //////////////////// -->
            </div>
		</div>
	</div>

<div class="modal fade" id="event-modal" tabindex="-1">
<div class="modal-dialog">
	<div class="modal-content">
		<form class="needs-validation" name="event-form" id="addForm" method="post" novalidate>
			<div class="modal-header py-3 px-4 border-bottom-0">
				<h5 class="modal-title" id="modal-title">Event</h5>
				<button type="button" class="btn-close"
					data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body px-4 pb-4 pt-0">
				<div class="row">
					<input type="text" hidden="true" id="event-no" name="no"  >
					<div class="col-12">
                     <div class="mb-3">
                        <div>
                           <label class="control-label form-label">이미지</label>
                           <img id="imgFixImg" src="" style="width:70%;" />
                        </div> 
                     </div>
                 	</div>
                  	  
					<div class="col-12">
						<div class="mb-3">
							<input type="hidden" class="form-control clsroom fixNo" id="modalfixNo"
                         	  name="fixNo" value="" readonly style="width: 100%;" /> 
                           
                       		 <label class="control-label form-label">비품명</label>
                       		 <input type="text" class="form-control fixNm" id="fixNm"
                          		 name="fixNm" value="" readonly style="width: 100%;" />
						</div>
					</div>
					<div class="col-12">
						<div class="mb-3">
							<label class="control-label form-label">예약자</label>
                       		 <input
                           		type="text" class="form-control clsroom" id="emplNm" 
                           		value="${customEmpl.emplNm}"
                           		style="width: 100%;" readonly />
                        	<input
                           		type="hidden" class="form-control clsroom emplId" id="emplId"
                           		name="emplId" value="${customEmpl.emplId}"
                           		style="width: 100%;" />
						</div>
					</div>
					   <div class="col-12">
	                     <div class="mb-3">
	                        <div>
	                           <label class="control-label form-label">예약시작일시</label>
	                           <input type="datetime-local" id="date-time-start" class="fixRsvtBgngDt" name="fixRsvtBgngDt" 
	                              placeholder="ex)2020-09-01" />
	                        </div>
	                     </div>
                  	  </div>
                  	  
                  	  <div class="col-12">
	                     <div class="mb-3">
	                        <div>
	                           <label class="control-label form-label">예약종료일시</label>
	                           <input type="datetime-local" id="date-time-start" class="fixRsvtEndDt" name="fixRsvtEndDt" 
	                              placeholder="ex)2020-09-01" />
	                        </div> 
	                     </div>
                  	  </div>
                  	  
				</div>
				
				<div class="row justify-content-end">
					<div class="col-6 text-end">
            			<div class="reservationStatus"></div>
            			
            			<div class="button-group">
                    		<button type="button" class="btn btn-success timeBtn mb-2" >예약가능체크</button>
					 		<div class="d-flex justify-content-end"> <!-- 버튼들을 가로로 정렬 -->
					 			<button type="button" class="btn btn-success addBtn me-1">예약하기</button>
					 			<button type="button" class="btn btn-light cloBtn" data-bs-dismiss="modal">닫기</button>
							</div>
				 		</div>
					</div>
				</div>
			
			
			
			</div>
		</form>
	</div>
	<!-- end modal-content-->
</div>
</div>



<script>
$(document).ready(function(){
	const token = $("meta[name='_csrf']").attr("content")
	const header = $("meta[name='_csrf_header']").attr("content");
	
	var card = $(".container");
	var addBtn = $(".addBtn");
	var timeBtn = $(".timeBtn");
	
	$('#container').on('click', '.card', function(){
		console.log("카드를 클릭하였습니다!");
		
		var fixNo = $(this).find("input[name='fixNo']").val();
		console.log(fixNo);
		var fixNm = $(this).find("input[name='fixNm']").val();
		console.log(fixNm);
		var fixImg = $(this).find("input[name='fixImg']").val();
		console.log(fixImg);
		var emplId = "${customEmpl.emplNm}(${customEmpl.emplId})";
		console.log(emplId);
		
		$(".fixNo").val(fixNo);
		$(".fixNm").val(fixNm);
		$("#imgFixImg").attr("src",fixImg);
// 		$(".clsroom").val(emplId);
		$("#event-modal").modal('show');
		
	}); 
	
	timeBtn.on("click", function() {
	    var fixNo = $(".fixNo").val();
	    var emplId = $(".emplId").val();
	    var fixRsvtBgngDt = $(".fixRsvtBgngDt").val();
	    var fixRsvtEndDt = $(".fixRsvtEndDt").val();
		
	    /*
	    EMPL_ID, FIX_NO, FIX_RSVT_BGNG_DT, FIX_RSVT_END_DT
	    */
	    var data = {
	        "fixNo": fixNo,
	        "emplId": emplId,
	        "fixRsvtBgngDt": fixRsvtBgngDt,
	        "fixRsvtEndDt": fixRsvtEndDt
	    };

	    /*
	    {"fixNo": "1","emplId": "20240624","fixRsvtBgngDt": "2024-07-27T09:53","fixRsvtEndDt": "2024-07-27T11:55"}
	    */
	    console.log("혼식3:",data);
	    
	    $.ajax({
	        url: "/egg/resFixTime",
	        type: "POST",
	        beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},	        
	        contentType: "application/json;charset=utf-8",
	        data: JSON.stringify(data),
	        dataType: 'text',
	        success: function(res) {
	        	console.log("혼식 못함:",res);
	            // 예약 상태 메시지를 업데이트
	            if (res > 0) {
	                $(".reservationStatus").html('<span style="color: red;">해당 시간에는 예약이 불가합니다.</span>');
	            } else {
	                $(".reservationStatus").html('<span style="color: green;">예약이 가능합니다.</span>');
	            }
	            console.log("한번 더",res);
	        },
	        error: function(xhr) {
	            alert("오류가 발생했습니다: " + xhr.status);
	        }
	    });
	});
	
	
	// 추가 버튼 클릭 이벤트 
	   addBtn.on("click", function(){
	     var fixNo = $(".fixNo").val();
	     var emplId = $(".emplId").val();
	     var fixRsvtBgngDt = $(".fixRsvtBgngDt").val();
	     var fixRsvtEndDt = $(".fixRsvtEndDt").val();
	     
	      console.log(fixNo);
	      console.log(emplId);
	      console.log(fixRsvtBgngDt);
	      console.log(fixRsvtEndDt);
	      
	      var data = {
	              "fixNo": fixNo,
	              "emplId": emplId,
	              "fixRsvtBgngDt": fixRsvtBgngDt,
	              "fixRsvtEndDt": fixRsvtEndDt
	          };
	      
	      /*
	      {"fixNo": "1","emplId": "20240624","fixRsvtBgngDt": "2024-07-29T21:13","fixRsvtEndDt": "2024-07-29T21:19"}
	      */
	      console.log("data : ", data);
	      
	       if($(".reservationStatus").html().includes("가능")){
	    	   alert("예약이 추가되었습니다.");
	    	    $.ajax({
	    	        url: "/egg/fixuresInsertRes",
	    	        type: "POST",
	    	        beforeSend:function(xhr){
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},       
	    	        contentType: "application/json;charset=utf-8",
	    	        data: JSON.stringify(data),
	    	        dataType: 'json',
	    	        success: function(res) {
	    	        	/*
	    	        	{"fixRsvtCd": null,"fixRsvtNo": 11,"emplId": "20240624","fixNo": 1,
    					 "fixRsvtBgngDt": "2024-07-29T13:35","fixRsvtEndDt": "2024-07-29T14:35",
    					 "dateFixRsvtBgngDt": null,"dateFixRsvtEndDt": null,
    					 "fixNm": null,"fixuresVO": null}
	    	        	*/
	    	        	console.log("혼식 못함:",res);
	    	        	location.href="/egg/fixuresResDet?fixRsvtNo="+res.fixRsvtNo
	    	            
	    	        },
	    	        error: function(xhr) {
	    	            alert("오류가 발생했습니다: " + xhr.status);
	    	        }
	    	    });
	    	   
	       }else {
	    	   alert("불가능한 시간이예요");
	       }
	      
	   	});
	
});

</script>
</body>
</html>