<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<div class="navbar-custom">
   <div class="topbar container-fluid">
       <div class="d-flex align-items-center gap-lg-2 gap-1">

           <!-- Topbar Brand Logo -->
           <div class="logo-topbar">
               <!-- Logo light -->
               <a href="/egg/main" class="logo-light">
                   <span class="logo-lg">
                       <img src="${pageContext.request.contextPath }/resources/logo/EGG_logo_full_light.png" alt="logo">
                   </span>
                   <span class="logo-sm">
                       <img src="${pageContext.request.contextPath }/resources/logo/EGG_logo_icon_light.png" alt="small logo">
                   </span>
               </a>

               <!-- Logo Dark -->
               <a href="/egg/main" class="logo-dark">
                   <span class="logo-lg">
                       <img src="${pageContext.request.contextPath }/resources/logo/EGG_logo_full_dark.png" alt="logo">
                   </span>
                   <span class="logo-sm">
                       <img src="${pageContext.request.contextPath }/resources/logo/EGG_logo_icon_dark.png" alt="small logo">
                   </span>
               </a>
           </div>

           <!-- Sidebar Menu Toggle Button -->
           <button class="button-toggle-menu">
               <i class="mdi mdi-menu"></i>
           </button>
			
       </div>

       <ul class="topbar-menu d-flex align-items-center gap-3">

		   <sec:authorize access="hasRole('ROLE_ADMIN')">
		   	<a href="/admin/main" class="btn btn-dark">관리자모드</a>
		   </sec:authorize>

			<li class="dropdown notification-list">
               <a class="nav-link dropdown-toggle arrow-none" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="false" aria-expanded="false"
               		id="alarmIconBtn" data-emplid="${sessionScope.emplInfo.emplId}">
                   <i class="ri-notification-3-line font-22"></i>
<!--                    <span class="noti-icon-badge"></span> -->
               </a>
               <div class="dropdown-menu dropdown-menu-end dropdown-menu-animated dropdown-lg py-0">
                   <div class="p-2 border-top-0 border-start-0 border-end-0 border-dashed border">
                       <div class="row align-items-center">
                           <div class="col">
                               <h6 class="m-0 font-16 fw-semibold"> Notification</h6>
                           </div>
                           <div class="col-auto">
                               <a href="javascript: void(0);" id="alarmClearAllBtn" class="text-dark text-decoration-underline" data-emplid="${sessionScope.emplInfo.emplId}">
                                   <small>Clear All</small>
                               </a>
                           </div>
                       </div>
                   </div>

                   <div id="alarmWindow" class="px-2" style="max-height: 300px;" data-simplebar>

                       <!-- alarm item-->

               		</div>
           </li>

		   <c:set value="${sessionScope.emplInfo}" var="emplInfo"/>
           <li class="dropdown">
               <a class="nav-link dropdown-toggle arrow-none nav-user px-2" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="false" aria-expanded="false">
                   <span class="account-user-avatar">
                       <img src="${pageContext.request.contextPath }${emplInfo.proflImageCours}" alt="user-image" width="32" class="rounded-circle">
                   </span>
                   <span class="d-lg-flex flex-column gap-1 d-none">
                       <h5 class="my-0">${emplInfo.emplNm }</h5>
                       <h6 class="my-0 fw-normal">${emplInfo.positionNm }</h6>
                   </span>
               </a>
               <div class="dropdown-menu dropdown-menu-end dropdown-menu-animated profile-dropdown">
                   <!-- item-->
                   <div class=" dropdown-header noti-title">
                       <h6 class="text-overflow m-0">${emplInfo.emplNm }님 환영합니다!</h6>
                   </div>

                   <!-- item-->
                   <a href="/egg/mypage" class="dropdown-item">
                       <i class="mdi mdi-account-circle me-1"></i>
                       <span>My Account</span>
                   </a>

                   <!-- item-->
                   <form id="logoutForm" action="/egg/logout" method="post" style="display: inline;">
    					<sec:csrfInput/>
    					<a href="javascript:void(0);" class="dropdown-item" onclick="document.getElementById('logoutForm').submit();">
        					<i class="mdi mdi-logout me-1"></i>
        					<c:choose>
        						<c:when test="${sessionScope.emplInfo.emplId != null}">
        							<span>Logout</span>
        						</c:when>
        						<c:otherwise>
        							<span>Login</span>
        						</c:otherwise>
        					</c:choose>
    					</a>
				   </form>
                </div>
            </li>
            
        </ul>
    </div>
</div>





