<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css"> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script> -->



<style>

.button-group {
    display: flex; /* Flexbox를 사용하여 버튼들을 정렬 */
    flex-direction: column; /* 세로 방향으로 정렬 */
    align-items: flex-end; /* 오른쪽 정렬 */
    gap: 10px; /* 버튼 간의 간격 */
    width: 200px; /* 버튼의 너비 조정 */
}

.col-6{
	text-align: right; /* 텍스트를 오른쪽으로 정렬*/
}

/* .btn { */
/* } */


#calendar {
   width: 1100px;
   text-align: center;
   margin: auto;
}

.row-btn {
   width: 200px;
}

.row-Sorting {
   display: flex; /* 가로 정렬  */
}

.container { /* 회의실 선택 버튼 컨테이너  */
   display: flex;
   flex-wrap: wrap;
   gep: 20px;
}

.card {
   flex: 1 1 calc(20% - 20px);
   box-sizing: border-box;
   /*    margin: 10px; */
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
   width: 120px; /* 버튼의 너비를 통일 */
   height: 40px; /* 버튼의 높이 설정 */
}
.cloBtn{
   width: 120px; /* 버튼의 너비를 통일 */
   height: 40px; /* 버튼의 높이 설정 */
}

</style>

<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.customEmpl" var="customEmpl" />
</sec:authorize>
<div>
   <h2>
      <i class="ri-time-line"></i>예약및대여
   </h2>
</div>
<%-- <p>${mettingRoomRes }</p> --%>
<!-- 가로 정렬 -->

<div class="row-Sorting">

   <!--회의실,비품 선택 버튼  -->
   <div class="row-btn">
      <div class="col-sm-3 mb-2 mb-sm-0">
         <div class="nav flex-column nav-pills" id="v-pills-tab"
            role="tablist" aria-orientation="vertical">
            <a href="/egg/mettingRoomRes" class="nav-link active show"
               style="width: 100px; font-size: 12pt;"> <i
               class="mdi mdi-home-variant d-md-none d-block"></i> <span
               class="d-none d-md-block">회의실</span>
            </a> <a href="/egg/fixuresRes" class="nav-link"
               style="width: 100px; font-size: 12pt;"> <i
               class="mdi mdi-account-circle d-md-none d-block"></i> <span
               class="d-none d-md-block">비품</span>
            </a>
         </div>
      </div>
      <!-- end col-->

      <div class="col-sm-9">
         <div class="tab-content" id="v-pills-tabContent">
            <div class="tab-pane fade active show" id="v-pills-home"
               role="tabpanel" aria-labelledby="v-pills-home-tab"></div>
            <div class="tab-pane fade" id="v-pills-profile" role="tabpanel"
               aria-labelledby="v-pills-profile-tab"></div>
            <div class="tab-pane fade" id="v-pills-settings" role="tabpanel"
               aria-labelledby="v-pills-settings-tab"></div>
         </div>
         <!-- end tab-content-->
      </div>
      <!-- end col-->
   </div>
   <!-- end row-->
   <!--회의실 선택 버튼-->
   <div class="res-row">
      <div class="container" id="container">
         <c:forEach var="list" items="${mettingRoomRes }" varStatus="status">
            <div class="card tilebox-one">
               <div class="card-body">
                  <input type="hidden" id="roomNo" name="roomNo" value="${list.roomNo}" />
                     <input type="hidden" id="roomNm" name="roomNm" value="${list.roomNm}" />
                      <i class="ri-shopping-basket-2-line float-end text-muted"></i>
                  <h2 class="m-b-20">${list.roomNm}</h2>
                  <span class="badge bg-primary"> ${list.roomNope }</span> <br>
                  <span class="text-muted">${list.roomEqpmnt }</span>
               </div>
            </div>
         </c:forEach>
      </div>

   </div>

</div>

