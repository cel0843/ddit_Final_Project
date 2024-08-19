<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<c:set var="participantCount" value="${fn:length(ptcpList)}" />
	<c:set var="emplcnt" value="${emplcnt}" />
	
<!-- 직원 리스트 모달 -->

<div class="modal fade" id="employeeModal" tabindex="-1" aria-labelledby="employeeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="employeeModalLabel">직원 리스트</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" data-simplebar style="max-height: 500px;">
                <div id="employeeList" class="list-group">
                    <!-- 직원 리스트 항목들 -->
                    <c:forEach var="employee" items="${employeeList}">
                        <label class="list-group-item">
                            <input type="checkbox" class="form-check-input me-1 employee-checkbox" data-empl-id="${employee.emplId}" data-empl-name="${employee.emplNm}">
                            ${employee.emplNm} - ${employee.emplId}
                        </label>
                    </c:forEach>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="registerEmployeesBtn">등록</button>
            </div>
        </div>
    </div>
</div> 	
	
	
	
<script>

    var participantCount = <c:out value="${participantCount}" />;
    var emplCount = <c:out value="${emplcnt}" />;   
    
        console.log("Total number of participants: " + participantCount); 
        console.log("Total number of emplcnt: " + emplCount); 
          
        var seq_QT = 0; 
        var selectedEmployees = [];
        var questionAnswers = {}; // 질문에 대한 항목 리스트를 관리하는 객체 @@
        function checkAnswer(button) {
            const answerDiv = button.closest('.answer');
            const answerNumber = answerDiv.querySelector('.as_no').textContent.trim();
            
            const rowDiv = button.closest('.row');
            const questionNumber = rowDiv.querySelector('.no').textContent.trim();

            console.log('질문 번호:', questionNumber);
            console.log('문항 번호:', answerNumber);
        }
        
        function addQuestionWithEmployees() {
            var questionList = $('#question-list');
            var questionTemplate = $('#question-template').html();
            var newQuestion = $('<div class="question col-md-6"></div>').html(questionTemplate);

            // "우수사원을 뽑아주세요" 설정
            newQuestion.find('input[name="questions[][qstnCn]"]').val("우수사원을 뽑아주세요");
            var answerList = newQuestion.find('.answer-list');

            var questionIndex = $('#question-list .question').length + 1;
            questionAnswers[questionIndex] = [];

            selectedEmployees.forEach(function(employee, index) {
                var answerTemplate = $('#answer-template').html();
                var newAnswer = $('<div></div>').html(answerTemplate);
//                 var newAnswer = $('<div class="answer"></div>').html(answerTemplate);
                newAnswer.find('input[name="questions[][answers][][qitemCn]"]').val(employee.emplName + "-" +employee.emplId);
                newAnswer.find('.as_no').text(index + 1);
                answerList.append(newAnswer);
				
	                // 질문에 대한 항목 리스트에 추가
	                questionAnswers[questionIndex].push({
	                    qitemCn: employee.emplName + "-" +employee.emplId
	                });
            });

            questionList.append(newQuestion);
            
            console.log(questionAnswers)
            updateQuestionNumbers();
            questionAnswers = [];

        }
        $(document).ready(function() {
        	 var survNo = "${surveyVO.survNo}";
        	 
        	 
             $('#registerEmployeesBtn').on('click', function() {
                 selectedEmployees = [];
                 $('#question-list .question').first().remove();
                 $('#employeeList .employee-checkbox:checked').each(function() {
                     var emplId = $(this).data('empl-id');
                     var emplName = $(this).data('empl-name');
                     selectedEmployees.push({emplId: emplId, emplName: emplName});
                 });
					
                 
                 $('#employeeModal').modal('hide');
                 addQuestionWithEmployees();
             });

        	
        	$('.categoryList').on('click', '.inbox-item.categories', function() {
                var categoryText = $(this).text();
                $('#survCat').val(categoryText);
                
                if(categoryText =="우수사원"){
                		// 위로 올려서 빨리 리턴하기 	
	               	 $.ajax({
	                     url: "/survey/checkSurvey",
	                     type: "GET",
	                     contentType: "application/json",
	                     dataType: "json",
	                     success: function(response) {
	                    	 // 우수사원 등록일의 해당 설문유무  체크
	                    	 if (response.status === "failed") {
                    			alert("이미 이번달의 우수사원 설문조사가 있거나 진행 중 입니다.");
                    			$('#survCat').val("");
                    			return;
			                } else {
				               	$('#employeeModal').modal('show');
			                    $('#sur_1').val("이번달의 우수사원을 선택해 주세요");
			                }
	                    	 
	                    	 
	                     }
	             	});	
                }else{
                	$('#sur_1').val("");
                }
            });
        	
        	// 설문 참가 통계 
        	var percentage = Math.ceil((participantCount / emplCount) * 100);
       	    var seriesData = [percentage];  
       	    var seriesLabels = ["Percent"];  // 원하는 라벨 값으로 변경
       	    renderGradientChart(seriesData, seriesLabels);
        	// 설문 참가 통계  
        	
        	// 질문 통계 
        	// 설문 데이터 
        	var ordNo = 1;		// 설문 질문 번호 
  		    var questionLabels = [];
  		    var questionData = [];	// 개수 

        	 $.ajax({
                    url: "/survey/" + survNo + "/selectResponCntSurvey",
                    type: "GET",
                    contentType: "application/json",
                    dataType: "json",
                    success: function(data) {
                        console.log(data);
                    	
                        data.forEach(function(res) {
                        	console.log(res)
                        	if(ordNo != res.QSTN_DISP_ORD){
                      		    console.log(questionLabels, questionData)
                        		renderSimpleDonutChart(questionLabels, questionData, ordNo);
                        		questionLabels = [];
                        		questionData = [];
                        		
                        	}
                        	ordNo = res.QSTN_DISP_ORD
                        	questionLabels.push(res.QITEM_CN)
                        	questionData.push(res.RESPONSE_COUNT)
                        	
                        });
		                renderSimpleDonutChart(questionLabels, questionData, ordNo);
                        
                    	
                    }
            });
        	
            $('.no').first().text('1');

            $('#insertBtn').on('click', function() {
                submitSurvey();
            });
            $('#checkBtn').on('click', function() {
            	 window.history.back();
            });
            
            
            
            
            function formatDate(dateString) {
                var date = new Date(dateString);
                var year = date.getFullYear();
                var month = ("0" + (date.getMonth() + 1)).slice(-2);
                var day = ("0" + date.getDate()).slice(-2);
                return year + "-" + month + "-" + day;
            }

            // 서버에서 받아온 날짜 값을 변환하여 input 요소에 설정
            var survEndDt = "${surveyVO.survEndDt}";
            if (survEndDt) {
                $("input[name='survEndDt']").val(formatDate(survEndDt));
            }

            function submitSurvey() {
                var survTtlNmObj = $("input[name='survTtlNm']");
                var survTtlNm = $("input[name='survTtlNm']").val();

                var survCnObj = $("textarea[name='survCn']");
                var survCn = $("textarea[name='survCn']").val();

                var survEndDtObj = $("input[name='survEndDt']");
                var survEndDt = $("input[name='survEndDt']").val();

                var survCatObj = $("input[name='survCat']");
                var survCat = $("input[name='survCat']").val();

                if (survTtlNm == "" || survTtlNm == null) {
                    survTtlNmObj.focus();
                    return;
                }

                if (survCn == "" || survCn == null) {
                    survCnObj.focus();
                    return;
                }

                if (survEndDt == "" || survEndDt == null) {
                    survEndDtObj.focus();
                    return;
                }
                if (survCat == "" || survCat == null) {
                	survCatObj.val("기타");
                    return;
                }

                var today = new Date();
                today.setHours(0, 0, 0, 0); 

                var inputDate = new Date(survEndDt);

                if (inputDate < today) {
                    alert("마감일은 오늘보다 빠를 수 없습니다.");
                    survEndDtObj.focus();
                    return;
                }

                var surveyData = {
                    survTtlNm: $("input[name='survTtlNm']").val(),
                    survCn: $("textarea[name='survCn']").val(),
                    survEndDt: $("input[name='survEndDt']").val(),
                    survCat: $("input[name='survCat']").val(),
                    questions: []
                };
                
                var valid = true; // 유효성 검사 플래그
                var firstInvalidElement = null; // 첫 번째로 유효하지 않은 요소를 저장
                let aa = $('#question-list .question');
                console.log(aa)
                $('#question-list .question').each(function(index) {
                    let qstnCnObj = $(this).find("input[name='questions[][qstnCn]']");
                    let qstnCn = qstnCnObj.val();
                    
                    if (qstnCn === "" || qstnCn == null) {
                        if (!firstInvalidElement) {
                            firstInvalidElement = qstnCnObj;
                        }
                        valid = false;
                        return false; // jQuery each 루프 중단
                    }

                    var questionData = {
                        qstnCn: qstnCn,
                        answers: []
                    };

                    $(this).find('.answer').each(function() {
                        let qitemCnObj = $(this).find("input[name='questions[][answers][][qitemCn]']");
                        let qitemCn = qitemCnObj.val();
                        
                        if (qitemCn === "" || qitemCn == null) {
                            if (!firstInvalidElement) {
                                firstInvalidElement = qitemCnObj;
                            }
                            valid = false;
                            return false; // jQuery each 루프 중단
                        }

                        var answerData = {
                            qitemCn: qitemCn
                        };
                        questionData.answers.push(answerData);
                        
                    });
                    

                    if (!valid) return false; // 내부 루프에서 유효성 검사 실패 시 외부 루프 중단

                    surveyData.questions.push(questionData);
                });

                if (!valid) {
                    if (firstInvalidElement) {
                        firstInvalidElement.focus();
                    }
                    return; // 유효성 검사 실패 시 함수 종료
                }

                console.log("submitSurvey", surveyData);

                $.ajax({
                    url: "/survey/insertSurvey",
                    type: "POST",
                    beforeSend: function(xhr) { // 데이터 전송 전, 헤더에 csrf 값 설정
                        xhr.setRequestHeader(header, token);
                    },
                    contentType: "application/json",
                    data: JSON.stringify(surveyData),
                    success: function(res) {
                        if (res == "success") {
                            window.location.href = "/survey/surveyMain"; // 성공 시 이동할 페이지의 URL로 변경
                        } else {
                            alert(res);
                        }
                    },
                    error: function(error) {
                        alert("Error submitting survey.");
                    }
                });
            }
        });

        // 질문 추가 
        function addQuestion() {
            var questionTemplate = $('#question-template').html();
            var questionList = $('#question-list');
            var newQuestion = $('<div class="question col-md-6"></div>').html(questionTemplate);
            questionList.append(newQuestion);
            seq_QT++;
            updateQuestionNumbers();
            console.log("질문추가");
        }

        // 문항 추가 
        function addAnswer(buttonElem) {
            var questionElem = $(buttonElem).closest('.question');
            var questionIndex = $('#question-list .question').index(questionElem) + 1;
            if (!questionAnswers[questionIndex]) {
                questionAnswers[questionIndex] = [];
            }
            if (questionAnswers[questionIndex].length >= 4) {
                console.log("4개 이상입니다.", questionAnswers[questionIndex].length);
                let survCat = $("input[name='survCat']").val();
                if(survCat !== "우수사원") {
                	
                    alert("질문의 최대치는 4개입니다.");
                    return false;
                } else {
                	
                    console.log("우수사원인 경우 문항 추가 허용");
                }
            }
            var answerTemplate = $('#answer-template').html();
            var answerList = questionElem.find('.answer-list');
            var newAnswer = $('<div></div>').html(answerTemplate);
            answerList.append(newAnswer);
            questionAnswers[questionIndex].push(newAnswer); // 항목 리스트에 새로운 항목 추가
            updateAnswerNumbers(questionElem);

            console.log('문항 리스트 ', questionAnswers);
        }

        function updateQuestionNumbers() {
            $('#question-list .question').each(function(index) {
                $(this).find('.no').text(index + 1);
            });
        }

        function updateAnswerNumbers(questionElem) {
            questionElem.find('.answer').each(function(index) {
                $(this).find('.as_no').text(index + 1);
            });
        }

        // 항목 삭제 
        function delAnswer(buttonElem) {
            var answerElem = $(buttonElem).closest('.answer');
            var questionElem = $(buttonElem).closest('.question');
            var questionIndex = $('#question-list .question').index(questionElem) + 1;

            console.log('문항? 항목 삭제 리스트 ', questionAnswers[questionIndex]);
            var answerIndex = questionElem.find('.answer-list .answer').index(answerElem);
            questionAnswers[questionIndex].splice(answerIndex, 1); // 항목 리스트에서 해당 항목 제거
            answerElem.remove();

            updateAnswerNumbers(questionElem);
        }

        // 질문 삭제 
        function delQuestion(buttonElem) {
            var questionElem = $(buttonElem).closest('.question');
            var questionIndex = $('#question-list .question').index(questionElem) + 1;

            // 삭제된 질문 번호 이후의 질문들을 앞으로 한 칸씩 이동
            var i;
            for (i = questionIndex; i < seq_QT; i++) {
                questionAnswers[i] = questionAnswers[i + 1];
            }
            delete questionAnswers[i]; // 마지막 요소 삭제
            questionElem.remove();
            updateQuestionNumbers();
            updateQuestionAnswers();
            console.log('delQuestion', questionAnswers);
        }

        // 질문 객체 업데이트 
        function updateQuestionAnswers() {
            var updatedQuestionAnswers = {};
            $('#question-list .question').each(function(index) {
                updatedQuestionAnswers[index + 1] = questionAnswers[index + 1];
            });
            questionAnswers = updatedQuestionAnswers;
            seq_QT = Object.keys(updatedQuestionAnswers).length + 1;
        }
    </script>
