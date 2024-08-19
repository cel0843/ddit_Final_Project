<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<style>
    label {
        display: none;
    }

    div.dataTables_wrapper div.dataTables_filter input {
        display: none;
    }
</style>
<script src="${pageContext.request.contextPath}/resources/assets/js/pages/a.products-user.js"></script>
<script type="text/javascript">
    $(function() {

        $('#addSurveyBtn').on('click', function() {
            console.log("넣어줘")
            window.location.href = '/survey/surveyInsert';

        })

        $('#products-datatable').on('click', 'tr', function() {
            var surveyNo = $(this).data('survey-no');
            var surveyStatus = $(this).find('.table-action').data('stts');
            var isSurveyPrtcp = $(this).find('.table-action').data('isprtcp');

            if (surveyNo) {
                if (surveyStatus === 'Y' || isSurveyPrtcp > 0) {
                    alert('이미 참여했거나 마감된 설문입니다.');
                    return false;
                }
                window.location.href = '/egg/survey/surveyDetail?surveyNo=' + surveyNo;
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
                        <h4 class="page-title">설문 리스트</h4>
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
                                    <!--                                     <a  class="btn btn-danger mb-2"  id="addSurveyBtn"><i class="mdi mdi-plus-circle me-2"></i> Add Survey</a> -->
                                </div>
                                <div class="col-sm-7">
                                    <div class="text-sm-end">
<!--                                         <button type="button" class="btn btn-success mb-2 me-1"><i class="mdi mdi-cog-outline"></i></button> -->
                                    </div>
                                </div><!-- end col-->
                            </div>
                            
							<form action="/egg/survey/surveyMain" method="get">
							<div class="row">
								<div class="col-12 text-end">
								    <div class="searchForm input-group float-end" style="align-items: flex-start; justify-content: flex-end;"> 
									        <div class="form-check m-1">
									            <input type="checkbox" class="form-check-input" id="survStts" name="survStts" value="Y" ${survStts == 'Y' ? 'checked' : ''}> 
									            <label for="survStts" class="form-check-label" style="display: block;"> 진행 </label>
									        </div>
									        <div class="form-check m-1">
									            <input type="checkbox" class="form-check-input" id="survPatcpCnt" name="survPatcpCnt" value="Y" ${survPatcpCnt == 'Y' ? 'checked' : ''}>
									            <label for="survPatcpCnt" class="form-check-label" style="display: block;"> 미참 </label>
									        </div>
								        <div class="me-2">
								            <select class="form-select" id="searchSelectBox" name="select">
								                <option value="survTtlNm" ${selectBoxChk=='survTtlNm' ? 'selected' : '' }>설문제목</option>
								                <option value="survRegDt" ${selectBoxChk=='survRegDt' ? 'selected' : '' }>시작일시</option>
								                <option value="survEndDt" ${selectBoxChk=='survEndDt' ? 'selected' : '' }>마감일시</option>
								            </select>
								        </div>
								        <div class="me-2">
								            <input type="text" name="searchText" class="form-control" value="${searchText}">
								        </div>
								        <div>
								            <input class="btn btn-primary" type="submit" value="검색" style="margin-left: 3px;">
								        </div>
								    </div>
								    <sec:csrfInput />
								</div>
							</div>
							</form>
                            <div class="">
                                <div id="products-datatable_wrapper" class="dataTables_wrapper dt-bootstrap5 no-footer">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <table class="table table-centered w-100 dt-responsive nowrap dataTable no-footer dtr-inline" id="products-datatable" aria-describedby="products-datatable_info" style="width: 720px;">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th class="all sorting_disabled dt-checkboxes-cell dt-checkboxes-select-all" style="width: 42.6px;" rowspan="1" colspan="1" data-col="0" aria-label=" &amp;nbsp; " hidden="true">
                                                            <div class="form-check"><input type="checkbox" class="form-check-input dt-checkboxes"><label class="form-check-label">&nbsp;</label></div>
                                                        </th>
                                                        <th class="all sorting sorting_asc text-center " tabindex="0" aria-controls="products-datatable" rowspan="1" colspan="1" style="width: 0px;" aria-sort="ascending" aria-label="Product: activate to sort column descending">No</th>
                                                        <th class="sorting " tabindex="0" aria-controls="products-datatable" rowspan="1" colspan="1" style="width: 231.8px;" aria-label="Category: activate to sort column ascending">설문 제목</th>
                                                        <th class="sorting text-center" tabindex="0" aria-controls="products-datatable" rowspan="1" colspan="1" style="width: 121.8px;" aria-label="Added Date: activate to sort column ascending">시작일시</th>
                                                        <th class="sorting text-center" tabindex="0" aria-controls="products-datatable" rowspan="1" colspan="1" style="width: 121.8px;" aria-label="Price: activate to sort column ascending">마감일시</th>
                                                        <th class="sorting text-center" tabindex="0" aria-controls="products-datatable" rowspan="1" colspan="1" style="width: 31.1px;" aria-label="Quantity: activate to sort column ascending">참가자</th>
                                                        <th class="sorting text-center" tabindex="0" aria-controls="products-datatable" rowspan="1" colspan="1" style="width: 31.1px;" aria-label="Status: activate to sort column ascending">상태</th>
                                                        <th style="width: 0px;" class="sorting_disabled" rowspan="1" colspan="1" aria-label="Action">참가여부</th>
                                                    </tr>
                                                </thead>
                                                <c:forEach items="${surveyList}" var="survey" varStatus="status">
                                                    <tr class="${status.index % 2 == 0 ? 'even' : 'odd'}" data-survey-no="${survey['SURV_NO']}">
                                                        <td class="dt-checkboxes-cell dtr-control" hidden="true">
                                                            <div class="form-check"><input type="checkbox" class="form-check-input dt-checkboxes"><label class="form-check-label">&nbsp;</label></div>
                                                        </td>
                                                        <td class="sorting_1 text-center">

                                                            <p class="m-0 d-inline-block align-middle font-16">
                                                                <a href="" class="text-body">${survey['ROW_NO']}</a>
                                                                <br>
                                                            </p>
                                                        </td>
                                                        <td style="">
                                                            ${survey['SURV_TTL_NM']}
                                                        </td>
                                                        <td style="" class="text-center">
                                                            <fmt:formatDate value="${survey['SURV_REG_DT']}" pattern="MM/dd/yyyy HH:mm" />
                                                        </td>
                                                        <td style=""  class="text-center">
                                                            <fmt:formatDate value="${survey['SURV_END_DT']}" pattern="MM/dd/yyyy HH:mm" />
                                                        </td>
                                                        <td style=""  class="text-center">
                                                            <c:choose>
                                                                <c:when test="${survey['SURV_STTS'] == 'N'}">
                                                                    ${survey['PRTCP_COUNT']} / ${survey['TOTAL_EMPL']}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${survey['PRTCP_COUNT']} / ${survey['SURV_PATCP_CNT']}
                                                                </c:otherwise>
                                                            </c:choose>

                                                        </td>
                                                        <td style=""  class="text-center">
                                                            <span class="${survey['SURV_STTS'] == 'N' ? 'badge bg-success' : 'badge bg-secondary'}">
                                                                ${survey['SURV_STTS'] == 'N' ? '진행' : '마감'}
                                                            </span>
                                                        </td>
                                                        <td class="table-action" style="" data-stts="${survey['SURV_STTS']}" data-isprtcp="${survey['SURV_PARTICIPATION']}"  class="text-center">
                                                            <c:if test="${survey['SURV_STTS'] == 'N'}">
                                                                <span class="${survey['SURV_PARTICIPATION'] > 0 ? 'badge bg-dark-subtle' : 'badge bg-success'}" data-bs-toggle="tooltip" data-bs-title="${survey['SURV_STTS'] == 'N' ? '진행중' : '마감'}인 설문입니다.">
                                                                    <c:choose>
                                                                        <c:when test="${survey['SURV_PARTICIPATION'] > 0}">
                                                                            	참여
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                           		 미참
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                    <a href="javascript:void(0);" class="action-icon"> <i class="mdi mdi-square-edit-outline"></i></a>
                                                                </span>
                                                            </c:if>
                                                            <c:if test="${survey['SURV_STTS'] == 'Y'}">
                                                                <span class="badge bg-dark-subtle" data-bs-toggle="tooltip" data-bs-title="${survey['SURV_STTS'] == 'N' ? '진행' : '마감'}된 설문입니다.">
                                                                    <c:choose>
                                                                        <c:when test="${survey['SURV_PARTICIPATION'] > 0}">
                                                                           		 참여
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            	미참
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                    <a href="javascript:void(0);" class="action-icon"> <i class="mdi mdi-square-edit-outline"></i></a>
                                                                </span>
                                                            </c:if>
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
</body>

</html>