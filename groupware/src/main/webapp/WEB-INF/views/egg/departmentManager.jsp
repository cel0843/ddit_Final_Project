<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<style>

.first-space{
	display: block;
}
.second-space{
	display: flex;
	justify-content: space-between; 
}

.insert-empl{
	
}
label {
    display: none;
}
div.dataTables_wrapper div.dataTables_filter input {
    display: none;
}
.searchForm{
	display: flex;
	flex-direction: row;
	justify-content: flex-start; 
}
.searchForm-insertBtn{
	display: flex;
	flex-direction: row;
	justify-content: space-between; 
}
</style>
<script type="text/javascript">
$(function(){
	$("#deptFormBtn").on("click",function(){
		location.href= "/admin/deptform";
	});
	
	$("#basic-datatable tbody").on('click', 'tr', function() {
        // 클릭된 행의 첫 번째 td 요소에서 deptId를 추출
        var deptId = $(this).find('td:first').text();
        $("#clickDeptIdInfo").val(deptId);
        
		$("#deptIdinfoForm").submit();
    });
});

</script>
<form id="deptIdinfoForm" action="/admin/updateDeptInfo" method="post">
	<input type="hidden" name="deptCd" id="clickDeptIdInfo" value="">
	<sec:csrfInput/>
</form>


<div class="row">
	<div class="col-md-12">
		<div class="card">
			<div class="card-header">
			
				<h1 class="card-title">부서관리</h1>
					<div class="searchForm-insertBtn">
						<form action="/admin/deptSearch" method="post">
							<div class="searchForm">
								<div>         
									<select class="form-select" id="searchSelectBox" name="select">
									    <option value="deptCd" ${selectBoxChk == 'deptCd' ? 'selected' : ''}>부서아이디</option>
									    <option value="deptNm" ${selectBoxChk == 'deptNm' ? 'selected' : ''}>부서명</option>
									    <option value="dprlrNm" ${selectBoxChk == 'dprlrNm' ? 'selected' : ''}>부서장명</option>
									</select>
								</div>
								<div>
									<input type="text" name="searchText" class="form-control" value="">
								</div>
								<div>
									<input class="btn btn-primary" type="submit" value="검색" style="margin-left: 3px;">
								</div>
							</div>
						<sec:csrfInput/>
						</form>
					
						<div class="insert-empl">
							<button id="deptFormBtn" class="btn btn-primary"><b>+ 부서등록</b></button>
						</div>
					</div>
					
			</div>
			
			<c:set value="${deptList}" var="deptList"/>
			
			<div class="card-body">
				<table id="basic-datatable" class="table table-striped dt-responsive nowrap w-100 dataTable no-footer dtr-inline">
				    <thead>
				        <tr>
				            <th>부서아이디</th>
				            <th>부서명</th>
				            <th>부서장명</th>
				            <th>부서전화번호</th>
				            <th>부서상태</th>
				        </tr>
				    </thead>
				
				    <tbody>
					     <c:forEach items="${deptList }" var="dept" >
					    	<tr>
	                           <td>${dept.deptCd }</td>
	                           <td>${dept.deptNm }</td>
	                           <td>${dept.dprlrNm }</td>
	                           <td>${dept.deptTelno }</td>
	                           <c:if test="${dept.deptTySt =='Y'}">
		                           <td>정상</td>
	                           </c:if>
	                           <c:if test="${dept.deptTySt !='Y'}">
		                           <td>이용정지</td>
	                           </c:if>
	                     
	                       	</tr>
					    </c:forEach>
				    </tbody>
				</table>
			</div>
			<div class="card-footer">
			
			</div>
		</div>
	</div>
</div>
