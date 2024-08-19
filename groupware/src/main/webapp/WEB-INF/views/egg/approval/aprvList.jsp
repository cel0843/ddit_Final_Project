<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<style>
div.dataTables_wrapper div.dataTables_filter{
    display: none;
}
#basic-datatable_length{
	display: none;
}
#basic-datatable_info{
	display: none;
}

.card {
    border: none;
    box-shadow: 0 0 15px rgba(0,0,0,0.1);
}
.search-form {
    padding: 20px;
}
.form-group {
    margin-bottom: 15px;
}
.date-range {
    display: flex;
    gap: 10px;
}
.checkbox-group {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
}
.btn-search {
    width: 80px;
    margin-top: 20px;
}
</style>

<div class="container mt-4">
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">결재관리</h3>
            <button type="button" class="btn btn-soft-success" id="data" style="float: right;">시연데이터</button>
        </div>
        <div class="card-body search-form">
            <form id="searchForm" method="post">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="atrzDmndDts">기안 기간</label>
                            <div class="date-range">
                                <input type="date" id="startDate" name="atrzDmndDts" class="form-control" value="${aprvSearchVO.atrzDmndDt1 }">
                                <input type="date" id="endDate" name="atrzDmndDts" class="form-control" value="${aprvSearchVO.atrzDmndDt2 }">
                            </div>
                            <span id="dateErrorMessage" style="display: none; color: red;"></span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="atrzCmptnDts">최종 결재 기간</label>
                            <div class="date-range">
                                <input type="date" id="approvalStartDate" name="atrzCmptnDts" class="form-control" value="${aprvSearchVO.atrzCmptnDt1 }">
                                <input type="date" id="approvalEndDate" name="atrzCmptnDts" class="form-control" value="${aprvSearchVO.atrzCmptnDt2 }">
                            </div>
	                        <span id="AprvDateErrorMessage" style="display: none; color: red;"></span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>기안자</label>
                            <input type="text" id="emplNm" name="emplNm" class="form-control" value="${aprvSearchVO.emplNm}" >
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>기안부서</label>
                            <select class="form-control select2" data-toggle="select2" id="deptNm" name="deptNm">
                            	<option value="">--전체--</option>
		                		<c:forEach var="dept" items="${dept}">
		                			<option value="${dept.deptCd }">${dept.deptNm }</option>
		                		</c:forEach>
		                		<c:if test="${aprvSearchVO.deptNm != null }">
		                			<option selected="selected">${aprvSearchVO.deptNm }</option>
		                		</c:if>
		                	</select>
                        </div>
                    </div>
                     <div class="col-md-3">
                        <div class="form-group">
                            <label>최종결재자</label>
                            <input type="text" id="lastAprv" name="lastAprv" class="form-control" value="${aprvSearchVO.lastAprv}">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>제목</label>
                            <input type="text" id="aprvTtl" name="aprvTtl" class="form-control" value="${aprvSearchVO.aprvTtl}">
                        </div>
                    </div>
                </div>
                <div class="row">
				    <div class="col-md-6">
				        <div class="form-group">
				            <label>문서 상태</label>
				            <div class="radio-group">
				                <div class="form-check form-check-inline">
				                    <input class="form-check-input" type="radio" id="docStatusAll" name="prgrsSttsTy" value=""
				                     <c:if test="${empty aprvSearchVO.prgrsSttsTy }">checked</c:if> checked>
				                    <label class="form-check-label" for="docStatusAll">전체</label>
				                </div>
				                <div class="form-check form-check-inline">
				                    <input class="form-check-input" type="radio" id="docStatusWaiting" name="prgrsSttsTy" value="SEC00103"
				                    <c:if test="${aprvSearchVO.prgrsSttsTy eq 'SEC00103' }">checked</c:if>>
				                    <label class="form-check-label" for="docStatusWaiting">대기</label>
				                </div>
				                <div class="form-check form-check-inline">
				                    <input class="form-check-input" type="radio" id="docStatusInProgress" name="prgrsSttsTy" value="SEC00102"
				                    <c:if test="${aprvSearchVO.prgrsSttsTy eq 'SEC00102'}">checked</c:if>>
				                    <label class="form-check-label" for="docStatusInProgress">진행</label>
				                </div>
				                <div class="form-check form-check-inline">
				                    <input class="form-check-input" type="radio" id="docStatusCompleted" name="prgrsSttsTy" value="SEC00101"
				                    <c:if test="${aprvSearchVO.prgrsSttsTy eq 'SEC00101'}">checked</c:if>>
				                    <label class="form-check-label" for="docStatusCompleted">완료</label>
				                </div>
				            </div>
				        </div>
				    </div>
				    <div class="col-md-6">
				        <div class="form-group">
				            <label>결재 상태</label>
				            <div class="radio-group">
				                <div class="form-check form-check-inline">
				                    <input class="form-check-input" type="radio" id="approvalStatusAll" name="aprvStatus" value="" 
				                    <c:if test="${empty aprvSearchVO.aprvStatus }">checked</c:if>checked>
				                    <label class="form-check-label" for="approvalStatusAll">전체</label>
				                </div>
				                <div class="form-check form-check-inline">
				                    <input class="form-check-input" type="radio" id="approvalWaiting" name="aprvStatus" value="SEC00103"
				                    <c:if test="${aprvSearchVO.aprvStatus eq 'SEC00103'}">checked</c:if>>
				                    <label class="form-check-label" for="approvalWaiting">대기</label>
				                </div>
				                <div class="form-check form-check-inline">
				                    <input class="form-check-input" type="radio" id="approvalStatusApproved" name="aprvStatus" value="SEC00202"
				                    <c:if test="${aprvSearchVO.aprvStatus eq 'SEC00202'}">checked</c:if>>
				                    <label class="form-check-label" for="approvalStatusApproved">승인</label>
				                </div>
				                <div class="form-check form-check-inline">
				                    <input class="form-check-input" type="radio" id="approvalStatusRejected" name="aprvStatus" value="SEC00201"
				                    <c:if test="${aprvSearchVO.aprvStatus eq 'SEC00201'}">checked</c:if>>
				                    <label class="form-check-label" for="approvalStatusRejected">반려</label>
				                </div>
				            </div>
				        </div>
				    </div>
				</div>
                <div class="text-right">
                    <button type="button" class="btn btn-primary btn-search" id="searchBtn" style="float: right;">검색</button>
                </div>
                <input type="hidden" name="searchFlag" value="search"/>
                <sec:csrfInput/>
            </form>
        </div>
    </div>
