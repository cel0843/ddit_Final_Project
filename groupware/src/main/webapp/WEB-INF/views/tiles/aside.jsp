<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="leftside-menu">

   <!-- Brand Logo Light -->
   <a href="/admin/main" class="logo logo-light">
       <span class="logo-lg">
           <img src="${pageContext.request.contextPath }/resources/logo/EGG_logo_full_light.png" alt="logo">
       </span>
       <span class="logo-sm">
           <img src="${pageContext.request.contextPath }/resources/logo/EGG_logo_icon_light.png" alt="small logo">
       </span>
   </a>

   <!-- Brand Logo Dark -->
   <a href="/admin/main" class="logo logo-dark">
       <span class="logo-lg">
           <img src="${pageContext.request.contextPath }/resources/logo/EGG_logo_full_dark.png" alt="logo">
       </span>
       <span class="logo-sm">
           <img src="${pageContext.request.contextPath }/resources/logo/EGG_logo_icon_dark.png" alt="small logo">
       </span>
   </a>

   <!-- Sidebar Hover Menu Toggle Button -->
   
   <div class="button-sm-hover" data-bs-toggle="tooltip" data-bs-placement="right" title="Show Full Sidebar">
       <i class="ri-checkbox-blank-circle-line align-middle"></i>
   </div>

   <!-- Full Sidebar Menu Close Button -->
   <div class="button-close-fullsidebar">
       <i class="ri-close-fill align-middle"></i>
   </div>

   <!-- Sidebar -->
   <div class="h-100" id="leftside-menu-container">
       <!-- Leftbar User -->
       <div class="leftbar-user">
           <a href="pages-profile.html">
               <img src="" alt="" height="42" class="rounded-circle shadow-sm">
               <span class="leftbar-user-name mt-2">사용자</span>
           </a>
       </div>

       <!--- Sidemenu -->
       <ul class="side-nav">

           <li class="side-nav-item">
               <a data-bs-toggle="collapse" href="#sidebarTaskManager" aria-expanded="false" aria-controls="sidebarDashboards" class="side-nav-link">
                   <i class="uil-clipboard-alt"></i>
                   <span> 업무관리 </span>
                   <span class="menu-arrow"></span>
               </a>
               <div class="collapse" id="sidebarTaskManager">
                   <ul class="side-nav-second-level">
                       <li>
                           <a href="/admin/csmain">일정관리</a>
                       </li>
                       <li>
                           <a href="/admin/formList">양식관리</a>
                       </li>
                       <li>
                           <a href="/admin/aprvList">결재관리</a>
                       </li>
                   </ul>
               </div>
           </li>

           <li class="side-nav-item">
               <a data-bs-toggle="collapse" href="#sidebarOrganization" aria-expanded="false" aria-controls="sidebarDashboards" class="side-nav-link">
                   <i class="ri-git-merge-line"></i>
                   <span> 조직관리 </span>
                   <span class="menu-arrow"></span>
               </a>
               <div class="collapse" id="sidebarOrganization">
                   <ul class="side-nav-second-level">
                       <li>
                           <a href="/admin/deptmain">부서관리</a>
                       </li>
                       <li>
                           <a href="/admin/empmain">사원관리</a>
                       </li>
                   </ul>
               </div>
           </li>

           <li class="side-nav-item">
               <a href="/admin/board" aria-expanded="false" aria-controls="sidebarDashboards" class="side-nav-link">
                   <i class="ri-slideshow-line"></i>
                   <span> 게시판관리 </span>
               </a>
           </li>

           <li class="side-nav-item">
               <a  href="/admin/adminDataMain" aria-expanded="false" aria-controls="sidebarDashboards" class="side-nav-link">
                   <i class="ri-drive-line"></i>
                   <span> 공용자료실 </span>
               </a>
           </li>

           <li class="side-nav-item">
               <a href="/survey/surveyMain" aria-expanded="false" aria-controls="sidebarDashboards" class="side-nav-link">
                   <i class="uil-copy-alt"></i>
                   <span> 설문 </span>
               </a>
           </li>

           <li class="side-nav-item">
               <a href="/admin/analytics/analyticsMain" aria-expanded="false" aria-controls="sidebarDashboards" class="side-nav-link">
                   <i class="ri-line-chart-line"></i>
                   <span> 통계 </span>
               </a>
           </li>

       </ul>
       <!--- End Sidemenu -->

        <div class="clearfix"></div>
    </div>
</div>