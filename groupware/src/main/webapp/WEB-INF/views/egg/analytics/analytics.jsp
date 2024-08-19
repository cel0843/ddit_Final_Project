<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/daterangepicker/moment.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/daterangepicker/daterangepicker.js"></script>
    <!-- Chart js -->
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/chart.js/chart.min.js"></script>
    <!-- Dashboard App js -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/pages/a.dashboard.js"></script>
<%--     <script src="${pageContext.request.contextPath }/resources/assets/js/pages/a.dashboard-projects.js"></script> --%>
    <!-- Vector Map js -->
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/jsvectormap/js/jsvectormap.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/jsvectormap/maps/world-merc.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/jsvectormap/maps/world.js"></script>
    <!-- Daterangepicker css -->
    <link href="${pageContext.request.contextPath }/resources/assets/vendor/daterangepicker/daterangepicker.css" rel="stylesheet" type="text/css">
    <!-- Vector Map css -->
    <link href="${pageContext.request.contextPath }/resources/assets/vendor/jsvectormap/css/jsvectormap.min.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath }/resources/assets/css/app-saas.min.css" rel="stylesheet" type="text/css" id="app-style" />
	
     
    <!-- Apex Chart js -->
<%--     <script src="${pageContext.request.contextPath }/resources/assets/vendor/apexcharts/apexcharts.min.js"></script> --%>
 
    <!-- Day.js 및 플러그인 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.11.0/dayjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.11.0/plugin/quarterOfYear.min.js"></script>

    <!-- App js -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/app.min.js"></script>

<style>
.fixed-height-card{
	  min-height: 484.97px; 
}


</style>    
    
    
<c:if test="${inputDate ne ''}">
	<c:set value="${ inputDate }" var="inputDate"></c:set>
</c:if> 


<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
	
	 var categories = [<c:forEach var="item" items="${emplSuvyResList}">"${item.EMPL_NM}",</c:forEach>];
     var data = [<c:forEach var="item" items="${emplSuvyResList}">${item.suvyres_cnt},</c:forEach>];
    var options = {
        chart: {
            height: 350,
            type: 'bar',
        },
        plotOptions: {
            bar: {
                distributed: true,
                horizontal: false,
                borderRadius: 10,
            }
        },
        colors: ['#727cf5', '#6c757d', '#0acf97', '#fa5c7c', '#ffbc00', '#39afd1', '#e3eaef', '#313a46'],
        dataLabels: {
            enabled: false
        },
        series: [{
            data: data
        }],
        xaxis: {
            categories: categories
        },
        legend: {
            show: false
        }
    };

    var chart = new ApexCharts(document.querySelector("#distributed-column"), options);
    chart.render();
});
$(function() {	
	
    function initDoughnutChart() {
        console.log('Initializing Doughnut Chart');
        var ctx = document.getElementById('project-status-chart').getContext('2d');
        var data = {
            labels: ["진행", "대기", "마감"],
            datasets: [{
                data: [
            	    ${taskStatusCounts.PERCENT_TKST001.intValue() }, 
            	    ${taskStatusCounts.PERCENT_TKST002.intValue() }, 
            	    ${taskStatusCounts.PERCENT_TKST003.intValue() }
            	],
                backgroundColor: ["#0acf97", "#727cf5", "#fa5c7c"],
                borderColor: "transparent",
                borderWidth: 3
            }]
        };
        var options = {
            maintainAspectRatio: false,
            cutout: 80,
            plugins: {
                legend: {
                    display: false
                }
            }
        };
        new Chart(ctx, {
            type: 'doughnut',
            data: data,
            options: options
        });
    }

    // 페이지가 로드될 때 차트를 초기화합니다.
    initDoughnutChart(); 
     
    function getFormattedDate(date) {
        var month = ('0' + (date.getMonth() + 1)).slice(-2);
        var day = ('0' + date.getDate()).slice(-2);
        var year = date.getFullYear();
        return month + '/' + day + '/' + year;
    }

    function changeDate(offset) {
        var selectedDate = $('#dash-daterange').val();
        var parts = selectedDate.split('/');
        var date = new Date(parts[2], parts[0] - 1, parts[1]);

        date.setMonth(date.getMonth() + offset);

        var formattedDate = getFormattedDate(date);
        window.location.href = '/admin/analytics/analyticsMain?selectDate=' + formattedDate;
    }

    $(document).on('click', '.applyBtn', function() {
        var selectedDate = $('#dash-daterange').val();
        window.location.href = '/admin/analytics/analyticsMain?selectDate=' + selectedDate;
    });
    
    $('#monthAgo').on('click', function () {
        changeDate(-1);
    });
    
    $('#monthAfter').on('click', function () {
        changeDate(1);
    });
	
})

