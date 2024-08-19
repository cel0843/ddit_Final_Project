<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
<script
	src="${pageContext.request.contextPath }/resources/node_modules/gridstack/dist/gridstack-all.js"></script>
<link
	href="${pageContext.request.contextPath }/resources/node_modules/gridstack/dist/gridstack.min.css"
	rel="stylesheet" />

<style type="text/css">
::-webkit-scrollbar {
	display: none;
}

.profile_right {
	display: flex;
	flex-direction: column;
	margin-left: 25%;
}

.profile_left_img {
	margin-left: 25%;
	width: 180px;
	height: 180px;
	border-radius: 100%;
}

.profile_right_myinfo {
	display: flex;
	flex-direction: column;
	margin-left: 43%;
}

.profile_right_myinfo_name {
	margin-left: 33%;
}

.profile_right_table {
	margin-top: 20px;
}

.fc-view-harness-active {
	/* 클릭 불가능 none */
	pointer-events: none;
}

.company_schedule_cal {
	height: 447px !important;
}

.grid-stack {
	background: #fafbfe;
}

.grid-stack-item {
	margin-top: -20px;
}

.grid-stack-item-content {
	background-color: #ffffff;
	padding: 25px;
	border-radius: 15px;
	box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.03);
}

.boardHeader {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
}

td a:link {
	color: #747d84;
}

td a:visited {
	color: #747d84;
}

td a:hover {
	color: #747d84;
}

