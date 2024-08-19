<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container-fluid">

       <!-- start page email-title -->
       <!-- start page title -->
       <div class="row">
           <div class="col-12">
               <div class="page-title-box">
                   <div class="page-title-right">
                       <ol class="breadcrumb m-0">
                           <li class="breadcrumb-item"><a href="javascript: void(0);">Hyper</a></li>
                           <li class="breadcrumb-item"><a href="javascript: void(0);">Email</a></li>
                           <li class="breadcrumb-item active">Email Read</li>
                       </ol>
                   </div>
                   <h4 class="page-title">Email Read</h4>
               </div>
           </div>
       </div>
       <!-- end page title -->
       <!-- end page email-title -->

       <div class="row">

           <!-- Right Sidebar -->
           <div class="col-12">
               <div class="card">
                   <div class="card-body">
                       <!-- Left sidebar -->
                           <div class="page-aside-left">
                                <div class="d-grid">
								    <a href="${pageContext.request.contextPath}/egg/mail/compose" class="btn btn-danger">Compose</a>
								</div>

                            <div class="email-menu-list mt-3">
                                <a href="${pageContext.request.contextPath}/egg/mail/reList" ><i class="ri-inbox-line me-2"></i>수신메일함<span class="badge badge-info-lighten float-end ms-2">${listCount }</span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/impoList" ><i class="ri-star-line me-2"></i>중요메일함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/drfList"><i class="ri-article-line me-2"></i>임시보관함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/sendList"><i class="ri-mail-send-line me-2"></i>보낸 메일함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/trashList"><i class="ri-delete-bin-line me-2"></i>휴지통<span class="badge badge-info-lighten float-end ms-2"></span></a>
                                <a href="${pageContext.request.contextPath}/egg/mail/mineList"><i class="ri-price-tag-3-line me-2"></i>내게 쓴 메일함<span class="badge badge-info-lighten float-end ms-2"></span></a>
                            </div>
                        </div>
                       <!-- End Left sidebar -->

                       <div class="page-aside-right">

                     

       

                           <div class="mt-3">
                               <h5 class="font-18">${mail.emlTtl}</h5>

                               <hr>

                               <div class="d-flex mb-3 mt-1">
                                   <div class="w-100 overflow-hidden">
                                       <small class="float-end">${mail.emlDt}</small>
                                   </div>
                               </div>

                               <p>${mail.emlCn}</p>

                               <hr>

                               <!-- <div class="mt-5">
                                   <a href="" class="btn btn-secondary me-2"><i class="mdi mdi-reply me-1"></i> Reply</a>
                                   <a href="" class="btn btn-light">Forward <i class="mdi mdi-forward ms-1"></i></a>
                               </div> -->

                           </div>
                           <!-- end .mt-4 -->

                       </div>
                       <!-- end inbox-rightbar-->
                   </div>

                   <div class="clearfix"></div>
               </div> <!-- end card-box -->

           </div> <!-- end Col -->
       </div><!-- End row -->

   </div>
</body>
</html>