</div>
    <div class="card" id="searchResultCard" >
        <div class="card-header">
            <h3 class="card-title">검색 결과</h3>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover" style="text-align: center;" id="basic-datatable">
                    <thead class="table-active" >
                        <tr>
                            <th>기안일</th>
                            <th>기안자</th>
                            <th>기안부서</th>
                            <th>제목</th>
                            <th>결재일</th>
                            <th>최종결재자</th>
                            <th>문서상태</th>
                            <th>결재상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty res }">
                        	<tr><td colspan="8" style="text-align: center;">검색된 결과가 없습니다</td></tr>
                        </c:if>
                        <c:forEach var="search" items="${res }">
                        	<tr data-aprvid=${search.aprvId } class="detail">
	                       		<td>${search.atrzDmndDt }</td>
	                            <td>${search.emplNm}</td>
	                            <td>${search.deptNm}</td>
	                            <td>${search.aprvTtl}</td>
	                           	<td>${search.atrzCmptnDt }
	                           		<c:if test="${empty search.atrzCmptnDt }">======</c:if>
	                           	</td>
	                            <td>${search.lastAprv}</td>
	                            <td>${search.prgrsSttsTy}</td>
	                            <td>${search.aprvStatus}</td>
                        	</tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>


<script>
$(function(){
	
	// 시연데이터
	$("#data").on("click",function(){
		$("#startDate").val("2024-08-05");
		$("#endDate").val("2024-08-05");
		$("#docStatusCompleted").attr("checked", true);
		$("#lastAprv").prop('disabled', true);
	    $("#lastAprv").val(''); 

	});
	 
    $("input[name='prgrsSttsTy']").change(function() {
	    var selectedDocStatus = $("input[name='prgrsSttsTy']:checked").val();
	    
	    if (selectedDocStatus === "SEC00103") {
	       $("#lastAprv").prop('disabled', true);
	       $("#lastAprv").val(''); 
	    } else {
	    	$("#lastAprv").prop('disabled', false);
	    }
        
    });
    $("input[name='aprvStatus']").change(function() {
	    var selectedApprovalStatus = $("input[name='aprvStatus']:checked").val();
	    
	    if (selectedApprovalStatus === "SEC00103") {
	       $("#lastAprv").prop('disabled', true);
	       $("#lastAprv").val(''); // 필드를 비움
	    } else {
	    	$("#lastAprv").prop('disabled', false);
	    }
        
    });
    
	$("#searchBtn").on("click", function(){
	    var draftStart = $("#startDate").val();
	    var draftEnd = $("#endDate").val();
	    var approvalStart = $("#approvalStartDate").val();
	    var approvalEnd = $("#approvalEndDate").val();
	    
	    var errorSpan = $("#dateErrorMessage");
	    var errorSpana = $("#AprvDateErrorMessage");
	   
	    
	    
	    var hasError = false;
	    
	    // 기안기간 입력값 검증
	    if ((draftStart && !draftEnd) || (!draftStart && draftEnd) ) {
	        errorSpan.text("기안 기간은 시작일과 종료일 모두 입력해주세요").show();
	        if(!draftEnd){
		        $("#endDate").focus();
	        }else{
	        	$("#startDate").focus();
	        }
	        hasError = true;
	    } else {
	        errorSpan.hide();
	    }
	    
	    // 결재기간 입력값 검증
	    if ( (approvalStart && !approvalEnd) || (!approvalStart && approvalEnd) ) {
	        errorSpana.text("최종결재기간은 시작일과 종료일 모두 입력해주세요").show();
	        if(!approvalEnd){
	        	$("#approvalEndDate").focus();
	        }else{
	        	$("#approvalStartDate").focus();
	        }
	        hasError = true;
	    } else {
	        errorSpana.hide();
	    }
	    
	 // 에러가 있으면 submit 방지
	    if (hasError) {
	        event.preventDefault();
	        return false;
	    }
	    
	    // 에러가 없으면 폼 제출
	    $("#searchForm").submit();
	   
	});
	
});
</script>