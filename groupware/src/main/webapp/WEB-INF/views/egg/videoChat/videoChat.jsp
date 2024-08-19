<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<html>
<body>

<div class="content">

    <!-- Start Content-->
    <div class="container-fluid">

		<!-- 페이지 타이틀 -->
		<!-- start page title -->
		<div class="row">
		    <div class="col-12">
		        <div class="page-title-box">
		            <div class="page-title-right">
		            </div>
		            <h4 class="page-title">화상 회의</h4>
		        </div>
		    </div>
		</div>
		<!-- end page title -->
		
		<div class="row">
		    <div class="col-12">
		        <div class="card">
		            <div class="card-body">
		                <div class="row mb-2">
	                    	<!-- 검색 폼 -->
		                    <div class="col-xl-8">
		                    </div>
		                    <div class="col-xl-4">
		                        <div class="text-xl-end mt-xl-0 mt-2">
		                            	<button type="button" id="test-create-room-list" class="btn btn-secondary mb-2 me-2">시연용 회의실 리스트 생성</button>
<%-- 		                        	<sec:authorize access="hasAuthority('ROLE_ADMIN')"> --%>
		                            	<button type="button" id="createVideoRoomModalOpenBtn" class="btn btn-primary mb-2 me-2">
		                            		<i class="mdi mdi-google-classroom me-1"></i> 회의실 생성 
	                            		</button>
<%-- 		                        	</sec:authorize> --%>
		                        </div>
		                    </div><!-- end col-->
		                </div>
		
		                <div class="table-responsive">
		                    <table class="table table-centered table-nowrap mb-0">
		                        <thead class="table-light">
		                            <tr>
		                                <th>#</th>
		                                <th>회의실 이름</th>
		                                <th>참가자</th>
		                                <th class="text-center" style="width: 125px;">회의 입장</th>
		                                <sec:authorize access="hasAuthority('ROLE_ADMIN')">
		                                	<th class="text-center" style="width: 125px;">회의 삭제</th>
		                                </sec:authorize>
		                            </tr>
		                        </thead>
		                        <tbody id="roomListTableBody">
		                        	<!-- 회의실 목록 -->
		                        	<c:forEach items="${roomList.data.list }" var="room" varStatus="status">
		                            <tr>
		                            	<td> <span class="text-body fw-bold"> ${status.index + 1 } </span> </td>
		                                <td id="roomId" style="display: none;">${room.roomId }</td>
		                                <td> ${room.roomTitle } </td>
		                                <td> <span class="badge badge-info-lighten"> ${room.currJoinCnt } / ${room.maxJoinCnt } </span> </td>
		                                <td class="text-center">
		                                    <a href="javascript:void(0);" id="enterRoomBtn" class="action-icon"> 
		                                    	<i class="uil uil-entry"></i>입장
		                                    </a>
		                                </td>
				                    	<sec:authorize access="hasAuthority('ROLE_ADMIN')">
			                                <td class="text-center">
						                    		<a href="javascript:void(0);" id="delRoomBtn" class="action-icon"> 
				                                    	<i class="uil uil-trash"></i>삭제
				                                    </a>
			                                </td>
				                    	</sec:authorize>
		                            </tr>
		                        	</c:forEach>
		                            
		                        </tbody>
		                    </table>
		                </div>
		            </div> <!-- end card-body-->
		        </div> <!-- end card-->
		    </div> <!-- end col -->
		</div> <!-- end row -->
	</div> <!-- container -->
</div> <!-- content -->


<!-- modal -->
<div id="createVideoRoomModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
			<div class="modal-header">
                <h4 class="modal-title" id="standard-modalLabel">회의실 생성</h4>
                <button type="button" onclick="insertTestData()" class="btn btn-light">데이터 삽입</button>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
            </div>
            <div class="modal-body">
                <form class="ps-3 pe-3" action="#">
                    <div class="mb-3">
                        <label for="modalRoomName" class="form-label">회의실 명</label>
                        <input class="form-control" type="text" maxlength="15" id="modalRoomName" required="required" placeholder="회의실 명을 입력하세요(15자 이내)">
                    </div>

                    <div class="mb-3">
                        <label for="modalMaxJoinCount" class="form-label">참가자 수</label>
                        <input class="form-control" type="number" id="modalMaxJoinCount" min="4" max="16" required="required" placeholder="참가자 수를 입력하세요(최대 16명)">
                    </div>

                    <div class="mb-3">
                        <label for="modalRoomPassword" class="form-label">비밀번호</label>
                        <input class="form-control" type="password" required="required" max="10" id="modalRoomPassword" placeholder="회의실 비밀번호를 입력하세요(최대10자리)">
                    </div>

                    <div class="mb-3 text-center">
                    	<button id="createRoomBtn" class="btn rounded-pill btn-primary">생성하기</button>
                    </div>
                </form>

            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div id="createdSuccessVidepRoomModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content modal-filled bg-primary">
            <div class="modal-body p-4">
                <div class="text-center">
                    <i class="ri-check-line h1"></i>
                    <h4 class="mt-2">SUCCESS</h4>
                    <p class="mt-3">회의실이 생성되었습니다!</p>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->



