<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자료실</title>
</head>
<body>
<div class="row">
<div class="col-sm">
	<h4>개인 자료실</h4>
	<div class="progress col-sm-2">
  		<div class="progress-bar" style="width:70%">350MB/500MB</div>
	</div>
	<hr>
</div>
</div>
	
	<div class="row">
	  <div class="col-sm-10">
	    <div class="dropdown d-inline-block">
	      <button class="btn btn-light dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	        파일명
	      </button>
	      <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
	        <a class="dropdown-item" href="#">파일명</a>
	        <a class="dropdown-item" href="#">확장자명</a>
	      </div>
	    </div>
	  
	    <div class="dropdown d-inline-block">
	      <button class="btn btn-light dropdown-toggle" type="button" id="dropdownMenuButton2" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	        전체
	      </button>
	      <div class="dropdown-menu" aria-labelledby="dropdownMenuButton2">
	        <a class="dropdown-item" href="#">doc</a>
	        <a class="dropdown-item" href="#">pdf</a>
	        <a class="dropdown-item" href="#">zip</a>
	        <a class="dropdown-item" href="#">xls</a>
	        <a class="dropdown-item" href="#">jpg</a>
	        <a class="dropdown-item" href="#">jpeg</a>
	        <a class="dropdown-item" href="#">png</a>
	      </div>
	    </div>
	    <div class="d-inline-block">
	      <input type="text" class="form-control" placeholder="Search files...">
	    </div>
	    <div class="d-inline-block">
	      <input type="button" class="btn btn-primary" id="search" value="검색"> 
	    </div>
	    <div class="d-inline-block">
			<button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#bs-example-modal-lg">파일 업로드</button>
			<button  type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#bs-example-modal-sm">폴더 생성</button>
	    </div>
	  </div> 
	</div>

	
	<div class="row">
	
			<!-- Small modal -->
			<div class="modal fade" id="bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
			    <div class="modal-dialog modal-sm">
			    	<form action="/egg/createFolder" method="post" id="folderForm">
				        <div class="modal-content">
				            <div class="modal-header">
				                <h4 class="modal-title" id="mySmallModalLabel">폴더 생성</h4>
				                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
				            </div>
				            <div class="modal-body">
				               <div class="input-group mb-3 input-group-lg">
								  <input type="text" class="form-control" name = "fldNm" id = "fldNm">
								</div>
				            </div>
				            <div class="modal-footer">
				            	<div class="button-group">
					                <button type="button" class="btn btn-primary" id="folderCreate">폴더 생성</button>
					                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
				            	</div>
				            </div>
				        </div><!-- /.modal-content -->
				        <sec:csrfInput/>
			    	</form>
			    </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
		
		    <!-- Large modal -->
			<div class="modal fade" id="bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
			    <div class="modal-dialog modal-lg">
			        <div class="modal-content">
			            <div class="modal-header">
			                <h4 class="modal-title" id="myLargeModalLabel">파일 업로드</h4>
			               
			                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
			            </div>
			            <div class="modal-body">
			            	<form action="/egg/upload" method="post" id="drop" enctype="multipart/form-data" >
								    <div class="hidden">
								    	<input name="fldTyCd" type="hidden" value="P">
								    	<input name="fldNm" id="fldNm" type="hidden" >
								    	<input name="isMakeFolder" id="isMakeFolder" type="hidden" />
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
			            </div>
			            <div class="modal-footer">
			                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			                <button type="button" class="btn btn-primary" id="fileSave">파일 저장</button>
			            </div>
			        </div><!-- /.modal-content -->
			    </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
			<!-- Small modal -->
			<div class="modal fade" id="bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
			    <div class="modal-dialog modal-sm">
			    	<form action="/egg/createFolder" method="post" id="folderForm">
				        <div class="modal-content">
				            <div class="modal-header">
				                <h4 class="modal-title" id="mySmallModalLabel">폴더 생성</h4>
				                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
				            </div>
				            <div class="modal-body">
				               <div class="input-group mb-3 input-group-lg">
								  <input type="text" class="form-control" name = "fldNm" id = "fldNm">
								</div>
				            </div>
				            <div class="modal-footer">
				            	<div class="button-group">
					                <button type="button" class="btn btn-primary" id="folderCreate">폴더 생성</button>
					                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
				            	</div>
				            </div>
				        </div><!-- /.modal-content -->
				        <sec:csrfInput/>
			    	</form>
			    	
			    	
			    </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
	    </div> 
	 
	 
			<div class="row" id="folderLocation">
 		<c:choose>
 			<c:when test="${empty dataList }">
				<div class="col-md-3">
					<div class="card">
						<div class="card-header">
							<p>조회하실 데이터가 존재하지 않습니다.</p>
						</div>
						<div class="card-body"></div>
					</div>
				</div>
 			</c:when>
 			<c:otherwise>
 				<c:forEach items="${dataList }" var="data">
					<div class="col-md-3">
						<div class="card">
							<div class="card-body text-center">
								<h2>폴더명 :</h2>
								<h4>${data.fldNm }</h4> <br>
							</div>
							<div class="card-footer">
							</div>
						</div>
					</div>
 				</c:forEach>
 			</c:otherwise>
 		</c:choose>
 	</div>
	    
	
