<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<script src="https://www.gstatic.com/charts/loader.js"></script>
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/frappe-gantt/frappe-gantt.min.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/dragula/dragula.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/ui/component.dragula.js"></script>
    <%-- <script src="${pageContext.request.contextPath}/resources/assets/vendor/ion-rangeslider/js/ion.rangeSlider.min.js"></script> --%>
    <%-- <link href="${pageContext.request.contextPath}/resources/assets/vendor/ion-rangeslider/css/ion.rangeSlider.min.css" rel="stylesheet"> --%>
    <%-- <script src="${pageContext.request.contextPath}/resources/assets/vendor/jquery.rateit/scripts/jquery.rateit.min.js"></script> --%>
    <%-- <link href="${pageContext.request.contextPath}/resources/assets/vendor/jquery.rateit/scripts/rateit.css" rel="stylesheet"> --%>
<style>
    .grid-background {
        fill: none;
        /* 배경색 제거 */
    }

    .gantt-container {
        width: 100%;
        overflow-x: auto;
        /* 가로 스크롤 허용 */
    }

    #ganttChart {
        width: 100%;
        min-width: 100%;
        /* 최소 너비 설정 */
        height: 500px;
        /* 높이 설정 */
    }
</style>


<c:choose>
    <c:when test="${not empty projectList}">
        <c:set var="proJno" value="${projectList[0].projNo}" />
    </c:when>
    <c:otherwise>
        <c:set var="proJno" value="0" />
    </c:otherwise>
</c:choose>

