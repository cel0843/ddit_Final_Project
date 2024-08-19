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

	<!-- 채팅방 사원 추가 모달 / Scrollable modal -->
	<div class="modal fade" id="scrollable-modal" tabindex="-1" role="dialog" aria-labelledby="scrollableModalTitle" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-scrollable" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="scrollableModalTitle">초대</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
	            </div>
	            <div class="modal-body">
	            	<div class="row">
						<div id="tooltip-container" class="col-12" style=" max-width: 575px;" data-simplebar>
					        <h5>초대 사원</h5>
					        <div id="add-empl-list-modal" style="white-space: nowrap">
								<!-- 초해할 사원이 들어가는 section -->
					        </div>
					    </div>
					</div>
					<div class="app-search mt-3">
						<form>
		                    <div class="mb-2 w-100 position-relative">
		                        <input type="search" class="form-control" placeholder="이름으로 검색하세요" id="empl-search-input-modal"/>
		                        <span class="mdi mdi-magnify search-icon"></span>
		                    </div>
		                </form>
					</div>
					<div class="modal-body-table-section">
		            	<!-- 모달 테이블 섹션 -->
					</div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	                <button type="button" class="btn btn-primary" id="add-empl-btn">사원 추가</button>
	            </div>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->

<div class="col-xxl-4 col-xl-6 order-xl-1">
		
	<div class="card">
	    <div class="card-body p-0">
	        <ul class="nav nav-tab nav-justified nav-bordered mb-2">
	            <li class="nav-item">
	                <a href="#chatListTab" data-bs-toggle="tab" aria-expanded="true" class="nav-link active">
						<i class="ri-discuss-line"> <span> 채팅 </span> </i>
	                </a>
	            </li>
	            <li class="nav-item">
	                <a href="#userListTab" data-bs-toggle="tab" aria-expanded=false class="nav-link">
						<i class="ri-contacts-book-line"> <span> 연락처 </span> </i>
	                </a>
	            </li>
	        </ul> <!-- end nav-->

			<!-- tab-content -->
	        <div class="tab-content">
	            <!-- chatListTab -->
	            <div class="tab-pane show active" id="chatListTab">
		            <div class="row">
		                <div class="col">
		                    <div class="card-body py-0 mb-3" data-simplebar style="max-height: 546px">
		                    	<!-- 채팅방 목록 -->
		                    	<!-- 채팅방 목록 상세 -->
		                    	<c:forEach items="${chatRoomList }" var="chatRoom">
			                        <a href="javascript:void(0);" class="text-body aChatRoomBtn" data-chatroomno="${chatRoom.chatRoomNo}">
			                            <div class="d-flex align-items-start mt-1 p-2">
			                            	<c:if test="${chatRoom.totalMembers == 2}">
				                                <img src="${pageContext.request.contextPath }/resources/logo/personal_chat_icon.png" class="me-2 rounded-circle" height="48" alt="one" />
			                            	</c:if>
			                            	<c:if test="${chatRoom.totalMembers > 2}">
				                                <img src="${pageContext.request.contextPath }/resources/logo/multiple_chat_icon.png" class="me-2 rounded-circle" height="48" alt="multi" />
			                            	</c:if>
			                                <div class="w-100 overflow-hidden">
			                                    <h5 class="mt-0 mb-0 font-14">
			                                        <span class="float-end text-muted font-12">${fn:substring(chatRoom.recentMsgDate, 5, 16) }</span>
			                                        ${chatRoom.chatRoomNm }
			                                    </h5>
			                                    <p class="mt-1 mb-0 text-muted font-14">
			                                    	<c:if test="${chatRoom.unreadMsgCount > 0 }">
				                                        <span class="w-25 float-end text-end">
				                                        	<span class="badge badge-danger-lighten">${chatRoom.unreadMsgCount }</span>
				                                        </span>
			                                    	</c:if>
			                                        <span class="w-75">${chatRoom.recentMsgContent }</span>
			                                    </p>
			                                </div>
			                            </div>
			                        </a>
		                    	</c:forEach>
		                    	
		                    </div> <!-- end slimscroll-->
		                </div> <!-- End col -->
		            </div> <!-- End row -->
	            </div>
	            
	            <!-- userListTab -->
	            <div class="tab-pane" id="userListTab">
		            <div class="row">
		                <div class="col">
		                    <div class="card-body py-0 mb-3" data-simplebar style="max-height: 546px">
		                    
		                    	<!-- 사원 검색 -->
                                <div class="app-search">
                                    <form>
                                        <div class="mb-2 w-100 position-relative">
                                            <input type="search" class="form-control" placeholder="이름으로 검색하세요" id="employeeSearchInput"/>
                                            <span class="mdi mdi-magnify search-icon"></span>
                                        </div>
                                    </form>
                                </div>
                                
		                    	<!-- 사원 목록 -->
								<table class="table table-hover table-centered mb-0">
								    <thead>
								        <tr>
								            <th class="text-center">사원</th>
								            <th>부서</th>
								            <th class="text-center">채팅</th>
								            <th class="text-center">상태</th>
								        </tr>
								    </thead>
									<c:forEach items="${chatEmplList }" var="chatEmpl">
									    <tbody id="employeeTableBody">
									        <tr>
									            <td class="table-user list-inline">
									                <img src="${chatEmpl.proflImageCours }" alt="" class="me-2 rounded-circle list-inline-item"/>
									                <h5 class="list-inline-item">${chatEmpl.emplNm }</h5>
									            </td>
									            <td>${chatEmpl.deptNm }</td>
									            <td class="table-action text-center"> 
									            	<a href="javascript:void(0);" class="action-icon personalChatBtn" 
									            		data-emplid='${chatEmpl.emplId }' data-existroomno='${chatEmpl.existRoomNo}'>
									            		<i class="ri-messenger-line"></i>
									            	</a> 
									           	</td>
									            <td class="table-action text-center">
													<c:set value="false" var="accessFlag" /> 
													<c:forEach items="${socketAccessEmplList }" var="accessEmplId">
														<c:if test="${accessEmplId == chatEmpl.emplId }">
															<c:set value="true" var="accessFlag" />
														</c:if>
													</c:forEach> 
													<c:if test="${accessFlag == 'true' }">
														<span class="badge badge-success-lighten"> on </span>
													</c:if> 
													<c:if test="${accessFlag == 'false' }">
														<span class="badge badge-danger-lighten "> off </span>
													</c:if>
												</td>
									        </tr>
									    </tbody>
									</c:forEach>
								</table>
								
		                    </div> <!-- end slimscroll-->
		                </div> <!-- End col -->
		            </div> <!-- End row -->
	            </div> <!-- userListTab -->
	            
	        </div> <!-- end tab content-->
	    </div> <!-- end card-body-->
	</div> <!-- end card-->
	
	</div>
	<!-- end chat users-->
	
	<!-- chat area -->
	<div class="col-xxl-8 col-xl-12 order-xl-2">
	    <div class="card" id="conversationWindow">
           	<!-- 대화 내용 섹션 -->
		</div>
	</div>
                                  
	