</body>
<script type="text/javascript">
$(function(){
	var folderCreate = $("#folderCreate");	// 폴더 생성 버튼
	var folderForm = $("#folderForm");		// 폴더 생성 form
	
	var drop = $("#drop");
	var fileSave = $("#fileSave");
	var dropzone = document.getElementById('myAwesomeDropzone');
	var fileInput = document.getElementById('fileInput');
	var search  = $("#search");
	
	search.on("keyup",function(){
		var v= search.val();
		$.ajax({
			url: "egg/search",
			data: JSON.stringify(v), 
			type: "post",
			contentType:"text/json; charset=utf-8" , 
			success: function(res){
				
			}
		})
	});
	
	folderCreate.on("click", function(){
		var fldNmVal = $("#fldNm").val();
		if(fldNmVal == null || fldNmVal == ""){
			alert("폴더명을 입력해주세요.");
			return false;
		}
		folderForm.submit();
	});
	
	fileSave.on("click",function(){
		var folderName = $("#folderName").val();
		var fldNm = $("#fldNm");
		let isMakeFolder = $("input[name='isMakeFolder']:checked").val();
		fldNm.val(folderName);
		$("#isMakeFolder").val(isMakeFolder);
		
		console.log("isMakeFolder : " + isMakeFolder);
		drop.submit();
	});
	
		$("#fileInput").on("change",function(e){
// 			let filename = $(this).val();
			
// 			console.log("filename : " + filename);
			
			//C:\fakepath\화면 캡처 2024-06-27 162958.jpg
// 			var num = filename.lastIndexOf("\\"); 
// 			var filename_origin = filename.substr(num+1); 
			
// 			console.log("filename_origin : " + filename_origin);
			
// 			$("#file-previews").html(filename_origin);
			dropzone.style.backgroundColor = '';
			let files = e.target.files;
			let filesArr = Array.prototype.slice.call(files);
			
			let str = "";
			
			filesArr.forEach(function(f){
// 				if(!f.type.match("image.*")){
// 					alert("확장자는 이미지 확장자만 가능합니다.");
// 					return;
// 				}
				
				console.log("name : " + f.name);
				
				str += f.name + "<br>"
			});
			
			$("#file-previews").html(str);
			
		});
		
		
		
		//드롭존을 클릭하면 파일선택 창이 돌출
		dropzone.addEventListener('click', function() {
          dropzone.style.backgroundColor = '#D8D8D8';
		  fileInput.click();
		});
		
		// 드롭존에 마우스가 들어오면 배경색 변경
        dropzone.addEventListener('dragover', function(e) {
            e.preventDefault();
            dropzone.style.backgroundColor = '#D8D8D8';
        });

        // 드롭존에서 마우스가 나가면 배경색 원래대로
        dropzone.addEventListener('dragleave', function(e){
            dropzone.style.backgroundColor = '';
        });

        // 드롭존에 파일을 놓으면 파일 업로드 처리
        dropzone.addEventListener('drop', function(e){
            e.preventDefault();
            dropzone.style.backgroundColor = '';

            const files = e.dataTransfer.files;
            if (files.length > 0) {
                fileInput.files = files[0];
                
                
        // 선택된 파일 처리 (예: 내용 출력, 서버 전송 등)
             console.log('선택된 파일:', files[0].name);
            }
        });
        
        folderCreate.on("click", function(){
    		var fldNmVal = $("#fldNm").val();
    		if(fldNmVal == null || fldNmVal == ""){
    			alert("폴더명을 입력해주세요.");
    			return false;
    		}
    		
    		folderForm.submit();
    	});
        
	})
</script>
</html>