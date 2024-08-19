<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<style>


 .divNodes {
    width: 150px; /* 너비를 약간 늘림 */
    height: auto; /* 높이를 자동으로 조정 */
    background-color: #ffffff;
/*     border: 2px solid #007bff; /* 테두리 두께를 늘림 */ */
/*     border-radius: 8px; /* 둥근 모서리 */ */
    text-align: center;
    padding: 10px; /* 패딩을 늘림 */
    background-color: #87CEEB;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
    cursor: pointer;
    transition: background-color 0.3s, transform 0.3s, box-shadow 0.3s; /* 효과 추가 */
}

.divNodes:hover {
    background-color: #e9ecef; /* 배경색 변경 */
    transform: scale(1.05); /* 살짝 확대 */
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); /* 호버 시 그림자 효과 증가 */
}

.divNodes .title {
    font-weight: bold; /* 제목을 굵게 */
    font-size: 16px; /* 제목 크기 조정 */
    margin-bottom: 5px; /* 제목과 내용 사이의 간격 */
}

.divNodes .role {
    color: #6c757d; /* 역할 색상 조정 */
    font-style: italic; /* 이탤릭체 */
    font-size: 14px; /* 역할 크기 조정 */
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
				url : "/egg/organizationChartAjax",
				type : "GET",
				beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
					xhr.setRequestHeader(header, token);
				},
				contentType : "application/json;charset=utf-8",
				success : function(res){
					console.log(res);
				    ceoData = [
				    	{'v' : res.ceoList[0].emplNm, 'f' : res.ceoList[0].emplNm + "<div style='color:black;font-style:italic; ' class='divNodes'>대표이사</div>"},"",res.ceoList[0].telno 
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
			        
			        var chart = new google.visualization.OrgChart(document.getElementById('chart_div'));
			        chart.draw(data, {'allowHtml':true, 'compactRows': true });
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
	console.log("개똥이");
  	
	$("#chart_div").on("click", ".divNodes", function(){
// 		var emplId = $(this).parents(".divNodes").data("id");  		
//	alert("ttt")
		var emplId = $(this).data("id");  		
  		$("#exampleModal").modal("show");
  	
	   	$.ajax({
	   		url: "/egg/emplDetail",
	   		type : "get",
	   		data : {
	   			emplId : emplId
	   		},
	   		contentType : "application/json;charset=utf-8",
	   		success : function(res){
	   			//alert("성공");
	   			//	res == EmployeeVO
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