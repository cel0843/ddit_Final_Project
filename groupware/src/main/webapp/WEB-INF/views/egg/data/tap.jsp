<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<ul class="nav nav-tabs mb-3">
    <li class="nav-item">
        <a href="#home" data-bs-toggle="tab" aria-expanded="true" class="nav-link active">
            <i class="mdi mdi-home-variant d-md-none d-block"></i>
            <span class="d-none d-md-block">개인자료실</span>
        </a>
    </li>
    <li class="nav-item">
        <a href="#profile" data-bs-toggle="tab" aria-expanded="false" class="nav-link ">
            <i class="mdi mdi-account-circle d-md-none d-block"></i>
            <span class="d-none d-md-block">공용자료실</span>
        </a>
    </li>
</ul>

<div class="tab-content">
    <div class="tab-pane show active" id="home">
        <%@include file="/WEB-INF/views/egg/data/privateDataDirectory.jsp" %>
    </div>
    <div class="tab-pane " id="profile">
        <%@include file="/WEB-INF/views/egg/data/commonDataDirectory.jsp" %>
    </div>
</div>
</body>
</html>