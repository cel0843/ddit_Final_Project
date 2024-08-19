<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
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
	    justify-content: space-between;
	    align-items: center;
	    margin-top: 20px; /* 원하는 경우 마진을 조정 */
	}
    td.clickable-cell {
        cursor: pointer;
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
    .pagination-container {
 	   display: flex;
  	   justify-content: space-between;
  	   align-items: center;
  	   margin-top: 20px; /* 원하는 경우 마진을 조정 */	
	}
	.card-header .row {
	    display: flex;
	    justify-content: center;
	    align-items: center;
	}
	
	.input-group {
	    flex-grow: 1;
	    display: flex;
	    align-items: center;
	}
	
	.card-header .row .btn {
	    margin-left: auto;
	}
	
	.table thead th {
    background-color: #f8f9fa;
    font-weight: bold;
    color: #343a40;
    text-align: center;
	}
</style>

<div class="row">
	<div class="col-md-12">
		<div class="card">
		
			<div class="card-header">
				<div class="card-title">
				
					<h1>주소록</h1>
				</div>
			</div>
			
			<div class="card-header">
			    <div class="row">
			        <form method="GET" action="${pageContext.request.contextPath}/egg/address/search" id="searchForm" style="flex-grow: 1;">
			            <div class="input-group">
			                <div>         
			                    <select class="form-select" id="searchSelectBox" name="select">
			                        <option value="adresNm" ${selectBoxChk == 'adresNm' ? 'selected' : ''}>이름</option>
			                        <option value="adresJbttl" ${selectBoxChk == 'adresJbttl' ? 'selected' : ''}>직위</option>
			                        <option value="adresEml" ${selectBoxChk == 'adresEml' ? 'selected' : ''}>이메일</option>
			                        <option value="adresTelno" ${selectBoxChk == 'adresTelno' ? 'selected' : ''}>휴대폰</option>
			                        <option value="adresCoNm" ${selectBoxChk == 'adresCoNm' ? 'selected' : ''}>회사</option>
			                    </select>
			                </div>
			                <div>
			                    <input type="text" name="searchText" class="form-control" value="${param.searchText}" style=" margin-right: 10px;">
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
				            <a href="${pageContext.request.contextPath}/egg/address/empllist" class="nav-link  ${tab == 'empl' ? 'active' : ''}">
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
			                    <th>직위</th>
			                    <th>이메일</th>
			                    <th>휴대폰</th>
			                    <th>회사</th>
			                    <th></th>
			                </tr>
			            </thead>
			            <tbody>
			                <c:choose>
			                    <c:when test="${empty adresList}">
			                        <tr class="text-center">
			                            <td colspan="6" align="center">조회하실 주소록이 없습니다</td>
			                        </tr>
			                    </c:when>
			                    <c:otherwise>
			                        <c:forEach items="${adresList}" var="adres">
			                            <tr class="text-center">
			                                <td >${adres.adresNm}</td>
			                                <td >${adres.adresJbttl}</td>
			                                <td >${adres.adresEml}</td>
			                                <td >${adres.adresTelno}</td>
			                                <td >${adres.adresCoNm}</td>
			                                <td class="table-action">
			                                    <a href="javascript: void(0);" class="action-icon mdi mdi-eye" data-id="${adres.adresNo}"></a>
			                                    <a href="javascript: void(0);" class="action-icon mdi mdi-pencil" data-id="${adres.adresNo}"></a>
			                                    <a href="#" class="action-icon mdi mdi-delete" data-id="${adres.adresNo}" data-name="${adres.adresNm}"></a>
			                                </td>
			                            </tr>                
			                        </c:forEach>
			                    </c:otherwise>
			                </c:choose>
			            </tbody>
			        </table>
			   </div>
			   
			   
				<!-- 페이징 -->
				<nav class="pagination-container" style="margin: 20px; display: flex; justify-content: space-between; align-items: center;">
				    <ul class="pagination pagination-rounded mb-0" style="flex-grow: 1; justify-content: center;">
				        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
				            <a class="page-link" href="${pageContext.request.contextPath}/egg/address/adresclist?page=${currentPage - 1}" aria-label="Previous">
				                <span aria-hidden="true">&laquo;</span>
				            </a>
				        </li>
				        <c:forEach var="i" begin="${startPage}" end="${endPage}">
				            <li class="page-item ${currentPage == i ? 'active' : ''}">
				                <a class="page-link" href="${pageContext.request.contextPath}/egg/address/adresclist?page=${i}">${i}</a>
				            </li>
				        </c:forEach>
				        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
				            <a class="page-link" href="${pageContext.request.contextPath}/egg/address/adresclist?page=${currentPage + 1}" aria-label="Next">
				                <span aria-hidden="true">&raquo;</span>
				            </a>
				        </li>
				    </ul>
				    <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#compose-modal" style="font-size: 12px; height:40px; width: 170px; padding: 5px 10px; margin-left: auto;">등록하기</button>
				</nav>

				
			</div>
			
			
		</div>
	</div>
	
</div>

<!-- Compose Modal -->
<div id="compose-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="compose-header-modalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header modal-colored-header bg-primary">
                <h4 class="modal-title" id="compose-header-modalLabel">외부인원 주소록</h4>
                
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="p-1">
                <form action="${pageContext.request.contextPath}/egg/address/register" method="post" id="frm">
                    <input type="hidden" name="status" value="${status}" />
                    <input type="hidden" name="adresNo" value="${adresBookVO.adresNo != null ? adresBookVO.adresNo : ''}" />
                    <div class="modal-body px-3 pt-3 pb-0">
                        <div class="mb-2">
                            <label for="adresNm" class="form-label">이름</label>
                            <input type="text" id="adresNm" name="adresNm" class="form-control" placeholder="Name" value="${adresBookVO.adresNm}">
                        </div>
                        <div class="mb-2">
                            <label for="adresCoNm" class="form-label">회사</label>
                            <input type="text" id="adresCoNm" name="adresCoNm" class="form-control" placeholder="Company" value="${adresBookVO.adresCoNm}">
                        </div>
                        <div class="mb-2">
                            <label for="adresJbttl" class="form-label">직급</label>
                            <input type="text" id="adresJbttl" name="adresJbttl" class="form-control" placeholder="Position" value="${adresBookVO.adresJbttl}">
                        </div>
                        <div class="mb-2">
                            <label for="adresTelno" class="form-label">연락처</label>
                            <input type="text" id="adresTelno" name="adresTelno" class="form-control" placeholder="000-0000-0000" value="${adresBookVO.adresTelno}">
                        </div>
                        <div class="mb-2">
                            <label for="adresEml" class="form-label">이메일</label>
                            <input type="text" id="adresEml" name="adresEml" class="form-control" placeholder="Example@email.com" value="${adresBookVO.adresEml}">
                        </div>
                        <div class="mb-3">
                            <label for="adresRmrk" class="form-label">비고</label>
                            <textarea class="form-control" id="adresRmrk" name="adresRmrk" rows="5" >${adresBookVO.adresRmrk}</textarea>
                        </div>
                    </div>
                    <div class="px-3 pb-3">
                        <button type="submit" class="btn btn-primary"><i class="mdi mdi-send me-1"></i> Apply</button>
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                        <a href="#" id="testbtn"><i class="ri-heart-fill"></i>시연용</a>
                    </div>
                    <sec:csrfInput/>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- Primary Header Modal -->
<div id="primary-header-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="primary-header-modalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <h4 class="modal-title" id="primary-header-modalLabel">주소록 삭제</h4>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-hidden="true"></button>
            </div>
            <div class="modal-body">
                정말로 삭제하시겠습니까?  
            </div>
            <form action="${pageContext.request.contextPath}/egg/address/coremove" method="post" id="delfrm">
                <div class="modal-footer">
                    <input type="hidden" name="adresNo" value="">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="deleteBtn">Delete</button>
                </div>
                <sec:csrfInput/>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
$(document).ready(function(){
	var adresRmrk = $("#adresRmrk").val();
    // 삭제 버튼 클릭 이벤트
   $(".mdi-delete").click(function(){
        var adresNo = $(this).attr('data-id'); 
        var adresNm = $(this).attr('data-name'); 

        Swal.fire({
            title: '정말로 ' + adresNm + '님을 삭제하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Delete'
        }).then((result) => {
            if (result.isConfirmed) {
                $("#delfrm input[name='adresNo']").val(adresNo);
                $("#delfrm").submit();
            }
        });
    });

    // 수정 버튼 클릭 이벤트
    $(".mdi-pencil").click(function(){
        var adresNo = $(this).attr('data-id'); 
        
        console.log("adresNo ={}",adresNo);
       

        $.ajax({
            url: "${pageContext.request.contextPath}/egg/address/coread",
            type: "GET",
            data: { adresNo: adresNo },
            success: function(data) {
            	console.log("@@",data)
            	
                $("#frm input[name='adresNo']").val(data.adresBookVO.adresNo);
                $("#frm input[name='adresNm']").val(data.adresBookVO.adresNm);
                $("#frm input[name='adresCoNm']").val(data.adresBookVO.adresCoNm);
                $("#frm input[name='adresJbttl']").val(data.adresBookVO.adresJbttl);
                $("#frm input[name='adresTelno']").val(data.adresBookVO.adresTelno);
                $("#frm input[name='adresEml']").val(data.adresBookVO.adresEml);
                $("#frm textarea[name='adresRmrk']").val(data.adresBookVO.adresRmrk);
                $("#frm input[name='status']").val("u");
                
                $("#compose-modal").modal('show');
            }
        });
    });

    // 상세보기 버튼 클릭 이벤트
    $(".mdi-eye").click(function(){
        var adresNo = $(this).attr('data-id'); 

        $.ajax({
            url: "${pageContext.request.contextPath}/egg/address/coread",
            type: "GET",
            data: { adresNo: adresNo },
            success: function(data) {
                $("#frm input[name='adresNo']").val(data.adresBookVO.adresNo).attr('readonly', true);
                $("#frm input[name='adresNm']").val(data.adresBookVO.adresNm).attr('readonly', true);
                $("#frm input[name='adresCoNm']").val(data.adresBookVO.adresCoNm).attr('readonly', true);
                $("#frm input[name='adresJbttl']").val(data.adresBookVO.adresJbttl).attr('readonly', true);
                $("#frm input[name='adresTelno']").val(data.adresBookVO.adresTelno).attr('readonly', true);
                $("#frm input[name='adresEml']").val(data.adresBookVO.adresEml).attr('readonly', true);
                $("#frm textarea[name='adresRmrk']").val(data.adresBookVO.adresRmrk).attr('readonly', true);
                $("#frm input[name='status']").val("");

                // Submit 버튼을 숨기고 Close 버튼만 보이게 설정
                $("#frm button[type='submit']").hide();
                $("#frm button[data-bs-dismiss='modal']").text('Close');

                $("#compose-modal").modal('show');
            }
        });
    });

    // 모달 창 닫힐 때 읽기 전용 속성 해제 및 Submit 버튼 복구
    $("#compose-modal").on('hidden.bs.modal', function () {
        $("#frm input").attr('readonly', false);
        $("#frm textarea").attr('readonly', false);
        $("#frm button[type='submit']").show();
        $("#frm button[data-bs-dismiss='modal']").text('Cancel');
    });
    
    
 // 시연용 버튼 클릭 이벤트 추가
    $("#testbtn").click(function() {
        $("#frm input[name='adresNm']").val('최수연');
        $("#frm input[name='adresCoNm']").val('Naver');
        $("#frm input[name='adresJbttl']").val('대표이사');
        $("#frm input[name='adresTelno']").val('010-3131-6464');
        $("#frm input[name='adresEml']").val('naver0805@naver.com');
        $("#frm textarea[name='adresRmrk']").val('대표님 24.08.06 미팅 일정 / 경기도 성남시 분당구 정자일로 95 7층 705호');
    });

});
</script>

</body>
</html>
