<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>근태관리</title>
<style>
.carousel-control-prev-icon,
.carousel-control-next-icon {
  background-image: none; /* 기본 이미지 제거 */
}

.carousel-control-prev-icon::before,
.carousel-control-next-icon::before {
  content: ''; /* SVG 아이콘 추가 */
  display: inline-block;
  width: 20px; /* 아이콘 크기 조정 */
  height: 20px;
  background-color: black; /* 아이콘 색상 설정 */
  mask: url('data:image/svg+xml;charset=UTF8,<svg xmlns="http://www.w3.org/2000/svg" fill="%23ffffff" viewBox="0 0 8 8"><path d="M2.5 0L1 1.5l2.5 2.5L1 6.5l1.5 1.5 4-4-4-4z"/></svg>') center / contain no-repeat;
}

.carousel-control-prev-icon::before {
  transform: scaleX(-1); /* 이전 버튼 아이콘 반전 */
}

.carousel-control-prev {
  left: 35%; /* 왼쪽 버튼의 위치를 조정합니다 */
}

.carousel-control-next {
  right: 35%; /* 오른쪽 버튼의 위치를 조정합니다 */
}

.month{
	margin-left: 48.5%;
}
</style>
<script>
var curMonth = ${currentMonth};
$(function(){
	$(".currMonth").text(curMonth + "월");

	$(".carousel-control-prev").on("click", function(){
		if(curMonth == 1){
			curMonth = 13;
		}
		curMonth = curMonth - 1;
		$(".currMonth").text(curMonth + "월");
// 		$("#monthInput").val(curMonth);
// 		$("#monthForm").submit();
		loadWorkData(curMonth);
	});
	$(".carousel-control-next").on("click", function(){
		if(curMonth == 12){
			curMonth = 0;
		}
		curMonth = curMonth + 1;
		$(".currMonth").text(curMonth + "월");
// 		$("#monthInput").val(curMonth);
// 		$("#monthForm").submit();
		loadWorkData(curMonth);
	});
});

