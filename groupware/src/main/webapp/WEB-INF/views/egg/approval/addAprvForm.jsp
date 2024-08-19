<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<script src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>

<c:set value="등록" var="name" />
<c:if test="${status eq 'u' }">
    <c:set value="수정" var="name" />
</c:if>

<div class="card">
    <div class="card-header">
        <h3 class="card-title">양식 ${name}</h3>
    </div>
    <div class="card-body">
        <form action="/admin/addForm" name="addForm" id="addForm" method="post">
            <c:if test="${status eq 'u' }">
                <input type="hidden" name="formCd" value="${result.formCd}" />
            </c:if>
            <div class="row g-2">
                <div class="mb-3 col-md-2">
                    <label for="aprvTy" class="form-label">양식유형</label> 
                    <select id="aprvTy" name="aprvTy" class="form-select">
                        <option>--- 분류 ---</option>
                        <option value="BP" <c:if test="${result.aprvTy == 'BP'}">selected</c:if>>업무</option>
                        <option value="AR" <c:if test="${result.aprvTy == 'AR'}">selected</c:if>>휴가</option>
                        <option value="HR" <c:if test="${result.aprvTy == 'HR'}">selected</c:if>>인사</option>
                    </select>
                </div>
                <div class="mb-3 col-md-10">
                    <label for="formTtl" class="form-label">양식 제목</label>
                    <input type="text" class="form-control" id="formTtl" name="formTtl"
                        value="${result.formTtl}" placeholder="제목을 입력해주세요">
                </div>
            </div>

            <div class="mb-3">
                <label for="formCn">양식내용</label>
                <textarea class="form-control" id="formCn" name="formCn" style="height: 300px;">${result.formCn}</textarea>
            </div>
            <sec:csrfInput />
        </form>
    </div>
    <div class="card-footer">
        <div class="row">
            <div class="col-12 text-end">
                <input type="button" value="${name}" id="addBtn" class="btn btn-primary">
                <c:if test="${status eq 'u' }">
                    <input type="button" value="취소" id="cancelBtn" class="btn btn-secondary">
                </c:if>
                <c:if test="${status ne 'u' }">
                    <input type="button" value="목록" id="listBtn" class="btn btn-secondary">
                </c:if>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function() {
    	 CKEDITOR.replace("formCn", {
    	        height: 370
    	    });
        var addForm = $("#addForm");
        var listBtn = $("#listBtn");
        var cancelBtn = $("#cancelBtn");

        $("#addBtn").on("click", function() {
            var formTtl = $("#formTtl").val();
            var formCn = CKEDITOR.instances.formCn.getData();

            if (formTtl == null || formTtl == "") {
                alert("제목을 입력해주세요!");
                $("#formTtl").focus();
                return false;
            }
            if (formCn == null || formCn == "") {
                alert("내용을 입력해주세요!");
                $("#formCn").focus();
                return false;
            }

            if ($(this).val() == "수정") {
                addForm.attr("action", "/admin/updateForm");
            }
            addForm.submit();
        });

        cancelBtn.on("click", function() {
            history.back();
        });
        listBtn.on("click", function() {
            location.href = "${pageContext.request.contextPath}/admin/formList";
        });
    });
</script>