<div class="row">
   <div class="col-12">
      <div class="card-body">
         <!-- /////////////// 회의실 예약 현황 시작 //////////////////// -->
         <%--             <p>${mettingRoomRes}</p> --%>
         <table
            class="table table-striped dt-responsive nowrap w-100 dataTable no-footer dtr-inline"
            style="width: 100%;">
            <thead>
               <tr>
                  <!--                              <th class="sorting" style="width: 10%;">순번</th> -->
                  <th class="sorting" style="width: 10%;">순번</th>
                  <th class="sorting" style="width: 20%;">회의실명</th>
                  <th class="sorting" style="width: 20%;">예약자(사번)</th>
                  <th class="sorting" style="width: 25%;">예약시작일시</th>
                  <th class="sorting" style="width: 25%;">예약종료일시</th>
               </tr>
            </thead>
            <tbody>
               <!-- 
                        stat.index : 0,1,2,...
                        stat.count : 1,2,3...
                        
                        mettingRoomRes : List<MettingRoomRsvtVO>
                         -->
               <c:forEach var="mettingRoomRsvtVO" items="${mettingRoomResList}"
                   varStatus="stat">
                  <tr class="odd">
                     <td>${stat.count}</td>
                     <td><a
                        href="/egg/mettingRoomResDet?rsvtNo=${mettingRoomRsvtVO.rsvtNo}">${mettingRoomRsvtVO.mettingRoomVO.roomNm}</a></td>
                     <td>${mettingRoomRsvtVO.emplId}</td>
                     <td>${mettingRoomRsvtVO.rsvtBgngDt}</td>
                     <td>${mettingRoomRsvtVO.rsvtEndDt}</td>
                  </tr>
               </c:forEach>
            </tbody>
         </table>
         <!-- /////////////// 회의실 예약 현황 끝 //////////////////// -->
      </div>
   </div>
</div>

<!-- letsgo -->
<div class="modal fade" id="event-modal" tabindex="-1">
   <div class="modal-dialog">
      <div class="modal-content">
         <form class="needs-validation" name="event-form" id="addForm" method="post" novalidate>
            <div class="modal-header py-3 px-4 border-bottom-0">
               <h5 class="modal-title" id="modal-title">Event</h5>
               <button type="button" class="btn-close" data-bs-dismiss="modal"
                  aria-label="Close"></button>
            </div>
            <div class="modal-body px-4 pb-4 pt-0">
               <div class="row">
                  <div class="col-12">
                     <div class="mb-3">
