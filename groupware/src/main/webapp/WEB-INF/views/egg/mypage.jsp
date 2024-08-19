<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    input{
    	margin:0px;
    	margin-bottom:20px;
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
		location.href="/egg/main";
	});
});
</script>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h1 class="card-title">내 정보</h1>
                </div>
                <c:set value="${sessionScope.emplInfo}" var="emplInfo"/>
                <div class="card-body">
                    <div class="container">
		                    <form id="employeeForm" action="/egg/mypageInfoUpdate" method="post" onsubmit="return validateForm()">
						    <div class="section">
						        <div class="left">
									<label for="proflImageCours">프로필 이미지</label>
						            <c:if test="${emplInfo.proflImageCours ne null }">
						            	<img id="profilePreview" src="${emplInfo.proflImageCours }" alt="프로필 이미지">
						            </c:if>
						            <c:if test="${emplInfo.proflImageCours eq null || emplInfo.proflImageCours eq '' }">
						            	<img id="profilePreview" src="${pageContext.request.contextPath }/resources/logo/personal_chat_icon.png" alt="프로필 이미지">
						            </c:if>
						            <input class="form-control" type="file" id="proflImageCours" accept="image/png, image/jpeg" onchange="encodeFileToBase64(this, 'proflImageBase64')" >
						            <input type="hidden" id="proflImageBase64" name="proflImageCours">
						        </div>
						        <div class="right">
						            <label for="esgn">서명 이미지</label>
						            <c:if test="${emplInfo.esgn ne null }">
						            	<img id="signaturePreview" src="${emplInfo.esgn}" alt="서명 이미지">
						            </c:if>
						            <c:if test="${emplInfo.esgn eq null || emplInfo.esgn eq '' }">
						            	<img id="signaturePreview" src="${pageContext.request.contextPath }/resources/logo/SIGN.jpg" alt="서명 이미지">
						            </c:if>
						            
						            <input class="form-control" type="file" id="esgn" accept="image/png, image/jpeg" onchange="encodeFileToBase64(this, 'esgnBase64')">
						            <input type="hidden" id="esgnBase64" name="esgn">
						        </div>
						    </div>
						
						    <div class="bottom-section">
						        <div class="bottom-left">
						        	<label for="emplNm">사원이름</label>
						            <input class="form-control" type="text" id="emplNm" name="emplNm" value="${emplInfo.emplNm }" required minlength="2" maxlength="50">
						            <label for="deptCd">부서</label>
						            <select id="deptCd" name="deptCd" required>
									    <option value="">선택하세요</option>
									    <option value="DEPT_01" ${emplInfo.deptCd == 'DEPT_01' ? 'selected' : ''}>보안사업부</option>
									    <option value="DEPT_02" ${emplInfo.deptCd == 'DEPT_02' ? 'selected' : ''}>기술영업부</option>
									    <option value="DEPT_03" ${emplInfo.deptCd == 'DEPT_03' ? 'selected' : ''}>사업부</option>
									    <option value="DEPT_04" ${emplInfo.deptCd == 'DEPT_04' ? 'selected' : ''}>QA사업부</option>
									    <option value="DEPT_05" ${emplInfo.deptCd == 'DEPT_05' ? 'selected' : ''}>인사부</option>
									</select>
						
						            <label for="positionCd">직급</label>
						            <select id="positionCd" name="positionCd" required>
									    <option value="">선택하세요</option>
									    <option value="POSITION06" ${emplInfo.positionCd == 'POSITION06' ? 'selected' : ''}>부장</option>
									    <option value="POSITION05" ${emplInfo.positionCd == 'POSITION05' ? 'selected' : ''}>차장</option>
									    <option value="POSITION04" ${emplInfo.positionCd == 'POSITION04' ? 'selected' : ''}>과장</option>
									    <option value="POSITION03" ${emplInfo.positionCd == 'POSITION03' ? 'selected' : ''}>대리</option>
									    <option value="POSITION02" ${emplInfo.positionCd == 'POSITION02' ? 'selected' : ''}>사원</option>
									    <option value="POSITION01" ${emplInfo.positionCd == 'POSITION01' ? 'selected' : ''}>인턴</option>
									</select>
									
						            <label for="emplId">아이디</label>
						            <input class="form-control" type="text" id="emplId" value="${emplInfo.emplId }" name="emplId"  required minlength="8" maxlength="8">
						
						            <label for="emplPswd">비밀번호</label>
						            <input class="form-control" type="password" id="emplPswd" value="" name="emplPswd" required minlength="4" maxlength="20">
						
						            <label for="email">이메일</label>
						            <input class="form-control" type="email" id="email" value="${emplInfo.email }" name="email" required>

						        </div>
						        <div class="bottom-right">
						        						
						            <label for="telno">연락처</label>
						            <input class="form-control" type="tel" id="telno" value="${emplInfo.telno }" name="telno" required pattern="^\d{3}-\d{3,4}-\d{4}$">
						
						            <label for="rrno">주민등록번호</label>
						            <c:set var = "first_rrno" value = "${fn:substring(emplInfo.rrno, 0, 6)}" />
						            <c:set var = "last_rrno" value = "${fn:substring(emplInfo.rrno, 6, 13)}" />
						            <input class="form-control" type="text" id="rrno" value="${first_rrno }-${last_rrno}" name="rrno" required pattern="\d{6}-\d{7}">
						            
						            <label for="zip">우편번호</label>
						            <button type="button"  onclick="sample6_execDaumPostcode()">주소검색</button>
						            <input class="form-control" type="text" id="zip" name="zip" value="${emplInfo.zip }" required pattern="\d{5}">
						
						            <label for="bscAddr">주소</label>
						            <input class="form-control" type="text" id="bscAddr" name="bscAddr" value="${emplInfo.bscAddr }" required>
						
						            <label for="dtlAddr">상세주소</label>
						            <input class="form-control" type="text" id="dtlAddr" name="dtlAddr" value="${emplInfo.dtlAddr }">
						        </div>
						    </div>
							<div class="button-section">
						    	<input class="btn btn-primary" type="submit" value="저장">
						        <input class="btn btn-danger" id="cancelBtn" type="button" value="뒤로가기">
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
             document.getElementById("dtlAddr").value = "";
             document.getElementById("dtlAddr").focus();
         }
     }).open();
 }


</script>