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

/* Search 참고할 부분 시작 */
label {
    display: none;
}
div.dataTables_wrapper div.dataTables_filter input {
    display: none;
}
/* Search 참고할 부분  끝*/


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
	$("#employeeFormBtn").on("click",function(){
		location.href= "/admin/empForm";
	});
	
	$("#basic-datatable tbody").on('click', 'tr', function() {
        // 클릭된 행의 첫 번째 td 요소에서 emplId를 추출
        var emplId = $(this).find('td:first').text();
        $("#clickEmplIdInfo").val(emplId);
        
		$("#emplIdinfoForm").submit();
    });


});

</script>
<form id="emplIdinfoForm" action="/admin/updateEmplInfo" method="post">
	<input type="hidden" name="emplId" id="clickEmplIdInfo" value="">
	<sec:csrfInput/>
</form>


<div class="row">
	<div class="col-md-12">
		<div class="card">
			<c:set value="${empListVO}" var="empListVO"/>
			<div class="card-header">
			
				<h1 class="card-title">사원관리</h1>
					<div>
						<p>조회된 사원수 : <span>${empListVO.size() }명</span></p>
					</div>
					
					<div>
							<div class="searchForm-insertBtn">
								<form action="/admin/emplSearch" method="post">
									<div class="searchForm">
										<div>         
											<select class="form-select" id="searchSelectBox" name="select">
											    <option value="emplId" ${selectBoxChk == 'emplId' ? 'selected' : ''}>사원번호</option>
											    <option value="emplNm" ${selectBoxChk == 'emplNm' ? 'selected' : ''}>이름</option>
											    <option value="deptNm" ${selectBoxChk == 'deptNm' ? 'selected' : ''}>부서</option>
											    <option value="positionNm" ${selectBoxChk == 'positionNm' ? 'selected' : ''}>직급</option>
											    <option value="telno" ${selectBoxChk == 'telno' ? 'selected' : ''}>휴대폰</option>
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
								<div>
									<div class="insert-empl">
										<button id="employeeFormBtn" class="btn btn-primary"><b>+ 사원등록</b></button>
									</div>
								</div>
							</div>
						
					</div>
			</div>
			
			<div class="card-body" style="padding-top: 0px;">
				<table id="basic-datatable" class="table table-striped dt-responsive nowrap w-100 dataTable no-footer dtr-inline">
				    <thead>
				        <tr>
				            <th>사원번호</th>
				            <th>이름</th>
				            <th>부서</th>
				            <th>직급</th>
				            <th>휴대폰</th>
				            <th>관리자</th>
				            <th>상태</th>
				        </tr>
				    </thead>
				
				    <tbody>  
				    <c:forEach items="${empListVO }" var="emp">
				    	<tr>
                           <td>${emp.emplId }</td>
                           <td>${emp.emplNm }</td>
                           <td>${emp.deptNm }</td>
                           <td>${emp.positionNm }</td>
                           <td>${emp.telno }</td>
                           
                           <c:if test="${emp.getAuthList().get(emp.getAuthList().size()-1).getAuth() == 'ROLE_MEMBER' }">
                           <td>사용자</td>
                           </c:if>
                           <c:if test="${emp.getAuthList().get(emp.getAuthList().size()-1).getAuth() != 'ROLE_MEMBER' }">
                           <td>관리자</td>
                           </c:if>
                           
                           <c:if test="${emp.rsgntnYmd ne null }">
                           	<td>이용중지</td>
                           </c:if>
                           <c:if test="${emp.rsgntnYmd eq null }">
                           	<td>정상</td>
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

