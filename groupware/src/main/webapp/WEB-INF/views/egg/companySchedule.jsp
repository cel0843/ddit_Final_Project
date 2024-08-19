<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>일정관리</title>

<style type="text/css">
.test123{
	display: flex;
	flex-direction: row;
}
.cstable{
	margin-left: 15px;
}

.card{
	border-radius: 15px;
}

.company_schedule_cal{
	height: 447px !important;
}
</style>

</head>
<body>
	<h2>사내일정</h2>
<!-- 	<input class="btn btn-outline-light" type="button" value="+ 새 일정 등록"> -->
<div class="test123">
	<div class="card" style="width: 80%; height: 95%;">
		<div class="card-body">
			<div>
				<div id="external-events"></div>
				<div id="calendar" class="company_schedule_cal"></div>
			</div>
		</div>
	</div>
	<c:set value="${csVOList}" var="csVOList"/>
	<div class="cstable">
		<div class="card" style="width: 100%; height: 95%;">
			<div class="card-body">
				<h2>Summary</h2>
				<ul id="summuryInfoList">
					<c:forEach items="${summuryInfo }" var="csVO">
						<li>${csVO }</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</div>

	<div class="modal fade" id="event-modal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<form class="needs-validation" name="event-form" id="form-event" novalidate>
					<div class="modal-header py-3 px-4 border-bottom-0">
						<h5 class="modal-title" id="modal-title">Event</h5>
						<button type="button" class="btn-close"
							data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body px-4 pb-4 pt-0">
						<div class="row">
							<input type="text" hidden="true" id="event-no" name="no"  >
							<div class="col-12">
								<div class="mb-3">
									<label class="control-label form-label">프로젝트 일정</label>
									<input class="form-control"
										placeholder="일정을 등록하세요" type="text" name="title"
										id="event-title" required />
									<div class="invalid-feedback">일정을 등록해주세요</div>
								</div>
							</div>
							<div class="col-12">
								<div class="mb-3">
									<label class="control-label form-label">일정 내용</label>
									<input class="form-control"
										placeholder="내용을 등록하세요" type="text" name="content"
										id="event-content" required />
									<div class="invalid-feedback">내용을 등록해주세요</div>
								</div>
							</div>
							<div class="col-12">
								<div class="mb-3">
									<label class="control-label form-label">색상</label> <select
										class="form-select" name="category" id="event-category"
										required>
										<option value="bg-danger" selected>red</option>
										<option value="bg-success">green</option>
										<option value="bg-primary">blue</option>
										<option value="bg-info">sky</option>
										<option value="bg-dark">black</option>
										<option value="bg-warning">yellow</option>
									</select>
									<div class="invalid-feedback">Please select a valid
										event category</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-6">
								<button type="button" class="btn btn-danger"
									id="btn-delete-event">Delete</button>
							</div>
							<div class="col-6 text-end">
								<button type="button" class="btn btn-light me-1"
									data-bs-dismiss="modal">Close</button>
								<button type="submit" class="btn btn-success"
									id="btn-save-event">Save</button>
							</div>
						</div>
					</div>
				</form>
			</div>
			<!-- end modal-content-->
		</div>
		<!-- end modal dialog-->
	</div>


	<!-- Fullcalendar js -->
	<script src="${pageContext.request.contextPath }/resources/assets/vendor/fullcalendar/index.global.min.js"></script>
	<!-- Calendar App refactoring js -->
	<script src="${pageContext.request.contextPath }/resources/assets/js/pages/a.companycalendar.js"></script>
</body>

<script type="text/javascript">
var goProjNo = 1;
</script>
</html>
