<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

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
    <div class="account-pages pt-2 pt-sm-5 pb-4 pb-sm-5 position-relative">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-xxl-4 col-lg-5">
                    <div class="card">

                        <!-- Logo -->
                        <div class="card-header py-4 text-center bg-primary">
                            <a href="/egg/login">
                                <span><img src="${pageContext.request.contextPath }/resources/logo/EGG_logo_full_dark.png" alt="logo" height="22"></span>
                            </a>
                        </div>

                        <div class="card-body p-4">

                            <form action="/login" method="post">

                                <div class="mb-3">
                                    <label for="id" class="form-label">ID</label>
                                    <input class="form-control" type="text" id="id" name="username" required="" placeholder="Enter your ID" >
                                </div>

                                <div class="mb-3">
<!--                                     <a href="pages-recoverpw.html" class="text-muted float-end"><small>Forgot your password?</small></a> -->
                                    <label for="password" class="form-label">Password</label>
                                    <div class="input-group input-group-merge">
                                        <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" >
                                        <div class="input-group-text" data-password="false">
                                            <span class="password-eye"></span>
                                        </div>
                                    </div>
                                </div>

<!--                                 <div class="mb-3 mb-3"> -->
<!--                                     <div class="form-check"> -->
<!--                                         <input type="checkbox" class="form-check-input" id="checkbox-signin" name="remember-me"> -->
<!--                                         <label class="form-check-label" for="checkbox-signin">Remember me</label> -->
<!--                                     </div> -->
<!--                                 </div> -->

                                <div class="mb-3 mb-0 text-center">
                                    <button class="btn btn-primary" type="submit"> Log In </button>
                                </div>
                                <div class="mb-3 mb-0 text-center">
                                    <button type="button" class="btn btn-secondary" id="kim-btn"> 김환용 사원 </button>
                                    <button type="button" class="btn btn-secondary" id="park-btn"> 박상현 사원 </button>
                                </div>
                                <!-- security를 적요 후 데이터 전송 시, csrfInput으로 시큐리티 토큰을 전송해야한다. -->
								<sec:csrfInput/>
								<h4 style="text-align: center;"> <font color="red"> <c:out value="${error }"/> </font> </h4>
                            </form>
                        </div> <!-- end card-body -->
                    </div>
                    <!-- end card -->

                </div> <!-- end col -->
            </div>
            <!-- end row -->
        </div>
        <!-- end container -->
    </div>
    <!-- end page -->

    <footer class="footer footer-alt">
        <script>document.write(new Date().getFullYear())</script> © EGG
    </footer>
    
    
    <script>
    
	    document.getElementById("kim-btn").addEventListener("click", function(){
	        console.log("kim clicked");
	        document.getElementById("id").value = "20180912";
	        document.getElementById("password").value = "1234";
	    });
	
	    document.getElementById("park-btn").addEventListener("click", function(){
	        console.log("park clicked");
	        document.getElementById("id").value = "20180122";
	        document.getElementById("password").value = "1234";
    	});

    	
    </script>
