<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>	    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>	    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<ul class="nav nav-tabs mb-3">
    <li class="nav-item">
        <a href="redirect:/egg/data/dataMain" data-bs-toggle="tab" aria-expanded="false" class="nav-link ">
            <i class="mdi mdi-home-variant d-md-none d-block"></i>
            <span class="d-none d-md-block">개인자료실</span>
        </a>
    </li>
    <li class="redirect:/egg/data/commonDataMain">
        <a href="#profile" data-bs-toggle="tab" aria-expanded="true" class="nav-link active">
            <i class="mdi mdi-account-circle d-md-none d-block"></i>
            <span class="d-none d-md-block">공용자료실</span>
        </a>
    </li>
</ul>

<div class="container">
	<div class="row">
		<div class="col-md-4" style="margin-bottom: 20px;">
			<button type="button" id="prev" class="btn btn-secondary" >상위폴더</button>
			<button type="submit" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#bs-example-modal-lg">파일 업로드</button>
		</div>
	</div>	
	<div class="row">
		<c:choose>
			<c:when test="${empty fileList }">
			<div class="col-md-2">
				<div class="card">
					<div class="card-header">
						<p>조회하실 파일이 존재하지 않습니다.</p>
					</div>
					<div class="card-body"></div>
				</div>
			</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${fileList }" var="file">
				<div class="col-md-2">
					<div class="card">
					<c:set var="filename" value="${file.fileStrgNm }" />
					<c:set var="fileNm" value="${fn:toLowerCase(filename)}" />
					<c:forTokens var="token" items="${fileNm }" delims="." varStatus="status">
						<c:if test="${status.last }">
							<c:choose>
								<c:when test="${token eq 'hwp' }">
									<div class="display-1 text-center" >
										<i class="ri-file-hwp-fill"></i>
									</div>
								</c:when>
								<c:when test="${token eq 'xls'|| token eq 'xlsx'}">
									<div class="display-1 text-center" >
										<i class="ri-file-excel-2-fill"></i>
									</div>
								</c:when>
								<c:when test="${token eq 'jpg'}">
									<div class="display-3 text-center" >
										<i class=" ri-file-user-fill"></i>
									</div>
								</c:when>
								<c:when test="${token eq 'png'}">
                                    <div class="display-3 text-center">
										<img src="/upload/data${file.fileStrgNm}" style="width:100%;"  height="80px;" />
                                    </div>
                               	</c:when>
                               	<c:when test="${token eq 'webp'}">
                                    <div class="display-3 text-center">
										<img src="/upload/data${file.fileStrgNm}" style="width:100%;"  height="80px;" />
                                   	</div>
                                 </c:when>
								<c:when test="${token eq 'gif'}">
									<div class="display-1 text-center" >
										<i class="ri-file-gif-fill"></i>
									</div>
								</c:when>
								<c:when test="${token eq 'pdf'}">
									<div class="display-1 text-center" >
										<i class="ri-file-pdf-fill"></i>
									</div>
								</c:when>
								<c:when test="${token eq 'ppt' }">
									<div class="display-1 text-center" >
										<i class="ri-file-ppt-2-fill"></i>
									</div>
								</c:when>
								<c:when test="${token eq 'txt' }">
									<div class="display-1 text-center" >
										<i class="ri-file-info-fill"></i>
									</div>
								</c:when>
								<c:when test="${token eq 'ini' }">
									<div class="display-1 text-center" >
										<i class="ri-file-settings-fill"></i>
									</div>
								</c:when>
								<c:otherwise>
									<div class="display-1 text-center" >
										<i class="ri-file-unknow-fill"></i>
									</div>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:forTokens>
						<div class="card-body text-center">
							<h4>${file.fileOrgnlNm} <br>[${file.fileFancysize }]</h4>  
							<button  type="button" id="downFile" class="btn btn-primary" >다운로드</button>
							
							<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
								<button  type="button" class="delFile btn btn-danger">파일삭제</button>
							</sec:authorize>
							<form action="/egg/data/delete" method="post" class="delForm">
								<input type="hidden" id="fileGn" name="fileGroupNo"  value="${file.fileGroupNo }" >
								<input type="hidden"  name=fileNo value="${file.fileNo}">
								<sec:csrfInput/>
							</form>
						</div>
					</div>
				</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
 </div>
<!-- Large modal -->



<!--Content starts-->
<div class="modal fade" id="bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myLargeModalLabel">파일 업로드</h4>
                	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
			</div>
           	<div class="modal-body">
          		<form action="/egg/data/folderFileupload" method="post" id="drop" enctype="multipart/form-data" >
				    <div class="hidden">
				    	<input name="fldTyCd" type="hidden" value="P">
				    	<input name="fileGroupNo" id="fileGroupNo" type="hidden" > 
				    	<input type="hidden"  name=fldNo value="${fldNo}">
				    </div>
								   
<!-- File Upload -->
					<div class="dropzone" id="myAwesomeDropzone" data-plugin="dropzone" data-previews-container="#file-previews"
								    data-upload-preview-template="#uploadPreviewTemplate" >
				   		<div class="dropzone-container">
				   	 		<input name="file" class="file" type="file" id="fileInput" multiple hidden />
				      	</div>
				    	<div class="dz-message needsclick">
				        	<i class="h1 text-muted ri-upload-cloud-2-line"></i>
				        	<h3>파일을 업로드 하려면 <font color="#0101DF">Click</font> 해주세요.</h3>
					    </div>	
					</div>
				    <sec:csrfInput/>
            	</form>
							
<!-- Preview -->
				<div class="dropzone-previews mt-3" id="file-previews"></div>
           </div> <!-- /.modal-body -->
           
           
           <div class="modal-footer">
               <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
               <button type="button" class="btn btn-primary" id="fileSave">파일 저장</button>
           </div>
       </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal --> 
</body>
<script type="text/javascript">
	$(function(){
		var drop = $("#drop");
		var fileSave = $("#fileSave");
		var dropzone = document.getElementById('myAwesomeDropzone');
		var fileInput = document.getElementById('fileInput');
		var folderFileUpload = $("#folderFileUpload"); 
		var fileSave = $("#fileSave");
		var prev = $("#prev");
		var downFile = $("#downFile");
		
		
		$("#fileInput").on("change",function(e){

			dropzone.style.backgroundColor = '';
			let files = e.target.files;
			let filesArr = Array.prototype.slice.call(files);
			
			let str = "";
			
			filesArr.forEach(function(f){
				console.log("name : " + f.name);
				
				str += f.name + "<br>"
			});
			
			$("#file-previews").html(str);
			
		});
		
		//드롭존을 클릭하면 파일선택 창이 돌출
		dropzone.addEventListener('click', function() {
		  fileInput.click();
		});
		
		fileSave.on("click",function(e){
			var fileGn = $("#fileGn").val();
			var fileGroupNo = $("#fileGroupNo").val(fileGn);
			drop.submit();			
		});
		prev.on("click",function(){
			window.history.back();
		})
		$(document).on("click","#downFile",function(){
		})
		$(document).on("click",".delFile",function(){
			if(confirm("파일을 정말로 삭제하시겠습니까?")){
				$(".delForm").submit();
			}
		})
	});
</script>
</html>