<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
    <script>
        $(document).ready(function() {
        	
            // 초기 설정
            $('.no').first().text('1');
            
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

            // 폼 요소를 비활성화하는 함수
            function disableFormElements() {
                $("input[name='survTtlNm']").attr("disabled", true);
                $("textarea[name='survCn']").attr("disabled", true);
                $("input[name='survEndDt']").attr("disabled", true);
                $("input[name^='questions'][name$='qstnCn']").attr("disabled", true);
                $("input[name^='questions'][name$='qitemCn']").attr("disabled", true);
            }

            // surveyVO가 존재하면 폼 요소를 비활성화
                disableFormElements();

            // 문항 클릭 이벤트 처리
            $(document).on('click', '.answerCn', function() {
                var $this = $(this);
                var $question = $this.closest('.question');

                // 해당 질문의 모든 문항에서 클래스 제거
                $question.find('.answerCn').removeClass('bg-primary p-2 text-dark bg-opacity-25');

                // 클릭한 문항에 클래스 추가
                
                if ( $question.find('.answerCn').hasClass('bg-primary p-2 text-dark bg-opacity-25')) {
               		$question.find('.answerCn').removeClass('bg-primary p-2 text-dark bg-opacity-25');
               	} else {
	                $this.addClass('bg-primary p-2 text-dark bg-opacity-25');
               	}
            });

            // 설문 참가 버튼 클릭 이벤트 처리
            $('#joinBtn').on('click', function() {
                var unansweredQuestions = [];
                var surveyData = {
                    surveyNo: '${surveyVO.survNo}',
                    answers: []
                };
                
                console.log('surveyData', surveyData)

                $('.question').each(function() {
                    var $question = $(this);
                    var questionNo = $question.find('.no').data('qno');
                    var $selectedAnswer = $question.find('.answerCn.bg-primary');

                    if ($selectedAnswer.length === 0) {
                        unansweredQuestions.push(questionNo);
                    } else {
                        var answerNo = $selectedAnswer.closest('.answer').data('ano');
                        surveyData.answers.push({
                            questionNo: questionNo,
                            answerNo: answerNo
                        });
                    }
                });

                if (unansweredQuestions.length > 0) {
                    alert('모든 질문에 응답하지 않았습니다' );
                    
                } else {
                	
                	console.log("surveyData",surveyData);
                    // AJAX로 설문 참가 데이터를 서버로 전송
                    $.ajax({
                        url: '/egg/survey/submitSurvey',
                        type: 'POST',
                        beforeSend: function(xhr) { // 데이터 전송 전, 헤더에 csrf 값 설정
                            xhr.setRequestHeader(header, token);
                        },
                        contentType: 'application/json',
                        data: JSON.stringify(surveyData),
                        success: function(response) {
                            window.location.href = '/egg/survey/surveyMain';
                        },
                        error: function(error) {
                            alert('설문 참가 중 오류가 발생하였습니다.');
                        }
                    });
                }
            });
        });
    </script>
    <style>
        .bg-primary.p-2.text-dark.bg-opacity-25 {
            background-color: rgba(0, 123, 255, 0.25);
            padding: 0.5rem;
            color: #212529;
        }
    </style>
</head>

<body>
    <form action="/survey/insertSurvey" method="post">
        <div class="content">
            <div class="row">
                <div class="col-12">
                    <div class="page-title-box">

                    </div>
                </div>
            </div>
            <fieldset>
                <legend><i class="mdi mdi-account-circle me-1"></i>설문정보</legend>
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
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane show active" id="main">
                            <div class="col-12">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-xl-6">
                                            <div class="mb-3">
                                                <label for="survTtlNm" class="form-label">설문제목</label>
                                                <input type="text" id="survTtlNm" name="survTtlNm" class="form-control" placeholder="제목을 입력해주세요" value="${surveyVO.survTtlNm}" />
                                            </div>
                                            <div class="mb-3">
                                                <label for="survCn" class="form-label">설문내용</label>
                                                <textarea id="survCn" name="survCn" class="form-control" rows="5" placeholder="설문 정보를 입력해주세요">${surveyVO.survCn}</textarea>
                                            </div>
                                            <div class="mb-3">
                                                <label for="survEndDt" class="form-label">마감일</label>
                                                <input type="date" id="survEndDt" name="survEndDt" class="form-control" value="${surveyVO.survEndDt}" />
                                            </div>
                                        </div>
                                        <div class="col-xl-6" style="display:flex;flex-wrap: wrap;">
                                            <div class="mb-10">
                                                <div class="col-11">
                                                    <c:if test="${surveyVO.survNo == null || surveyVO.survNo == ''}">
                                                        <!-- 추가 콘텐츠를 여기에 삽입 -->
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
                                            <c:if test="${surveyVO.survNo != null && surveyVO.survNo != ''}">
                                                <c:forEach var="question" items="${surveyVO.questions}" varStatus="qstnStatus">
                                                    <div class="question col-md-6">
                                                        <div class="row" >
                                                            <div>	<!--  CSS 수정  -->
                                                                <label><span class="no" data-qno="${question.qstnNo}">${question.qstnDispOrd}</span>) </label>
                                                                <input type="text" placeholder="설문내용을 입력해주세요" value="${question.qstnCn}" name="questions[${qstnStatus.index}].qstnCn" class="questCn form-control shadow-sm p-2 mb-2 rounded" />
                                                            </div>
                                                            <div class="answer-list">
                                                                <c:forEach var="answer" items="${question.answers}" varStatus="ansStatus">
                                                                    <div class="answer" data-ano="${answer.qitemNo}" style="margin-left: 30px;">
                                                                        <div>
                                                                            <div style="display: flex;" class="">
                                                                                <span class="as_no">${answer.qitemDispOrd}  </span>.
                                                                                <span name="questions[${qstnStatus.index}].answers[${ansStatus.index}].qitemCn" class="answerCn form-control">  ${answer.qitemCn} </span>
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
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="text-center">
                        <button type="button" id="checkBtn" class="btn btn-primary" style="margin-top: 20px;">뒤로가기</button>
                        <button type="button" id="joinBtn" class="btn btn-dark" style="margin-top: 20px;">설문 참가</button>
                    </div>
                </div>
            </fieldset>
        </div>
    </form>
</body>
</html>