td a:active {
	color: #747d84
}
</style>
</head>
<body>

	<c:set value="${sessionScope.emplInfo}" var="emplInfo" />
	<div id="success-alert-modal" class="modal fade" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content modal-filled bg-primary">
				<div class="modal-body p-4">
					<div class="text-center">
						<i class="ri-check-line h1"></i>
						<h4 class="mt-2">출근</h4>
						<p class="mt-3">출근 처리를 하시겠습니까?</p>
						<div id="outputStart">
							<div id="outputMessageStart">QR코드를 카메라에 노출시켜 주세요</div>
							<div id="outputLayerStart" hidden>
								<span id="outputDataStart"></span>
							</div>
						</div>
						<div>&nbsp;</div>
						<div>
							<div id="frameStart">
								<div id="loadingMessageStart">
									🎥 비디오 스트림에 액세스 할 수 없습니다<br />웹캠이 활성화되어 있는지 확인하십시오
								</div>
								<canvas id="canvasStart" style="width: 100%;"></canvas>
							</div>
						</div>
						<button type="button" class="btn btn-light my-2"
							data-bs-dismiss="modal">취소</button>
						<button id="workStart" type="button" class="btn btn-light my-2"
							data-bs-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="success-alert-modal1" class="modal fade" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content modal-filled bg-danger">
				<div class="modal-body p-4">
					<div class="text-center">
						<i class="ri-check-line h1"></i>
						<h4 class="mt-2">퇴근</h4>
						<p class="mt-3">퇴근 처리를 하시겠습니까?</p>
						<div id="outputEnd">
							<div id="outputMessageEnd">QR코드를 카메라에 노출시켜 주세요</div>
							<div id="outputLayerEnd" hidden>
								<span id="outputDataEnd"></span>
							</div>
						</div>
						<div>&nbsp;</div>
						<div>
							<div id="frameEnd">
								<div id="loadingMessageEnd">
									🎥 비디오 스트림에 액세스 할 수 없습니다<br />웹캠이 활성화되어 있는지 확인하십시오
								</div>
								<canvas id="canvasEnd" style="width: 100%;"></canvas>
							</div>
						</div>
						<button type="button" class="btn btn-light my-2"
							data-bs-dismiss="modal">취소</button>
						<button id="workEnd" type="button" class="btn btn-light my-2"
							data-bs-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="content">
		<div class="container-fluid">
			<br>
			<div class="row">
				<!--row 시작-->

				<div class="grid-stack">

					<c:set value="${gridList}" var="gridList" />

					<div class="grid-stack-item" gs-id="1"
						gs-x="${gridList.get(0).getGsX()}"
						gs-y="${gridList.get(0).getGsY()}"
						gs-w="${gridList.get(0).getGsW()}"
						gs-h="${gridList.get(0).getGsH()}">
						<div class="grid-stack-item-content">
							<div class="d-flex align-items-center">
								<div>
									<img src="${emplInfo.proflImageCours}" class="profile_left_img">
								</div>
								<div class="profile_right">
									<div class="profile_right_myinfo">
										<div class="profile_right_myinfo_name">
											<span><b style="font-size: 17px;">${emplInfo.emplNm}</b>&nbsp;&nbsp;</span><span
												style="font-size: 12px;">${emplInfo.positionNm}</span><br>
										</div>
										<div>
											<span>${emplInfo.deptNm}
												&nbsp;&nbsp;${emplInfo.emplId}</span><br>
										</div>
									</div>
									<div class="profile_right_table">
										<table class="table">
											<tr>
												<td><a href="/egg/aprvList">결재 대기문서</a></td>
												<td>:</td>
												<td><a href="/egg/aprvList">${aprvDocListCount }개</a></td>
											</tr>
											<tr>
												<td><a href="/project/mainProjectPage">진행중 업무</a></td>
												<td>:</td>
												<td><a href="/project/mainProjectPage">${playingworkCount}개</a></td>
											</tr>
											<tr>
												<td><a href="/egg/mail/reList">안 읽은 메일</a></td>
												<td>:</td>
												<td><a href="/egg/mail/reList">${uReadMailCount }개</a></td>
											</tr>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>


					<div class="grid-stack-item" gs-id="2"
						gs-x="${gridList.get(1).getGsX()}"
						gs-y="${gridList.get(1).getGsY()}"
						gs-w="${gridList.get(1).getGsW()}"
						gs-h="${gridList.get(1).getGsH()}">
						<div class="grid-stack-item-content">
							<h3>근태현황</h3>

							<h5>${resultToday }</h5>
							<h5>
								출근 시간 : <span id="startChkTime">${sTime }</span>
							</h5>
							<h5>
								퇴근 시간 : <span id="endChkTime">${eTime }</span>
							</h5>
							<br>
							<button style="width: 100px;" type="button"
								class="btn btn-primary" data-bs-toggle="modal"
								data-bs-target="#success-alert-modal">출근</button>
							<button style="width: 100px;" type="button"
								class="btn btn-danger" data-bs-toggle="modal"
								data-bs-target="#success-alert-modal1">퇴근</button>
						</div>
					</div>



					<div class="grid-stack-item" gs-id="3"
						gs-x="${gridList.get(2).getGsX()}"
						gs-y="${gridList.get(2).getGsY()}"
						gs-w="${gridList.get(2).getGsW()}"
						gs-h="${gridList.get(2).getGsH()}">
						<div class="grid-stack-item-content">
							<!-- 				<div class="col-sm-12"> -->
							<!-- 					<div class="card widget-flat"> -->
							<!-- 						<div class="card-body"> -->
							<div>
								<div class="boardHeader">
									<div>
										<h3>공지사항</h3>
									</div>
									<div>
										<a href="/egg/board">+ 더보기</a>
									</div>
								</div>
								<h5>1. ${boardList.get(0).bbsTtl }</h5>
								<h5>2. ${boardList.get(1).bbsTtl }</h5>
								<h5>3. ${boardList.get(2).bbsTtl }</h5>
								<h5>4. ${boardList.get(3).bbsTtl }</h5>
								<h5>5. ${boardList.get(4).bbsTtl }</h5>
							</div>
						</div>
					</div>


					<!-- 			</div>row 종료 -->


					<!-- 			<div class="row"> -->

					<div class="grid-stack-item" gs-id="4"
						gs-x="${gridList.get(3).getGsX()}"
						gs-y="${gridList.get(3).getGsY()}"
						gs-w="${gridList.get(3).getGsW()}"
						gs-h="${gridList.get(3).getGsH()}">
						<div class="grid-stack-item-content">
							<div id="external-events"></div>
							<div id="calendar" class="company_schedule_cal"></div>
						</div>
						<!-- end col -->
					</div>
					<!-- end card body-->

					<!-- Add New Event MODAL -->
					<div class="modal fade" id="event-modal" tabindex="-1">
						<div class="modal-dialog">
							<div class="modal-content">
								<form class="needs-validation" name="event-form" id="form-event"
									novalidate>
									<div class="modal-header py-3 px-4 border-bottom-0">
										<h5 class="modal-title" id="modal-title">Event</h5>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body px-4 pb-4 pt-0">
										<div class="row">
											<div class="col-12">
												<div class="mb-3">
													<label class="control-label form-label">Event Name</label>
													<input class="form-control" placeholder="Insert Event Name"
														type="text" name="title" id="event-title" required />
													<div class="invalid-feedback">Please provide a valid
														event name</div>
												</div>
											</div>
											<div class="col-12">
												<div class="mb-3">
													<label class="control-label form-label">Category</label> <select
														class="form-select" name="category" id="event-category"
														required>
														<option value="bg-danger" selected>Danger</option>
														<option value="bg-success">Success</option>
														<option value="bg-primary">Primary</option>
														<option value="bg-info">Info</option>
														<option value="bg-dark">Dark</option>
														<option value="bg-warning">Warning</option>
													</select>
													<div class="invalid-feedback">Please select a valid
														event category</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-6">
												<button type="button" class="btn btn-danger"
													id="btn-delete-event">Delete</button>
											</div>
											<div class="col-6 text-end">
												<button type="button" class="btn btn-light me-1"
													data-bs-dismiss="modal">Close</button>
												<button type="submit" class="btn btn-success"
													id="btn-save-event">Save</button>
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>

					<div class="grid-stack-item" gs-id="5"
						gs-x="${gridList.get(4).getGsX()}"
						gs-y="${gridList.get(4).getGsY()}"
						gs-w="${gridList.get(4).getGsW()}"
						gs-h="${gridList.get(4).getGsH()}">
						<div class="grid-stack-item-content">
							<div class="row justify-content-center">
								<div class="">
									<!-- 투두리스트임!  -->
									<h4 class="header-title mb-3">투두리스트</h4>
									<input type="hidden" id="todo-emplinfo"
										value="${emplInfo.emplId }">
									<div class="todoapp">
										<div class="row">
											<div class="col">
												<h5 id="todo-message">
													<span id="todo-remaining"></span> of <span id="todo-total"></span>
												</h5>
											</div>
											<div class="col-auto">
												<a href="" class="float-end btn btn-light btn-sm"
													id="btn-archive">삭제</a>
											</div>
										</div>

										<div style="max-height: 314px" data-simplebar="">
											<ul class="list-group list-group-flush todo-list"
												id="todo-list"></ul>
										</div>

										<form name="todo-form" id="todo-form" class="needs-validation"
											novalidate="">
											<div class="row">
												<div class="col">
													<input type="text" id="todo-input-text"
														name="todo-input-text" class="form-control"
														placeholder="Add new todo" required="">
													<div class="invalid-feedback">Please enter your task
														name</div>
												</div>
												<div class="col-auto d-grid">
													<button
														class="btn-primary btn-md btn waves-effect waves-light"
														type="submit" id="todo-btn-submit">추가</button>
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- gridstack -->
		</div>
		<!-- end col-->
	</div>
	<!-- Fullcalendar js -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/vendor/fullcalendar/index.global.min.js"></script>
	<!-- Calendar App refactoring js -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/pages/a.companycalendar.js"></script>

	<script
		src="${pageContext.request.contextPath }/resources/assets/js/jsQR.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/ui/component.todo.js"></script>

	<script type="text/javascript">
