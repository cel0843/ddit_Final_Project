<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- SimpleMDE css -->
<link href="${pageContext.request.contextPath}/resources/assets/vendor/simplemde/simplemde.min.css" rel="stylesheet" type="text/css" />
<style>
    .form-group {
        display: flex;
        align-items: center;
        margin-bottom: 1rem;
    }
    .form-group label {
        min-width: 100px;
        margin-right: 1rem;
    }
    .form-group input, 
    .form-group select,
    .form-group .form-control-file {
        flex: 1;
    }
    .form-group .form-check-input {
        flex: none;
        margin-right: 0.5rem;
    }
    .form-group .form-check-label {
        flex: none;
        margin-right: 1rem;
    }
    .full-width {
        display: flex;
        flex: 1;
    }
    .full-width input[type="text"] {
        flex: 1;
    }
    .icon-links {
        display: flex;
        gap: 1rem;
        margin-bottom: 1rem;
    }
    .icon-links a {
        color: black;
        text-decoration: none;
    }
    .icon-links a:hover {
        color: blue;
        text-decoration: underline;
    }
    .separator {
        border-bottom: 1px solid #ddd;
        margin-bottom: 1rem;
    }
</style>
</head>
<body>
<div class="container-fluid">
    <!-- start page email-title -->
    <!-- start page title -->
    <div class="row">
        <div class="col-12">
            <div class="page-title-box">
                <div class="page-title-right">
                    <ol class="breadcrumb m-0">
                        <li class="breadcrumb-item"><a href="javascript: void(0);">Hyper</a></li>
                        <li class="breadcrumb-item"><a href="javascript: void(0);">Email</a></li>
                        <li class="breadcrumb-item active">Email Compose</li>
                    </ol>
                </div>
                <h4 class="page-title">Email Compose</h4>
            </div>
        </div>
    </div>
    <!-- end page title -->
    <!-- end page email-title -->

    <div class="row">
        <!-- Right Sidebar -->
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <!-- Left sidebar -->
                    <div class="page-aside-left">
                        <div class="d-grid">
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#compose-modal">Compose</button>
                        </div>
                        <div class="email-menu-list mt-3">
                            <a href="${pageContext.request.contextPath}/egg/mail/reList"><i class="ri-inbox-line me-2"></i>수신메일함<span class="badge badge-info-lighten float-end ms-2">${listCount}</span></a>
                            <a href="${pageContext.request.contextPath}/egg/mail/impoList"><i class="ri-star-line me-2"></i>중요메일함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                            <a href="${pageContext.request.contextPath}/egg/mail/drfList"><i class="ri-article-line me-2"></i>임시보관함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                            <a href="${pageContext.request.contextPath}/egg/mail/sendList"><i class="ri-mail-send-line me-2"></i>보낸 메일함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                            <a href="${pageContext.request.contextPath}/egg/mail/trashList"><i class="ri-delete-bin-line me-2"></i>휴지통<span class="badge badge-info-lighten float-end ms-2"></span></a>
                            <a href="${pageContext.request.contextPath}/egg/mail/mineList"><i class="ri-price-tag-3-line me-2"></i>내게 쓴 메일함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                        </div>
                        
                        
                    </div>
                    <!-- End Left sidebar -->
                    <!-- form -->
                    <div class="page-aside-right">
                        <div class="icon-links">
                            <a href="#" id="sendEmailBtn"><i class="ri-send-plane-fill"></i>보내기</a>
                            <a href="#" id="saveDraftBtn"><i class="ri-briefcase-fill"></i>임시저장</a>
                            <a href="#" id="testbtn"><i class="ri-chat-heart-fill"></i>시연용</a>
                        </div>
                        <div class="separator"></div>
                        <form id="uploadForm" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <div class="form-group">
                                <label for="recipient">받는 사람</label>
                                <input type="checkbox" class="form-check-input" id="customCheck6">
                                <label class="form-check-label" for="customCheck6">나에게</label>
                                <div class="row align-items-center" id="select2-preview">
                                    <div class="col-md-12 mb-2">
                                        <select class="select2 form-control select2-multiple" data-toggle="select2" multiple="multiple" data-placeholder="주소록선택" id="recipientIds">
                                            <optgroup label="보안 사업부">
                                                <c:forEach var="emp" items="${reference}">
                                                    <c:if test="${emp.deptCd == '보안 사업부'}">
                                                        <option value="${emp.emplId}" <c:if test="${param.replyTo == emp.emplId}">selected</c:if>>${emp.positionCd}_ ${emp.emplNm}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </optgroup>
                                            <optgroup label="기술 영업부">
                                                <c:forEach var="emp" items="${reference}">
                                                    <c:if test="${emp.deptCd == '기술 영업부'}">
                                                        <option value="${emp.emplId}" <c:if test="${param.replyTo == emp.emplId}">selected</c:if>>${emp.positionCd}_ ${emp.emplNm}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </optgroup>
                                            <optgroup label="사업부">
                                                <c:forEach var="emp" items="${reference}">
                                                    <c:if test="${emp.deptCd == '사업부'}">
                                                        <option value="${emp.emplId}" <c:if test="${param.replyTo == emp.emplId}">selected</c:if>>${emp.positionCd}_ ${emp.emplNm}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </optgroup>
                                            <optgroup label="QA 사업부">
                                                <c:forEach var="emp" items="${reference}">
                                                    <c:if test="${emp.deptCd == 'QA 사업부'}">
                                                        <option value="${emp.emplId}" <c:if test="${param.replyTo == emp.emplId}">selected</c:if>>${emp.positionCd}_ ${emp.emplNm}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </optgroup>
                                            <optgroup label="인사부">
                                                <c:forEach var="emp" items="${reference}">
                                                    <c:if test="${emp.deptCd == '인사부'}">
                                                        <option value="${emp.emplId}" <c:if test="${param.replyTo == emp.emplId}">selected</c:if>>${emp.positionCd}_ ${emp.emplNm}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </optgroup>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="subject">제목</label>
                                <div class="full-width">
                                    <input type="text" id="subject" class="form-control" name="subject" value="${fn:escapeXml(param.subject)}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="attachments">파일첨부</label>
                                <div class="full-width">
                                    <input class="form-control" type="file" id="attachments" name="attachments" multiple>
                                </div>
                            </div>
                            <!-- 내용입력  -->
                            <div class="mb-3">
                                <label for="example-textarea" class="form-label">내용</label>
                                <textarea class="form-control" id="textId" rows="25">${fn:escapeXml(param.content)}</textarea>
                            </div>
                        </form>
                    </div>
                    <!-- end inbox-rightbar-->
                </div>
                <div class="clearfix"></div>
            </div> <!-- end card-box -->
        </div> <!-- end Col -->
    </div><!-- End row -->
