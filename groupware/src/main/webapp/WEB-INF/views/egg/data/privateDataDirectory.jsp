<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>자료실</title>
    <style type="text/css">
        /* hoverText */
        .hovertext {
            position: relative;
            
        }

        .hovertext:before {
            content: attr(data-hover);
            visibility: hidden;
            opacity: 0;
            width: max-content;
            background-color: black;
            color: #fff;
            text-align: center;
            border-radius: 5px;
            padding: 5px 5px;
            transition: opacity 1s ease-in-out;

            position: absolute;
            z-index: 1;
            left: 0;
            top: 60%;
            border: 2px solid transparent;
        }

        .hovertext:hover:before {
            opacity: 1;
            visibility: visible;
  			border-radius: 15px;
        }

        .progress-bar {
            width: 70%%;
            font: black;
            /* 이전 코드 */
            color: black;
            /* 폰트 색상을 검정색으로 설정 */
        }
          img {
		  width: 80px;
		  height: 80px;
		}
		
		#progress-bar container {
		  width: 300px;
		  height: 20px;
		  background-color: #ccc;
		  border: 1px solid #ddd;
		}
		
		#progressbar {
		  width: 0%;
		  height: 100%;
		  background-color: #007bff;
		}
		.page-aside-left{
			margin-right: 50px;
		}
		.bg-light:hover{
			border: 2px solid var(--linkbrary-primary-color, #6d6afe);
  			border-radius: 15px;
		}
		.bg-light{
			border: 2px solid transparent;	
		}
    </style>
</head>

<body>
	<ul class="nav nav-tabs mb-3">
	    <li class="nav-item">
	        <a href="/egg/data/dataMain" data-bs-toggle="tab" aria-expanded="true" class="nav-link active">
	            <i class="mdi mdi-home-variant d-md-none d-block"></i>
	            <span class="d-none d-md-block">개인자료실</span>
	        </a>
	    </li>
	    <li class="nav-item">
	        <a href="/egg/data/commonDataMain" data-bs-toggle="tab" aria-expanded="false" class="nav-link ">
	            <i class="mdi mdi-account-circle d-md-none d-block"></i>
	            <span class="d-none d-md-block">공용자료실</span>
	        </a>
	    </li>
	</ul>
    <div class="row">
        <div class="d-flex">
           <a href="/egg/data/dataMain"><h3 class="ri-drive-line">개인 자료실</h3></a>
        </div>
         <div class=" d-flex justify-content-end py-2" >
             <div class="dropdown d-inline-block mr-2">
                 <select class="form-select form-select-sm" id="searchExtension" name="searchExtension" aria-label=".form-select-sm example">
                     <option selected="selected" value=all>전체</option>
                     <option>hwp</option>
                     <option>xls</option>
                     <option>jpg</option>
                     <option>gif</option>
                     <option>png</option>
                     <option>pdf</option>
                     <option>ppt</option>
                     <option>txt</option>
                     <option>zip</option>
                 </select>
             </div>
             <div class="d-inline-block mr-2">
                 <input type="text" class="form-control-sm" id="keyWord" name="keyWord" style="ime-mode:auto;" placeholder="Search files...">
             </div>
         </div>
    </div>
    <div class="row">
        <!-- Small modal -->
        <div class="modal fade" id="bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm">
                <form action="/egg/data/createFolder" method="post" id="folderForm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="mySmallModalLabel">폴더 생성</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
                        </div>
                        <div class="modal-body">
                            <div class="input-group mb-3 input-group-lg">
                                <input type="text" class="form-control" name="fldNm" id="fldNm">
                            </div>
                             <div class="hidden">
                                <input name="fldTyCd" type="hidden" value="P">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div class="button-group">
                                <button type="button" class="btn btn-primary" id="folderCreate">폴더 생성</button>
                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
                            </div>
                        </div>
                    </div><!-- /.modal-content -->
                    <sec:csrfInput />
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
                        <form action="/egg/data/fileupload" method="post" id="drop" enctype="multipart/form-data">
                            <div class="hidden">
                                <input name="fldTyCd" type="hidden" value="P">
                            </div>

                            	업로드할 폴더
                            <select class="form-select mb-3" name="fldNo">
                        	<c:forEach items="${dataList }" var="data">
                                    <option value="${data.fldNo }">
                                        ${data.fldNm }
                                    </option>
                           </c:forEach>
                            </select>

                            <div class="dropzone" id="myAwesomeDropzone" data-plugin="dropzone" data-previews-container="#file-previews" data-upload-preview-template="#uploadPreviewTemplate">


                                <div class="dropzone-container">
                                    <input name="file" class="file" type="file" id="fileInput" onchange="setThumbnail(event);" multiple hidden />
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
                        <button type="button" class="btn btn-primary" id="fileSave">파일 업로드</button>
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
       <div class="modal fade" id="bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm">
                <form action="/egg/data/createFolder" method="post" id="folderForm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="mySmallModalLabel">폴더 생성</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
                        </div>
                        <div class="modal-body">
                            <div class="input-group mb-3 input-group-lg">
                                <input type="text" class="form-control" name="fldNm" id="fldNm">
                            </div>
                             <div class="hidden">
                                <input name="fldTyCd" type="hidden" value="P">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div class="button-group">
                                <button type="button" class="btn btn-primary" id="folderCreate">폴더 생성</button>
                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
                            </div>
                        </div>
                    </div><!-- /.modal-content -->
                    <sec:csrfInput />
                </form>
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
    </div>

    <div class="container d-flex flex-row ">
        <div class="page-aside-left col-md-3 ">
        	<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')">
	            <div class="d-grid">
	                <button type="button" class="btn btn-primary ri-file-upload-line" data-bs-toggle="modal" data-bs-target="#bs-example-modal-lg">
	                    파일 업로드</button>
	            </div>
         	</sec:authorize>   
				<c:choose>
					<c:when test="${empty  dataList }">
						<div class="col-sm-12" align="left">
                            	<p>조회할 폴더가 존재하지 않습니다.</p>
                        </div>
					</c:when>
					<c:otherwise>
					    <div class="email-menu-list ">
			                <c:forEach items="${dataList }" var="data">
			                   <form action="/egg/data/delFolder" method="post" class="delFForm">
			                    <div class="d-inline-block">
			                        <a class=" ri-folder-5-fill" onclick="" href="/egg/data/fileList?fileGroupNo=${data.fileGroupNo}&fldNo=${data.fldNo}">
			                            ${data.fldNm }</a> 
			                    </div>
			                    <div class="d-inline-block">
			                       <span class="deleteFolder" style="color: red;"><i class="ri-close-fill"></i></span>
			                    </div> <br>
			                   	<input type="hidden" name="fldNo" value="${data.fldNo }">
			                   	<sec:csrfInput/>
			                   </form>
			                </c:forEach>
			            </div>
					</c:otherwise>
				</c:choose>
				
<!-- 	            <div class="email-menu-list mt-3"> -->
<%-- 	                <c:forEach items="${dataList }" var="data"> --%>
<!-- 	                    <div> -->
<%-- 	                        <a class=" ri-folder-5-fill" href="/egg/data/fileList?fileGroupNo=${data.fileGroupNo}&fldNo=${data.fldNo}"> --%>
<%-- 	                            ${data.fldNm}</a> --%>
<!-- 	                    </div> -->
<%-- 	                </c:forEach> --%>
<!-- 	            </div> -->
	          <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')">  
	            <div class="d-grid">
	                <button type="button" class="btn btn-primary ri-folder-add-line" data-bs-toggle="modal" data-bs-target="#bs-example-modal-sm">
	                    폴더 생성</button>
	            </div>
	         </sec:authorize>   

			
            <div class="mt-4">
                <h6 class="text-uppercase mt-3">Storage</h6>
                <c:set var="usage" value="${(totalUsage.TOTAL_USAGE_MB*100)/300}" />
                <c:choose>
                	<c:when test="${usage>=50 and usage <70}"><c:set var="clor" value="yellow" /></c:when>
                	<c:when test="${usage>=70}"><c:set var="clor" value="red" /></c:when>
                	<c:otherwise><c:set var="clor" value="blue" /></c:otherwise>
                </c:choose>
                <div class="progress my-2 progress-sm" style="float:left;width:${usage}%;">
	                <div class="progress-bar container" style="background-color:${clor};"><!-- totalUsage.TOTAL_USAGE_MB -->
	                	<input type="hidden"  id="currentBytes" value="${totalUsage.TOTAL_USAGE_MB}">
	                </div>
                </div>
                <br />
                <span class="text-muted font-13 mb-0 " style="display: inline-block;">${totalUsage.TOTAL_USAGE_MB}MB (${usage}%) of 300MB used</span>
            </div>
        </div>
		<div class="row col-md-10 text-center">
                <div class="row col-md-12  text-center" id="fileLocation">
                    <c:choose>
                        <c:when test="${empty allFileList }">
                            <div class="col-sm-12" align="left">
                            	<p>조회할 파일이 존재하지 않습니다.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${allFileList }" var="dataVO">
                                <c:forEach items="${dataVO.attachFileList }" var="file">
                                    <div class="col-md-2 ">
                                        <div class="card hovertext bg-light" style="width: 200px auto; height: 200px auto;" data-hover="${file.fileOrgnlNm}[${file.fileFancysize}]">
                                            <c:set var="filename" value="${file.fileStrgNm }" />
                                            <c:set var="fileNm" value="${fn:toLowerCase(filename)}" />
                                            <c:forTokens var="token" items="${fileNm }" delims="." varStatus="status">
                                                <c:if test="${status.last }">
                                                    <c:choose>
                                                        <c:when test="${token eq 'hwp' }">
                                                            <div class="display-1 text-center">
                                                                <i class="ri-file-hwp-fill"></i>
                                                            </div>
                                                        </c:when>
                                                        <c:when test="${token eq 'xls'|| token eq 'xlsx'}">
                                                            <div class="display-1 text-center">
                                                                <i class="ri-file-excel-2-fill"></i>
                                                            </div>
                                                        </c:when>
                                                        <c:when test="${token eq 'jpg'}">
                                                            <div class="display-1 text-center">
                                                                <!--                                                                 <i class=" ri-file-user-fill"></i> -->
                                                                <img src="/upload/data${file.fileStrgNm}" />
                                                            </div>
                                                        </c:when>
                                                        <c:when test="${token eq 'png'}">
                                                            <div class="display-1 text-center">
                                                                <!--                                                                 <i class=" ri-file-user-fill"></i> -->
                                                                <img src="/upload/data${file.fileStrgNm}" />
                                                            </div>
                                                        </c:when>
                                                        <c:when test="${token eq 'webp'}">
                                                            <div class="display-1 text-center">
                                                                <!--                                                                 <i class=" ri-file-user-fill"></i> -->
                                                                <img src="/upload/data${file.fileStrgNm}" />
                                                            </div>
                                                        </c:when>
                                                        <c:when test="${token eq 'gif'}">
                                                            <div class="display-1 text-center">
                                                                <img src="/upload/data${file.fileStrgNm}" />
                                                            </div>
                                                        </c:when>
                                                        <c:when test="${token eq 'pdf'}">
                                                            <div class="display-1 text-center">
                                                                <i class="ri-file-pdf-fill"></i>
                                                            </div>
                                                        </c:when>
                                                        <c:when test="${token eq 'ppt' }">
                                                            <div class="display-1 text-center">
                                                                <i class="ri-file-ppt-2-fill"></i>
                                                            </div>
                                                        </c:when>
                                                        <c:when test="${token eq 'txt' }">
                                                            <div class="display-1 text-center">
                                                                <i class="ri-file-info-fill"></i>
                                                            </div>
                                                        </c:when>
                                                        <c:when test="${token eq 'ini' }">
                                                            <div class="display-1 text-center">
                                                                <i class="ri-file-settings-fill"></i>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="display-1 text-center">
                                                                <i class="ri-file-unknow-fill"></i>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:if>
                                            </c:forTokens>
                                                <c:choose>
                                                    <c:when test="${fn:length(file.fileOrgnlNm) gt 8}">
                                                        <c:out value="${fn:substring(file.fileOrgnlNm, 0, 7)} " />··· <br>
                                                        [
                                                        <c:out value="${file.fileFancysize }" />]
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:out value="${file.fileOrgnlNm}" /> <br>
                                                        [
                                                        <c:out value="${file.fileFancysize }" />]
                                                    </c:otherwise>
                                                </c:choose> <br>
                                                <div class="m-1">
                                                    <a class="d-inline-block" href="${pageContext.request.contextPath}/egg/data/download?fileGroupNo=${file.fileGroupNo}&fileNo=${file.fileNo}" target="_blank" class="">
                                                    <h2><i class="ri-download-2-line"></i></h2></a>
                                                     <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')">
                                                   		&emsp;&emsp;<a class="d-inline-block delFile" data-fgn="${file.fileGroupNo }" data-no="${file.fileNo}"> <h2><i class="ri-delete-bin-fill danger"></i></h2></a>
                                                   	</sec:authorize>	
                                                </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
<!--                     <div id="more_div" align="center"> -->
<!-- 	                    <hr> -->
<!-- 	                    	 <h4> <a id="more_btn" href=""> 더보기 </a></h4> -->
<!-- 	                    <hr> -->
<!--                     </div> -->
					<form action="/egg/data/delete" method="post" class="delForm" id="delFrm">
						<input type="hidden" id="fileGn" name="fileGroupNo"  value="${file.fileGroupNo }" >
						<input type="hidden" id="fileN"  name="fileNo" value="${file.fileNo}">
						<sec:csrfInput/>
					</form>	
                </div>
                </div>
            </div>
</body>
<script type="text/javascript">
    $(function() {
        var folderCreate = $("#folderCreate"); // 폴더 생성 버튼
        var folderForm = $("#folderForm"); // 폴더 생성 form

        var fileLocation = $("#fileLocation");
        var drop = $("#drop");
        var fileSave = $("#fileSave");
        var dropzone = document.getElementById('myAwesomeDropzone');
        var fileInput = document.getElementById('fileInput');
        var search = $("#search");
        var getFileList = $("#getFileList");
        var getFileForm = $("#getFileForm");

        var search = $("#keyWord");
        var searchExtension = $("#searchExtension option:selected").val();
        
        var currentpage = 1;
        var pageSize=18;
        
        
      	
        

        search.on("keyup", function() {
            var keyWord = $("#keyWord").val();
            var searchExtension = $("#searchExtension option:selected").val();
            var data = {
                "keyWord": keyWord,
                "searchExtension": searchExtension
//                 "SIZE" : 1,
//                 ENDSIZE : ENS,
            }
            var str = "";

//             if (keyWord == "") { // 검색어가 존재하지 않으면
//                 location.href = "/egg/data/dataMain"
//             } // if end

            $.ajax({
                url: "/egg/data/search",
                type: "post",
                beforeSend: function(xhr) { // 데이터 전송 전 , 헤더에 csrf 값 설정
                    xhr.setRequestHeader(header, token);
                },
                data: JSON.stringify(data),
                contentType: "application/json;charset=utf-8",
                success: function(searchList) {
                    console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@", searchList)
                    updateList(searchList);
                }
            })
        })


        function updateList(data) {
            var $fileLocation = $('#fileLocation');
            $fileLocation.empty(); // 기존 리스트 비우기

            if (Array.isArray(data)) { // 응답이 배열인지 확인
                var row = "";
                data.forEach(function(dataVO) {
                    if (dataVO.attachFileList && dataVO.attachFileList.length > 0) {
                        dataVO.attachFileList.forEach(function(file, index) {
                            //                     if (index % 6 === 0) {
                            //                         row = $('<div class="row"></div>'); // 새로운 행 생성
                            //                         $profile.append(row); // 행을 프로필에 추가
                            //                     }

                            var filename = file.fileStrgNm.toLowerCase();
                            var fileIcon = '';
                            var fileExtension = filename.split('.').pop();

                            switch (fileExtension) {
                                case 'hwp':
                                    fileIcon = '<i class="ri-file-hwp-fill"></i>';
                                    break;
                                case 'xls':
                                case 'xlsx':
                                    fileIcon = '<i class="ri-file-excel-2-fill"></i>';
                                    break;
                                case 'jpg':
                                	fileIcon = `<img src="/upload/data\${file.fileStrgNm}" />` ;
                                    break;
                                case 'png':
                                	fileIcon = `<img src="/upload/data\${file.fileStrgNm}" />`;
                                    break;
                                case 'webp':
                                	fileIcon = `< img src = '/upload/data\${file.fileStrgNm}' / >` ;
                                    break;
                                case 'gif':
                                    fileIcon = `<img src="/upload/data\${file.fileStrgNm}" />`;
                                    break;
                                case 'pdf':
                                    fileIcon = '<i class="ri-file-pdf-fill"></i>';
                                    break;
                                case 'ppt':
                                    fileIcon = '<i class="ri-file-ppt-2-fill"></i>';
                                    break;
                                case 'txt':
                                    fileIcon = '<i class="ri-file-info-fill"></i>';
                                    break;
                                case 'ini':
                                    fileIcon = '<i class="ri-file-settings-fill"></i>';
                                    break;
                                default:
                                    fileIcon = '<i class="ri-file-unknow-fill"></i>';
                            }

                            var truncatedFileName = file.fileOrgnlNm.length > 11 ?
                                file.fileOrgnlNm.substring(0, 10) + '···' :
                                file.fileOrgnlNm;

                            var fileCard = `
                            
	                        <div class="col-md-2 fileList">
                            	<div class="card hovertext bg-light" style="width: 200px auto; height: 200px auto;" data-hover="\${file.fileOrgnlNm}[\${file.fileFancysize}]">
	                                <div class="display-1 text-center">
	                                    \${fileIcon}
	                                </div>
	                                
	                                    \${truncatedFileName} <br> [\${file.fileFancysize}] <br>
	                                
	                                <div class="card-footer text-center">
		                                <a class="d-inline-block" href="${pageContext.request.contextPath}/egg/data/download?fileGroupNo=\${file.fileGroupNo}&fileNo=\${file.fileNo}" target="_blank">
	                                    <h2><i class="ri-download-2-line"></i></h2></a>
	                                    <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')">
	                                    	&emsp;&emsp;<a href="javascript:void(0)" class="d-inline-block delFile" data-fgn="\${file.fileGroupNo }" data-no="\${file.fileNo}"> <h2><i class="ri-delete-bin-fill danger"></i></h2></a>
                                   		</sec:authorize>
	                                </div>
	                            </div>
	                        </div>
                    `;

                            $fileLocation.append(fileCard);
                        });
                        
                        
                    } else {
                        var noFilesMessage = `
                    <div class="col-md-2">
                        <div class="card">
                            <div class="card-header">
                                <p>조회할 파일이 존재하지 않습니다.</p>
                            </div>
                            <div class="card-body"></div>
                        </div>
                    </div>
                `;
                        $fileLocation.append(noFilesMessage);
                    }
                });
            } else {
                console.error('Received data is not an array:', data);
            }
        }

        folderCreate.on("click", function() {
            var fldNmVal = $("#fldNm").val();
            if (fldNmVal == null || fldNmVal == "") {
                alert("폴더명을 입력해주세요.");
                return false;
            }
            folderForm.submit();
            parent.location.reload();
        });


        fileSave.on("click", function() {
            var folderName = $("#folderName").val();
            var fldNm = $("#fldNm");
            fldNm.val(folderName);
            drop.submit();
        });

        $("#fileInput").on("change", function(e) {
            
            dropzone.style.backgroundColor = '';
            let files = e.target.files;
            let filesArr = Array.prototype.slice.call(files);

            let str = "";

            filesArr.forEach(function(f) {
                // 				if(!f.type.match("image.*")){
                // 					alert("확장자는 이미지 확장자만 가능합니다.");
                // 					return;
                // 				}

                // 				console.log("name : " + f.name);

                str += f.name + "<br>"
            });

            $("#file-previews").html(str);

        });


        const myAwesomeDropzone = document.getElementById('myAwesomeDropzone');
        myAwesomeDropzone.addEventListener('click', function() {
            document.getElementById('fileInput').click();
        });



        folderCreate.on("click", function() {
            var fldNmVal = $("#fldNm").val();
            if (fldNmVal == null || fldNmVal == "") {
                alert("폴더명을 입력해주세요.");
                return false;
            }

            folderForm.submit();
        });

        //         function getThumbnailName(fileName){
        //     		var front = fileName.substr(0,12); // 2024/05/29
        //     		var end = fileName.substr(12); // 뒤 파일명
        //     		console.log(front + "::::"+end);
        //     		return front + "s_"+end;

        //     	};
        //     	//파일명 추출
        //     	function getOriginalName(fileName){
        //     		if(checkImageType(fileName)){
        //     			return;
        //     		}
        //     		var idx = fileName.indexOf("_")+1;
        //     		return fileName.substr(idx);
        //     	};
        //     	//이미지인지 확인
        //     	function checkImageType(fileName){
        //     		var pattern = /jpg|gif|png|jpeg/i;
        //     		return fileName.match(pattern); //패턴과 일치한다면 true
        //     	};
        
        
        
        $(document).on("click",".delFile",function(e){
        	e.preventDefault();
        	console.log("### : " + $(this).data("fgn"));
        	console.log("### : " + $(this).data("no"));
        	$("#delFrm").find("#fileGn").val($(this).data("fgn"));
        	$("#delFrm").find("#fileN").val($(this).data("no"));
			
        	if(confirm("파일을 정말로 삭제하시겠습니까?")){
        		$("#delFrm").submit();
				
			}
		})
		
		$(document).ready(function() {
		    $('.nav-link').click(function() {
		        var href = $(this).attr('href');
		        window.location.href = href;
		    });
		});
        
        $(".email-menu-list .deleteFolder").on("click","i",function(){
			if(confirm("폴더를 정말로 삭제하시겠습니까?")){
	        	$(this).parents('.delFForm').submit();
			}
		})
		
    });
</script>

</html>