var goProjNo = 1;
// GridStack.init();



document.addEventListener("DOMContentLoaded", function () {
	
    var grid = GridStack.init();
    grid.on('change', function (e, items) {
    	items.forEach(function(item) {
//     		console.log(item);
    		var id = item._id;
    		var x = item.x;
    		var y = item.y;
    		var w = item.w;
    		var h = item.h;
    		console.log("id : " + id);
    		console.log("x : " + x);
    		console.log("y : " + y);
    		console.log("w : " + w);
    		console.log("h : " + h);
   			$.ajax({
	   				url: '/egg/gridStackInfo',
	    			type: 'POST',
	                beforeSend : function(xhr){ // 데이터 전송 전 , 헤더에 csrf 값 설정
                		xhr.setRequestHeader(header , token);
           			},
	                contentType: 'application/json',
	                data: JSON.stringify({
	                	gsId : id,
	                	gsX:x,
	                	gsY:y,
	                	gsW:w,
	                	gsH:h
	    			}),
	                success: function(data) {
// 	                	for(var i =0; i<data.length; i++)
// 	                    alert(i+" 번째   "+data[i].emplId + " | " +data[i].gsX +" | " + data[i].gsY + " | " + data[i].gsW + " | " + data[i].gsH);
// 	                	근데 생각해보니 셀렉트는 처음에 home 들어왔을때 값을 동기방식으로 할때 넣어주면 됨.
	                }
            });
   
   
//     	    $.ajax({
    			
//     			data: {
    				
//     			},
//     			success: function(data) {
//     	            alert("성공!!!");
//     	        },
//     			error: function() {
//     			}
//     		});
            
        });
    });
    
    
    
    var videoStart = document.createElement("video");
    var canvasElementStart = document.getElementById("canvasStart");
    var canvasStart = canvasElementStart.getContext("2d");
    var loadingMessageStart = document.getElementById("loadingMessageStart");
    var outputContainerStart = document.getElementById("outputStart");
    var outputMessageStart = document.getElementById("outputMessageStart");
    var outputDataStart = document.getElementById("outputDataStart");
    var streamStart;

    var videoEnd = document.createElement("video");
    var canvasElementEnd = document.getElementById("canvasEnd");
    var canvasEnd = canvasElementEnd.getContext("2d");
    var loadingMessageEnd = document.getElementById("loadingMessageEnd");
    var outputContainerEnd = document.getElementById("outputEnd");
    var outputMessageEnd = document.getElementById("outputMessageEnd");
    var outputDataEnd = document.getElementById("outputDataEnd");
    var streamEnd;

    function drawLine(begin, end, color, canvas) {
        canvas.beginPath();
        canvas.moveTo(begin.x, begin.y);
        canvas.lineTo(end.x, end.y);
        canvas.lineWidth = 4;
        canvas.strokeStyle = color;
        canvas.stroke();
    }

    function startVideoStream(video, canvasElement, canvas, loadingMessage, outputContainer, outputMessage, outputData, isStart) {
        navigator.mediaDevices.getUserMedia({ video: { facingMode: "environment" } }).then(function (s) {
            if (isStart) {
                streamStart = s;
            } else {
                streamEnd = s;
            }
            video.srcObject = s;
            video.setAttribute("playsinline", true);
            video.play();
            requestAnimationFrame(function tick() {
                if (video.readyState === video.HAVE_ENOUGH_DATA) {
                    loadingMessage.hidden = true;
                    canvasElement.hidden = false;
                    outputContainer.hidden = false;
                    canvasElement.height = video.videoHeight;
                    canvasElement.width = video.videoWidth;
                    canvas.drawImage(video, 0, 0, canvasElement.width, canvasElement.height);
                    var imageData = canvas.getImageData(0, 0, canvasElement.width, canvasElement.height);
                    var code = jsQR(imageData.data, imageData.width, imageData.height, { inversionAttempts: "dontInvert" });

                    if (code) {
                        drawLine(code.location.topLeftCorner, code.location.topRightCorner, "#FF0000", canvas);
                        drawLine(code.location.topRightCorner, code.location.bottomRightCorner, "#FF0000", canvas);
                        drawLine(code.location.bottomRightCorner, code.location.bottomLeftCorner, "#FF0000", canvas);
                        drawLine(code.location.bottomLeftCorner, code.location.topLeftCorner, "#FF0000", canvas);
                        outputMessage.hidden = true;
                        outputData.parentElement.hidden = false;
                        
                        var qrData = code.data;
                        
                        if (qrData == "${emplInfo.emplId}"){
//                         	alert("큐알 아이디 : " + qrData + "내 로그인된 아이디 : " + "${emplInfo.emplId}");
                       	 	var startChkTime = $("#startChkTime").text().trim();
	                        if(startChkTime === "--:--") {
	                            // 출근 시간이 없으므로 출근 처리
	                            $("#workStart").click();
	                        } else {
	                            // 출근 시간이 있으므로 퇴근 처리
	                            $("#workEnd").click();
	                        }
	                        stopVideoStream(isStart); // 카메라 스트림 종료
                        }
                    } else {
                        outputMessage.hidden = false;
                        outputData.parentElement.hidden = true;
                    }
                }
                requestAnimationFrame(tick);
            });
        }).catch(function (err) {
            console.error("Error accessing media devices.", err);
            loadingMessage.innerText = "Error accessing media devices.";
        });
    }

    function stopVideoStream(isStart) {
        var stream = isStart ? streamStart : streamEnd;
        if (stream) {
            stream.getTracks().forEach(function(track) {
                track.stop();
            });
            if (isStart) {
                videoStart.srcObject = null;
            } else {
                videoEnd.srcObject = null;
            }
        }
    }

    // 출근 모달이 열릴 때 카메라 활성화
    $('#success-alert-modal').on('shown.bs.modal', function () {
    	startVideoStream(videoStart, canvasElementStart, canvasStart, loadingMessageStart, outputContainerStart, outputMessageStart, outputDataStart, true);
    });

    // 퇴근 모달이 열릴 때 카메라 활성화
    $('#success-alert-modal1').on('shown.bs.modal', function () {
        startVideoStream(videoEnd, canvasElementEnd, canvasEnd, loadingMessageEnd, outputContainerEnd, outputMessageEnd, outputDataEnd, false);
    });

    // 모달이 닫힐 때 카메라 스트림 중지
    $('#success-alert-modal, #success-alert-modal1').on('hidden.bs.modal', function () {
        stopVideoStream(true);
        stopVideoStream(false);
    });
});