<!--                         <input type="hidden" class="form-control clsroom" id="modalRsvtNo" -->
<%--                            name="rsvtNo" value="${MettingRoomRsvtVO.rsvtNo}" readonly --%>
<!--                            style="width: 100%;" />  -->

                        <input type="hidden" class="form-control clsroom roomNo" id="modalRoomNo"
                           name="roomNo" value="" readonly style="width: 100%;" /> 
                           
                        <label class="control-label form-label">회의실명</label>
                        <input type="text" class="form-control roomNm" id="roomNm"
                           name="roomNm" value="" readonly style="width: 100%;" />
                     </div>
                  </div>
                  <div class="col-12">
                     <div class="mb-3">
                        <label class="control-label form-label">예약자</label>
                        <input
                           type="text" class="form-control clsroom"
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
                           <input type="datetime-local" id="date-time-start" class="rsvtBgngDt" name="rsvtBgngDt" 
                              placeholder="ex)2020-09-01" />
                        </div>
                     </div>
                  </div>
                  
                  <div class="col-12">
                     <div class="mb-3">
                        <div>
                           <label class="control-label form-label">예약종료일시</label>
                           <input type="datetime-local" id="date-time-end"  class="rsvtEndDt" name="rsvtEndDt"
                              placeholder="ex)2020-09-01" />
                        </div>   
                     </div>
                  </div>
               </div>
                     

					<div class="row justify-content-end">
					    <div class="col-6 text-end">
					        <!-- 시간 확인 -->
					        <div class="reservationStatus"></div>
					
					        <div class="button-group">
					            <button type="button" class="btn btn-success timeBtn mb-2">예약가능체크</button>
					            <div class="d-flex justify-content-end"> <!-- 버튼들을 가로로 정렬 -->
					            	<button type="button" class="btn btn-success addBtn me-1">예약하기</button>
					            	<button type="button" class="btn btn-light cloBtn" data-bs-dismiss="modal">닫기</button>
					            </div>
					        </div>
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
$(document).ready(function(){
   const token = $("meta[name='_csrf']").attr("content")
   const header = $("meta[name='_csrf_header']").attr("content");
   
   var card = $(".container");
   var addBtn = $(".addBtn");
   var timeBtn = $(".timeBtn");
   //var resDt = $("#resDt");
   
   $('#container').on('click', '.card', function(){
      console.log("카드를 클릭하였습니다!");
//       var rsvtNo = $(this).find("input[name='rsvtNo']").val();
//       console.log(rsvtNo);
      var roomNo = $(this).find("input[name='roomNo']").val();
      console.log(roomNo);
      var roomNm = $(this).find("input[name='roomNm']").val();
      console.log(roomNm);
      var emplId = $(this).find("input[name='emplId']").val();
      console.log(emplId);
//         $("#modalRsvtNo").val(rsvtNo);
      $(".roomNo").val(roomNo);
      $('.roomNm').val(roomNm);
      $("#event-modal").modal('show');
          
              
   });
   
   timeBtn.on("click", function() {
	    var roomNo = $(".roomNo").val();
	    var emplId = $(".emplId").val();
	    var rsvtBgngDt = $(".rsvtBgngDt").val();
	    var rsvtEndDt = $(".rsvtEndDt").val();

	    var data = {
	        "roomNo": roomNo,
	        "emplId": emplId,
	        "rsvtBgngDt": rsvtBgngDt,
	        "rsvtEndDt": rsvtEndDt
	    };

	    console.log("혼식2:",data);
	    $.ajax({
	        url: "/egg/resTime",
	        type: "POST",
	        beforeSend : function(xhr) {
	            xhr.setRequestHeader(header, token);
	        },	        
	        contentType: "application/json;charset=utf-8",
	        data: JSON.stringify(data),
	        dataType: 'text',
	        success: function(res) {
	        	console.log("혼식 못함:",res);
	            // 예약 상태 메시지를 업데이트
	            if (res > 0) {
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
      var roomNo = $(".roomNo").val();
      var emplId = $(".emplId").val();
      var rsvtBgngDt = $(".rsvtBgngDt").val();
      var rsvtEndDt = $(".rsvtEndDt").val();
      console.log(roomNo);
      console.log(emplId);
      console.log(rsvtBgngDt);
      console.log(rsvtEndDt);
      
      var data = {
              "roomNo": roomNo,
              "emplId": emplId,
              "rsvtBgngDt": rsvtBgngDt,
              "rsvtEndDt": rsvtEndDt
          };
      
       if($(".reservationStatus").html().includes("가능")){
    	   alert("예약이 추가되었습니다.");
    	    $.ajax({
    	        url: "/egg/mettingInsertRes",
    	        type: "POST",
    	        beforeSend : function(xhr) {
    	            xhr.setRequestHeader(header, token);
    	        },	        
    	        contentType: "application/json;charset=utf-8",
    	        data: JSON.stringify(data),
    	        dataType: 'json',
    	        success: function(res) {
    	        	console.log("혼식 못함:",res);
    	        	location.href="/egg/mettingRoomResDet?rsvtNo="+res.rsvtNo
    	            
    	        },
    	        error: function(xhr) {
    	            alert("오류가 발생했습니다: " + xhr.status);
    	        }
    	    });
    	   
       }else {
    	   alert("불가능한 시간이예요");
       }
      
      /*
      $.ajax({
           url : "/egg/resTime",
           type : "POST",
           beforeSend : function(xhr) {
               xhr.setRequestHeader(header, token);
           },
	       contentType: "application/json;charset=utf-8",
           data : $("#addForm").serialize(),
           dataType: 'JSON',
           success : function (data) {
               if(data.resultMap.code == "1"){
                   alert("success!")
                   
               } else {
                   alert("해당 시간에는 예약이 불가합니다.")
               }
               
               }
           });  //ajax
         */
   	})
   	
   
   

   });
</script>
                                          