</script>    
<body>
        <div class="content">
            <!-- Start Content-->
            <div class="container-fluid">

                <div class="row">
                    <div class="col-12">
                        <div class="page-title-box">
                            <div class="page-title-right">
                                <form class="d-flex">
                                    <div class="input-group">
                                    	<!--  월 이동 버튼  -->
                                    	<input type="button" id="monthAgo" value="◀ 이전달" class="btn btn-soft-primary btn-sm me-2" > 
                                    	<input type="button"id ="monthAfter" value="다음달 ▶" class="btn btn-soft-primary btn-sm"> 
                                        <input type="text" class="form-control form-control-light ms-2" id="dash-daterange" value="${inputDate}">
                                        <span class="input-group-text bg-primary text-white">
                                            <i class="mdi mdi-calendar-range font-13"></i>
                                        </span>
                                    </div>
                                    <a href="javascript: void(0);" class="btn btn-primary ms-2">
                                        <i class="mdi mdi-autorenew"></i>
                                    </a>
                                </form>
                            </div>
                            <h4 class="page-title">통계</h4>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xl-3 col-lg-4">
                        <div class="card tilebox-one">
                            <div class="card-body">
                                <i class='uil uil-users-alt float-end'></i>
	                            
                                <h4 class="text-uppercase mt-0">총 사원 수</h4>
                                <h2 class="my-2" id="active-users-count">${emplTotalcnt }</h2>	<!--  사원수 -->
                                <p class="mb-0 text-muted">
                                    <span class="text-success me-2"><c:if test="${ idRate < 0 }">  <span class="mdi mdi-arrow-down-bold"></span>  </c:if>  <span class="mdi mdi-arrow-up-bold"></span> ${iDRate }%</span>
                                    <span class="text-nowrap">Since last month</span>
                                </p>
                            </div> <!-- end card-body-->
                        </div>
                        <!--end card-->

                        <div class="card tilebox-one">
                            <div class="card-body">
                                <i class='uil uil-window-restore float-end'></i>
                                <h6 class="text-uppercase mt-0">평균 근속년수</h6>
                                <h2 class="my-2" id="active-views-count">${serviceManYear }</h2>
                                <p class="mb-0 text-muted">