$("#workStart").on("click", function() {
	var startNullChk = $("#startChkTime").text();
	if(startNullChk != "--:--"){
		alert("이미 출근체크를 했습니다.");
		return false;
	}
	var time = new Date();
	var hours = time.getHours().toString().padStart(2, '0');
	var minutes = time.getMinutes().toString().padStart(2, '0');
    var startTime = hours + ':' + minutes;
    
    $.ajax({
		url: '/egg/workStart',
		type: 'GET',
		data: {startTime:startTime, emplId: "${emplInfo.emplId}"},
		success: function(data) {
            $("#startChkTime").text(" "+data);
        },
		error: function() {
		}
	});
	
});

$("#workEnd").on("click", function() {
	var startNullChk = $("#startChkTime").text();
	if(startNullChk == "--:--"){
		alert("출근을 하지 않았습니다.");
		return false;
	}
	var time = new Date();
	var hours = time.getHours().toString().padStart(2, '0');
	var minutes = time.getMinutes().toString().padStart(2, '0');
    var endTime = hours + ':' + minutes;
    
    $.ajax({
		url: '/egg/workEnd',
		type: 'GET',
		data: {endTime:endTime, emplId: "${emplInfo.emplId}"},
		success: function(data) {
            $("#endChkTime").text(" " + data);
        },
		error: function() {
		}
	});
});

</script>



</body>


</html>