<script type="text/javascript">
    var tasKCnt1 = 0;
    var tasKCnt2 = 0;
    var tasKCnt3 = 0;
    var goProjNo = parseInt("${proJno}");
    var goProjName = "";
    var currentPage = 1;
    var pageSize = 10;
    var searchType = '';
    var searchWord = '';
    var totalTaskList;
    
    // XSS 공격 대비 
    function sanitize(input) {
        var element = document.createElement('div');
        element.innerText = input;
        return element.innerHTML;
    }
    
    // class 선택
    function setTaskFormState(isEditable) {
        const elements = [
            '#taskTtl',
            '#taskCn',
            '#taskBgngYmd',
            '#taskDdlnYmd',
            '#taskPrgsPer',
            '#getting-values',
            '#projMember'
        ];

        elements.forEach(selector => {
            $(selector).attr("disabled", !isEditable);
        });
    }
	
    // 저장, 뒤로가기, 수정 후 폼 초기화 
    function resetTaskForm() {
        setTaskFormState(true);
        $('#taskTtl').val("");
        $('#taskCn').val("");
        $('#task-id').val("");
        $('#taskBgngYmd').val(convertToISODate(getCurrentDateYYYYMMDD()));
        $('#taskDdlnYmd').val("");
        $('#taskPrgsPer').val("0");
    }

    // 프로젝트의 모든 유저의 업무 데이터 load
    // 페이징 처리 
    function loadTasks(goProjNo) {
        $('#currentPage').html('<h5>' + currentPage + ' p </h5>');
        $.ajax({
            url: '/project/ajax/selectTaskList',
            type: 'get',
            data: {
                projNo: goProjNo,
                page: currentPage,
                size: pageSize,
                searchType: searchType,
                searchWord: searchWord
            },
            dataType: 'json',
            success: function(data) {
                taskListAll(data.taskList);
                updatePagination(data.totalPages);
            }
        });
    }
	
	// 리더 권한 확인 - 업무 추가 가능, 캘린더 추가 가능 
    function authCheck(goProjNo) {
        $.ajax({
            url: '/project/ajax/authCheck',
            type: 'get',
            data: {
                projNo: goProjNo
            },
            dataType: 'json',
            success: function(authPrtcp) {
                if (authPrtcp.projMngrYn == 'leader') {
                    $('#taskAdd').show();
					$('#btn-save-event').show();
					$('#btn-delete-event').show(); 
					
                } else {
                    $('#taskAdd').hide();
					$('#btn-save-event').hide();
					$('#btn-delete-event').hide();
					
                }
            }
        });
    }
	
	// 선택 프로젝트 참가자 리스트 
    function projPrtcpList(goProjNo) {
        $.ajax({
            url: '/project/ajax/projPrtcpList',
            type: 'get',
            data: {
                projNo: goProjNo
            },
            dataType: 'json',
            success: function(memberList) {
                var memberListHtml = '';
                var memberListDashBoardHtml = '';
                var prtcpCnt  = 0 +" 명";
                
                if(memberList != null){
                	
	                prtcpCnt = memberList.length +" 명";
               
	                $('#prtcpCnt').text(prtcpCnt);
	                memberList.forEach(function(member) {
	                	console.log(member)
	                    memberListHtml += `<option value="\${member.EMPL_ID}"> \${member.EMPL_NM} </option>`;
	                    
	                    let posiCd = member.POSITION_CD;
	                    let posiNm = "";
	                    if (posiCd == 'POSITION07') {
	                        posiNm = "대표이사 ";
	                    } else if (posiCd == 'POSITION06') {
	                        posiNm = "부장";
	                    } else if (posiCd == 'POSITION05') {
	                        posiNm = "차장";
	                    } else if (posiCd == 'POSITION04') {
	                        posiNm = "과장";
	                    } else if (posiCd == 'POSITION03') {
	                        posiNm = "대리";
	                    } else if (posiCd == 'POSITION02') {
	                        posiNm = "사원";
	                    } else {
	                        posiNm = "인턴";
	                    }
						
	                    var styleLeader = "";
	                    var strLeader = "";
	                    if(member.PROJ_MNGR_YN == "leader" ){
	                    	styleLeader = " ri-copper-coin-line"
	                    	strLeader = "leader";
	                    }
	                    
			
	                    memberListDashBoardHtml +=
	                        `<div class="d-flex align-items-start  mt-3">
	                    <img class="me-3 rounded-circle" src="\${member.PROFL_IMAGE_COURS}" width="40" alt="##">
	                    <div class="w-100 overflow-hidden">
	                        <h5 class="mt-0 mb-1 fw-semibold"><a href="javascript:void(0);" class="text-reset"> \${member.EMPL_NM} </a> <i class="\${styleLeader}"> </i> </h5>  
	                        <ul class="list-inline mb-0 font-13">
	                            <li class="list-inline-item"> \${posiNm} </li>
	                            <li class="list-inline-item text-muted"><i class="mdi mdi-circle-small"></i></li>
	                            <li class="list-inline-item"> \${member.DEPT_NM} </li>
	                        </ul>
	                    </div>
	                </div>
	                `;
	
	                })
	
	                $('#projMember').html(memberListHtml);
	
	                $('#projMemberList').html(memberListDashBoardHtml);
	                var projNm ="";
	                
	                if (memberList != null && memberList.length > 0 && memberList[0].PROJ_NAME) {
	                    var projNm = ' | ' + memberList[0].PROJ_NAME;
	                    var goProjName = ''+projNm;
	                    $('#projNm').text(goProjName);
	                } 
	
	            }
	        }
        });
    }

	
	// 업무 추가 버튼 
    $(document).on('click', '#taskAddBtn', function() {
        $('#divCharge').show();
        resetTaskForm();

        $('#insertTaskBtn').attr("hidden", false);
        $('#reviceUpdate').attr("hidden", true);
    })

	
    // 전체 업무 메소드 
    function taskListAll(taskList) {
        let taskListContainer = $('#projectTaskCn');
        var taskHtml = '';
        taskList.forEach(function(task) {
            let color = '';
            let prioty = '';
            let status = '';
            if (task.tkprCode == "TKPR001") {
                color = "badge bg-info";
                prioty = "하급";
            } else if (task.tkprCode == "TKPR002") {
                color = "badge bg-warning";
                prioty = "중급";
            } else { // 상급 
                color = "badge bg-danger";
                prioty = "상급";
            }

            if (task.tkstCode == "TKST001") {
                status = "진행";
            } else if (task.tkstCode == "TKST002") {
                status = "대기";
            } else {
                status = "마감";
            }

            let ch_bgng = convertToISODate(task.taskBgngYmd)
            let ch_Ddln = convertToISODate(task.taskDdlnYmd)
            let ch_Mdfcn = convertToISODate(task.taskMdfcnYmd)
			
            

            taskHtml += `
            <tr class="task-row" data-task-id="\${task.taskNo}" data-task-proj-name="\${goProjName}" data-task-charge-id ="\${task.emplId}">
        		<td style="display: none;">\${task.taskNo}</td>
                <td class="text-center">\${task.RNUM}</td>
                <td> \${task.truncatedTaskTtl}</td> 
                <td class="text-center"><span class="\${color}">\${prioty} </span> </td>
                <td class="text-center">\${status}</td>
                <td class="text-center">\${task.emplNm}</td>
                <td class="text-center">\${ch_bgng}</td>
                <td class="text-center">\${ch_Ddln}</td>
                <td class="text-center">\${ch_Mdfcn}</td>
                <td class="text-center">\${task.taskPrgsPer}</td>
            </tr>
        `;
        });
        taskListContainer.html(taskHtml);
    }

    //Task 전체 목록, 상세 조회 
    $(document).on('click', '.task-row', function() {
        var taskNo = $(this).data('task-id');
//         var projName = $(this).data('task-proj-name');
        var chargeId = $(this).data('task-charge-id');
        var currentUserId = '${sessionScope.emplInfo.emplId}';
        $.ajax({
            url: '/project/ajax/selectTaskDetail',
            type: 'get',
            data: {
                taskNo: taskNo
            },
            dataType: 'json',
            success: function(data) {
                var status = 0;
                if (data.tkprCode === 'TKPR001') {
                    status = 1;
                } else if (data.tkprCode === 'TKPR002') {
                    status = 2;
                } else if (data.tkprCode === 'TKPR003') {
                    status = 3;
                }else {
                    status = 0; 
                }

                console.log("status", status)
                $('#getting-values').rateit('value', status);
                $('#taskDdlnYmd').val(convertToISODate(data.taskDdlnYmd));
                $('#taskPrgsPer').val(data.taskPrgsPer);
                $('#taskTtl').val(data.taskTtl);
//                 $('#projNm').text(projName);
                $('#taskCn').val(data.taskCn);
                $('#task-id').val(data.taskNo);
                $('#projMember').val(chargeId);
                $('#taskBgngYmd').val(convertToISODate(data.taskBgngYmd));

                setTaskFormState(chargeId == currentUserId);

                $('#divCharge').hide();
                $('#insertTaskBtn').attr("hidden", true);
                $('#reviceUpdate').attr("hidden", currentUserId !== data.emplId);
                $('#taskModal').modal('show');
            }
        });

    });

	// 페이징 
    function updatePagination(totalPages) {
        if (currentPage <= 1) {
            $('#prevPage').prop('disabled', true);
        } else {
            $('#prevPage').prop('disabled', false);
        }

        if (currentPage >= totalPages) {
            $('#nextPage').prop('disabled', true);
        } else {
            $('#nextPage').prop('disabled', false);
        }
    }
	
	// 대쉬보드 상태별 업무 
	// goPage2
    function fetchTasks(projNo, status, containerId) {
        var chartTitle = "업무 수"
        $.ajax({
            url: "/project/ajax/taskListByStatus",
            type: "get",
            data: {
                projNo: projNo,
                status: status
            },
            dataType: "json",
            success: function(data) {
            	console.log('data@@@1',data)
                updateTaskList(data.taskList, containerId);
                updateScheduleList(data.scheduleList);
				
                if (status == "TKST001") {
                    tasKCnt1 = data.taskList.length;
                    $('#taskPr').text(tasKCnt1 + "건");
                } else if (status == "TKST002") {
                    tasKCnt2 = data.taskList.length;
                    $('#taskSt').text(tasKCnt2  + "건");
                } else if (status == "TKST003") {
                    tasKCnt3 = data.taskList.length;
                    $('#taskDe').text(tasKCnt3  + "건");
                }

                google.charts.load('current', {
                    'packages': ['corechart']
                });
                google.charts.setOnLoadCallback(drawChartBar);

                if (data.taskList.length == 0) {
                    chartTitle = "업무가 없습니다.";
                }

                function drawChartBar() {
                    const chartData = google.visualization.arrayToDataTable([
                        ['Status', 'Count'],
                        ['진행', tasKCnt1],
                        ['대기', tasKCnt2],
                        ['마감', tasKCnt3]
                    ]);

                    const options = {
                        title: chartTitle
                    };

                    const chart = new google.visualization.PieChart(document.getElementById('myChart'));
                    chart.draw(chartData, options);
                }

            }
        });
    }
    //  페이지 시작 시 호출 
    $(function() {
        $('.rateit').rateit();
        $('#getting-values').rateit('max', 3);
        $('#getting-values').rateit('step', 1); 

        
    	$('#pptBtn1').on('click',function(){
    		$('#event-title').val("대덕인재개발원  최종프로젝트 마지막 일정입니다.. ");
    		$('#event-content').val("모두 수고 하셨습니다. 성공적인 취업을 기원합니다.");
    		$('#event-category').val('bg-info');
    	})
    	
    	$('#pptBtn2').on('click',function(){
    		$('#taskTtl').val("업데이트 내역 정리 ");
    		$('#taskCn').val("랜섬웨어 대응을 위한 서버 옵션기능 추가 \n 서버에 저장하는 파일의 확장자를 변형하는 랜섬웨어 감염을 회피"); 
    		$('#taskDdlnYmd').val('2024-08-14');
    		$('#getting-values').rateit('value',1);
    		$('#taskPrgsPer').val(30);
    		
    	})
    	
        loadTasks(goProjNo);

        //차트 불러오기 	
        google.charts.load('current', {
            'packages': ['corechart']
        });
        google.charts.setOnLoadCallback(function() {
            drawChartDay(goProjNo);
        });

        // 페이지 로드 시 1번 프로젝트 선택
        selectProject(goProjNo);
		// 칸반보드 메소드 
        var drake = dragula([
                document.getElementById('inProgressTasks'),
                document.getElementById('pendingTasks'),
                document.getElementById('completedTasks')
            ])
            .on('drop', function(el, target, source, sibling) {
                var taskId = $(el).data('task-id');
                var targetId = $(target).attr('id');
                var newStatus;

                if (targetId === 'inProgressTasks') {
                    newStatus = 'TKST001';
                } else if (targetId === 'pendingTasks') {
                    newStatus = 'TKST002';
                } else if (targetId === 'completedTasks') {
                    newStatus = 'TKST003';
                }

                if (newStatus === 'TKST003') {
                    if (confirm("정말 마감처리 하시겠습니까?")) {
                        updateTaskStatus(taskId, newStatus);
                    } else {
                        $(source).append(el);
                    }
                } else {
                    updateTaskStatus(taskId, newStatus);
                }
            });


        $('#searchButton').on('click', function() {
        	projNo = $('#proj-no').val();
            searchType = $('#searchType').val();
            searchWord = $('#searchKeyword').val();
            currentPage = 1;
            loadTasks(projNo);
        });

        $('#pageSize').on('change', function() {
        	projNo = $('#proj-no').val();
            pageSize = $(this).val();
            currentPage = 1;
            loadTasks(goProjNo);
        });

        $('#prevPage').on('click', function() {
        	projNo = $('#proj-no').val();
            if (currentPage > 1) {
                currentPage--;
                loadTasks(projNo);
            }
        });

        $('#nextPage').on('click', function() {
            currentPage++;
            projNo = $('#proj-no').val();
            
            loadTasks(projNo);
        });

        

        $("#home").on("click", ".taskModalOpenBtn", function() {
            $("#taskModal").modal("show");
        });


    }); // $(function)

	
    // yyyy/MM/dd 형식 변환  
    function formatTimestamp(timestamp) {
        var date = new Date(timestamp);
        var year = date.getFullYear();
        var month = (date.getMonth() + 1).toString().padStart(2, '0');
        var day = date.getDate().toString().padStart(2, '0');
        return year + '/' + month + '/' + day;
    }

    // 5일내 마감 업무 차트 그리기 
    function drawChartDay(goProjNo) {
        let chartTitle = "5일 내 마감 업무";

        $.ajax({
            url: '/project/ajax/selectTasksDay',
            method: 'GET',
            data: {
                projNo: goProjNo
            },
            dataType: 'json',
            success: function(data) {
                var chartData = [
                    ['날짜', '개수']
                ];

                data.forEach(function(task) {
                    chartData.push([formatTimestamp(task.task_date), task.task_count]);
                });


                var googleData = google.visualization.arrayToDataTable(chartData);

                var options = {
                    title: chartTitle
                };

                var chart = new google.visualization.BarChart(document.getElementById('myChart2'));
                chart.draw(googleData, options);
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error('Error fetching task data: ', textStatus, errorThrown);
            }
        });
    }

    // 프로젝트 선택시 상태별 업무 리스트 조회 
    function selectProject(goProjNo) {
        // 모든 projects_tab 클래스를 가진 요소들에서 text-bg-secondary 클래스를 제거
        $('.projects_tab').removeClass('text-bg-primary bg-opacity-75');
        // 클릭된 요소에 text-bg-primary 클래스 추가
        $(`.projects_tab[data-projno='\${goProjNo}']`).addClass('text-bg-primary bg-opacity-75');
        
        fetchTasks(goProjNo, "TKST001", "#inProgressTasks"); 
        fetchTasks(goProjNo, "TKST002", "#pendingTasks");
        fetchTasks(goProjNo, "TKST003", "#completedTasks");

        // 선택 프로젝트 번호
        $('#proj-no').val(goProjNo);

        // 업무 일감 만들기 권한 체크 
        authCheck(goProjNo);
        // 프로젝트 참가자 인원 조회 
        projPrtcpList(goProjNo);
        
        // 페이지 업무 조회 
        loadTasks(goProjNo);
        // 간트차트

        drawChartDay(goProjNo);
    }


    // 일정 리스트 
    function updateScheduleList(scheduleList) {
        console.log(scheduleList);
        var scheduleContainer = $('#handle-dragula-left');
        scheduleContainer.empty();

        if (scheduleList.length == 0) {
            console.log('scheduleList', scheduleList)
            var scheduleHtml = `
                <div class="card mb-0 mt-2">
                    <div class="d-flex align-items-start">
                         <div class="w-100 overflow-hidden">
                      		<div> <h5 class="text-muted"> 일정이 없습니다 </h5> </div> 
                         </div>
                    </div>
                </div>
            `;
            scheduleContainer.html(scheduleHtml);

            return;
        }

        scheduleList.forEach(function(schedule) {
            let ch_projSchdlNm = '';
            if (schedule.projSchdlNm.length > 20) {
                ch_projSchdlNm = schedule.projSchdlNm.substring(0, 13) + "..";
                //         		ch_projSchdlNm = schedule.projSchdlNm;
            } else {
                ch_projSchdlNm = schedule.projSchdlNm;
            }
            let ch_time_end = convertTimestampToMMDDHHMM(schedule.projSchdlEndDt)


            var scheduleHtml = `
                <div class="card mb-0 mt-2">
                    <div class="card-body">
                        <div class="d-flex align-items-start">
                            <div class="w-100 overflow-hidden">
	                        	<div>\${ch_projSchdlNm}</div>
                                <h5 class="mb-1 mt-1"><small class="float-end text-muted"> \${ch_time_end}</small></h5>
                                <p class="mb-0"></p>
                            </div>
                        </div>
                    </div>
                </div>
            `;
            scheduleContainer.append(scheduleHtml);


        });
    }

    //업무 상세 수정 
    function updateTaskList(tasks, containerId) {
        var taskListContainer = $(containerId);
        taskListContainer.empty();

        if (tasks.length == 0) {
            var taskHtml = `
                <div class="card mb-0 mt-2">
            		<div class="card-body">
	                    <div class="d-flex align-items-start">
	                         <div class="w-100 overflow-hidden">
	                      		<div> <h5 class="text-muted"> 업무가 없습니다 </h5> </div>
	                         </div>
	                    </div>
                    </div>
                </div>
            `;
            taskListContainer.html(taskHtml);
            return;
        }


        tasks.forEach(function(task) {
            var tkprCode = task.tkprCode;
            var color = "";
            var prioty = "";
            var status = "";
            if (tkprCode == "TKPR001") { // 하급 
                color = "badge bg-info";
                prioty = "하급";
            } else if (tkprCode == "TKPR002") { // 중급
                color = "badge bg-warning";
                prioty = "중급";
            } else { // 상급 
                color = "badge bg-danger";
                prioty = "상급";
            }
            console.log('task', task);
            var deadline = new Date(task.taskDdlnYmd.slice(0, 4) + "-" + task.taskDdlnYmd.slice(4, 6) + "-" + task.taskDdlnYmd.slice(6, 8));
            var now = new Date();
            var timeDiff = deadline - now;
            var dayDiff = timeDiff / (1000 * 3600 * 24);
            console.log('dayDiff',dayDiff)
            var cardStyle = "";
            var fontStyle = "";
            if (dayDiff < 0) {
                cardStyle = "border-top border-danger";
                fontStyle = "text-danger";
            } else if (dayDiff <= 1) {
                cardStyle = "border-top border-warning";
                fontStyle = "text-warning";
            }
            var tooltipAttr = "";
            var trunkTask = "";
            if (task.taskTtl.length > 11) {
            	trunkTask =  task.taskTtl.slice(0, 11) + "..";
            	 tooltipAttr = `data-bs-toggle="tooltip" data-bs-title="\${task.taskTtl}"`;
            } else {
            	trunkTask =  task.taskTtl;
            }
            // goPage 3
            
            var taskHtml = `
                <div class="card mb-0 mt-2 \${cardStyle}" data-task-id="\${task.taskNo}" data-tkst-code="\${task.tkstCode}" data-task-cn="\${task.taskCn}" data-task-ttl="\${task.taskTtl}"  data-task-bgng-ymd="\${task.taskRegYmd}" data-task-ddln-ymd="\${task.taskDdlnYmd}" data-task-tkpr-code="\${task.tkprCode}" data-task-prgs-per="\${task.taskPrgsPer}" data-task-proj-name="\${task.projName}">
                    <div class="card-body">
                        <div class="d-flex align-items-start">
                            <div class="w-100 overflow-hidden"> 
                                <h5 class="mb-1 mt-1">
                                    <a href="#" class="task-link taskModalOpenBtn \${fontStyle}" \${tooltipAttr} >\${trunkTask}</a> 
				                   <span style="margin-left: 20px;font-size: 10px;" class="\${color} float-end ">\${prioty}</span>
                                </h5>
                            </div>
                            <span class="dragula-handle"></span>
                        </div>
                    </div>
                </div>
            `;
            taskListContainer.append(taskHtml);
        });

        // 업무 클릭시 값 가져오기 
        $('.task-link').on('click', function() {

            var taskCard = $(this).closest('.card');
            var taskCn = taskCard.data('task-cn');
            var taskId = taskCard.data('task-id');
            var taskTtl = taskCard.data('task-ttl');
            var taskBgngYmd = taskCard.data('task-bgng-ymd');
            var taskDdlnYmd = taskCard.data('task-ddln-ymd');
            var tkprCode = taskCard.data('task-tkpr-code');
            var taskTkstCode = taskCard.data('tkst-code');
            var taskPrgsPer = taskCard.data('task-prgs-per');
            var taskProjName = taskCard.data('task-proj-name');


            if (tkprCode == "TKPR001") {
                prstatus = 1;
            } else if (tkprCode == "TKPR002") {
                prstatus = 2;
            } else if (tkprCode == "TKPR003") {
                prstatus = 3;
            }
            $('#task-id').val(taskId);

            $('#divCharge').hide();

            $('#taskTtl').val(taskTtl);
            $('#taskCn').val(taskCn);

            var dateTaskBegin = convertToISODate(taskBgngYmd);
            var dateTaskEnd = convertToISODate(taskDdlnYmd);
            $('#taskBgngYmd').val(dateTaskBegin);
            $('#taskDdlnYmd').val(dateTaskEnd);
            $('#taskPrgsPer').val(taskPrgsPer);
            console.log('status', status)
            $('#getting-values').rateit('value', prstatus);


            $('#insertTaskBtn').attr("hidden", true);


            $('#taskTtl').attr("disabled", false);
            $('#reviceUpdate').attr("hidden", false);
            $('#taskPrgsPer').attr('disabled', false);
            $('#taskBgngYmd').attr("disabled", false);
            $('#taskDdlnYmd').attr('disabled', false);
            $('#getting-values').attr('disabled', false);
            $('#taskCn').attr('disabled', false);
            $('#projMember').attr('disabled', false);

            $('.modal-title').next('span').text(taskProjName);
        });
    } // updateTaskList 끝 

    // yyyy-MM-dd 변경 
    function convertToISODate(eightDigitDate) {

        if (typeof eightDigitDate === 'undefined' || eightDigitDate === null) {
            return '-';
        }

        if (typeof eightDigitDate !== 'string') {
            eightDigitDate = String(eightDigitDate);
        }

        let year = eightDigitDate.substring(0, 4);
        let month = eightDigitDate.substring(4, 6);
        let day = eightDigitDate.substring(6, 8);

        return year + '-' + month + '-' + day;
    }
    // 현재날짜 yyyyMMdd 8자리 
    function getCurrentDateYYYYMMDD() {
        var date = new Date();
        var year = date.getFullYear();
        var month = (date.getMonth() + 1).toString().padStart(2, '0');
        var day = date.getDate().toString().padStart(2, '0');
        return year + month + day;
    }

    function convertTimestampToMMDDHHMM(timestamp) {
        var date = new Date(timestamp);

        var month = (date.getMonth() + 1).toString().padStart(2, '0');
        var day = date.getDate().toString().padStart(2, '0');
        var hours = date.getHours().toString().padStart(2, '0');
        var minutes = date.getMinutes().toString().padStart(2, '0');
        let date_str = month + '/' + day + ' ' + hours + ':' + minutes;
        return date_str;
    }

    function convertToEightDigitDate(isoDate) {
        if (typeof isoDate !== 'string') {
            return '';
        }
        let parts = isoDate.split('-');
        if (parts.length !== 3) {
            return '';
        }
        let year = parts[0];
        let month = parts[1];
        let day = parts[2];
        if (month.length === 1) {
            month = '0' + month;
        }
        if (day.length === 1) {
            day = '0' + day;
        }
        return year + month + day;
    }

    // 일감 상태 변경    
    function updateTaskStatus(taskId, newStatus) {
        var currentDate = getCurrentDateYYYYMMDD(); // 현재 날짜를 yyyyMMdd 형식으로 변환
        $.ajax({
            url: "/project/ajax/updateTaskStatus",
            type: "post",
            beforeSend: function(xhr) { // 데이터 전송 전, 헤더에 csrf 값 설정
                xhr.setRequestHeader(header, token);
            },
            data: JSON.stringify({
                taskId: taskId,
                tkstCode: newStatus,
                mdfcnYmd: currentDate
            }),
            contentType: "application/json",
            success: function(res) {
            	//// goPage 1
            	let projNo = $('#proj-no').val();
            	selectProject(projNo);
            }
        });
    }

    // 수정 업데이트 
    $(document).on('click', '#reviceUpdate', function() {
        let prStatus = $('#getting-values').rateit('value');
        if (prStatus == '1') {
            tkprCode = 'TKPR001';
        } else if (prStatus == '2') {
            tkprCode = 'TKPR002';
        } else if (prStatus == '3') {
            tkprCode = 'TKPR003';
        } else {
            alert("중요도를 입력해주세요");
            return false;
        }

        var projNo = $("#proj-no").val();
        
        var formData = {
            taskNo: $('#task-id').val(),
            taskTtl: sanitize($('#taskTtl').val()),
            taskCn: sanitize($('#taskCn').val()),
            tkprCode: tkprCode,
            taskPrgsPer: parseInt($('#taskPrgsPer').val()),
            taskBgngYmd: convertToEightDigitDate($('#taskBgngYmd').val()),
            taskDdlnYmd: convertToEightDigitDate($('#taskDdlnYmd').val()),
            taskMdfcnYmd: getCurrentDateYYYYMMDD()
        };


        $.ajax({
            url: "${pageContext.request.contextPath}/project/ajax/updateTaskDetail",
            type: "post",
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token); // CSRF 헤더 설정
            },
            data: JSON.stringify(formData),
            contentType: "application/json",
            success: function(res) {
                // 모달 , 백드럽 사라지기 
                $("#taskModal").modal("hide");
                $(".modal-backdrop").remove();
                selectProject(projNo);
            }
        });
    });
    // 일감 등록 변경    
    $(document).on('click', '#insertTaskBtn', function() {
        var taskTtl = sanitize($('#taskTtl').val());
        var taskCn = sanitize($('#taskCn').val());
        var taskDdlnYmd = $('#taskDdlnYmd').val();
        var taskBgngYmd = $('#taskBgngYmd').val();
        var tkprCode = $('#getting-values').rateit('value');
        var taskPrgsPer = $('#taskPrgsPer').val();
        var projNo = $('#proj-no').val();
        var emplId = $('#projMember').val();
        $('#divCharge').attr("hidden", false);
		console.log("emplId", emplId)
        var ch_taskDdlnYmd = convertToEightDigitDate(taskDdlnYmd);
        var ch_taskBgngYmd = convertToEightDigitDate(taskBgngYmd);
        var ch_taskRegYmd = getCurrentDateYYYYMMDD();
		
        if (!taskTtl) {
            alert("제목을 입력해주세요.");
            $('#taskTtl').focus();
            return false;
        }

        if (!taskCn) {
            alert("내용을 입력해주세요.");
            $('#taskCn').focus();
            return false;
        }

        if (!taskDdlnYmd) {
            alert("마감일자를 입력해주세요.");
            $('#taskDdlnYmd').focus();
            return false;
        }

        if (!taskBgngYmd) {
            alert("시작일자를 입력해주세요.");
            $('#taskBgngYmd').focus();
            return false;
        }

        if (!tkprCode) {
            alert("중요도를 입력해주세요.");
            $('#getting-values').focus();
            return false;
        }

        if (!taskPrgsPer) {
            alert("진행률을 입력해주세요.");
            $('#taskPrgsPer').focus();
            return false;
        }

        if (tkprCode == '1') {
            tkprCode = 'TKPR001';
        } else if (tkprCode == '2') {
            tkprCode = 'TKPR002';
        } else if (tkprCode == '3') {
            tkprCode = 'TKPR003';
        } else {
            alert("중요도를 입력해주세요");
            return false;
        }

        if (taskDdlnYmd > ch_taskRegYmd) {
            alert("마감일자가 등록일자보다 늦어야 됩니다.");
            return false;
        }

        var formData = {
            taskTtl: 		taskTtl,
            taskCn: 		taskCn,
            emplId: 		emplId,
            tkprCode: 		tkprCode,
            taskPrgsPer: 	taskPrgsPer,
            projNo: 		projNo,
            taskBgngYmd: 	ch_taskBgngYmd,
            taskDdlnYmd: 	ch_taskDdlnYmd,
            taskRegYmd: 	ch_taskRegYmd
        };
        $.ajax({
            url: "${pageContext.request.contextPath}/project/ajax/insertTask",
            type: "post",
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token); // CSRF 헤더 설정
            },
            data: JSON.stringify(formData),
            contentType: "application/json",
            success: function(res) {
                $("#taskModal").modal("hide");
                $(".modal-backdrop").remove();
                loadTasks(projNo);
                
            }
        });
    });
