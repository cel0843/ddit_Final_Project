<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
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
		location.href="/admin/empmain";
	});
});
</script>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                <c:if test="${update != null }">
                    <h1 class="card-title">사원정보수정</h1>
                </c:if>
                <c:if test="${update == null }">
                    <h1 class="card-title">사원등록</h1>
                    <button id="empVOInsertBtn" class="btn btn-danger">시연용 버튼</button>
                </c:if>
                    
                </div>
                
                <c:set value="${empVO}" var="empVO"/>
                
                <div class="card-body">
                    <div class="container">
                        <h1>사원 정보 입력</h1>
                        
                        <c:set value="/admin/employeeUpdateForm" var="moveUrl"/>
                        <c:if test="${update == null }">
	                        <c:set value="/admin/employeeInsertForm" var="moveUrl"/>
		                </c:if>
		                    <form id="employeeForm" action="${moveUrl }" method="post" onsubmit="return validateForm()">
						    <div class="section">
						        <div class="left">
						            <label for="emplNm">사원이름</label>
						            <input class="form-control" type="text" id="emplNm" name="emplNm" value="${empVO.emplNm }" required minlength="2" maxlength="50">
						
						            <label for="deptCd">부서</label>
						            <select id="deptCd" name="deptCd" required>
									    <option value="">선택하세요</option>
									    <option value="DEPT_01" ${empVO.deptCd == 'DEPT_01' ? 'selected' : ''}>보안사업부</option>
									    <option value="DEPT_02" ${empVO.deptCd == 'DEPT_02' ? 'selected' : ''}>기술영업부</option>
									    <option value="DEPT_03" ${empVO.deptCd == 'DEPT_03' ? 'selected' : ''}>사업부</option>
									    <option value="DEPT_04" ${empVO.deptCd == 'DEPT_04' ? 'selected' : ''}>QA사업부</option>
									    <option value="DEPT_05" ${empVO.deptCd == 'DEPT_05' ? 'selected' : ''}>인사부</option>
									</select>
						
						            <label for="positionCd">직급</label>
						            <select id="positionCd" name="positionCd" required>
									    <option value="">선택하세요</option>
									    <option value="POSITION06" ${empVO.positionCd == 'POSITION06' ? 'selected' : ''}>부장</option>
									    <option value="POSITION05" ${empVO.positionCd == 'POSITION05' ? 'selected' : ''}>차장</option>
									    <option value="POSITION04" ${empVO.positionCd == 'POSITION04' ? 'selected' : ''}>과장</option>
									    <option value="POSITION03" ${empVO.positionCd == 'POSITION03' ? 'selected' : ''}>대리</option>
									    <option value="POSITION02" ${empVO.positionCd == 'POSITION02' ? 'selected' : ''}>사원</option>
									    <option value="POSITION01" ${empVO.positionCd == 'POSITION01' ? 'selected' : ''}>인턴</option>
									</select>
						
						            <label for="jncmpYmd">입사날짜</label>
						            <input class="form-control" type="date" id="jncmpYmd" name="jncmpYmd" value="${empVO.jncmpYmd}" required>
						            
						        </div>
						        <div class="right">
						            <label for="proflImageCours">프로필 이미지</label>
						            <c:if test="${empVO.proflImageCours ne null }">
						            	<img id="profilePreview" src="${empVO.proflImageCours }" alt="프로필 이미지">
						            </c:if>
						            <c:if test="${empVO.proflImageCours eq null || empVO.proflImageCours eq '' }">
						            	<img id="profilePreview" src="${pageContext.request.contextPath }/resources/logo/personal_chat_icon.png" alt="프로필 이미지">
						            </c:if>
						            <input class="form-control" type="file" id="proflImageCours" accept="image/png, image/jpeg" onchange="encodeFileToBase64(this, 'proflImageBase64')" >
						            <input type="hidden" id="proflImageBase64" name="proflImageCours">
						
						            <label for="esgn">서명 이미지</label>
						            
						            
						            <c:if test="${empVO.esgn ne null }">
						            	<img id="signaturePreview" src="${empVO.esgn}" alt="서명 이미지">
						            </c:if>
						            <c:if test="${empVO.esgn eq null || empVO.esgn eq '' }">
						            	<img id="signaturePreview" src="${pageContext.request.contextPath }/resources/logo/승인_20240729.jpg" alt="서명 이미지">
						            </c:if>
						            
						            
						            
						            
						            
						            <input class="form-control" type="file" id="esgn" accept="image/png, image/jpeg" onchange="encodeFileToBase64(this, 'esgnBase64')">
						            <input type="hidden" id="esgnBase64" name="esgn">
						        </div>
						    </div>
						
						    <div class="bottom-section">
						        <div class="bottom-left">
						            <label for="emplId">아이디</label>
						            <input class="form-control" type="text" id="emplId" value="${empVO.emplId }" name="emplId"  required minlength="8" maxlength="8">
						
						            <label for="emplPswd">비밀번호</label>
						            <input class="form-control" type="password" id="emplPswd" value="" name="emplPswd" required minlength="4" maxlength="20">
						
						            <label for="email">이메일</label>
						            <input class="form-control" type="email" id="email" value="${empVO.email }" name="email" required>
						
						            <label for="telno">연락처</label>
						            <input class="form-control" type="tel" id="telno" value="${empVO.telno }" name="telno" required pattern="^\d{3}-\d{3,4}-\d{4}$">
						
						            <label for="rrno">주민등록번호</label>
						            <input class="form-control" type="text" id="rrno" value="${empVO.rrno }" name="rrno" required pattern="\d{6}-\d{7}">
						        </div>
						        <div class="bottom-right">
						            <label for="zip">우편번호</label>
						            <button type="button"  onclick="sample6_execDaumPostcode()">주소검색</button>
						            <input class="form-control" type="text" id="zip" name="zip" value="${empVO.zip }" required pattern="\d{5}">
						
						            <label for="bscAddr">주소</label>
						            <input class="form-control" type="text" id="bscAddr" name="bscAddr" value="${empVO.bscAddr }" required>
						
						            <label for="dtlAddr">상세주소</label>
						            <input class="form-control" type="text" id="dtlAddr" name="dtlAddr" value="${empVO.dtlAddr }">
						
						            <h5>관리자권한</h5>
						            <div class="form-check">
						                <input type="radio" name="authList[0].auth" class="form-check-input" value="ROLE_MEMBER" ${empVO.authList[0].auth == 'ROLE_MEMBER' ? 'checked' : ''}>
						                <label class="form-check-label">사용자</label>
						            </div>
						            <div class="form-check">
						                <input type="radio" name="authList[0].auth" class="form-check-input" value="ROLE_ADMIN" ${empVO.authList[0].auth == 'ROLE_ADMIN' ? 'checked' : ''}>
						                <label class="form-check-label">관리자</label>
						            </div>
						            
						            <c:if test="${update != null }">
						            <br>
						            <div class="form-check form-switch">
									    <label class="form-check-label" for="rsgntnYmd">퇴사처리</label>
									    <input type="checkbox" name="rsgntnYmd" class="form-check-input" id="rsgntnYmd" ${empVO.rsgntnYmd != null ? 'checked' : '' }>
									</div>
									</c:if>
						        </div>
						    </div>
							<div class="button-section">
						 	
							 	<c:set value="등록" var="btnValue"/>
		                        <c:if test="${update != null }">
			                        <c:set value="수정" var="btnValue"/>
				                </c:if>
				                
						    	<input class="btn btn-primary" type="submit" value="${btnValue }">
						        <input class="btn btn-danger" id="cancelBtn" type="button" value="취소">
						    </div>
						    
						    <sec:csrfInput/>
						</form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

