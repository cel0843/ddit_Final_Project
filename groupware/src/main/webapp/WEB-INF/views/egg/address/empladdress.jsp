<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
    <title>사내인원 주소록</title>
    <style>
        .container {
            display: flex;
        }
        .table-container {
            flex-grow: 1;
        }
        .btn-blue {
            background-color: #007bff;
            border-color: #007bff;
            color: white;
        }
        .btn-blue:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .pagination-container {
            display: flex;
            justify-content: center;
            margin-top: 20px; /* 원하는 경우 마진을 조정 */
        }
        .search-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            align-items: center;
            margin-bottom: 20px;
        }
        .search-input {
            flex: 1;
            min-width: 150px;
        }
        .tab-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .nav-tabs {
            flex-grow: 1;
        }
        .card-header .row .btn {
		    margin-left: auto;
		}
		.input-group {
		    flex-grow: 1;
		    display: flex;
		    align-items: center;
		}
		/* 헤더 스타일 */
		.table thead th {
		    background-color: #f8f9fa;
		    font-weight: bold;
		    color: #343a40;
		    text-align: center;
		}
		
    </style>
</head>
<body>
<div class="row">
	<div class="col-md-12">
		<div class="card">
			<div class="card-header">
				<div class="card-title">
					<h1>주소록</h1>
				</div>
			</div>	
							
			<div class="card-header">
			    <div class="row justify-content-center">
			        <!-- 검색 폼 -->
			        <form method="GET" action="${pageContext.request.contextPath}/egg/address/empllist" id="searchForm" class="d-flex justify-content-center w-100">
			            <div class="input-group">
			                <div>         
			                    <select class="form-select" id="searchSelectBox" name="select">
			                        <option value="emplNm" ${selectBoxChk == 'emplNm' ? 'selected' : ''}>이름</option>
			                        <option value="deptCd" ${selectBoxChk == 'deptCd' ? 'selected' : ''}>부서</option>
			                        <option value="positionCd" ${selectBoxChk == 'positionCd' ? 'selected' : ''}>직위</option>
			                        <option value="email" ${selectBoxChk == 'email' ? 'selected' : ''}>이메일</option>
			                        <option value="telno" ${selectBoxChk == 'telno' ? 'selected' : ''}>휴대폰</option>
			                    </select>
			                </div>
			                <div>
			                    <input type="text" name="searchText" class="form-control" value="${param.searchText}" style="width: 100%; margin-right: 10px;">
			                </div>
			                <button type="submit" class="btn btn-sm btn-primary" style="font-size: 12px; height:40px; width: 60px; padding: 5px 10px;">검색</button>
			            </div>
			        </form>
			    </div>
			</div>

			
			<div class="card-body">
				<div class="tab-header">
				    <ul class="nav nav-tabs nav-justified nav-bordered mb-3">
				        <li class="nav-item">
				            <a href="${pageContext.request.contextPath}/egg/address/empllist" class="nav-link ${tab == 'empl' ? 'active' : ''}">
				                <i class="mdi mdi-home-variant d-md-none d-block"></i>
				                <span class="d-none d-md-block">사내주소록</span>
				            </a>
				        </li>
				        <li class="nav-item">
				            <a href="${pageContext.request.contextPath}/egg/address/adresclist" class="nav-link ${tab == 'adres' ? 'active' : ''}">
				                <i class="mdi mdi-account-circle d-md-none d-block"></i>
				                <span class="d-none d-md-block">외부주소록</span>
				            </a>
				        </li>
				    </ul>
				</div>
			    <div class="table-container">
			        <table class="table table-striped table-centered mb-0">
			            <thead>
			                <tr class="text-center">
			                    <th>이름</th>
			                    <th>부서</th>
			                    <th>직위</th>
			                    <th>이메일</th>
			                    <th>휴대폰</th>
			                    <th></th>
			                </tr>
			            </thead>
			            <tbody>
			                <c:choose>
			                    <c:when test="${empty emplList}">
			                        <tr class="text-center"> 
			                            <td colspan="6" align="center">조회하실 주소록이 없습니다</td>
			                        </tr>
			                    </c:when>
			                    <c:otherwise>
			                        <c:forEach items="${emplList}" var="address">
			                            <tr class="text-center">
			                                <td>${address.emplNm}</td>
			                                <td>${address.deptCd}</td>
			                                <td>${address.positionCd}</td>
			                                <td>${address.email}</td>
			                                <td>${address.telno}</td>
			                                <td class="table-action">
			                                    <a href="javascript: void(0);" class="action-icon mdi mdi-eye" data-id="${address.emplId}"></a>
			                                </td>
			                            </tr>
			                        </c:forEach>
			                    </c:otherwise>
			                </c:choose>
			            </tbody>
			        </table>
			    </div>
			    <nav class="pagination-container" style="margin: 20px;">
				    <ul class="pagination pagination-rounded mb-0">
				        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
				            <a class="page-link" href="${pageContext.request.contextPath}/egg/address/empllist?page=${currentPage - 1}" aria-label="Previous">
				                <span aria-hidden="true">&laquo;</span>
				            </a>
				        </li>
				        <c:forEach var="i" begin="${startPage}" end="${endPage}">
				            <li class="page-item ${currentPage == i ? 'active' : ''}">
				                <a class="page-link" href="${pageContext.request.contextPath}/egg/address/empllist?page=${i}">${i}</a>
				            </li>
				        </c:forEach>
				        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
				            <a class="page-link" href="${pageContext.request.contextPath}/egg/address/empllist?page=${currentPage + 1}" aria-label="Next">
				                <span aria-hidden="true">&raquo;</span>
				            </a>
				        </li>
				    </ul>
				</nav>
			    
			
			</div>
		</div>
	</div>