</head>

<body>
    <form:form action="/survey/insertSurvey" method="post" modelAttribute="surveyVO">
        <div class="content">
            <div class="row">
                <div class="col-12">
                    <div class="page-title-box">
                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                            </ol>
                        </div>
                        <c:if test="${surveyVO.survNo == null || surveyVO.survNo == '' }">
                            <h2 class="page-title">새로운 설문 등록</h2>
                        </c:if>
                    </div>
                </div>
            </div>
            <div>
                <legend><i class="mdi mdi-account-circle me-1"></i>설문 정보</legend>
                <div class="card">
                    <ul class="nav nav-tabs mb-3">
                        <li class="nav-item">
                            <a href="#main" data-bs-toggle="tab" aria-expanded="true" class="nav-link active">
                                <i class="mdi mdi-home-variant d-md-none d-block"></i>
                                <span class="d-none d-md-block">내용</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="#survey" data-bs-toggle="tab" aria-expanded="false" class="nav-link">
                                <i class="mdi mdi-account-circle d-md-none d-block"></i>
                                <span class="d-none d-md-block">설문지</span>
                            </a>
                        </li>
                        <c:if test="${ptcpList != null }">
                            <li class="nav-item">
                                <a href="#statistics" data-bs-toggle="tab" aria-expanded="false" class="nav-link">
                                    <i class="mdi mdi-account-circle d-md-none d-block"></i>
                                    <span class="d-none d-md-block">설문 통계</span>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane show active" id="main">
                            <div class="col-12">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-xl-6">
                                            <div class="mb-3">
                                                <form:label path="survTtlNm" class="form-label">설문제목</form:label>
                                                <form:input path="survTtlNm" class="form-control" placeholder="제목을 입력해주세요"  />
                                            </div>
                                            <div class="mb-3">
                                                <form:label path="survCn" class="form-label">설문내용</form:label>
                                                <form:textarea path="survCn" class="form-control" rows="5" placeholder="설문 정보를 입력해주세요"   />
                                            </div>
                                            <div class="mb-3">
                                                <form:label path="survEndDt" class="form-label">마감일</form:label>
                                                <form:input path="survEndDt" type="date" class="form-control" />
                                            </div>
	                                        <c:if test="${category == null || surveyVO.survCat != null }">
	                                           <div class="mb-3">
	                                               <form:label path="survCat" class="form-label">카테고리</form:label>
	                                               <form:input path="survCat"  class="form-control"  />
	                                           </div>
	                                        </c:if>
                                        </div>
                                        <div class="col-xl-6" style="display:flex;flex-wrap: wrap;">
                                            <div class="mb-10">
                                                <div class="col-11">
                                                        <c:if test="${surveyVO.survNo == null || surveyVO.survNo == '' }">
                                                            <fieldset>
                                                                <legend><span>주의사항</span></legend>
                                                                <span>제목은 30자 이하입니다.</span> <br>
                                                                <span>내용은 150자 이하입니다.</span> <br>
                                                                <span>시작일은 등록일자와 같습니다.</span> <br>
                                                                <span>우수사원 카테고리 선택시 <br>
                                                                	  [사원이름 - 사원번호] 양식으로 추가 가능합니다. </span> <br>
                                                            </fieldset>
                                                        </c:if>
                                                         <br>
                                                         <c:if test="${surveyVO.survNo == null || surveyVO.survNo == ''}">
	                                                        <div class="card">
		                                                        <div class="card-body pb-0">
			                                                        <div class="d-flex justify-content-between align-items-center mb-2">
		                                                            	<h4 class="header-title">카테고리 목록</h4>
			                                                        </div>
			                                                        <c:if test="${ not empty categoryList }">
		                                                                <div class="inbox-widget categoryList">
				                                                        	<c:forEach items="${categoryList }" var="category">
				                                                        			<div class="inbox-item categories">${ category.survCat }</div>
				                                                        	</c:forEach>
			                                                        	</div>
                                                       				 </c:if>	<!-- if문 수정함 -->
                                                                </div>
		                                                        <c:if test="${empty categoryList}">
															        <p>No categories available.</p>
															    </c:if>
	                                                        </div>
                                                        </c:if>
                                                        
                                                    </div>
                                                       <c:if test="${surveyVO.survNo != null || surveyVO.survNo != '' }">
                                                           <legend><span>참고사항</span></legend>
                                                           <span> 참여인원이 존재시 통계란이 생성됩니다.  </span>
                                                       </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="survey">
                            <div class="row">
                                <div class="col-12">
                                    <div class="card-body card">
                                        <div id="question-list" class="row">
                                            <c:if test="${surveyVO.survNo == null || surveyVO.survNo == '' }">
                                                <div class="question col-md-6">
                                                    <div class="row">
                                                        <div>
                                                            <label><span class="no"></span>) </label>
                                                            <input type="text" placeholder="설문내용을 입력해주세요" maxlength="15" required="required" class="questCn form-control shadow-sm p-2 mb-2 rounded" id="sur_1" name="questions[][qstnCn]" />
                                                        </div>
                                                        <div class="answer-list"></div>
                                                        <div style="text-align-last: center;">
                                                            <button type="button" style="margin: 20px;" class="btn btn-secondary" onclick="addAnswer(this)">문항 추가</button>
                                                            <button type="button" style="margin: 20px;" class="btn btn-danger" onclick="delQuestion(this)">질문 삭제</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:if test="${surveyVO.survNo != null || surveyVO.survNo != ''}">
                                                <c:forEach var="question" items="${surveyVO.questions}" varStatus="qstnStatus">
                                                    <div class="question col-md-6">
                                                        <div class="row">
                                                            <div>
                                                                <label><span class="no">${question.qstnDispOrd}</span>) </label>
                                                                <form:input type="text" placeholder="설문내용을 입력해주세요 " value="${question.qstnCn }" path="questions[${qstnStatus.index}].qstnCn" class="questCn form-control shadow-sm p-2 mb-2 rounded" />
                                                            </div>
                                                            <div class="answer-list">
                                                                <c:forEach var="answer" items="${question.answers}" varStatus="ansStatus">
                                                                    <div class="answer" style="margin-left: 30px;">
                                                                        <div>
                                                                            <div style="display: flex;">
                                                                                [<span class="as_no">${answer.qitemDispOrd}</span>]
                                                                                <form:input type="text" value="${answer.qitemCn }" path="questions[${qstnStatus.index}].answers[${ansStatus.index}].qitemCn" class="answerCn form-control" placeholder="문항내용을 입력해주세요"/>
