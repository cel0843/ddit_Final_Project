$(function() {
	var ganttData; // 함수 외부에서 ganttData 변수를 정의합니다.
	var projNo = goProjNo;
	$('.projects_tab').on('click', function() {
		var projNo = $(this).data('projno');
	    loadGanttChart(projNo);
	});
	$('#ganttChartTab').on('click', function() {
//		var projNo = $(this).data('projno');
	    loadGanttChart(projNo);
	});
	
	
	loadGanttChart(projNo);
	
	
	function formatDate(dateString) {
    	return `${dateString.slice(0, 4)}-${dateString.slice(4, 6)}-${dateString.slice(6)}`;
	}
	
	function loadGanttChart(projNo) {
		 $.ajax({
		        url: '/project/ajax/selectTaskGantChart',
		        type: 'get',
		        data: {
		            projNo: projNo,
		        },
		        dataType: 'json',
		        success: function(tasks) {
		        	if(tasks.length == 0){
		        		return;
		        	}
		        	
		        	ganttData = tasks.map(task => ({
					    id: task.taskNo.toString(),
					    name: task.taskTtl,
					    start: formatDate(task.taskBgngYmd),
					    end: formatDate(task.taskDdlnYmd),
					    progress: task.taskPrgsPer
					}));
					
					console.log('ganttData', ganttData);
					renderGanttChart(ganttData); // AJAX 호출이 성공하면 간트 차트를 렌더링합니다.
		        }
		});
	}

	function renderGanttChart(ganttData) {
	
	
	    var e = new Gantt("#tasks-gantt", ganttData, {
	        view_modes: ["Quarter Day", "Half Day", "Day", "Week", "Month"],
	        bar_height: 27,
	        padding: 18,
	        view_mode: "Week",
	        custom_popup_html: function(e) {
	            var s = e.end;
	            60 <= e.progress || 30 <= e.progress && e.progress;
	            return `
	                <div class="popover fade show bs-popover-right gantt-task-details" role="tooltip">
	                    <div class="arrow"></div><div class="popover-body">
	                    <h5>${e.name}</h5><p class="mb-2">${s} 에 완료될 예정입니다.</p>
	                    <div class="progress mb-2">
	                    <div class="progress-bar  progressCls + '" role="progressbar" style="width: ${e.progress}%;" aria-valuenow="${e.progress}"
	                     aria-valuemin="0" aria-valuemax="100">${e.progress}%</div>
	                    </div></div></div>
	                `
	        }
	    }), s = ($("#modes-filter :input").on("change", function() { 
	        e.change_view_mode($(this).val());
	    }), document.getElementById("modes-filter").querySelectorAll(".btn"));
	    
	    s.forEach(function(e) {
	        e.addEventListener("click", function() {
	            s.forEach(function(e) {
	                e.classList.remove("active");
	            }), e.classList.add("active");
	        });
	    });
	}
	
});
