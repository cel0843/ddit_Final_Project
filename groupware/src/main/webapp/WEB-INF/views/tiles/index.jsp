<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="en">

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

    <!-- App css -->
    <link href="${pageContext.request.contextPath }/resources/assets/css/app-saas.min.css" rel="stylesheet" type="text/css" id="app-style" />

    <!-- Icons css -->
    <link href="${pageContext.request.contextPath }/resources/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    
    <!-- Datatables css -->
	<link href="${pageContext.request.contextPath }/resources/assets/vendor/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath }/resources/assets/vendor/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" type="text/css" />
    
    <!-- Flatpickr Timepicker css  -->
    <link href="${pageContext.request.contextPath }/resources/assets/vendor/flatpickr/flatpickr.min.css" rel="stylesheet" type="text/css" />
    
    
    
    <script src="${pageContext.request.contextPath }/resources/js/jquery.min.js"></script>
    
    
</head>
<style>
/* body, h1, h2, h3, h4, h5, h6, input, textarea, select { */
/* 	font-family: 'Noto Sans KR', sans-serif; */
/* } */

</style>
<script type="text/javascript">
	var token = "";		// 시큐리티 인증 시, 사용할 토큰 정보
	var header = "";	// 시큐리티 인증 시, 사용할 토큰 키
	$(function(){
		token = $("meta[name='_csrf']").attr("content");
		header = $("meta[name='_csrf_header']").attr("content");
	});
	
	$('html').attr('data-menu-color', 'dark');
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
						<tiles:insertAttribute name="body" />
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

    <!-- Apex Charts js -->
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/apexcharts/apexcharts.min.js"></script>

    <!-- Vector Map Js -->
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/jsvectormap/js/jsvectormap.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/jsvectormap/maps/world-merc.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/jsvectormap/maps/world.js"></script>

    <!-- Dashboard App js -->
<%--     <script src="${pageContext.request.contextPath }/resources/assets/js/pages/demo.dashboard.js"></script> --%>

    <!-- App js -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/app.min.js"></script>

<!-- 창은이가 시작하는 데이터 테이블 설정 -->
	<!-- Datatables js -->
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/vendor/datatables.net/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/vendor/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/vendor/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/vendor/datatables.net-responsive-bs5/js/responsive.bootstrap5.min.js"></script>
	
	<!-- Datatable Init js -->
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/js/pages/demo.datatable-init.js"></script>
	<!-- 창은이가 시작하는 데이터 테이블 설정 끝 -->
	
	<!-- Flatpickr Timepicker   -->
	<script src="${pageContext.request.contextPath}/resources/assets/vendor/flatpickr/flatpickr.min.js"></script>
	
	<!-- 설문 반원 차트   -->
	<script src="${pageContext.request.contextPath}/resources/assets/js/pages/a.apex-radialbar.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/pages/a.apex-pie.js"></script>
	
	<!-- CKEDITOR -->
	<script	src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>
	

</body>

</html>