</script>

<body>
    <div>
        <div>
            <ul class="nav nav-tabs mb-3">
                <li class="nav-item">
                    <a href="#home" data-bs-toggle="tab" aria-expanded="true" class="nav-link active">
                        <i class="mdi mdi-home-variant d-md-none d-block"></i>
                        <span class="d-none d-md-block">메인</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#dashboard" data-bs-toggle="tab" aria-expanded="false" class="nav-link" id="dashboardTab">
                        <i class="mdi mdi-account-circle d-md-none d-block"></i>
                        <span class="d-none d-md-block">대쉬보드</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#Task" data-bs-toggle="tab" aria-expanded="false" class="nav-link">
                        <i class="mdi mdi-settings-outline d-md-none d-block"></i>
                        <span class="d-none d-md-block">업무</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#GanttChart" data-bs-toggle="tab" aria-expanded="false" class="nav-link" id="ganttChartTab">
                        <i class="mdi mdi-settings-outline d-md-none d-block"></i>
                        <span class="d-none d-md-block">간트차트</span>
                    </a>
                </li>
            </ul>
        </div>

        <div style="display: flex; " >
            <div id="projectList" class="card" style=" margin-right: 10px; ">  
                <div class=""> 
                	<div class="card-body mb-5"> 
	                	<h4>내 프로젝트 </h4>
	                    <c:choose>
	                        <c:when test="${not empty projectList}">
	                            <c:forEach var="project" items="${projectList}">
	                                <i class="ri-survey-line"></i> <a onclick="selectProject(${project.projNo})" class="projects_tab" data-projno="${project.projNo}">
	                                    <c:out value="${project.projName}" /><br></a>
	                            </c:forEach>
	
	                        </c:when>
	                        <c:otherwise>
	                            <span> 참가중인 프로젝트가 없습니다. </span>
	                        </c:otherwise>
	                    </c:choose>
                	</div>
                	
               	    <div class="col-md-12">
                         <!-- project member List  -->
                         <div class="card card-h-100">
                             <div class="card-header d-flex justify-content-between align-items-center">
                                 <h4 class="header-title mb-0">팀 참가인원</h4>  &ensp; <span id="prtcpCnt"></span> 
                             </div>

                             <div class="card-body py-0 mb-3 simplebar-scrollable-y" data-simplebar="init" style="max-height: 242px;">
                                 <div class="simplebar-wrapper" style="margin: 0px -12px;">
                                     <div class="simplebar-height-auto-observer-wrapper">
                                         <div class="simplebar-height-auto-observer"></div>
                                     </div>
                                     <div class="simplebar-mask">
                                         <div class="simplebar-offset" style="right: 0px; bottom: 0px;">
                                             <div class="simplebar-content-wrapper" tabindex="0" role="region" aria-label="scrollable content" style="height: auto; overflow: hidden scroll;">
                                                 <div class="simplebar-content" style="padding: 0px 24px;" id="projMemberList"> 
                                                     <!-- memberList 주석 -->
                                                 </div>
                                             </div>
                                         </div>
                                     </div>
                                     <div class="simplebar-placeholder" style="width: 450px; height: 378px;"></div>
                                 </div>
                                 <div class="simplebar-track simplebar-horizontal" style="visibility: hidden;">
                                     <div class="simplebar-scrollbar" style="width: 0px; display: none;"></div>
                                 </div>
                                 <div class="simplebar-track simplebar-vertical" style="visibility: visible;">
                                     <div class="simplebar-scrollbar" style="height: 244px; transform: translate3d(0px, 0px, 0px); display: block;"></div>
                                 </div>
                             </div>
                         </div>
		                    <div class="card-body mt-5">
			               	 	
		                	</div>
                             
                    </div>
                	
                </div>
            </div>
            
            <!-- 프로젝트 KANBAN BOARD -->
            <div class="tab-content col-md-10">
                <div class="tab-pane show active" id="home">
                	<div style=" text-align-last: end;">
			            <div  class="text-muted">  
			            	<span class="text-danger"><i class="mdi mdi-minus-thick"></i></span>기한 지난 업무    &ensp;
			              	<span class="text-warning"><i class="mdi mdi-minus-thick"></i></span> 1일 남은 업무  
			            </div>
			            <br>
                	</div> 
                    <div class="row" data-plugin="dragula" data-containers='["inProgressTasks", "pendingTasks", "completedTasks"]' data-handleClass="dragula-handle">
                        <div class="col-md-3">
                            <div class="bg-dragula p-2 p-lg-2">
                                <h4 class="mt-0 task-header"><i class=" uil-play-circle"></i>업무 진행 <span id="taskPr" class="float-end"> </span></h4> 
                                <div class="card-body py-0 mb-3 simplebar-scrollable-y" data-simplebar="init" style="max-height: 400px;">
                                    <div class="simplebar-wrapper" style="margin: 0px -24px;">
                                        <div class="simplebar-height-auto-observer-wrapper">
                                            <div class="simplebar-height-auto-observer"></div>
                                        </div>
                                        <div class="simplebar-mask">
                                            <div class="simplebar-offset" style="right: 0px; bottom: 0px;">
                                                <div class="simplebar-content-wrapper" tabindex="0" role="region" aria-label="scrollable content" style="height: auto; overflow: hidden scroll;">
                                                    <div class="simplebar-content">
                                                        <div id="inProgressTasks" class="py-2" data-simplebar>
                                                            <!-- 비동기 로드된 작업 목록 -->
                                                        </div>
                                                    </div> <!--  -->
                                                </div>
                                            </div>
                                        </div>
                                        <div class="simplebar-placeholder" style="width: 450px; height: 378px;"></div>
                                    </div> <!--  -->
                                    <div class="simplebar-track simplebar-horizontal" style="visibility: hidden;">
                                        <div class="simplebar-scrollbar" style="width: 0px; display: none;"></div>
                                    </div>
                                    <div class="simplebar-track simplebar-vertical" style="visibility: visible;">
                                        <div class="simplebar-scrollbar" style="height: 244px; transform: translate3d(0px, 0px, 0px); display: block;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="bg-dragula p-2 p-lg-2">
                                <h4 class="mt-0 task-header"><i class=" uil-pause-circle"></i>업무 대기 <span id="taskSt" class="float-end"> </span>  </h4>   
                                <div class="card-body py-0 mb-3 simplebar-scrollable-y" data-simplebar="init" style="max-height: 400px;">
                                    <div class="simplebar-wrapper" style="margin: 0px -24px;">
                                        <div class="simplebar-height-auto-observer-wrapper">
                                            <div class="simplebar-height-auto-observer"></div>
                                        </div>
                                        <div class="simplebar-mask">
                                            <div class="simplebar-offset" style="right: 0px; bottom: 0px;">
                                                <div class="simplebar-content-wrapper" tabindex="0" role="region" aria-label="scrollable content" style="height: auto; overflow: hidden scroll;">
                                                    <div class="simplebar-content">
                                                        <div id="pendingTasks" class="py-2" data-simplebar>
                                                            <!-- 비동기 로드된 작업 목록 -->
                                                        </div>
                                                    </div> <!--  -->
                                                </div>
                                            </div>
                                        </div>
                                        <div class="simplebar-placeholder" style="width: 450px; height: 378px;"></div>
                                    </div> <!--  -->
                                    <div class="simplebar-track simplebar-horizontal" style="visibility: hidden;">
                                        <div class="simplebar-scrollbar" style="width: 0px; display: none;"></div>
                                    </div>
                                    <div class="simplebar-track simplebar-vertical" style="visibility: visible;">
                                        <div class="simplebar-scrollbar" style="height: 244px; transform: translate3d(0px, 0px, 0px); display: block;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="bg-dragula p-2 p-lg-2">
	                           <h4 class="mt-0 task-header"><i class=" uil-stop-circle"></i>업무 마감 <span id="taskDe" class="float-end"> </span> </h4>
                                <div class="card-body py-0 mb-3 simplebar-scrollable-y" data-simplebar="init" style="max-height: 400px;">
                                    <div class="simplebar-wrapper" style="margin: 0px -24px;">
                                        <div class="simplebar-height-auto-observer-wrapper">
                                            <div class="simplebar-height-auto-observer"></div>
                                        </div>
                                        <div class="simplebar-mask">
                                            <div class="simplebar-offset" style="right: 0px; bottom: 0px;">
                                                <div class="simplebar-content-wrapper" tabindex="0" role="region" aria-label="scrollable content" style="height: auto; overflow: hidden scroll;">
                                                    <div class="simplebar-content">
                                                        <div id="completedTasks" class="py-2" data-simplebar>
                                                            <!-- 비동기 로드된 작업 목록 -->
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="simplebar-placeholder" style="width: 450px; height: 378px;"></div>
                                    </div> <!--  -->
                                    <div class="simplebar-track simplebar-horizontal" style="visibility: hidden;">
                                        <div class="simplebar-scrollbar" style="width: 0px; display: none;"></div>
                                    </div>
                                    <div class="simplebar-track simplebar-vertical" style="visibility: visible;">
                                        <div class="simplebar-scrollbar" style="height: 244px; transform: translate3d(0px, 0px, 0px); display: block;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                          <div class="col-md-3" style="margin-bottom: 10px">
                            <div class="bg-dragula p-2 p-lg-3">
                                <h5 class="mt-0 task-header"><i class="mdi mdi-calendar-outline"></i> 프로젝트 일정</h5>
                                <div class="card-body py-0 mb-3 simplebar-scrollable-y" data-simplebar="init" style="max-height: 400px;">
                                    <div class="simplebar-wrapper" style="margin: 0px -24px;">
                                        <!--  -->
                                        <div class="simplebar-height-auto-observer-wrapper">
                                            <div class="simplebar-height-auto-observer"></div>
                                        </div>
                                        <div class="simplebar-mask">
                                            <div class="simplebar-offset" style="right: 0px; bottom: 0px;">
                                                <div class="simplebar-content-wrapper" tabindex="0" role="region" aria-label="scrollable content" style="height: auto; overflow: hidden scroll;">
                                                    <div class="simplebar-content">
                                                        <!--  -->
                                                        <div id="handle-dragula-left" class="py-2">
                                                            <c:forEach var="schedule" items="${scheduleList}">
                                                                <div class="card mb-0 mt-2">
                                                                    <div class="card-body">
                                                                        <div class="d-flex align-items-start">
                                                                            <c:set value="${schedule.projSchdlEndDt}" var="date"></c:set>

                                                                            ${schedule.projSchdlNm}<br><span style="margin-left: 20px;font-size: 10px;color: #818181ba;">
                                                                                <fmt:formatDate value="${date}" pattern="MM/dd HH:mm" /> </span>
                                                                            <div class="w-100 overflow-hidden">
                                                                                <h5 class="mb-1 mt-1"></h5>
                                                                                <p class="mb-0"></p>
                                                                            </div>
                                                                            <span class="dragula-handle"></span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                    </div> <!--  -->
                                                </div>
                                            </div>
                                        </div>
                                        <div class="simplebar-placeholder" style="width: 450px; height: 378px;"></div>
                                    </div> <!--  -->
                                    <div class="simplebar-track simplebar-horizontal" style="visibility: hidden;">
                                        <div class="simplebar-scrollbar" style="width: 0px; display: none;"></div>
                                    </div>
                                    <div class="simplebar-track simplebar-vertical" style="visibility: visible;">
                                        <div class="simplebar-scrollbar" style="height: 244px; transform: translate3d(0px, 0px, 0px); display: block;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 프로젝트 KANBAN BOARD 끝 -->
                <div class="tab-pane" id="dashboard">
                    <div>
                        <div style="display: flex;">
                            <div class="col-md-4">
                                <div class="col-md-11 card" style="overflow: hidden;">
                                    <div class="card card-h-100">
                                        <div class="card-header d-flex justify-content-between align-items-center">
                                            <h4 class="header-title mb-0">업무 상태</h4>
                                            <div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="myChart" style="max-width:300px; height:200px;"></div> 
                                </div>
                                <div class="col-md-11 card" style="overflow: hidden;">
                                    <div class="card card-h-100">
                                        <div class="card-header d-flex justify-content-between align-items-center">
                                            <h4 class="header-title mb-0">5일 내 마감업무</h4>
                                            <div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="myChart2" style="width:100%; max-width:550px; height:230px;"></div>
                                </div>
                            </div>
                            <div class="col-md-8 card">
                                <div class="col-md-12">
                                    <div class="card-body">
	                                	<div class="card-h-100 d-flex justify-content-between align-items-center">
                                           	<h2 class="header-title mb-30">프로젝트 일정</h2>
                                            <div>
                                            	<hr>
                                            </div>
	                                    </div>
	                                     <div class="col-lg-12">
	                                         <div id="external-events"></div>
	                                         <div id="calendar"></div>
	                                     </div>
                                        <!-- end col -->
                                    </div>
                                </div>
                            </div>
                            <!-- end card body-->

                            <!-- Calledar Add New Event MODAL -->
                            <div class="modal fade" id="event-modal" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <form class="needs-validation" name="event-form" id="form-event" novalidate>
                                            <div class="modal-header py-3 px-4 border-bottom-0">
                                                <h5 class="modal-title" id="modal-title">Event</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body px-4 pb-4 pt-0">
                                                    
                                                <div class="row">
                                                    <input type="text" hidden="true" id="event-no" name="no">
                                                    <div class="col-12">
                                                        <div class="mb-3">
                                                            <label class="control-label form-label">프로젝트 일정</label> <input type="button"  class="float-end btn btn-primary" id="pptBtn1" value="데이터">
                                                            <input class="form-control" placeholder="일정을 등록하세요" type="text" name="title" id="event-title" required />
                                                            <div class="invalid-feedback">일정을 등록해주세요</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-12">
                                                        <div class="mb-3">
                                                            <label class="control-label form-label">일정 내용</label>
                                                            <input class="form-control" placeholder="내용을 등록하세요" type="text" name="content" id="event-content" required />
                                                            <div class="invalid-feedback">내용을 등록해주세요</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-12">
                                                        <div class="mb-3">
                                                            <label class="control-label form-label">색상</label> <select class="form-select" name="category" id="event-category" required>
                                                                <option value="bg-danger" selected>red</option>
                                                                <option value="bg-success">green</option>
                                                                <option value="bg-primary">blue</option>
                                                                <option value="bg-info">sky</option>
                                                                <option value="bg-dark">black</option>
                                                                <option value="bg-warning">yellow</option>
                                                            </select>
                                                            <div class="invalid-feedback">Please select a valid
                                                                event category</div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-6">
                                                        <button type="button" class="btn btn-danger" id="btn-delete-event">삭제</button>
                                                    </div>
                                                    <div class="col-6 text-end">
                                                        <button type="button" class="btn btn-light me-1" data-bs-dismiss="modal">취소</button>
                                                        <button type="submit" class="btn btn-success" id="btn-save-event">저장</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <!-- end modal-content-->
                                </div>
                                <!-- end modal dialog-->
                            </div>
                        </div>

                    </div>
                </div>
                <div class="tab-pane" id="Task">
                    <div class="row">

                        <div class="col-sm-12 col-md-4">
                            <div class="dataTables_length" id="insert_btn">
                                <div id="taskAdd">
                                    <button class='btn btn-primary' id='taskAddBtn' data-bs-toggle='modal' data-bs-target='#taskModal'> 업무 등록 </button>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-2">
                            <div class="dataTables_length" id="selection-datatable_length">
                                <label class="form-label" style="display: flex">
                                    <select id="pageSize" name="selection-datatable_length" class="form-select form-select-sm">
                                        <option value="10">10</option>
                                        <option value="25">25</option>
                                        <option value="50">50</option>
                                    </select>

                                </label>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <div id="selection-datatable_filter" class="dataTables_filter">
                                <label style="display: flex">
                                    <select id="searchType" class="form-select form-select-sm">
                                        <option value="TASK_TTL">업무명</option>
                                        <option value="EMPL_NM">담당자</option>
                                    </select>
                                    <input type="search" id="searchKeyword" class="form-control form-control-sm" placeholder="입력해주세요">
                                    <input type="button" id="searchButton" class="btn btn-primary" value="검색">
                                </label>
                            </div>
                        </div>
                    </div>
                    <table id="" class="table dt-responsive nowrap w-100" >
                        <thead class="table-light">
                            <tr>
                                <th class="text-center">번호</th>
                                <th>업무명</th>
                                <th class="text-center">중요도</th>
                                <th class="text-center">상태</th>
                                <th class="text-center">담당자</th>
                                <th class="text-center">시작일자</th>
                                <th class="text-center">마감일자</th>
                                <th class="text-center">최종수정일자</th>
                                <th class="text-center">진척도</th>
                            </tr>
                        </thead>
                        <tbody id="projectTaskCn">
                        </tbody>
                    </table>
                    <div class="row">
                        <div class="col-sm-12 col-md-5" style="text-align: right;">
                            <button id="prevPage" class="btn btn-primary">이전</button>
                        </div>
                        <div class="col-sm-12 col-md-2" style="text-align: center;" id="currentPage"> </div>
                        <div class="col-sm-12 col-md-5" style="text-align: left;">
                            <button id="nextPage" class="btn btn-primary">다음</button>
                        </div>
                    </div>
                </div>
                <!--  간트 차트 탭 테이블  -->
                <div class="tab-pane" id="GanttChart">

                    <div class="card">
                        <div class="card-body">
                            <div class="col-xxl-12 mt-4 mt-xl-0 col-lg-12">
                                <div class="ps-xl-3">
                                    <div class="row">
                                        <div class="col text-sm-end">
                                            <div class="btn-group btn-group-sm mb-2" data-bs-toggle="buttons" id="modes-filter">
                                                <label class="btn btn-primary d-none d-sm-inline-block">
                                                    <input class="btn-check" type="radio" name="modes" id="qday" value="Quarter Day"> 사시
                                                </label>
                                                <label class="btn btn-primary">
                                                    <input class="btn-check" type="radio" name="modes" id="hday" value="Half Day"> 반일
                                                </label>
                                                <label class="btn btn-primary">
                                                    <input class="btn-check" type="radio" name="modes" id="day" value="Day"> 일간
                                                </label>
                                                <label class="btn btn-primary active">
                                                    <input class="btn-check" type="radio" name="modes" id="week" value="Week" checked=""> 주간
                                                </label>
                                                <label class="btn btn-primary">
                                                    <input class="btn-check" type="radio" name="modes" id="month" value="Month"> 월간
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col mt-3">
                                            <svg id="tasks-gantt">
                                            </svg>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 프로젝트 KANBAN BOARD Modal 시작 -->
    <div class="modal fade" id="taskModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden=true>
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                       <i class="ri-todo-line"> </i>Task &ensp;<span id="projNm"></span> 
                       <span class="text-muted" > <i class="mdi mdi-circle-small"></i> project</span> 
                    </h5>   
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                     <input type="button"  class="float-end btn btn-primary" id="pptBtn2" value="데이터">
                    <form method="post">
                        <div class="mb-3">
                            <label for="taskTtl" class="col-form-label">업무제목</label>
                             <input type="text" id="taskTtl" class="form-control form-control-light" disabled="disabled" placeholder="업무제목을 써주세요" /> 
                        </div>
                        <div class="mb-3">
                            <label for="taskCn" class="col-form-label">업무내용</label>
                            <textarea class="form-control form-control-light" id="taskCn" name="taskCn" placeholder="업무내용을 써주세요"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="taskBgngYmd" class="col-form-label">시작일</label>
                            <input type="date" class="form-control form-control-light" name="taskBgngYmd" id="taskBgngYmd" >
                        </div>
                        <div class="mb-3">
                            <label for="taskDdlnYmd" class="col-form-label">마감일</label>
                            <input type="date" class="form-control form-control-light" name="taskDdlnYmd" id="taskDdlnYmd">
                        </div>
                        <div class="mb-3">
                            <label for="tkprCode" class="col-form-label">중요도</label>

                            <div class="rateit rateit-mdi" id="getting-values" data-rateit-mode="font" data-rateit-icon="󰓒">


                            </div>
                        </div>
                        <div class="mb-3">
                            <div class="slidecontainer">
                                <label for="taskPrgsPer" class="col-form-label">진행률</label>
                                <input type="range" min="0" max="100" step="10" class="slider" id="taskPrgsPer">
                            </div>
                        </div>
                        <div class="mb-3" id="divCharge">
                            <label for="taskCharge" class="col-form-label">담당자</label>
                            <select id="projMember">
                                <!--  엄무배정 리스트   -->
                            </select>
                        </div>

                        <sec:csrfInput />
                        <input type="hidden" id="task-id">
                        <input type="hidden" id="proj-no">
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" id="modalClose" data-bs-dismiss="modal">Close</button>
                    <button type="button" id="reviceUpdate" class="btn btn-primary">수정</button>
                    <button type="button" id="insertTaskBtn" class="btn btn-primary" hidden="true">등록</button>
                </div>
            </div>
            <!-- 프로젝트 KANBAN BOARD Modal 끝 -->
        </div>
    </div>

    <script src="${pageContext.request.contextPath }/resources/assets/vendor/frappe-gantt/frappe-gantt.min.js"></script>
    <!--     Fullcalendar js -->
    <%-- <script src="${pageContext.request.contextPath }/resources/assets/js/vendor.min.js"></script> --%>
    <!-- Fullcalendar js -->
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/fullcalendar/index.global.min.js"></script>
    <!-- Calendar App refactoring js -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/pages/a.calendar.js"></script>

    <!-- Gantt refactoring js -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/pages/a.project-gantt.js"></script>

    <!-- 별 관련  -->
    <%-- 	<script src="${pageContext.request.contextPath }/resources/assets/vendor/jquery.rateit/scripts/jquery.rateit.min.js"></script> --%>
    
</body>

</html>