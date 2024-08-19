<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>EGG Work</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />

    <!-- App favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/assets/images/favicon.ico">

    <!-- Theme Config Js -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/hyper-config.js"></script>

    <!-- App css -->
    <link href="${pageContext.request.contextPath }/resources/assets/css/app-saas.min.css" rel="stylesheet" type="text/css" id="app-style" />

    <!-- Icons css -->
    <link href="${pageContext.request.contextPath }/resources/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    
</head>

<body>
    <!-- Begin page -->
    <div class="wrapper">

        <!-- ============================================================== -->
        <!-- Start Page Content here -->
        <!-- ============================================================== -->
			<div class="position-absolute start-0 end-0 start-0 bottom-0 w-100 h-100">
		        <svg xmlns='http://www.w3.org/2000/svg' width='100%' height='100%' viewBox='0 0 800 800'>
		            <g fill-opacity='0.22'>
		                <circle style="fill: rgba(var(--ct-primary-rgb), 0.1);" cx='400' cy='400' r='600' />
		                <circle style="fill: rgba(var(--ct-primary-rgb), 0.2);" cx='400' cy='400' r='500' />
		                <circle style="fill: rgba(var(--ct-primary-rgb), 0.3);" cx='400' cy='400' r='300' />
		                <circle style="fill: rgba(var(--ct-primary-rgb), 0.4);" cx='400' cy='400' r='200' />
		                <circle style="fill: rgba(var(--ct-primary-rgb), 0.5);" cx='400' cy='400' r='100' />
		            </g>
		        </svg>
		    </div>
		    
		    <!-- 모듈 초기화 상태 Modal -->
			<div id="reset-info-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
			    <div class="modal-dialog modal-sm">
			        <div class="modal-content">
			            <div class="modal-body p-4">
			                <div class="text-center">
			                    <i class="ri-information-line h1 text-info"></i>
			                    <h4 class="mt-2" id="reset-info-modal-header">초기화 상태</h4>
<!-- 			                    <p class="mt-3">초기화</p> -->
			                    <button type="button" class="btn btn-secondary my-2" data-bs-dismiss="modal">확인</button>
			                </div>
			            </div>
			        </div><!-- /.modal-content -->
			    </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
		    
		    <!-- 지문 인식중 모달 -->
		    <div class="modal fade" id="checking-modal" tabindex="-1" role="dialog" aria-hidden="true">
			    <div class="modal-dialog modal-dialog-centered">
			        <div class="modal-content">
			            <div class="modal-header">
			                <h3 class="modal-title" id="myCenterModalLabel">CHECKING...</h3>
			            </div>
			            <div class="modal-body text-center">
			            	<h2>
								지문인식중... <div class="spinner-grow text-secondary" role="status"></div>
			            	</h2>
			            </div>
			        </div><!-- /.modal-content -->
			    </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->

		    
			<!-- 결과 모달 -->
			<!-- 출근 성공 -->
			<div id="success-alert-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
			    <div class="modal-dialog modal-sm">
			        <div class="modal-content modal-filled bg-primary">
			            <div class="modal-body p-4">
			                <div class="text-center">
			                    <i class="ri-check-line h1"></i>
			                    <h4 class="mt-2">SUCCESS!</h4>
			                    <h5 class="mt-3">정상 출근 되었습니다!</h5>
			                    <button type="button" class="btn btn-light my-2" data-bs-dismiss="modal">확인</button>
			                </div>
			            </div>
			        </div><!-- /.modal-content -->
			    </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
			
			<!-- 이미 출근한 사원 -->
			<div id="info-alert-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
			    <div class="modal-dialog modal-sm">
			        <div class="modal-content">
			            <div class="modal-body p-4">
			                <div class="text-center">
			                    <i class="ri-information-line h1 text-info"></i>
			                    <h4 class="mt-2">INFO!</h4>
			                    <p5 class="mt-3">이미 출근한 사원입니다!</h5>
			                    <button type="button" class="btn btn-info my-2" data-bs-dismiss="modal">Continue</button>
			                </div>
			            </div>
			        </div><!-- /.modal-content -->
			    </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
			
			<!-- 존재하지 않는 사원 -->
			<div id="warning-alert-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
			    <div class="modal-dialog modal-sm">
			        <div class="modal-content">
			            <div class="modal-body p-4">
			                <div class="text-center">
			                    <i class="ri-alert-line h1 text-warning"></i>
			                    <h4 class="mt-2">WARN</h4>
			                    <h5 class="mt-3">등록되지 않은 사원입니다!</h5>
			                    <button type="button" class="btn btn-warning my-2" data-bs-dismiss="modal">Continue</button>
			                </div>
			            </div>
			        </div><!-- /.modal-content -->
			    </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
			
			<!-- 서버 오류 -->
			<div id="danger-alert-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
			    <div class="modal-dialog modal-sm">
			        <div class="modal-content modal-filled bg-danger">
			            <div class="modal-body p-4">
			                <div class="text-center">
			                    <i class="ri-close-circle-line h1"></i>
			                    <h4 class="mt-2">DANGER!</h4>
			                    <p class="mt-3">서버 오류! 관리자에게 문의하세요!</p>
			                    <button type="button" class="btn btn-light my-2" data-bs-dismiss="modal">Continue</button>
			                </div>
			            </div>
			        </div><!-- /.modal-content -->
			    </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->

                         
			
			
            <div class="account-pages pt-2 pt-sm-5 pb-4 pb-sm-5 position-relative">
                <!-- Start Content-->
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-12">
                            <div class="card">
                            	
                            	<div class="card-header d-flex justify-content-between align-items-center">
                            		<h1>EGG WORK</h1>
                            		<div>
	                            		<button id="workInBtn" class="btn btn-primary btn-lg">출근하기</button>
