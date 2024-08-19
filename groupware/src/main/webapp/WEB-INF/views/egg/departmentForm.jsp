<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    body { 
        font-family: Arial, sans-serif; 
    } 
    .container {
        width: 80%;
        margin: auto;
    }
    .section {
        display: flex;
        justify-content: space-between;
        margin-bottom: 20px;
    }
    .left, .right {
        width: 48%;
    }
    .right {
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .section img {
        width: 100px;
        height: 100px;
        display: block;
        margin-bottom: 10px;
    }
    .section input[type="text"], .section input[type="email"], .section input[type="tel"], .section input[type="date"], .section input[type="password"] {
        width: 100%;
        padding: 8px;
        margin: 5px 0;
        box-sizing: border-box;
    }
    .section select {
        width: 100%;
        padding: 8px;
        margin: 5px 0;
        box-sizing: border-box;
    }
    .section label {
        display: block;
        margin: 5px 0;
    }
    .section input[type="file"] {
        margin: 10px 0;
    }
    .bottom-section {
        display: flex;
        justify-content: space-between;
        border-top: 1px solid #ccc;
        padding-top: 20px;
    }
    .bottom-left, .bottom-right {
        width: 48%;
    }
    .bottom-section input[type="text"], .bottom-section input[type="email"], .bottom-section input[type="tel"], .bottom-section input[type="password"] {
        width: 100%;
        padding: 8px;
        margin: 5px 0;
        box-sizing: border-box;
    }
    .bottom-section select {
        width: 100%;
        padding: 8px;
        margin: 5px 0;
        box-sizing: border-box;
    }
    .button-section {
        text-align: right;
        margin-top: 20px;
    }
    .button-section input[type="submit"], .button-section input[type="reset"], .button-section input[type="button"] {
        padding: 10px 20px;
        margin: 5px;
    }
</style>

<c:if test="${not empty errorMessages}">
	<script>
   		 alert("${errorMessages}");
    </script>
</c:if>

<script type="text/javascript">
$(function(){
	$("#cancelBtn").on("click", function(){
		location.href="/admin/deptmain";
	});
});
</script>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                <c:if test="${update != null }">
                    <h1 class="card-title">부서정보수정</h1>
                </c:if>
                <c:if test="${update == null }">
                    <h1 class="card-title">부서등록</h1>
                </c:if>
                    
                </div>
                
                <c:set value="${deptVO}" var="deptInfo"/>
                
                <div class="card-body">
                    <div class="container">
                        <h1>부서 정보 입력</h1>
                        
                        <c:set value="/admin/departmentUpdateForm" var="moveUrl"/>
                        <c:if test="${update == null }">
	                        <c:set value="/admin/departmentInsertForm" var="moveUrl"/>
		                </c:if>
		                    <form id="departmentForm" action="${moveUrl }" method="post" onsubmit="return validateForm()">
						    <div class="section">
						        <div class="left">
						            <label for="deptCd">부서아이디</label>
						            <c:if test="${update == null }">
						            <input class="form-control" type="text" id="deptCd" name="deptCd" value="${inputDeptCd }" readonly>
						            </c:if>
						            <c:if test="${update != null }">
						            <input class="form-control" type="text" id="deptCd" name="deptCd" value="${deptInfo.deptCd }" readonly>
						            </c:if>
						            <label for="deptNm">부서명</label>
						            <input class="form-control" type="text" id="deptNm" name="deptNm" value="${deptInfo.deptNm }" required>
						            <label for="dprlrNm">부서장</label>
						            <input class="form-control" type="text" id="dprlrNm" name="dprlrNm" value="${deptInfo.dprlrNm }" required>
						            <label for="deptTelno">부서전화번호</label>
						            <input class="form-control" type="text" id="deptTelno" name="deptTelno" value="${deptInfo.deptTelno }" required>
						            <c:if test="${update != null }">
							            <div class="form-check form-switch" style="padding-left: 0px;">
										    <label class="form-check-label" for="deptTySt" >부서사용여부</label>
										    <input type="checkbox" name="deptTySt" class="form-check-input" id="deptTySt" ${deptInfo.deptTySt == 'Y' ? 'checked' : '' } style="margin-left: 0px;">
										</div>
							        </c:if>
						        </div>
						        <div class="right">
							        
						        </div>
						    </div>
						
						    <div class="bottom-section">
						        
						    </div>
							<div class="button-section">
						 	
							 	<c:set value="등록" var="btnValue"/>
		                        <c:if test="${update != null }">
			                        <c:set value="수정" var="btnValue"/>
				                </c:if>
				                
						    	<input class="btn btn-primary" type="submit" value="${btnValue }">
						        <input class="btn btn-danger"id="cancelBtn" type="button" value="취소">
						    </div>
						    
						    <sec:csrfInput/>
						</form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
