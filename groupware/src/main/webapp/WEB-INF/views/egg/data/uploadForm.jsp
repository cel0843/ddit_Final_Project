<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
                                                    
</head>
<body>
	<!-- File Upload -->
	<form action="/" method="post" class="dropzone" id="myAwesomeDropzone" data-plugin="dropzone" data-previews-container="#file-previews"
	    data-upload-preview-template="#uploadPreviewTemplate">
	    
	   <div class="dropzone-container">
        <input name="file" type="file" id="fileInput" multiple hidden />
      </div>

	    <div class="dz-message needsclick">
	        <i class="h1 text-muted ri-upload-cloud-2-line"></i>
	        <h3>Drop files here or click to upload.</h3>
	    </div>
	</form>
	
	<!-- Preview -->
	<div class="dropzone-previews mt-3" id="file-previews"></div>
	
	<!-- file preview template -->
	<div class="d-none" id="uploadPreviewTemplate">
	    <div class="card mt-1 mb-0 shadow-none border">
	        <div class="p-2">
	            <div class="row align-items-center">
	                <div class="col-auto">
	                    <img data-dz-thumbnail src="#" class="avatar-sm rounded bg-light" alt="">
	                </div>
	                <div class="col ps-0">
	                    <a href="javascript:void(0);" class="text-muted fw-bold" data-dz-name></a>
	                    <p class="mb-0" data-dz-size></p>
	                </div>
	                <div class="col-auto">
	                    <!-- Button -->
	                    <a href="" class="btn btn-link btn-lg text-muted" data-dz-remove>
	                        <i class="ri-close-line"></i>
	                    </a>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
</body>
<script type="text/javascript">
	$(function(){
		var dropzone = document.getElementById('myAwesomeDropzone');
		var fileInput = document.getElementById('fileInput');

		dropzone.addEventListener('click', function() {
		  fileInput.click();
		});
	})
</script>
</html>