</div>











<!-- 상세보기 모달 -->
<div id="detail-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="detail-header-modalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header modal-colored-header bg-primary">
                <h4 class="modal-title" id="detail-header-modalLabel">사내인원 상세보기</h4>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-2">
                        <label for="detailEmplNm" class="form-label">이름</label>
                        <input type="text" id="detailEmplNm" name="emplNm" class="form-control" value="${employee.emplNm}" readonly>
                    </div>
                    <div class="mb-2">
                        <label for="detailDeptCd" class="form-label">부서</label>
                        <input type="text" id="detailDeptCd" name="deptCd" class="form-control" value="${employee.deptNm}" readonly>
                    </div>
                    <div class="mb-2">
                        <label for="detailEmail" class="form-label">이메일</label>
                        <input type="text" id="detailEmail" name="positionCd" class="form-control" value="${employee.email}" readonly>
                    </div>
                    <div class="mb-2">
                        <label for="detailJncmpYmd" class="form-label">입사날자</label>
                        <input type="text" id="detailJncmpYmd" name="email" class="form-control" value="${formattedDate}" readonly>
                    </div>
                    <div class="mb-2">
                        <label for="detailTelno" class="form-label">연락처</label>
                        <input type="text" id="detailTelno" name="telno" class="form-control" value="${employee.telno}" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="detailBscAddr" class="form-label">주소</label>
                        <textarea class="form-control" id="detailBscAddr" name="remark" rows="5" readonly>${employee.bscAddr}${employee.dtlAddr}</textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> -->
<script type="text/javascript">
document.querySelectorAll('.dropdown-item').forEach(item => {
    item.addEventListener('click', function(event) {
        event.preventDefault(); 
        document.getElementById('filterInput').value = this.getAttribute('data-filter');
        document.getElementById('searchForm').submit();
    });
});

$(document).ready(function(){
    // 상세보기 버튼 클릭 이벤트
    $(".mdi-eye").click(function(){
        var emplId = $(this).attr('data-id'); 

        $.ajax({
            url: "${pageContext.request.contextPath}/egg/address/adresread",
            type: "GET",
            data: { emplId: emplId },
            success: function(data) {
                $("#detailEmplNm").val(data.employee.emplNm);
                $("#detailDeptCd").val(data.employee.deptNm);
                $("#detailEmail").val(data.employee.email);
                $("#detailJncmpYmd").val(data.formattedDate); // 변환된 날짜 사용
                $("#detailTelno").val(data.employee.telno);
                $("#detailBscAddr").val(data.employee.bscAddr);

                $("#detail-modal").modal('show');
            }
        });
    });
});
</script>

</body>
</html>
