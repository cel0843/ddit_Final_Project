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
           
           <a href="/egg/main" class="btn btn-light">사용자모드</a>


		   <c:set value="${sessionScope.emplInfo}" var="emplInfo"/>
           <li class="dropdown">
               <a class="nav-link dropdown-toggle arrow-none nav-user px-2" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="false" aria-expanded="false">
                   <span class="account-user-avatar">
                       <img src="${pageContext.request.contextPath }${emplInfo.proflImageCours}" alt="user-image" width="32" class="rounded-circle">
                   </span>
                   <span class="d-lg-flex flex-column gap-1 d-none">
                       <h5 class="my-0">${emplInfo.emplNm}</h5>
                       <h6 class="my-0 fw-normal">${emplInfo.positionNm}</h6>
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