</body>
</html>
<script>

inChatPage = true;
var currentChatRoomNo;

$(function(){
	
	// 사원 검색
	$("#employeeSearchInput").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#employeeTableBody tr").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });
	
	// 모달 사원 검색
	$(document).find("#empl-search-input-modal").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $(document).find("#empl-modal-table-body tr").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });
	
	function showChatRoom(selectedNo){
		var chatRoomNo = selectedNo;
		$.ajax({
	        url: "/egg/selectChatRoom",
	        type: "GET",
			data: { chatRoomNo: chatRoomNo },
	        beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
	        contentType: "application/json",
	        success: function(res) {
	        	var liTag = "";
	       		var conversationHTML = "";
               	conversationHTML += "<div class='card-body px-0 pb-0'>";
               	
               	conversationHTML += "<div class='btn-group col-12 row' id='emplInChatList'>";
               	// 드롭다운 메뉴 구성
               	
               	conversationHTML += "</div> <ul class='conversation-list px-3' data-simplebar style='max-height: 554px'>";
	       		conversationHTML += "<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>";
	        	$.each(res, function(index, chatMsg) {
	        		// 채팅방 메세지 뿌리기
	        		conversationHTML += insertConversation(chatMsg);
	        	});
	        	
               	conversationHTML += `
       				</div>
	        	</ul>
               	<div class='card-body p-0'>
		        <div class='row'>
		            <div class='col'>
		                <div class='mt-2 bg-light p-3'>
		                    <form class='needs-validation' novalidate='' name='chat-form' id='chat-form' method="post" enctype='multipart/form-data'>
		                        <div class='row'>
		                            <div class='col mb-2 mb-sm-0'>
		                            
		                                <input type='text' id='chatContentArea' name='chatContent' class='form-control border-0' placeholder='메세지를 입력해주세요.' required=''>
		                                <div class='invalid-feedback'>
		                                    Please enter your messsage
		                                </div>
		                            </div>
		                            <div class='col-sm-auto'>
		                                <div class='btn-group'>
											<input type='hidden' name='chatMsgNo' value=''>
											<input type='hidden' name='chatRoomNo' value='\${chatRoomNo}'>
											<input type='hidden' name='emplId' value='${sessionScope.emplInfo.emplId}'>
											<input type='hidden' name='emplName' value='${sessionScope.emplInfo.emplNm}'>
											<input type='hidden' name='emplProfileImg' value='${sessionScope.emplInfo.proflImageCours}'>
											<input type='hidden' name='chatMsgType' value=''>
											<input type='hidden' name='chatWriteDate' value=''>
											<input type='hidden' name='fileGroupNo' value=''>
											<input type='hidden' name='imgFile' value=''>
											<input type='hidden' name='fileNo' value=''>
											<input type='hidden' name='filePath' value=''>
											<input type='hidden' name='fileStrgNm' value=''>
											<input type='hidden' name='fileOrgnlNm' value=''>
											<input type='hidden' name='fileSz' value=''>
											<input type='hidden' name='fileFancySize' value=''>
											<input type='hidden' name='fileCtrDt' value=''>
											<input type='hidden' name='fileType' value=''>
											<input type='file' id="fileInputTag" name='fileData' value='' style='display: none;'>
		                                    <a href='#' class='btn btn-light' id='attachFileBtn'><i class='uil uil-paperclip'></i></a>
		                                    <a href='#' class='btn btn-light' id='addEmpCurrentChatRoom' data-chatroomno='\${chatRoomNo}'
		                                   		 data-bs-toggle="modal" data-bs-target="#scrollable-modal">
		                                    	<i class='uil ri-add-circle-line'></i>
		                                    </a>
		                                    <div class='d-grid'>
		                                        <button type='button' onclick='sendMessage()' id='sendChatBtn' class='btn btn-success chat-send'><i class='uil uil-message'></i></button>
		                                    </div>
		                                </div>
		                            </div> 
		                        </div> 
		                    </form>
		                </div>
		            </div> 
		        </div>
		    </div>
		</div> 
	</div>
	`;
				console.log("@@@" + chatRoomNo); // del
                $("#conversationWindow").html(conversationHTML);
                setTimeout(focusOnLastElement, 100);  // DOM 업데이트 후 호출
                selectCurrentChatRoomEmpl(chatRoomNo);
	        },
	        error: function(error) {
                console.log(error);
                alert("Error loading chat messages");
            }
		 });
	}
	
	function selectCurrentChatRoomEmpl(selectedChatRoomNo){
		var selectEmplInChatHTML = "";
		$.ajax({
			url: "/egg/selectEmplInChat",
			type: "GET",
			data: { chatRoomNo: selectedChatRoomNo },
			beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
			contentType: "application/json",
			success: function(res) {
				$.each(res, function(index, emplInChat) {
					console.log(index + "emplInChat / nm : " + emplInChat.EMPLNM);
					if (index == 0) {
						selectEmplInChatHTML += `
			           		<div class="col-11"></div>
			           		<button type="button" id="showCurrentChatRoomEmplBtn" class="btn btn-primary dropdown-toggle col-1" data-roomno="\${selectedChatRoomNo}" 
			           			data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			           			
			                </button>
			                <div class="dropdown-menu col-3">
			                    <h6 class="dropdown-header">\${emplInChat.CHATROOMNM}</h6><div>
						`;
					}
					selectEmplInChatHTML += `
		                    <a class="dropdown-item col-3" href="#" data-emplno="\${emplInChat.EMPLID}">\${emplInChat.EMPLNM}</a>
					`;
	        	});
				selectEmplInChatHTML += `
	                </div>
				`;
				$("#conversationWindow").find("#emplInChatList").html(selectEmplInChatHTML);
			},
			error: function(error) {
				console.log(error);
				alert("Error loading employee list");
			}
		});	
	} 
	
	// 새로운 채팅방 생성
	function createChatRoom(firstEmplId, secondEmplId, chatRoomName){
		console.log(firstEmplId);
		console.log(secondEmplId);
		console.log(chatRoomName);
		var createdChatRoomNo = "";
		$.ajax({
	        url: "/egg/createChatRoom",
	        type: "POST",
			data: { 
				firstEmplId: firstEmplId,
				secondEmplId: secondEmplId,
				chatRoomName : chatRoomName
			},
	        beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
	        dataType: "json",
	        success: function(res) {
	        	console.log("새로운 채팅방 번호입니다 : " + res);
	        	createdChatRoomNo = res;
	        	currentChatRoomNo = res;
				insertNewChatRoom(res, chatRoomName);
				// 채팅방 생성 및 채팅방 open
				showChatRoom(res);
				selectCurrentChatRoomEmpl(res);
			},
		    error: function(error) {
		        console.log(error);
		        alert("Error create chat room");
		    }
		});
		return createdChatRoomNo;
	}
	
	// 개인 챗 클릭
	$(".personalChatBtn").on('click', function(){
		var myEmplId = "${sessionScope.emplInfo.emplId}";
		var targetEmplId = $(this).data("emplid");
		var existRoomNo = $(this).data("existroomno");
		currentChatRoomNo = existRoomNo;
		if (existRoomNo == null || existRoomNo == "") {
			// 채팅방 이름 입력창 max + 1, 채팅방 이름
			var roomName = prompt("채팅방 이름을 지정해주세요");
			if (roomName.trim() == null || roomName.trim() == "") {
				return false;
			}
			createChatRoom(myEmplId, targetEmplId, roomName);
		} 
		
	});
	
	// 채팅방 조회
	$(document).on("click", ".aChatRoomBtn", function(){
		var chatRoomNo = $(this).data("chatroomno"); // chatRoomNo 값을 가져옴
		currentChatRoomNo = chatRoomNo;	// 현재 접속한 채팅방 번호 지정
		showChatRoom(currentChatRoomNo);
		$(this).find(".badge").hide();
	}); // /$(".text-body").click
	
	// 엔터키 입력 시 메시지 전송
    $(document).on("keypress", "#chatContentArea", function(e) {
        if (e.which === 13) {
            e.preventDefault();
            sendMessage();
        }
    });

    // 파일 첨부 버튼 클릭 시 파일 선택 창 열기
    $(document).on("click", "#attachFileBtn", function(e) {
        e.preventDefault();
        $("#fileInputTag").click();
    });

    var fileData = null;
    
    // 파일 선택 시 confirm 창 띄우기
    $(document).on("change", "#fileInputTag", function(e) {
        if (confirm("파일을 전송하시겠습니까?")) {
        	$("#chatContentArea").val("");
            console.log("파일 선택됨: " + e.target.files[0]);
            fileData = e.target.files[0];
            sendMessage();
            fileData = null;
        } else {
            fileData = null;
        }
    });
	
	// 다운로드 기능
    $(document).on('click', '.downloadChatFileLink', function() {
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
    
	
	// ====================================================
		
	//메시지 전송
	//입력 필드 #message의 값을 서버로 SockJS를 통해 전송합니다.
	function sendMessage() {
		var messageContent = $("#conversationWindow").find("#chatContentArea").val();
		if ((fileData == null) && (messageContent == null || messageContent == "")) {
			return false;
		}
	    var chatRoomNo = $(".text-body.active").data("chatroomno");
	
	    var formData = new FormData();
	    formData.append('chatContent', messageContent);
	    formData.append('chatRoomNo', currentChatRoomNo);
	    formData.append('chatMsgType', 'MSG_01');
	    formData.append('emplId', '${sessionScope.emplInfo.emplId}');
	    formData.append('emplName', '${sessionScope.emplInfo.emplNm}');
	    formData.append('emplProfileImg', '${sessionScope.emplInfo.proflImageCours}');
	    formData.append('fileData', fileData);
	
	    $.ajax({
	        url: "/egg/insertChatMessage",
	        type: "POST",
	        data: formData,
	        beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
	        processData: false,
	        contentType: false,
	        success: function(res) {
				var res_to_json = {
					chatMsgNo : res.chatMsgNo,
					chatRoomNo : res.chatRoomNo,
					emplId : res.emplId,
					emplName : res.emplName,
					emplProfileImg : res.emplProfileImg,
					chatMsgType : res.chatMsgType,
					chatContent : res.chatContent,
					chatWriteDate : res.chatWriteDate,
					fileGroupNo : res.fileGroupNo,
					imgFile : res.imgFile,
					fileNo : res.fileNo,
					filePath : res.filePath,
					fileStrgNm : res.fileStrgNm,
					fileOrgnlNm : res.fileOrgnlNm,
					fileSz : res.fileSz,
					fileFancySize : res.fileFancySize,
					fileCtrDt : res.fileCtrDt,
					fileType : res.fileType
				};
				
				// letsgo
				var chatAlarmContent = "";
				if (res.chatMsgType == "MSG_01") {
					const alarmMsgMaxLength = 15;
					if (res.chatContent.length > alarmMsgMaxLength) {
						chatAlarmContent = res.chatContent.substring(0, alarmMsgMaxLength) + '...';
					}else{
						chatAlarmContent = res.chatContent;
					}
				}
				if (res.chatMsgType == "MSG_02") {
					chatAlarmContent = "이미지 메세지입니다.";
				}
				if (res.chatMsgType == "MSG_03") {
					chatAlarmContent = "첨부파일 메세지입니다.";
				}
				
				// 알람타입 | 알람타이틀 | 알람내용 | 사용자조회고유아이디 | 부가정보
				var alarm_msg_to_json = {
					alarmType : "ALARM01",
					alarmTitle : "EGGCHAT", 
					alarmContent : chatAlarmContent,
					referenceId : res.chatRoomNo,
					referenceInfo : ""
				};
				
	            // 메시지 전송 후, 필요한 후속 작업 수행 (예: 채팅창 업데이트)
	            $("#chatContentArea").val("");
	            // 소켓 서버로 데이터 전송
	            chatSock.send(JSON.stringify(res_to_json));
	            alarmSock.send(JSON.stringify(alarm_msg_to_json));
	        },
	        error: function(error) {
	            console.log("Error sending message: ", error);
	            alert("메시지 전송 중 오류가 발생했습니다.");
	        }
	    });
	
	}
	// ====================================================
	
	// 사원 추가 함수
	function addEmplToChatRoom(selectedChatRoomNo, emplArrToStr){
		$.ajax({
	        url: "/egg/addEmplToChatRoom",
	        type: "POST",
			data: { 
				chatRoomNo: selectedChatRoomNo,
				emplArrToStr : emplArrToStr
			},
	        beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
				xhr.setRequestHeader(header, token);
			},
	        dataType: "text",	// 서버에서 전달 받는 데이터
	        success: function(res) {
	        	console.log(res); // del
	        	$("#chatListTab").find("a").each(function() {
	        	    if ($(this).data("chatroomno") === selectedChatRoomNo) {
	        	        $(this).find("img").attr("src", "/resources/logo/multiple_chat_icon.png");
	        	    }
	        	});
	        	selectCurrentChatRoomEmpl(selectedChatRoomNo);
			},
		    error: function(error) {
		        console.log(error);
		        alert("Error insert employee");
		    }
		});
	}



chatSock.onmessage = onMessage;
chatSock.onclose = onClose;

// 서버로부터 메시지를 받았을 때
// 들어오는 메시지(msg.data)를  추가
function onMessage(msg) {
	var data = JSON.parse(msg.data);
	if (data.chatRoomNo == currentChatRoomNo) {
		console.log("data.chatContent : " + data.chatContent); // del
		appendMessage(data);
	}
}
// 서버와 연결을 끊었을 때
function onClose(evt) {
	console.log("채팅 소켓연결 끊김");
}

// 채팅 메세지 삽입
function appendMessage(chatMsg) {
    var conversationHTML = insertConversation(chatMsg);
    $(".simplebar-content:last").append(conversationHTML);
    setTimeout(focusOnLastElement, 100);
}

// 채팅메세지 데이터 format
function insertConversation(recieveMsg){
	var appendConversationHTML = ""; 
	var liTag = recieveMsg.emplId == "${sessionScope.emplInfo.emplId}" ? "<li class='clearfix odd'>" : "<li class='clearfix'>";
	appendConversationHTML += liTag;
	appendConversationHTML += "<div class='chat-avatar'>"; 
	appendConversationHTML += 	"<img src='"+ recieveMsg.emplProfileImg +"' class='rounded' alt='"+ recieveMsg.emplName +"' />"; 
	appendConversationHTML += 	"</div>";
	appendConversationHTML += "<div class='conversation-text'>"; 
	if (recieveMsg.emplId == "${sessionScope.emplInfo.emplId}") {
		appendConversationHTML += 	"<i> "+ formatTimestamp(recieveMsg.chatWriteDate) +" </i>" ;
	}
	if (recieveMsg.chatMsgType == "MSG_01") {
		appendConversationHTML += 	"<div class='ctext-wrap'>"; 
		appendConversationHTML += 	"<i>"+ recieveMsg.emplName +"</i>"; 
		appendConversationHTML += 	"<p>"+recieveMsg.chatContent+"</p>"; 
	}
	if (recieveMsg.chatMsgType == "MSG_02") {
		appendConversationHTML += 	"<div class='ctext-wrap col-md-8'>"; 
		appendConversationHTML += 	"<i>"+ recieveMsg.emplName +"</i>"; 
		appendConversationHTML += 	"<img src='" + recieveMsg.imgFile + "' class='col-md-12'/>"; 
	}
	if (recieveMsg.chatMsgType == "MSG_03") {
		appendConversationHTML += 	"<div class='ctext-wrap'>"; 
		appendConversationHTML += 	"<i>"+ recieveMsg.emplName +"</i>"; 
		appendConversationHTML += "<div class='card mt-2 mb-1 shadow-none border text-start'>";
		appendConversationHTML += "<div class='p-2'>";
		appendConversationHTML += "<div class='row align-items-center'>";
		appendConversationHTML += "<div class='col-auto'>";
		appendConversationHTML += "<div class='avatar-sm'>";
		appendConversationHTML += "<span class='avatar-title rounded'>";
		appendConversationHTML += "." + recieveMsg.fileType;
		appendConversationHTML += "</span>";
		appendConversationHTML += "</div>";
		appendConversationHTML += "</div>";
		appendConversationHTML += "<div class='col ps-0'>";
		appendConversationHTML += "<a href='javascript:void(0);' class='text-muted fw-bold downloadChatFileLink' "
									+ "data-filename='"+recieveMsg.fileStrgNm+"' data-originalfilename='"+recieveMsg.fileOrgnlNm+"'>"
									+recieveMsg.fileOrgnlNm+"</a>";
		appendConversationHTML += "<p class='mb-0'>"+recieveMsg.fileFancySize+"</p>";
		appendConversationHTML += "</div>";
		appendConversationHTML += "<div class='col-auto'>";
		appendConversationHTML += "<a href='javascript:void(0);' class='btn btn-link btn-lg text-muted downloadChatFileLink' "
									+ "data-filename='"+recieveMsg.fileStrgNm+"' data-originalfilename='"+recieveMsg.fileOrgnlNm+"'>";
		appendConversationHTML += "<i class='ri-download-2-line'></i>";
		appendConversationHTML += "</a>";
		appendConversationHTML += "</div>";
		appendConversationHTML += "</div>";
		appendConversationHTML += "</div>";
		appendConversationHTML += "</div>";
	}
	appendConversationHTML += 	"</div>"; 
	if (recieveMsg.emplId != "${sessionScope.emplInfo.emplId}") {
		appendConversationHTML += 	"<i> "+ formatTimestamp(recieveMsg.chatWriteDate) +" </i>" ;
	}
	appendConversationHTML += "</div>";
	appendConversationHTML += "</li>";
	return appendConversationHTML;
// 	$(".simplebar-content:last").append(appendConversationHTML);
	setTimeout(focusOnLastElement, 100);  // DOM 업데이트 후 호출
}

// 밀리초 시간 포맷함수
function formatTimestamp(timestamp) {
    var date = timestamp == null ? new Date(Date.now()) : new Date(timestamp);
    var month = ('0' + (date.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1
    var day = ('0' + date.getDate()).slice(-2);
    var hours = ('0' + date.getHours()).slice(-2);
    var minutes = ('0' + date.getMinutes()).slice(-2);
    return month + '/' + day + '.' + hours + ':' + minutes;
}

// 마지막 채팅내용 focus
function focusOnLastElement() {
    var lastElement = $(".simplebar-content:last").children().last();
    if (lastElement.length) {
        lastElement[0].scrollIntoView({ behavior: "smooth", block: "end" }); // 스크롤 위치 조정
        lastElement.focus(); // 포커스 설정
    }
}

// 새로운 채팅방 화면에 prepend
function insertNewChatRoom(createdChatRoomNo, createdChatRoomName){
	var curTime = formatTimestamp();
	var HTMLCode = `<a href='javascript:void(0);' class='text-body aChatRoomBtn' data-chatroomno='\${createdChatRoomNo}'>
        <div class="d-flex align-items-start mt-1 p-2">
            <img src="/resources/logo/personal_chat_icon.png" class="me-2 rounded-circle" height="48">
            <div class="w-100 overflow-hidden">
                <h5 class="mt-0 mb-0 font-14">
                    <span class="float-end text-muted font-12"></span>
                    \${createdChatRoomName}
                </h5>
                <p class="mt-1 mb-0 text-muted font-14">
                    <span class="w-75"> 새로운 채팅방 </span>
                </p>
            </div>
        </div>
    </a>
	`;
		
	$("#chatListTab").find(".simplebar-content").prepend(HTMLCode);
}

// 채팅방에서 사원 추가 버튼 클릭
$(document).on("click", "#addEmpCurrentChatRoom", function(e){
	e.preventDefault();
	var roomNo = $(this).data("chatroomno");
	clearAddEmplList();
	// 리스트 요청
	$.ajax({
        url: "/egg/selectEmplNotInChatroom",
        type: "GET",
		data: { chatRoomNo: roomNo },
        beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
			xhr.setRequestHeader(header, token);
		},
        dataType: "json",
        success: function(res) {
			var modalBodyTableHTMLCode = "";
			modalBodyTableHTMLCode +=`
				
				<table class="table table-centered mb-0">
				    <thead>
				        <tr>
				            <th class="text-center">사원</th>
				            <th>부서</th>
				            <th class="text-center">초대</th>
				        </tr>
				    </thead>
				    <tbody id="empl-modal-table-body">`;
				    
		        	$.each(res, function(index, modalEmplInfo) {
		        		modalBodyTableHTMLCode +=`
					        <tr>
					            <td class="list-inline">
					            	<img src="\${modalEmplInfo.proflImageCours}" 
					            		class="me-2 rounded-circle list-inline-item" height="48" >
					            	<h5 class="list-inline-item">\${modalEmplInfo.emplNm}</h5>
					            </td>
					            <td>\${modalEmplInfo.deptNm}</td>
					            <td>
					                <div>
					                    <input type="checkbox" id="switch\${index}" data-switch="success" 
					                    	data-emplid="\${modalEmplInfo.emplId}"
					                    	data-emplnm="\${modalEmplInfo.emplNm}"
					                    	data-emplprofile="\${modalEmplInfo.proflImageCours}"
					                    	/>
					                    <label for="switch\${index}" data-on-label="Yes" data-off-label="No" class="mb-0 d-block"></label>
					                </div>
					            </td>
					        </tr>
						`;
		        		console.log(modalEmplInfo.emplNm);
	        	});
		        	modalBodyTableHTMLCode += `</table>`;
				$(".modal-body-table-section").html(modalBodyTableHTMLCode);
			
		},
	    error: function(error) {
	        console.log(error);
	        alert("Error loading chat employee");
	    }
	});
});

// 추가할 사원 선택
// 체크박스가 체크되거나 해제될 때 이벤트 처리
$(document).on("change", "input[type='checkbox'][data-switch='success']", function() {
    var isChecked = $(this).is(":checked");
    var emplId = $(this).data("emplid");
    var emplNm = $(this).data("emplnm");
    var emplProfile = $(this).data("emplprofile");

    if (isChecked) {
        var newEmplHTML = `
            <a href="javascript:void(0);" data-bs-container="#tooltip-container" 
            data-bs-toggle="tooltip" data-bs-placement="top" class="d-inline-block me-2 added-empl" aria-label="\${emplNm}" data-bs-original-title="\${emplNm}"
            data-emplid="\${emplId}"
            data-emplnm="\${emplNm}"
            data-emplprofile="\${emplProfile}">
                <img src="\${emplProfile}" class="rounded-circle img-thumbnail avatar-sm">
                <h5 class="mb-0">\${emplNm}</h5>
            </a>
        `;
        $("#add-empl-list-modal").prepend(newEmplHTML);
    } else {
        $("#add-empl-list-modal").find(`a[data-emplid='\${emplId}']`).remove();
    }
});

//추가된 <a> 요소 클릭 시 체크박스 해제 및 요소 제거
$(document).on("click", ".added-empl", function() {
    var emplId = $(this).data("emplid");
    $(document).find(`input[type='checkbox'][data-emplid='\${emplId}']`).prop('checked', false).trigger('change');
    $(this).remove();
});

// 초대 버튼 클릭시
$("#add-empl-btn").on("click", function(){
	var addingEmplList = $("#add-empl-list-modal").find("a");
	var emplArrToStr = "";
	$.each(addingEmplList, function(index, addingEmpl) {
		emplArrToStr += $(addingEmpl).data("emplid") + ",";
	});
	console.log("emplArrToStr : " + emplArrToStr);
	console.log("currentChatRoomNo : " + currentChatRoomNo)
	addEmplToChatRoom(currentChatRoomNo, emplArrToStr);
	$("#scrollable-modal").modal('hide'); // 모달 숨김
	alert("초대하였습니다");
});


function clearAddEmplList(){
	$(document).find("#add-empl-list-modal").html("");
}

}); // /$function

</script>