$(function() {
    $("#empVOInsertBtn").on("click", function() {
        // Set the 입사 날짜 (join date) to today's date
        var today = new Date();
        var dateStr = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
        $("#jncmpYmd").val(dateStr);

        // Set values for other input fields
        $("#emplNm").val("홍길동"); // 사원이름
        $("#deptCd").val("DEPT_01"); // 부서 선택 (보안사업부)
        $("#positionCd").val("POSITION01"); // 직급 선택 (인턴)
        $("#emplId").val("20251212"); // 아이디
        $("#emplPswd").val("1234"); // 비밀번호
        $("#email").val("example@example.com"); // 이메일
        $("#telno").val("010-1234-5678"); // 연락처
        $("#rrno").val("860824-1655067"); // 주민등록번호
        $("#zip").val("34908"); // 우편번호
        $("#bscAddr").val("대전광역시 중구 계룡로 846"); // 기본주소
        $("#dtlAddr").val("305호"); // 상세주소



        // Check the appropriate user role
        $('input[name="authList[0].auth"][value="ROLE_MEMBER"]').prop('checked', true); // 사용자 권한 설정
    });
});

function encodeFileToBase64(fileInput, hiddenInputId) {
    const file = fileInput.files[0];
    const reader = new FileReader();
    reader.onloadend = function () {
        document.getElementById(hiddenInputId).value = reader.result;
        if (hiddenInputId == "proflImageBase64") {
        	$("#profilePreview").attr("src", reader.result);
		}
        if (hiddenInputId == "esgnBase64") {
        	$("#signaturePreview").attr("src", reader.result);
		}
    }
    reader.readAsDataURL(file);
}



function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = ''; // 주소 변수

            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            $("#zip").val(data.zonecode);
            $("#bscAddr").val(addr);
            document.getElementById("dtlAddr").focus();
        }
    }).open();
}


</script>