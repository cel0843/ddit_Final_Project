<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<style>
.divNodes{
	 width:120px; 
	 height:30px;
	 background-color: white; 
}
.btn.btn-sm.btn-info{
	width:120px;
	height:30px;
	background-color: white; 
}


</style>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript" src="/resources/js/jquery.min.js"></script>
    
   
    
    <script type="text/javascript">
      google.charts.load('current', {packages:["orgchart"]});
      google.charts.setOnLoadCallback(drawChart);

      var ceoData;
      var departmentData;
      var organizationData;
      
      function drawChart() {
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Name');
        data.addColumn('string', 'Manager');
        data.addColumn('string', 'ToolTip');
		
        setTimeout(() => {
			$.ajax({
				url : "/egg/orgChartAjax",
				type : "GET",
				beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
					xhr.setRequestHeader(header, token);
				},
				contentType : "application/json;charset=utf-8",
				success : function(res){
					console.log(res);
				    ceoData = [
				    	{'v' : res.ceoList[0].emplNm, 'f' : res.ceoList[0].emplNm + "<div style='color:black;font-style:italic;' class='divNodes'>대표이사</div>"},"",res.ceoList[0].telno 
				    ];
				    let departLength = res.departmentList.length;
				    let organizLength = res.organizationList.length;

				    var arr = [];
					arr.push(ceoData);
					for(var i = 0; i < departLength; i++){
						arr.push(res.departmentList[i]);
					}
					for(var i = 0; i < organizLength; i++){
						arr.push(res.organizationList[i]);
					}
					console.log(arr);
			        data.addRows(arr);
			        
			        // Create the chart.
			        var chart = new google.visualization.OrgChart(document.getElementById('chart_div'));
			        // Draw the chart, setting the allowHtml option to true for the tooltips.
			        chart.draw(data, {'allowHtml':true});
				}
			});
		}, 50);
      }
   </script>
    <div id="chart_div"></div>
    
    <!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="modalTitle"></h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body" >
	      		<div  style="display: flex;">
				<div id="proflImageCours">
					<img src="{require}" id="proflImageInModal" width="120px">
				</div>
				
				<div style="align-items: center;">
				<div id="emplId"></div>
				<div id="emplNm"></div>
				<div id="deptNm"></div>
				<div id="email"></div>
				<div id="telno"></div>
	      		</div>
				</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
    
<script type="text/javascript">
$(function(){
  	
	$("#chart_div").on("click", ".divNodes", function(){
		var emplId = $(this).data("id");  		
  		$("#exampleModal").modal("show");
  	
	   	$.ajax({
	   		url: "/egg/orgEmplDetail",
	   		type : "get",
	   		data : {
	   			emplId : emplId
	   		},
	   		contentType : "application/json;charset=utf-8",
	   		success : function(res){
	   			console.log(res);
	   			var proflImageCoursCode = "";
	   			proflImageCoursCode = res.proflImageCours;
	   			console.log("@" + proflImageCoursCode);
	   			var idCode = '사번 : ' + res.emplId;
	   			var emplNmCode = '이름 : ' + res.emplNm;
	   			var deptNmCode = '부서 : ' + res.deptNm;
	   			var emailCode = '이메일 : ' + res.email;
	   			var telnoCode = '전화번호 : ' + res.telno;
	   			
				$("#proflImageInModal").attr("src", proflImageCoursCode);
	   			$('#emplId').html(idCode);
	   			$('#emplNm').html(emplNmCode);
	   			$('#deptNm').html(deptNmCode);
	   			$('#email').html(emailCode);
	   			$('#telno').html(telnoCode);
	   		}
	   	});
  	});
});
  </script>