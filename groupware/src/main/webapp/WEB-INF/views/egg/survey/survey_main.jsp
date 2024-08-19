<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<!-- Flatpickr Timepicker css  -->
<%-- <link href="${pageContext.request.contextPath }/resources/assets/vendor/flatpickr/flatpickr.min.css" rel="stylesheet" type="text/css" /> --%>

<!-- 프로덕트 -->
<script src="${pageContext.request.contextPath}/resources/assets/js/pages/a.products.js"></script>
<script type="text/javascript">

$(function () {
    
	$('#addSurveyBtn').on('click', function() {
		console.log("넣어줘")
		window.location.href = '/survey/surveyInsert';
		
	})
	
	$('#products-datatable').on('click', 'td.survey-title', function() {
		 var surveyNo = $(this).closest('tr').data('survey-no');
           if (surveyNo) {
               window.location.href = '/survey/surveyDetail?surveyNo=' + surveyNo;
           }
    });
		
	
    $('#products-datatable').on('click', '.reloadSurvey', function() {
    	$("#datetime-datepicker").val("");
    	$("#survNo").val("");
        let survNo = $(this).closest('tr').data('survey-no');
        let survtitle = $(this).closest('tr').find('td.survey-title').text().trim(); 
		console.log(survNo + "survtitle"+ survtitle)
		$('#survtitle').val(survtitle);
		$('#survNo').val(survNo);

    });
  
	$('#reInsertSurvey').on('click', function() {
		let survNo = $(this).closest('tr').data('survey-no');
		let dateValue  = $("#datetime-datepicker").val();
		let reloadSurveyForm = $('#reloadSurveyForm');
		let survTtlNm = $(this).closest('tr').find('td.survey-title').text().trim(); 
		
		
		console.log("reInsertSurvey", dateValue)
		if(dateValue == null || dateValue == '' ){
			$("#datetime-datepicker").focus();
			
			return;
		}
		
		 $.ajax({
	            url: '/survey/reloadSurveyForm',
	            type: 'POST',
	            beforeSend: function(xhr) { // 데이터 전송 전, 헤더에 csrf 값 설정
                    xhr.setRequestHeader(header, token);
                },
                contentType: "application/json",
	            data: JSON.stringify({
	                survNo: reloadSurveyForm.find('input[name="survNo"]').val(),
	                survEndDt: reloadSurveyForm.find('input[name="survEndDt"]').val(),
	                survTtlNm: $('#survtitle').val()
	            }),
	            success: function(res) {
	                location.reload();
	                $('#standard-modal').modal('hide');
	            }
	        });
	})
	
	
	$('#closeSelectedSurveysBtn').on('click', function() {
        let selectedSurveys = [];
        $('#products-datatable input[type="checkbox"]:checked').each(function() {
            let surveyNo = $(this).closest('tr').data('survey-no');
            if (surveyNo) {
                selectedSurveys.push(surveyNo);
            }
        });

        if (selectedSurveys.length > 0) {
            $.ajax({
                url: '/survey/closeSurveys',
                type: 'POST',
                contentType: 'application/json',
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(header, token);
                },
                data: JSON.stringify(selectedSurveys),
                success: function(response) {
                    location.reload(); // 페이지를 새로고침하여 변경 사항을 반영합니다.
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        } else {
            alert('Please select at least one survey to close.');
        }
    });
		
		
})

</script>
<body>
    <div class="content">
        <!-- Start Content-->
        <div class="container-fluid">
            <!-- start page title -->
            <div class="row">
                <div class="col-12">
                    <div class="page-title-box">
                        <h1 class="page-title">설문 관리</h1>
                    </div>
                </div>
            </div>
            <!-- end page title -->

            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="row mb-2">
                                <div class="col-sm-5">
                                    <a  class="btn btn-primary mb-2"  id="addSurveyBtn"><i class="mdi mdi-plus-circle me-2"></i> 설문 등록</a>
                                </div>
                                <div class="col-sm-7">
                                    <div class="text-sm-end">
                                        <button type="button" class="btn btn-warning mb-2 me-1" id="closeSelectedSurveysBtn"><i class="mdi mdi-cog-outline"></i> 설문 마감</button>
                                    </div>
                                </div><!-- end col-->
                            </div>
						
                            <div class="">
                                <div id="products-datatable_wrapper" class="dataTables_wrapper dt-bootstrap5 no-footer">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <table class="table table-centered w-100 dt-responsive nowrap dataTable no-footer dtr-inline" id="products-datatable" aria-describedby="products-datatable_info" style="width: 720px;">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th class="" style="" rowspan="1" colspan="1" data-col="0" aria-label=" &amp;nbsp; ">
                                                            <div class="form-check"><input type="checkbox" class="form-check-input dt-checkboxes"  ${survey['SURV_STTS'] == 'N' ? '' : 'disabled'}><label class="form-check-label"></label></div>
                                                        </th>
                                                        <th style="width: 0px;" class="all sorting sorting_asc text-center" tabindex="0" aria-controls="products-datatable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Product: activate to sort column descending">No</th>
                                                        <th class="sorting " tabindex="0" aria-controls="products-datatable" rowspan="1" colspan="1" style="width: ;" aria-label="Category: activate to sort column ascending">설문제목</th>
                                                        <th class="sorting text-center" tabindex="0" aria-controls="products-datatable" rowspan="1" colspan="1"  aria-label="Added Date: activate to sort column ascending">시작일시</th>
                                                        <th class="sorting text-center" tabindex="0" aria-controls="products-datatable" rowspan="1" colspan="1"  aria-label="Price: activate to sort column ascending">마감일시</th>
                                                        <th class="sorting text-center" tabindex="0" aria-controls="products-datatable" rowspan="1" colspan="1"  aria-label="Quantity: activate to sort column ascending">참가자</th>
                                                        <th class="sorting text-center" tabindex="0" aria-controls="products-datatable" rowspan="1" colspan="1"  aria-label="Status: activate to sort column ascending">상태</th>
                                                        <th class="sorting_disabled text-center" rowspan="1" colspan="1" aria-label="Action">재등록</th>
                                                    </tr>
                                                </thead>
												<c:forEach items="${surveyList}" var="survey" varStatus="status">
	                                                <tr class="${status.index % 2 == 0 ? 'even' : 'odd'}" data-survey-no="${survey['SURV_NO']}">
	                                                    <td class="dt-checksboxes-cell dtr-control">
	                                                        <div class="form-check"><input type="checkbox" class="form-check-input dt-checkboxes"><label class="form-check-label"></label></div> 
	                                                    </td>
	                                                    <td class="sorting_1 text-center">
	                                                    	 
	                                                        <p class="m-0 d-inline-block align-middle font-16">
	                                                            <a href="" class="text-body">${survey['ROW_NO']}</a>
	                                                            <br>
	                                                        </p>
	                                                    </td>
	                                                    <td class="survey-title" style="">
	                                                        ${survey['SURV_TTL_NM']} 
	                                                    </td>
	                                                    <td class="text-center">
	                                                       <fmt:formatDate value="${survey['SURV_REG_DT']}" pattern="yyyy/MM/dd HH:mm" /> 
	                                                    </td>
	                                                    <td class="text-center">
	                                                         <fmt:formatDate value="${survey['SURV_END_DT']}" pattern="yyyy/MM/dd HH:mm" /> 
	                                                    </td>
	                                                    <td class="text-center">
	                                                    	<c:choose>
	                                                    		<c:when test="${survey['SURV_STTS'] == 'N'}">
			                                                    	${survey['PRTCP_COUNT']} / ${survey['TOTAL_EMPL']}
	                                                    		</c:when>
	                                                    		<c:otherwise>
			                                                    	${survey['PRTCP_COUNT']} / ${survey['SURV_PATCP_CNT']}
	                                                    		</c:otherwise>
	                                                    	</c:choose>
	                                                    	
	                                                    </td>
	                                                    <td class="text-center">
	                                                        <span class="${survey['SURV_STTS'] == 'N' ? 'badge bg-success' : 'badge bg-warning'}">
																${survey['SURV_STTS'] == 'N' ? '진행' : '마감'}
															</span>
	                                                    </td>
	
	                                                    <td class="table-action text-center" style="">
		                                                    <a data-bs-toggle="modal" data-bs-target="#standard-modal" class="action-icon"> <i class="mdi mdi-square-edit-outline reloadSurvey"></i></a>
	                                                    </td>
	                                                </tr>
												</c:forEach>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12 col-md-5">
                                        </div>
                                        <div class="col-sm-12 col-md-7">
                                            <div class="dataTables_paginate paging_simple_numbers" id="products-datatable_paginate">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div> <!-- end card-body-->
                    </div> <!-- end card-->
                </div> <!-- end col -->
            </div>
            <!-- end row -->

        </div> <!-- container -->
    </div>
 <!--  동기로 바꾸기  -->
<div id="standard-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="standard-modalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="standard-modalLabel">설문 재등록</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
            </div>
            <form method="post" id="reloadSurveyForm" >
	            <div class="modal-body">
		            <div class="mb-3">
		    			<label class="form-label">설문 제목</label>
		    			<div >
		    				<input type="text" id="survtitle" name="survTtlNm" class="form-control">
		    			</div>
		    			<input type="text" hidden="true" name="survNo" id="survNo" class="form-control" >
					</div>
		            <div class="mb-3">
		    			<label class="form-label">마감일시</label>
		    			<input type="text" name="survEndDt" id="datetime-datepicker" class="form-control" placeholder="Date and Time">
					</div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
	                <button type="button" class="btn btn-primary" id="reInsertSurvey">등록</button>
	            </div>
	            <sec:csrfInput/>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>

<!-- 설문 타임픽커  -->
<script src="${pageContext.request.contextPath}/resources/assets/vendor/flatpickr/flatpickr.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/pages/a.timepicker.js"></script>
</html>