</div>
<!-- SimpleMDE js -->
<%-- <script src="${pageContext.request.contextPath}/resources/assets/vendor/simplemde/simplemde.min.js"></script> --%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>
<script>
$(function(){
    CKEDITOR.replace("textId");
});

document.getElementById('attachments').addEventListener('change', function() {
    var form = document.getElementById('uploadForm');
    var formData = new FormData(form);
    
    fetch('${pageContext.request.contextPath}/egg/mail/upload', {
        method: 'POST',
        headers: {
            'X-CSRF-TOKEN': document.querySelector('input[name="${_csrf.parameterName}"]').value
        },
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            /* alert('파일성공'); */
        } else {
            /* alert('파일실패: ' + data.message); */
        }
    })
    .catch(error => {
        console.error('Error:', error);
        /* alert('File upload failed.'); */
    });
});

// 수정된 부분 시작
document.getElementById('customCheck6').addEventListener('change', function() {
    var recipientSelect = document.getElementById('recipientIds');
    if (this.checked) {
        recipientSelect.disabled = true;
        // Clear selected options
        $(recipientSelect).val(null).trigger('change');
    } else {
        recipientSelect.disabled = false;
    }
});


//시연용 버튼 클릭 이벤트 추가
document.getElementById('testbtn').addEventListener('click', function() {
 document.getElementById('subject').value = '대표님 미팅 일정 참고 사항';
 CKEDITOR.instances.textId.setData('인적사항 참고해주세요<br><br>' +
     '이름 : 최수연<br>' +
     '회사 : 네이버<br>' +
     '직급 : 대표이사<br>' +
     '연락처 : 010-3131-6464<br>' +
     '이메일 : naver0805@naver.com<br>' +
     '비고 : 대표님 24.08.06 미팅 일정 / 경기도 성남시 분당구 정자일로 95 7층 705호<br>');
});

document.getElementById('sendEmailBtn').addEventListener('click', function() {
    var subject = document.getElementById('subject').value;
    var content = CKEDITOR.instances.textId.getData();
    
    var recipientIds = Array.from(document.getElementById('recipientIds').selectedOptions).map(option => option.value);
    
    // 수정된 부분 시작
    if (document.getElementById('customCheck6').checked) {
        var loggedInUserId = '${sessionScope.emplInfo.emplId}';
        recipientIds.push(loggedInUserId);
    }
    // 수정된 부분 끝
    
    var form = document.getElementById('uploadForm');
    var formData = new FormData();
    
    formData.append('subject', subject);
    formData.append('content', content);
    for(let i=0; i< form.attachments.files.length; i++){
	    formData.append('attachments', form.attachments.files[i]);
    }
    recipientIds.forEach(id => formData.append('recipientIds', id));
    
    fetch('${pageContext.request.contextPath}/egg/mail/sendEmail', {
        method: 'POST',
        headers: {
            'X-CSRF-TOKEN': document.querySelector('input[name="${_csrf.parameterName}"]').value
        },
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            /* alert('이메일 성공'); */
            window.location.href = "/egg/mail/reList";
        } else {
            /* alert('이메일 실패: ' + data.message); */
        }
        console.log("메일 고유번호 : " + data.emlNo);
        console.log("메일 전송자 :" + data.emlSenderName);
        
        // 알람 소켓 전송
        let sendAlarmContent = data.emlSenderName + "님으로 부터 새로운 메일이 도착했습니다";
        
        var alarm_msg_to_json = {
            alarmType : "ALARM02",
            alarmTitle : "메일 수신", 
            alarmContent : sendAlarmContent,
            referenceId : data.emlNo,
            referenceInfo : ""
        };

        alarmSock.send(JSON.stringify(alarm_msg_to_json));
        
    })
    .catch(error => {
        console.error('Error:', error);
        /* alert('Email send failed.'); */
    });
});

document.getElementById('saveDraftBtn').addEventListener('click', function() {
    var subject = document.getElementById('subject').value;
    var content = CKEDITOR.instances.textId.getData();

    var form = document.getElementById('uploadForm');
    var formData = new FormData();
    formData.append('subject', subject);
    formData.append('content', content);
    
    fetch('${pageContext.request.contextPath}/egg/mail/saveDraft', {
        method: 'POST',
        headers: {
            'X-CSRF-TOKEN': document.querySelector('input[name="${_csrf.parameterName}"]').value
        },
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            /* alert('임시저장 성공'); */
            window.location.href = "/egg/mail/drfList";
        } else {
            /* alert('임시저장 실패: ' + data.message); */
        }
    })
    .catch(error => {
        console.error('Error:', error);
        /* alert('Draft save failed.'); */
    });
});
</script>
</body>
</html>