function loadWorkData(month) {
	$.ajax({
		url: '/egg/workMonthInfo',
		type: 'GET',
		data: { month: month },
		success: function(data) {
			console.log(data[2]);
            var accordionHTML = "";
            var monthTotalTime=0.0;
            var weekTotalTime=0.0;
            
            var maxWeekNum = 0; // 최대 주차 번호를 저장할 변수
            
         // 데이터를 먼저 순회하여 최대 주차 번호 찾기
            Object.keys(data).forEach(function(week) {
                data[week].forEach(function(workData) {
                    if (workData.numWeek > maxWeekNum) {
                        maxWeekNum = workData.numWeek; // 최대 주차 번호 업데이트
                    }
                });
            });
            Object.keys(data).forEach(function(week, index) {
            	
                accordionHTML += "<div class=\"accordion-item\">" +
                    "<h2 class=\"accordion-header\" id=\"heading" + index + "\">" +
                        "<button class=\"accordion-button " + (index !== 0 ? 'collapsed' : '') + "\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#collapse" + index + "\" aria-expanded=\"" + (index === 0 ? 'true' : 'false') + "\" aria-controls=\"collapse" + index + "\">" +
                            week + "주차" +
                        "</button>" +
                    "</h2>" +
                    "<div id=\"collapse" + index + "\" class=\"accordion-collapse collapse " + (index === 0 ? 'show' : '') + "\" aria-labelledby=\"heading" + index + "\" data-bs-parent=\"#accordionExample\">" +
                        "<div class=\"accordion-body\">" +
                            "<table class=\"table table-bordered\">" +
                                "<thead>" +
                                    "<tr>" +
                                        "<th>일자</th>" +
                                        "<th>출근</th>" +
                                        "<th>퇴근</th>" +
                                        "<th>총근무시간</th>" +
                                        "<th>근무시간 상세</th>" +
                                        "<th>상태</th>" +
                                    "</tr>" +
                                "</thead>" +
                                "<tbody>";
                data[week].forEach(function(workData) {
            		if(workData.workDayHours < 0){
        				workData.workDayHours = 0;
        			}
                	monthTotalTime += parseFloat(workData.workDayHours);
                	// 최대 주차에 해당하는 데이터만 처리
                    if (workData.numWeek == maxWeekNum) {
                        weekTotalTime += parseFloat(workData.workDayHours);
                    }
                	var startTime = new Date(workData.workBgngHr);
                	var endTime = new Date(workData.workEndHr);
                	var day = formatDate(startTime).toString();
                	var end = formatDate(endTime).toString();
                	var strDay = day.substring(5,10);
                	var first = day.substring(11,16);
                	var second = end.substring(11,16);
                    
                    var workHours = endTime.getHours() - startTime.getHours();
                    var workMinutes = endTime.getMinutes() - startTime.getMinutes();
                    var workSeconds = endTime.getSeconds() - startTime.getSeconds();
                    
                    var overTime;
                    var defTime = convertTime(workData.workDayHours);
                    // 연장시간 구하는조건문
                    if(workData.workDayHours > 9.0){
                    	defTime = convertTime(workData.workDayHours - (workData.workDayHours-9.0));
                    	overTime = convertTime(workData.workDayHours-9.0) 
                    }else{
                    	overTime = convertTime(0);
                    }
                    
                    
                    
//    					// 근태상태 체크하는 조건문
//         			if (timeChk >= 9.0 && timeChk1 > 0) {
// 	        				workData.workState = "지각";
//         			} 
//         			else {
//         				if(workData.workDayHours == 0){
// 	        				workData.workState = "결근";
//         				}else{
// 	        				workData.workState = "정상";
//         				}
//         			}
        	
                    
                    accordionHTML += "<tr>" +
                        "<td>" + strDay + "</td>" +
                        "<td>" + first + "</td>" +
                        "<td>" + second + "</td>" +
                        "<td>" + defTime + "</td>" +
                        "<td>기본: " + defTime + " / 연장: " + (overTime || '0h 0m 0s') + "</td>" +
                        "<td>" + workData.workState + "</td>" +
                    "</tr>";
                });
                accordionHTML += "</tbody>" +
                            "</table>" +
                        "</div>" +
                    "</div>" +
                "</div>";
            });
            $('#accordionExample').html(accordionHTML);
            $('#monthTime').html(convertTime(monthTotalTime));
            $('#weekTime').html(convertTime(weekTotalTime));
            if(weekTotalTime > 45.0){
	            $('#weekOverTime').html(convertTime(parseFloat(weekTotalTime-45.0)));
            }else{
            	$('#weekOverTime').html("0h 0m 0s");
            }
            if(monthTotalTime > 209.0){
	            $('#monthOverTime').html(convertTime(parseFloat(monthTotalTime-209.0)));
            }else{
            	$('#monthOverTime').html("0h 0m 0s");
            }
            
            
        },
	});
	
	function formatDate(dateString) {
	    var date = new Date(dateString);
	    var year = date.getFullYear();
	    var month = ('0' + (date.getMonth() + 1)).slice(-2);  // 월은 0부터 시작하므로 1을 추가
	    var day = ('0' + date.getDate()).slice(-2);
	    var hours = ('0' + date.getHours()).slice(-2);
	    var minutes = ('0' + date.getMinutes()).slice(-2);
	    var seconds = ('0' + date.getSeconds()).slice(-2);

	    return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
	}

	function convertTime(decimalHours) {
	    var hours = Math.floor(decimalHours);  // 시간 부분을 추출 (소수점 제거)
	    var minutesFromDecimal = (decimalHours - hours) * 60;  // 남은 소수 부분을 분으로 변환
	    var minutes = Math.floor(minutesFromDecimal);  // 분의 정수 부분
	    var seconds = Math.floor((minutesFromDecimal - minutes) * 60);  // 남은 소수 부분을 초로 변환

	    return hours + "h " + minutes + "m " + seconds + "s";
	}
}

