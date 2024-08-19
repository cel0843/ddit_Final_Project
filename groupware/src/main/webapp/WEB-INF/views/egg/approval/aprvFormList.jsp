<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- jstree css -->
<link href="${pageContext.request.contextPath }/resources/assets/vendor/jstree/themes/default/style.min.css" rel="stylesheet" type="text/css">
<style type="text/css">
#bs-example-modal-lg .modal-dialog {
    max-width: 40%; 
}
div.dataTables_wrapper div.dataTables_filter{
    display: none;
}
#basic-datatable_length{
	display: none;
}
#basic-datatable_info{
	display: none;
}
</style>
<div class="card">
    <div class="card-body">
		<div class="col-lg-12" id="formList">
			<h3>양식 관리</h3><br>
			<input type="button" value="+양식추가" class="btn btn-soft-primary" id="formAdd" style=" float: right;">					
			<button type="button" value="" class="btn btn-primary dropdown-toggle"  data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">분류</button><br><br>				
			<div class="dropdown-menu" style="text-align: center;">
                <a class="dropdown-item" href="${pageContext.request.contextPath }/admin/formList">전체</a>
                <a class="dropdown-item" href="${pageContext.request.contextPath }/admin/formList?aprvTy=AR">휴가</a>
                <a class="dropdown-item" href="${pageContext.request.contextPath }/admin/formList?aprvTy=HR">인사</a>
                <a class="dropdown-item" href="${pageContext.request.contextPath }/admin/formList?aprvTy=BP">프로젝트</a>
            </div>
			
			<table class="table table-hover table-centered mb-0" id="basic-datatable">
			    <thead  class="table-active">
			        <tr>
			            <th>NO</th>
			            <th>양식제목</th>
			            <th>등록일자</th>
			            <th>수정일자</th>			         
			            <th>전결가능 여부</th>
			            <th>사용여부</th>
			        </tr>
			    </thead>
			    <tbody>
			    <c:forEach var="aprvForm" items="${list}" varStatus="status">
			        <tr>
			            <td>${status.count }</td>
			            <td class="formTtl" data-cd="${aprvForm.formCd }">${aprvForm.formTtl }</td>
			            <td>${aprvForm.formRegYmd }</td>
			            <td>${aprvForm.formMdfcnYmd }</td>			          
			            <td style="text-align: center;">
			                <!-- Switch-->
			                <div>			                
			                    <input type="checkbox" id="dcrb0${status.count }" class="switchDcrb" data-cd="${aprvForm.formCd }" <c:if test="${aprvForm.dcrbPsbltyYn == 'Y' }">checked</c:if> data-switch="success"/>
			                    <label for="dcrb0${status.count }" data-on-label="Yes" data-off-label="No" class="mb-0 d-block"></label>
			                </div>
			             </td>
			             <td>
			                <!-- Switch-->
			                <div>			                
			                    <input type="checkbox" id="switch0${status.count }" class="switchUse" data-cd="${aprvForm.formCd }" <c:if test="${aprvForm.useYn == 'Y' }">checked</c:if> data-switch="success"/>
			                    <label for="switch0${status.count }" data-on-label="Yes" data-off-label="No" class="mb-0 d-block"></label>
			                </div>
			            </td>
			        </tr>
			     </c:forEach>
			     </tbody>
    		</table>
		</div>		
		<div class="modal fade" id="bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		    <div class="modal-dialog modal-lg">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h4 class="modal-title" id="myLargeModalLabel"></h4>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
		            </div>
		            <div class="modal-body">		                
		            </div>
		        </div><!-- /.modal-content -->
		    </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
	</div>
</div>
<!-- jstree js -->
<script src="${pageContext.request.contextPath }/resources/assets/vendor/jstree/jstree.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/js/pages/demo.jstree.js"></script>
<script type="text/javascript">
$(function(){    
	var html;
	
	//제목클릭시 내용미리보기
	$(".formTtl").on("click",function(){		
		 formCd = $(this).data("cd");
		 $.ajax({
				url : "/admin/formOne",
				type: "post",
				contentType: "application/json",
				beforeSend : function(xhr){		// 데이터 전송전, 헤더에 csrf 값 설정
					xhr.setRequestHeader("${_csrf.headerName }", "${_csrf.token }");
				},
		        data: JSON.stringify({ formCd: formCd }), 
				success: function(res){					
					html = '<form action="/admin/remove" method="post" id="delform">';
		            html += '    <input type="hidden" name="formCd" value=' + formCd + '><sec:csrfInput /></form>';
		            html += '<button type="button" class="btn btn-danger" id="formDel" style=" float: right;">삭제</button>';
		            html += '<button type="button" class="btn btn-warning" id="formMod" style=" float: right;">수정</button>';
		            
		         	// 모달의 내용 업데이트
		            $("#bs-example-modal-lg .modal-title").html(res.formTtl);
		            $("#bs-example-modal-lg .modal-body").html(res.formCn);
		            $("#bs-example-modal-lg .modal-body").append(html);
		            
		            // 모달 표시
		            $("#bs-example-modal-lg").modal('show');
				}
			});			//ajax end		
	});			//click end
	
	// 사용여부스위치에 따른 db데이터수정
	  $('.switchUse').change(function() {		  
	        var isChecked = $(this).is(':checked');
	       
	        formCd = $(this).data('cd'); 
	        // AJAX 요청을 통해 서버에 데이터 전송
	        console.log(isChecked);
	        $.ajax({
	            url: '/admin/formUse',
	            type: 'POST',
	            contentType: 'application/json',
				beforeSend : function(xhr){		// 데이터 전송전, 헤더에 csrf 값 설정
					xhr.setRequestHeader("${_csrf.headerName }", "${_csrf.token }");
				},
	            data: JSON.stringify({
	            	formCd: formCd,
	            	useYn: isChecked ? 'Y' : 'N'
	            }),
	            success: function(res) {	            	
	                console.log('DB 업데이트 성공');
	            },
	            error: function(xhr, status, error) {
	                console.error('DB 업데이트 실패:', error);
	            }
	        });
	    });
	
	// 전결여부스위치에 따른 db데이터수정
	  $('.switchDcrb').change(function() {		  
	        var isChecked = $(this).is(':checked');
	       
	        formCd = $(this).data('cd'); 
	        // AJAX 요청을 통해 서버에 데이터 전송
	        console.log(isChecked);
	        $.ajax({
	            url: '/admin/dcrbYn',
	            type: 'POST',
	            contentType: 'application/json',
				beforeSend : function(xhr){		// 데이터 전송전, 헤더에 csrf 값 설정
					xhr.setRequestHeader("${_csrf.headerName }", "${_csrf.token }");
				},
	            data: JSON.stringify({
	            	formCd: formCd,
	            	dcrbPsbltyYn: isChecked ? 'Y' : 'N'
	            }),
	            success: function(res) {	            	
	                console.log('DB 업데이트 성공');
	            },
	            error: function(xhr, status, error) {
	                console.error('DB 업데이트 실패:', error);
	            }
	        });
	    });
	
	$("#formAdd").on("click",function(){
		location.href="${pageContext.request.contextPath }/admin/addAprvForm";
	});
	
	$(document).on("click","#formMod",function(){		
		location.href="${pageContext.request.contextPath }/admin/modForm?formCd="+formCd;
	});
	
	$(document).on("click","#formDel",function(){
		if(confirm("양식을 삭제하시겠습니까?")){
			$("#delform").submit();
		}
	});
	
	
});//readyfunction
</script>