<!-- 	                            		<button id="resetModuleBtn" class="btn btn-secondary btn-lg">초기화</button> -->
                            		</div>
                            	</div>
                            	
                                <div class="card-body">

                                    <div class="table-responsive" style="height: 600px;">
                                        <table class="table table-centered table-nowrap mb-0">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>사번</th>
                                                    <th>이름</th>
                                                    <th>출근시간</th>
                                                </tr>
                                            </thead>
                                            <tbody id="work-list-table-body" style="max-height: 500px;">
                                            	<c:forEach items="${workList }" var="work">
	                                                <tr>
	                                                    <td> <h4>${work.emplId }</h4> </td>
	                                                    <td>
	                                                        <div class="d-flex">
	                                                            <div class="d-flex align-items-center">
	                                                                <div class="flex-shrink-0">
	                                                                    <img src="${work.profileImg }" class="rounded-circle avatar-xs" alt="">
	                                                                </div>
	                                                                <div class="flex-grow-1 ms-2">
	                                                                    <h4 class="my-0">${work.emplNm }</h4>
	                                                                </div>
	                                                            </div>
	                                                        </div>
	                                                    </td>
	                                                    <td> 
	                                                    	<h4> ${work.inTime } </h4>
	                                                    </td>
	                                                </tr>
                                            	</c:forEach>

                                            </tbody>
                                        </table>
                                        
                                    </div>
                                    
                                </div> <!-- end card-body-->
                            </div> <!-- end card-->
                        </div> <!-- end col -->
                    </div> <!-- end row -->
                </div> <!-- container -->
            </div> <!-- content -->
            
            
    </div>
    <!-- END wrapper -->

    <!-- Vendor js -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/vendor.min.js"></script>

    <!-- App js -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/app.min.js"></script>
    
    <!-- jQuery -->
    <script src="${pageContext.request.contextPath }/resources/js/jquery.min.js"></script>

</body>

<!-- jquery-toast-plugin -->
<script src="${pageContext.request.contextPath }/resources/assets/vendor/jquery-toast-plugin/jquery.toast.min.js"></script>
<link href="${pageContext.request.contextPath }/resources/assets/vendor/jquery-toast-plugin/jquery.toast.min.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
$(function(){
	
	$("#resetModuleBtn").on("click", function(){
		console.log("초기화 해보자!");
		$.ajax({
	        url: "/work/resetModule",
	        type: "GET",
	        success: function(res) {
	        	console.log("처리 결과 : " + res.status);
	        	if (res.status == "success") {
	        		$("#reset-info-modal-header").text("초기화 성공!");
				} else {
	        		$("#reset-info-modal-header").text("초기화 실패!");
				}
	        	
	        	// modal 열기
	        	$("#reset-info-modal").modal('show'); // 성공
	            setTimeout(function(){
	            	$("#reset-info-modal").modal('hide');
	            }, 1500); // 2초 후에 모달을 닫기
	        },
	        error: function(error) {
	            console.log("Error", error);
	        }
	    });
	});
	
	
	$("#workInBtn").on("click", function(){
		console.log("출근해보자!");
		$(this).attr("disabled", true);
		$(this).html("<span class='spinner-grow spinner-grow-sm me-1' role='status' aria-hidden='true'></span>Loading...");
		$("#checking-modal").modal('show');
		$.ajax({
	        url: "/work/insertWorkBeginTime",
	        type: "GET",
	        success: function(res) {
	        	console.log("처리 결과 : " + res.workInCheck); // del
				$("#checking-modal").modal('hide');
	        	showModal(res.workInCheck);
	        	refreshList(res.workList);
				$("#workInBtn").attr("disabled", false);
				$("#workInBtn").html("출근하기");
	        },
	        error: function(error) {
	            console.log("Error", error);
	        }
	    });
	});
	
	function refreshList(workList){
		var listHTML = "";
		$.each(workList, function(index, work) {
			listHTML += "<tr>";
			listHTML += "	<td> <h4>" + work.emplId + "</h4> </td>";
			listHTML += "	<td>";
			listHTML += "		<div class='d-flex'>";
			listHTML += "			<div class='d-flex align-items-center'>";
			listHTML += "				<div class='flex-shrink-0'>";
			listHTML += "					<img src=" + work.profileImg + " class='rounded-circle avatar-xs'>";
			listHTML += "				</div>";
			listHTML += "				<div class='flex-grow-1 ms-2'>";
			listHTML += "					<h4 class='my-0'>" + work.emplNm + "</h4>";
			listHTML += "				</div>";
			listHTML += "			</div>";
			listHTML += "		</div>";
			listHTML += "	</td>";
			listHTML += "	<td><h4>" + work.inTime + "</h4></td>";
			listHTML += "</tr>";
		});
		$("#work-list-table-body").html(listHTML);
		console.log("## 리스트 갱신중..."); // del
	}
	
	
    function showModal(resultMsgType) {
    	var alertModalType = "#";
    	
    	if (resultMsgType == "error") {
    		alertModalType += "danger-alert-modal"
		}
    	
    	if (resultMsgType == "success") {
    		alertModalType += "success-alert-modal"
		}
    	
    	if (resultMsgType == "already") {
    		alertModalType += "info-alert-modal"
		}
    	
    	if (resultMsgType == "notFound") {
    		alertModalType += "warning-alert-modal"
		}
    	
        $(alertModalType).modal('show'); // 성공
        setTimeout(function(){
            $(alertModalType).modal('hide');
        }, 1500); // 2초 후에 모달을 닫기
        
    }
	
});

</script>

</html>