<!--                                     <span class="text-danger me-2"><span class="mdi mdi-arrow-down-bold">5%</span>  </span> -->
<!--                                     <span class="text-nowrap">Since year</span> -->
                                </p>
                            </div> <!-- end card-body-->
                        </div>
                        <!--end card-->

                        <div class="card cta-box overflow-hidden">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div>
                                        <h3 class="m-0 fw-normal cta-box-title">프로젝트 & 일감 생성 <br> <b><a href="/admin/formList" >바로가기</a></b><i class="mdi mdi-arrow-right"></i></h3>
                                    </div>
                                    <img class="ms-3" src="${pageContext.request.contextPath}/resources/assets/images/svg/email-campaign.svg" width="92" alt="Generic placeholder image">
                                </div>
                            </div>
                            <!-- end card-body -->
                        </div>
                    </div> <!-- end col -->

                    <div class="col-xl-9 col-lg-8">
                        <div class="card card-h-100">
                            <div class="card-body row" style="justify-content: space-around;">
                                <div class="col-3 card border border-2 rm-2 " data-simplebar style="max-height: 497.5px;">
                                	
                                	<div class="card-body" > 
                                		<div class="h-10">
                                			<h4 class="m-0 fw-normal cta-box-title "><span class="border-bottom"><b>${monthName}월 의 우수사원</b></span></h4> 
                                		</div>
						                <c:if test="${not empty processedEmplOfMonth}">
						                    <c:forEach var="empl" items="${processedEmplOfMonth}">
						                        <div class=" border bg-light mt-3 mb-3" style="width:200px; height:220px;">
						                        	<c:if test="${not empty empl.PROFL_IMAGE_COURS }">
							                            <img alt="..." src="${empl.PROFL_IMAGE_COURS }"  style="width:200px; height:220px;" class="object-fit-cover border rounded avatar-xl">
						                        	</c:if>
						                        	<c:if test="${empty empl.PROFL_IMAGE_COURS }">
						                        		<img alt="...empty" src="" class="object-fit-cover border rounded avatar-xl">
						                        	</c:if>
						                        </div>
						                        <div class="h-auto">
						                            <h4 class="hw-nomal">${empl.EMPL_NM} <i class="small-circle"></i> ${empl.position_nm}</h4>
						                            <h5>${empl.DEPT_NM}</h5>
						                        	<hr>
						                        </div>
						                    </c:forEach>
						                </c:if>
                                		<c:if test="${empty emplOfMonth}">
                   							
                  							<div class="card-body border bg-light mt-3 mb-3 "  style="width:200px; height:220px;" >
	                                			<img alt="...emtyImage" src="" class="object-fit-cover border rounded avatar-xl ">
	                                		</div>
	                                		
	                                		<div class="h-3">
		                                		<h5>이번달의 설문조사를 끝마치지 못했습니다.</h5>
	                                		</div>
            							</c:if>
                                	</div>
                                </div>   
                                <!-- 내용 1 -->
                                <div class="col-7 card shadow-sm p-2 mb-2 rounded">
	                                <div class="card-body">
	                                	<h4 class="header-title"> 우수사원 설문 결과 차트</h4>
	                                    <div dir="ltr">
	                                        <div id="distributed-column" class="apex-charts" data-colors="#727cf5,#6c757d,#0acf97,#fa5c7c,#ffbc00,#39afd1,#e3eaef,#313a46"></div>
	                                    </div>
			                                	
	                                </div>
                                </div>
                                
                                
                            </div> <!-- end card-body-->
                        </div> <!-- end card-->
                    </div>
                </div>

				<div class="row">
                        <div class="col-12">
                            <div class="card widget-inline">
                                <div class="card-body p-0">
                                    <div class="row g-0">
                                        <div class="col-sm-6 col-lg-3">
                                            <div class="card rounded-0 shadow-none m-0">
                                                <div class="card-body text-center">
                                                    <i class="ri-briefcase-line text-muted font-24"></i>
                                                    <h3><span>${projectAnalytics.TOTAL_PROJECTS }</span></h3>
                                                    <p class="text-muted font-15 mb-0">총 프로젝트</p>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-6 col-lg-3">
                                            <div class="card rounded-0 shadow-none m-0 border-start border-light">
                                                <div class="card-body text-center">
                                                    <i class="ri-list-check-2 text-muted font-24"></i>
                                                    <h3><span>${projectAnalytics.TOTAL_TASKS }</span></h3> 
                                                    <p class="text-muted font-15 mb-0">전체 업무</p>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-6 col-lg-3">
                                            <div class="card rounded-0 shadow-none m-0 border-start border-light">
                                                <div class="card-body text-center">
                                                    <i class="ri-group-line text-muted font-24"></i>
                                                    <h3><span>${projectAnalytics.TOTAL_PARTICIPANTS }</span></h3>
                                                    <p class="text-muted font-15 mb-0">진행 멤버</p>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-6 col-lg-3">
                                            <div class="card rounded-0 shadow-none m-0 border-start border-light">
                                                <div class="card-body text-center">
                                                    <i class="ri-line-chart-line text-muted font-24"></i>
                                                    <h3><span>${avgAttendanceRate}%</span> <i class="mdi mdi-arrow-up text-success"></i></h3>
                                                    <p class="text-muted font-15 mb-0">출석률</p>
                                                </div>
                                            </div>
                                        </div>

                                    </div> <!-- end row -->
                                </div>
                            </div> <!-- end card-box-->
                        </div> <!-- end col-->
                    </div>

                    <div class="row">
                        <div class="col-lg-4">
                            <div class="card">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h4 class="header-title">프로젝트 상태</h4>

                                </div>

                                <div class="card-body pt-0">
                                    <div class="mt-3 mb-4 chartjs-chart" style="height: 204px;">
                                        <canvas id="project-status-chart"></canvas>
                                    </div>

                                    <div class="row text-center mt-2 py-2">
                                        <div class="col-sm-4">
                                            <div class="my-2 my-sm-0">
                                                <i class="mdi mdi-trending-up text-success mt-3 h3"></i>
                                                <h3 class="fw-normal">
                                                    <span>${taskStatusCounts.PERCENT_TKST001 }%</span>
                                                </h3>
                                                <p class="text-muted mb-0">대기</p>
                                            </div>

                                        </div>
                                        <div class="col-sm-4">
                                            <div class="my-2 my-sm-0">
                                                <i class="mdi mdi-trending-down text-primary mt-3 h3"></i>
                                                <h3 class="fw-normal">
                                                    <span>${taskStatusCounts.PERCENT_TKST002 }%</span>
                                                </h3>
                                                <p class="text-muted mb-0"> 진행</p>
                                            </div>

                                        </div>
                                        <div class="col-sm-4">
                                            <div class="my-2 my-sm-0">
                                                <i class="mdi mdi-trending-down text-danger mt-3 h3"></i>
                                                <h3 class="fw-normal">
                                                    <span>${taskStatusCounts.PERCENT_TKST003}%</span>
                                                </h3>
                                                <p class="text-muted mb-0"> 마감</p>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- end row-->

                                </div> <!-- end card body-->
                            </div> <!-- end card -->
                        </div><!-- end col-->

                        <div class="col-lg-8">
                            <div class="card fixed-height-card">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h4 class="header-title">완료 업무</h4>
                                </div>
                                <div class="card-header bg-light-lighten border-top border-bottom border-light py-1 text-center">
                                    <p class="m-0"> 전체 업무 :   <b>${taskStatusCounts.totalTasks }</b>건 &nbsp; 중 &nbsp; 완료  :  
                                    <c:set var="deadTasksCount" value="${fn:length(deadTasks)}"/>
        							<b>${deadTasksCount}</b>건  </p>
                                </div>
                                <div class="card-body pt-2">
                                    <div class="table-responsive" data-simplebar style="max-height: 353.5px;"> 
                                        <table class="table table-centered table-nowrap table-hover mb-0">
                                            <tbody>
                                            	<c:forEach var="task" items="${deadTasks}">
	                                                <tr>
	                                                    <td>
	                                                        <h5 class="font-14 my-1"><a href="javascript:void(0);" class="text-body">${task.TASK_TTL}</a></h5>
	                                                        <span class="text-muted font-13"> 소요기간 : ${task.complementDays} 일</span>
	                                                    </td>
	                                                    <td>
	                                                        <span class="text-muted font-13">중요도</span> <br />
	                                                        <span class="badge badge-warning-lighten">${task.tkprWord}</span>
	                                                    </td>
	                                                    <td>
	                                                        <span class="text-muted font-13">담당자</span>
	                                                        <h5 class="font-14 mt-1 fw-normal">${task.EMPL_NM}</h5>
	                                                    </td>
	                                                    <td>
	                                                        <span class="text-muted font-13">전체 기간</span>
	                                                        <h5 class="font-14 mt-1 fw-normal">${task.totalDays}일</h5>
	                                                    </td>
	                                                </tr>
                                                 </c:forEach>
                                            </tbody>
                                        </table>
                                    </div> <!-- end table-responsive-->

                                </div> <!-- end card body-->
                            </div> <!-- end card -->
                        </div><!-- end col-->
                    </div>
                    <!-- end row-->
               
                </div>
                <!-- end row -->

                </div>
                <!-- end row -->

            </div>
            <!-- container -->

        </div>
        <!-- content -->


</body>

</html>