<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>

<html lang="en" data-menu-color="light">

<head>
    <meta charset="utf-8" />
    <title>EGG-Groupware</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta id="_csrf" name="_csrf" content="${_csrf.token }">
	<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName }">
	<!-- eggfont  ================================================   -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/common_css/eggFont.css">
	
    <!-- App favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/assets/images/favicon.ico">

    <!-- Daterangepicker css -->
    <link href="${pageContext.request.contextPath }/resources/assets/vendor/daterangepicker/daterangepicker.css" rel="stylesheet" type="text/css">

    <!-- Vector Map css -->
    <link href="${pageContext.request.contextPath }/resources/assets/vendor/jsvectormap/css/jsvectormap.min.css" rel="stylesheet" type="text/css">

    <!-- Theme Config Js -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/hyper-config.js"></script>

	<!-- Select2 JS -->
	<link href="${pageContext.request.contextPath }/resources/assets/vendor/select2/css/select2.min.css" rel="stylesheet" type="text/css" />

    <!-- App css -->
    <link href="${pageContext.request.contextPath }/resources/assets/css/app-saas.min.css" rel="stylesheet" type="text/css" id="app-style" />

    <!-- Icons css -->
    <link href="${pageContext.request.contextPath }/resources/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    
    <!-- star select js  -->
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/jquery.rateit/scripts/rateit.css" rel="stylesheet">
    
    <!-- Datatables css -->
	<link href="${pageContext.request.contextPath }/resources/assets/vendor/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath }/resources/assets/vendor/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" type="text/css" />
    
    <!-- JQuery -->
	<script src="${pageContext.request.contextPath }/resources/js/jquery.min.js"></script>
	
	<!-- SweetAlert -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	
	<!-- CKEDITOR -->
	<script	src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>
	
	<script type="text/javascript">
		var token = "";		// 시큐리티 인증 시, 사용할 토큰 정보
		var header = "";	// 시큐리티 인증 시, 사용할 토큰 키
		$(function(){
			token = $("meta[name='_csrf']").attr("content");
			header = $("meta[name='_csrf_header']").attr("content");
		});
	</script>
	
	<!-- sockjs -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
	<!-- 챗팅 소켓 연결 -->
	<script type="text/javascript">
		// ddit lan
		var chatSock = new SockJS("http://192.168.35.47/egg/chat");
		var alarmSock = new SockJS("http://192.168.35.47/egg/alarm");

		// ddit wifi
// 		var chatSock = new SockJS("http://192.168.35.120/egg/chat");
// 		var alarmSock = new SockJS("http://192.168.35.120/egg/alarm");

		// test localhost
// 		var chatSock = new SockJS("http://localhost/egg/chat");
// 		var alarmSock = new SockJS("http://localhost/egg/alarm");

		var inChatPage = false;
		var inApprovalPage = false;
		var inMailPage = false;
		// letsgo
	</script>
	
	
</head>
<c:if test="${not empty message }">
	<script type="text/javascript">
		alert("${message}");
		<c:remove var="message" scope="request"/>
	</script>
</c:if>
<script type="text/javascript">
	$('html').attr('data-menu-color', 'light');
</script>

<body>
    <!-- Begin page -->
    <div class="wrapper">
        
        <!-- ========== Topbar Start ========== -->
        <tiles:insertAttribute name="header" />
        <!-- ========== Topbar End ========== -->

        <!-- ========== Left Sidebar Start ========== -->
        <tiles:insertAttribute name="aside" />
        <!-- ========== Left Sidebar End ========== -->

        <!-- ============================================================== -->
        <!-- Start Page Content Here -->
        <!-- ============================================================== -->

        <div class="content-page">
            <div class="content">

                <!-- Start Content-->
                <div class="container-fluid">
					<!-- //// title start ///// -->
                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box">
                            	<!-- 타이틀 -->
<!--                                 <h4 class="page-title">Dashboard</h4> -->
                                <div class="page-title-right">
                                	<!-- 타이틀 오른쪽 -->
                                </div>
                            </div>
                        </div>
                    </div>
					<!-- //// title end ///// -->
					<div class="row">
					<!-- //// content start ///// -->
						<tiles:insertAttribute name="user_body" />
					<!-- //// content end ///// -->
                    </div>
                </div>
                <!-- container -->

            </div>
            <!-- content -->

            <!-- Footer Start -->
            <tiles:insertAttribute name="footer" />
            <!-- end Footer -->
            
        </div>

        <!-- ============================================================== -->
        <!-- End Page content -->
        <!-- ============================================================== -->

    </div>
    <!-- END wrapper -->


    <!-- Vendor js -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/vendor.min.js"></script>

    <!-- Daterangepicker js -->
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/daterangepicker/moment.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/daterangepicker/daterangepicker.js"></script>

	<!-- jstree js -->
	<script src="${pageContext.request.contextPath}/resources/assets/vendor/jstree/jstree.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/pages/demo.jstree.js"></script>

    <!-- Vector Map Js -->
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/jsvectormap/js/jsvectormap.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/jsvectormap/maps/world-merc.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/jsvectormap/maps/world.js"></script>

    <!-- Dashboard App js -->
<%--     <script src="${pageContext.request.contextPath }/resources/assets/js/pages/demo.dashboard.js"></script> --%>

	<script src="${pageContext.request.contextPath }/resources/assets/vendor/select2/js/select2.min.js"></script>

<script src="${pageContext.request.contextPath }/resources/assets/vendor/quill/quill.min.js"></script>

    <!-- App js -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/app.min.js"></script>
    
    <!-- jquery-toast-plugin -->
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/jquery-toast-plugin/jquery.toast.min.js"></script>
    <link href="${pageContext.request.contextPath }/resources/assets/vendor/jquery-toast-plugin/jquery.toast.min.css" rel="stylesheet" type="text/css">
    <!-- alram js -->
    <script src="${pageContext.request.contextPath }/resources/common_js/alramJS.js"></script>
	
	<!-- Datatables js -->
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/vendor/datatables.net/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/vendor/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/vendor/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/vendor/datatables.net-responsive-bs5/js/responsive.bootstrap5.min.js"></script>
	
	<!-- Datatable Init js -->
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/js/pages/demo.datatable-init.js"></script>
	
	<!-- star select js  -->
	<script src="${pageContext.request.contextPath }/resources/assets/vendor/jquery.rateit/scripts/jquery.rateit.min.js"></script>
</body>

</html>