<%--                                                                                 <form:input type="text" value="${answer.qitemCn }" path="questions[${qstnStatus.index}].answers[${ansStatus.index}].qitemCn" class="answerCn form-control" placeholder="문항내용을 입력해주세요" disabled/> --%>
                                                                                <button type="button" class="btn btn-black .bg-black.bg-gradient" onclick="checkAnswer(this)">@</button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                    </div>
                                    	<c:if test="${surveyVO.survNo eq null || surveyVO.survNo eq '' }">
	                                        <div class="text-center">
		                                        <button type="button" class="btn btn-secondary .bg-secondary.bg-gradient" onclick="addQuestion()">질문 추가</button>
	                                    	</div>	
                                    	</c:if>
                                </div>
                            </div>
                        </div>
                        <c:if test="${ ptcpList != null }">
                            <div class="tab-pane" id="statistics">
                                <!-- 참가자 설문 현황 -->
                                <!-- 설문 질문 리스트 띄우고  -->
                                <c:if test="${surveyVO.survNo ne null || surveyVO.survNo ne ''}">
                                	<div class="row col-12">
	                                	<div class="col-6">
	                                    <c:forEach var="question" items="${surveyVO.questions}" varStatus="qstnStatus">    
	                                        <div class="accordion" id="CardaccordionExample${question.qstnDispOrd}">
	                                            <div class="card mb-0">
	                                                <div class="card-header" id="Cardheading${question.qstnDispOrd}">
	                                                    <h5 class="m-0">
	                                                        <a class="custom-accordion-title d-block pt-2 pb-2"
	                                                            data-bs-toggle="collapse" href="#collapse${question.qstnDispOrd}"
	                                                            aria-expanded="true" aria-controls="collapseOne" data-order="${question.qstnDispOrd}">
	                                                            ${question.qstnCn} #${question.qstnDispOrd}
	                                                        </a>
	                                                    </h5>
	                                                </div>
	                                                <div id="collapse${question.qstnDispOrd}" class="collapse show"
	                                                    aria-labelledby="Cardheading${question.qstnDispOrd}" data-bs-parent="#CardaccordionExample${question.qstnDispOrd}">
	                                                    <div class="card-body pt-0">
	                                                        <div class="">
	                                                        	<h4 class="header-title">응답 비율</h4>
							                                    <div dir="ltr">
							                                        <div id="simple-donut-${question.qstnDispOrd}" class="apex-charts" ></div>
							                                    </div>
	                                                        	
	                                                        </div>
	                                                        <div class="col-6">
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </c:forEach>
	                                	</div>
	                                    <div class="col-6">
											<div class="card-body">
	                                    		<h4 class="header-title mb-4">설문 참여율</h4>
			                                    <div dir="ltr">
			                                        <div id="gradient-chart" class="apex-charts" data-colors="#8f75da,#727cf5"></div>
			                                    </div>
	                                		</div>
	                                  	</div>
	                               	</div>
                                </c:if>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="text-center">
                <button type="button" id="checkBtn" class="btn btn-primary" style="margin-top: 20px;">뒤로가기</button>
                <!--  뒤로가기  -->
                <c:if test="${surveyVO.survNo == null || surveyVO.survNo == '' }">
                    <button type="button" id="insertBtn" class="btn btn-primary" style="margin-top: 20px;">설문 등록</button>
                </c:if>
            </div>
        </div>
    </form:form>
	
	
    <script type="text/template" id="question-template">
        <div>
            <div>
                <div>
                    <label><span class="no"> </span>)</label>
                    <input name="questions[][qstnCn]" type="text" class="questCn form-control shadow-sm p-2 mb-2 rounded" placeholder="설문내용을 입력해주세요" />
                </div>
                <div class="answer-list"></div>
            </div>
            <div style="text-align-last: center;">
                <button type="button" style="margin: 20px;" class="btn btn-secondary .bg-secondary.bg-gradient" onclick="addAnswer(this)">문항 추가</button>
                <button type="button" style="margin: 20px;" class="btn btn-danger" onclick="delQuestion(this)">질문 삭제</button>
            </div>
        </div>
    </script>

    <script type="text/template" id="answer-template">
        <div class="answer" style="margin-left: 30px;">
            <div>
                <div style="display: flex;">
                    [<span class="as_no"> </span>]
                    <input name="questions[][answers][][qitemCn]" type="text" class="answerCn form-control" placeholder="문항내용을 입력해주세요" />
                    <button type="button" class="btn btn-black .bg-black.bg-gradient" onclick="delAnswer(this)">X</button>
                </div>
            </div>
        </div>
    </script>
    
    
</body>

	
</html>
