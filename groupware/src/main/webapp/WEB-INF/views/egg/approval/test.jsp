<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<link href="${pageContext.request.contextPath}/resources/assets/vendor/jstree/themes/default/style.min.css" rel="stylesheet" type="text/css">
 <div class="container mt-5">
            <div class="row mb-3">
                <label for="title" class="col-sm-2 col-form-label">제목</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="title">
                </div>
            </div>

            <h5>1. 교육개요</h5>
            <div class="mb-3 row">
                <label for="educationName" class="col-sm-2 col-form-label">프로젝트 목표</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="educationName">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="educationContent" class="col-sm-2 col-form-label">프로젝트 과정</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="educationContent">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="educationPeriod" class="col-sm-2 col-form-label">프로젝트 기간</label>
                <div class="col-sm-4">
                    <input type="date" class="form-control" id="educationPeriodStart">
                </div>
                <div class="col-sm-1 text-center">~</div>
                <div class="col-sm-4">
                    <input type="date" class="form-control" id="educationPeriodEnd">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="educationTime" class="col-sm-2 col-form-label">회의 시간</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="educationTime">
                </div>
                <label for="educationPlace" class="col-sm-2 col-form-label">프로젝트 장소</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="educationPlace">
                </div>
            </div>

            <h5>2. 프로젝트 내용</h5>
            <div class="mb-3">
                <textarea class="form-control" id="educationDetails" rows="5"></textarea>
            </div>

            <h5>3. 결과</h5>
            <div class="mb-3">
                <textarea class="form-control" id="applicationPoints" rows="3"></textarea>
            </div>

            <h5>4. 기타</h5>
            <div class="mb-3">
                <textarea class="form-control" id="others" rows="3"></textarea>
            </div>

    </div>