</body>

<script type="text/javascript">

$(function(){
	
	$(document).on('click','#enterRoomBtn',function(event){
		var roomId = $(this).parent().parent().find('#roomId').text();
		console.log("### 선택한 방 코드 : " + roomId); // del
		
		var obj = {roomId : roomId};
		var jsonObj = JSON.stringify(obj);
		$.ajax({
			url : "/egg/videoChatJoin",
			type : "post",
			data : jsonObj,
			contentType : "application/json;charset=UTF-8",
			dataType : 'json',
			beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
		         xhr.setRequestHeader(header, token);
		      },
			success : function(res){
				console.log(res.data.url);
				var url = res.data.url;
				
				
				window.open(url,'_blank');
			},
			error : function(xhr){
				alert(xhr.status);
			}
		});
		
	});
	
	
	$(document).on('click','#delRoomBtn',function(event){
		
		if(confirm("해당 회의실을 삭제하시겠습니까?? ")){
			var roomId = $(this).parent().parent().find('#roomId').text();
			console.log("### 선택한 방 코드 : " + roomId); // del
			var obj = {roomId : roomId};
			var jsonObj = JSON.stringify(obj);
			$.ajax({
				url : "/egg/deleteRoom",
				type : "post",
				data : jsonObj,
				contentType : "application/json;charset=UTF-8",
				dataType : 'json',
				beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
			         xhr.setRequestHeader(header, token);
			    },
				success : function(res){
					alert("삭제가 완료되었습니다.");
					location.reload();
				}
				
			});
				
		}
		
	});
	
	$('#createVideoRoomModalOpenBtn').on('click',function(){
		$("#modalRoomName").val("");
		$("#modalRoomPassword").val("");
		$("#modalMaxJoinCount").val("");
		
		$("#createVideoRoomModal").modal('show');
	});
	
	
	$('#createRoomBtn').on('click',function(){
		var roomName = $("#modalRoomName").val();
		var password = $("#modalRoomPassword").val();
		var maxJoinCount = $("#modalMaxJoinCount").val();
		$("#createVideoRoomModal").modal('hide');
		
		var obj = {
			roomName : roomName,
			password : password,
			maxJoinCount : maxJoinCount
		};
		var jsonObj = JSON.stringify(obj);
		
		console.log("### 생성할 방 이름 : " + roomName); // del
		console.log("### 생성할 방 비밀번호 : " + password); // del
		console.log("### 생성할 방 최대인원 : " + maxJoinCount); // del
		
		$.ajax({
			url : "/egg/createRoom",
			type : "POST",
			data : jsonObj,
			contentType : "application/json;charset=UTF-8",
			dataType : "json",
			beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
		         xhr.setRequestHeader(header, token);
		    },
			success : function(res){
				$("#createdSuccessVidepRoomModal").modal('show');
				setTimeout(function(){
		            $("#createdSuccessVidepRoomModal").modal('hide');
					location.reload();
		        }, 2000); // 2초 후에 모달을 닫기
			},
			error : function(xhr){
				console.log("생성 오류 : " + xhr.status);
			}
		});
		
	});
	
	
	// letsgo
	// 시연 회의 리스트 생성 버튼 
	$("#test-create-room-list").on("click", function(){
		testCreate("관리자 정기 예방교육", "1234", 8);
		testCreate("사업부 파견인원 업무보고", "1234", 4);
		testCreate("인사부 긴급회의", "1234", 7);
		testCreate("사업부 주간 회의", "1234", 16);
		testCreate("스터디룸3", "1234", 6);
		testCreate("스터디룸2", "1234", 10);
		testCreate("스터디룸1", "1234", 10);
	});
	
	function testCreate(n, p, c){
	
		var obj = {
			roomName : n,
			password : p,
			maxJoinCount : c
		};
	
		var jsonObj = JSON.stringify(obj);
	
		$.ajax({
			url : "/egg/createRoom",
			type : "POST",
			data : jsonObj,
			contentType : "application/json;charset=UTF-8",
			dataType : "json",
			beforeSend : function(xhr){   // 데이터 전송 전, 헤더에 csrf 값 설정
		         xhr.setRequestHeader(header, token);
		    },
			success : function(res){
				console.log("생성 성공 : " + res);
			},
			error : function(xhr){
				console.log("생성 오류 : " + xhr.status);
			}
		});
	
	}
	// /letsgo
	

}); // $(function(){ })
	
	
// 시연용 데이터 삽입 버튼
function insertTestData(){
	$("#modalRoomName").val("인턴사원 교육관련 회의");
	$("#modalMaxJoinCount").val(7);
	$("#modalRoomPassword").val("1234");
}



</script>


</html>