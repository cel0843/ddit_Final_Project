<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="leftside-menu">

   <!-- Brand Logo Light -->
   <a href="/egg/main" class="logo logo-light">
       <span class="logo-lg">
           <img src="${pageContext.request.contextPath }/resources/logo/EGG_logo_full_light.png" alt="logo">
       </span>
       <span class="logo-sm">
           <img src="${pageContext.request.contextPath }/resources/logo/EGG_logo_icon_light.png" alt="small logo">
       </span>
   </a>

   <!-- Brand Logo Dark -->
   <a href="/egg/main" class="logo logo-dark">
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
<%--                <img src="${pageContext.request.contextPath }/resources/---.jpg" alt="user-image" height="42" class="rounded-circle shadow-sm"> --%>
               <span class="leftbar-user-name mt-2">사용자</span>
           </a>
       </div>

       <!--- Sidemenu -->
       <ul class="side-nav">

           <li class="side-nav-item">
               <a href="/egg/main" aria-expanded="false" aria-controls="sidebarDashboards" class="side-nav-link">
                   <i class="ri-home-3-line"></i>
                   <span>홈</span>
               </a>
           </li>

           <li class="side-nav-item">
               <a href="/project/mainProjectPage" aria-expanded="false" aria-controls="sidebarDashboards" class="side-nav-link">
                   <i class="uil-briefcase"></i>
                   <span>프로젝트</span>
               </a>
           </li>

           <li class="side-nav-item">
               <a href="/egg/aprvList" aria-expanded="false" aria-controls="sidebarDashboards" class="side-nav-link">
                   <i class="uil-clipboard-alt"></i>
                   <span>전자결재 </span>
               </a>
           </li>

           <li class="side-nav-item">
               <a href="/egg/mail/reList" aria-expanded="false" aria-controls="sidebarDashboards" class="side-nav-link">
                   <i class="uil-envelope"></i>
                   <span>메일</span>
               </a>
           </li>

           <li class="side-nav-item">
               <a href="/egg/address/empllist" aria-expanded="false" aria-controls="sidebarDashboards" class="side-nav-link">
                   <i class="ri-contacts-book-line"></i>
                   <span>주소록</span>
               </a>
           </li>

           <li class="side-nav-item">
               <a href="/egg/data/dataMain" aria-expanded="false" aria-controls="sidebarDashboards" class="side-nav-link">
                   <i class="ri-drive-line"></i>
                   <span>자료실</span>
               </a>
           </li>
           
           <li class="side-nav-item">
               <a href="/egg/work" aria-expanded="false" aria-controls="sidebarDashboards" class="side-nav-link">
                   <i class="ri-user-follow-line"></i>
                   <span>근태현황</span>
               </a>
           </li>

           <li class="side-nav-item">
               <a href="/egg/mettingRoomRes" aria-expanded="false" aria-controls="sidebarDashboards" class="side-nav-link">
                   <i class="ri-reserved-line"></i>
                   <span>예약 및 대여</span>
               </a>
           </li>

           <li class="side-nav-item">
               <a href="/egg/chat_main" aria-expanded="false" aria-controls="sidebarDashboards" class="side-nav-link">
                   <i class="ri-chat-3-line"></i>
                   <span>채팅</span>
               </a>
           </li>

           <li class="side-nav-item">
               <a href="/egg/videoChat" aria-expanded="false" aria-controls="sidebarDashboards" class="side-nav-link">
                   <i class="ri-webcam-line"></i>
                   <span>화상회의</span>
               </a>
           </li>

           <li class="side-nav-item">
               <a href="/egg/board" aria-expanded="false" aria-controls="sidebarDashboards" class="side-nav-link">
                   <i class="ri-slideshow-line"></i>
                   <span>게시판</span>
               </a>
           </li>

           <li class="side-nav-item">
               <a href="/egg/survey/surveyMain" aria-expanded="false" aria-controls="sidebarDashboards" class="side-nav-link">
                   <i class="uil-copy-alt"></i>
                   <span>설문</span>
               </a>
           </li>

           <li class="side-nav-item">
               <a href="/egg/organizationChart" aria-expanded="false" aria-controls="sidebarDashboards" class="side-nav-link">
                   <i class="ri-git-merge-line"></i>
                   <span>조직도</span>
               </a>
           </li>

       </ul>
       
       <!--- End Sidemenu -->
       
       <div class="clearfix"></div>
    </div>
</div>