</script>
</head>
<body>
<!-- 	<form id="monthForm" action="/egg/work" method="get"> -->
<%-- 		<input type="hidden" id="monthInput" name="month" value="${currentMonth}"> --%>
<!-- 	</form> -->
	<h2 style="margin-top: 20px;">근태현황</h2>
	<div id="carouselExampleControlsNoTouching" class="carousel slide" data-bs-touch="false">
		<div class="carousel-inner">
			<div class="carousel-item active">
				<h3 style="margin-left: 48%;" class="currMonth"></h3>
			</div>
		</div>
		<button class="carousel-control-prev" type="button">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button">
			<span class="carousel-control-next-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Next</span>
		</button>
	</div>

	<div id="workDataContainer">
		<!-- 근태 데이터를 표시할 영역 -->
		<div class="content">
			<div class="container-fluid">
				<br>
				<div class="row">
					<div class="col-sm-3">
						<div class="card widget-flat">
							<div class="card-body">
								<div class="d-flex align-items-center">
									<div>
										<h4 class="profileInfo">이번주 누적</h4>
										<br>
										<c:if test="${weekTime == null}">
										<p class="profileInfo" style="font-size: 24px; color: skyblue;">0h 0m 0s</p>
										</c:if>
										<c:if test="${weekTime != null}">
										<p id="weekTime" class="profileInfo" style="font-size: 24px; color: skyblue;">${weekTime }</p>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="card widget-flat">
							<div class="card-body">
								<div class="d-flex align-items-center">
									<div>
										<h4 class="profileInfo">이번달 누적</h4>
										<br>
										<p id="monthTime" class="profileInfo" style="font-size: 24px; color: skyblue;">${monthTime }</p>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="card widget-flat">
							<div class="card-body">
								<div class="d-flex align-items-center">
									<div>
										<h4 class="profileInfo">이번주 초과</h4>
										<br>
										<c:if test="${weekOverTime == null}">
										<p class="profileInfo" style="font-size: 24px; color: skyblue;">0h 0m 0s</p>
										</c:if>
										<c:if test="${weekOverTime != null}">
										<p id="weekOverTime" class="profileInfo" style="font-size: 24px; color: skyblue;">${weekOverTime }</p>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="card widget-flat">
							<div class="card-body">
								<div class="d-flex align-items-center">
									<div>
										<h4 class="profileInfo">이번달 초과</h4>
										<br>
										<p id="monthOverTime" class="profileInfo" style="font-size: 24px; color: skyblue;">${monthOverTime }</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="accordion" id="accordionExample">
				<c:forEach var="weekEntry" items="${groupedByWeek}" varStatus="status">
					<div class="accordion-item">
						<h2 class="accordion-header" id="heading${status.index}">
							<button class="accordion-button <c:if test="${status.index != 0}">collapsed</c:if>" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${status.index}" aria-expanded="<c:if test="${status.index == 0}">true</c:if>" aria-controls="collapse${status.index}">
								${weekEntry.key}주차
							</button>
						</h2>
						<div id="collapse${status.index}" class="accordion-collapse collapse <c:if test="${status.index == 0}">show</c:if>" aria-labelledby="heading${status.index}" data-bs-parent="#accordionExample">
							<div class="accordion-body">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th>일자</th>
											<th>출근</th>
											<th>퇴근</th>
											<th>총근무시간</th>
											<th>근무시간 상세</th>
											<th>상태</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="workData" items="${weekEntry.value}">
											<tr>
												<td>${fn:substring(workData.workBgngHr, 5, 10)}</td>
												<td>${fn:substring(workData.workBgngHr, 11, 16)}</td>
												<td>${fn:substring(workData.workEndHr, 11, 16)}</td>
												<td>${workData.workDayHours}</td>	
												<c:if test="${workData.overTime != null}">
													<td>기본 : ${workData.workDayHours} / 연장 : ${workData.overTime}</td>
												</c:if>
												<c:if test="${workData.overTime == null}">
													<td>기본 : ${workData.workDayHours} / 연장 : 0h 0m 0s</td>
												</c:if>
												<td>${workData.workState}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					</c:forEach>
				</div>
			</div>
		</div>
</body>
</html>
