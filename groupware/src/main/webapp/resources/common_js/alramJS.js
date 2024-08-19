/**
 * alarm JavaScript
*/

/*
jquery.toast.min.css 에서 아래 요소 제거
.close-jq-toast-single{position:absolute;top:3px;right:7px;font-size:14px;cursor:pointer}
*/

/*
알람 속성 정리
heading : '' >> 알람 타이틀
text : '알람 메세지' >>
text: [
        'text1',
        'text2',
        'text3'
      ]

icon : 'info', 'error', 'warning', 'success' >> 알람 아이콘
hideAter : 5000 >> milli seconds (5초) || false
showHideTransition: 'slide', 'fade', 'plain' >> 사라지는 형식
stack: 4 >> 알람 허용 스택 4개까지 || false
textAlign: 'center' >> 정렬  기준

*/
$(function(){
    
    function alarmExecution(alarmTitle, alarmContent, alarmPosition, bColor, tColor){
        // 알람 띄우기
        (function (c) {
          "use strict";
          function t() {}
          (t.prototype.send = function (t, o, p, bc, tc) {
            t = {
              heading: t,
              text: o,
        
              showHideTransition: "fade",
              allowToastClose: true,
              hideAfter: 3000,
              stack: 5,
              position: p,
              
              bgColor: bc,
              textColor: tc,
              textAlign: "left",
              loader: true,
              loaderBg: "rgba(0,0,0,0.2)",
            };
            c.toast().reset("all"), c.toast(t);
        }),
        (c.NotificationApp = new t()),
        (c.NotificationApp.Constructor = t)
        
    	})(window.jQuery); // /알람 띄우기
    	
    	window.jQuery.NotificationApp.send(alarmTitle, alarmContent, alarmPosition, bColor, tColor);
	} // /alarmExecution

    // 알람 수신
    alarmSock.onmessage = function onMessage(alarmMsg) {
        var data = JSON.parse(alarmMsg.data);
        console.log("받은 data : " + data); // del
        console.log("받은 data의 알람타입 : " + data.alarmType); // del
        if(data.alarmType == "ALARM01"){
            if(!inChatPage){
                alarmExecution(data.alarmTitle, data.alarmContent, "bottom-right", "#e4e6fb", "#313a46");
            }
        }

        if(data.alarmType == "ALARM02" || data.alarmType == "ALARM03"){
            alarmExecution(data.alarmTitle, data.alarmContent, "top-right", "#727cf5", "#ffffff");
        }
        
        onNewAlarm();

        // letsgo
        // 다른 알람은 여기에 추가 
    }
    
    // 알람 소켓 연결 끊었을때
    alarmSock.onclose = function onClose(evt) {
	    console.log("알람 소켓연결 끊김");
    }


    // 헤더 알람 아이콘 관련 Method --------------------------------------------------------------------

    // 알람 아이콘 클릭시 - alarmIconBtn click
    $("#alarmIconBtn").on("click", function(e){
        e.preventDefault();
        console.log("alarmIconBtn clicked"); // del
        $.ajax({
            url: "/egg/selectAlarmListByEmplNo",
            type: "GET",
            beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
                xhr.setRequestHeader(header, token);
            },
            success: function(res) {
                var alarmWindowHTML = "";
                $.each(res, function(index, alarmVO) {
                    if(index < 7){
                        console.log(alarmVO.alarmTyCd);
                        alarmWindowHTML += "<a href='javascript:void(0);' class='dropdown-item p-0 notify-item card unread-noti shadow-none mb-2'>";
                        alarmWindowHTML += "    <div class='card-body'>";
                        // alarmWindowHTML += "        <span class='float-end noti-close-btn text-muted'><i class='mdi mdi-close'></i></span>";
                        alarmWindowHTML += "        <div class='d-flex align-items-center'>";
                        alarmWindowHTML += "            <div class='flex-shrink-0'>";
                        alarmWindowHTML += "                <div class='notify-icon bg-primary'>";
                        if(alarmVO.alarmTyCd == "ALARM02"){ // if 메일
                            alarmWindowHTML += "                    <i class='mdi mdi-email'></i>";
                        }
                        if(alarmVO.alarmTyCd == "ALARM03"){ // if 전자결재
                            alarmWindowHTML += "                    <i class='mdi mdi-file-document'></i>";
                        }
                        alarmWindowHTML += "                </div>";
                        alarmWindowHTML += "            </div>";
                        alarmWindowHTML += "            <div class='flex-grow-1 text-truncate ms-2'>";
                        alarmWindowHTML += "                <h5 class='noti-item-title fw-semibold font-14'>"+alarmVO.alarmTitle+" <small class='fw-normal text-muted ms-1'>" 
                                                                +formatTimeFN(alarmVO.alarmCtrDt)+"</small></h5>";
                        alarmWindowHTML += "                <small class='noti-item-subtitle text-muted'>"+alarmVO.alarmConts+"</small>";
                        alarmWindowHTML += "            </div>";
                        alarmWindowHTML += "        </div>";
                        alarmWindowHTML += "    </div>";
                        alarmWindowHTML += "</a>";
                    }
                });
                if(alarmWindowHTML.trim() == ""){
                    console.log("조회된 알림이 없습니다");
                    $("#alarmWindow").html("<div class='text-center'><h5>조회된 알림이 없습니다.</h5></div>");
                }else{
                    $("#alarmWindow").html(alarmWindowHTML);
                }
            },
            error: function(error) {
                console.log(error);
                alert("Error loading AlarmList");
            }
        });
        $("#alarmIconBtn").find("span").remove();
    });
    
    // 알람전체삭제 - clearAll버튼 클릭
    $("#alarmClearAllBtn").on("click", function(e){
        e.preventDefault();
        $.ajax({
            url: "/egg/clearAllAlarm",
            type: "GET",
            beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
                xhr.setRequestHeader(header, token);
            },
            dataType: "text",
            success: function(res) {
                console.log("야야 이것좀 봐라 - " + res); // del
                if(res == "success"){
                    $("#alarmWindow").html(""); // 성공시
                }
            },
            error: function(error) {
                console.log(error);
                alert("Error loading existedAlarmYN");
            }
        });
    });
    
    function onNewAlarm(){
        $("#alarmIconBtn").append("<span class='noti-icon-badge'></span>");
    }

    // 밀리초 시간 포맷함수
    function formatTimeFN(getedTime) {
        var date = getedTime == null ? new Date(Date.now()) : new Date(getedTime);
        var month = ('0' + (date.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1
        var day = ('0' + date.getDate()).slice(-2);
        var hours = ('0' + date.getHours()).slice(-2);
        var minutes = ('0' + date.getMinutes()).slice(-2);
        return month + '/' + day + '.' + hours + ':' + minutes;
    }
    
    // 페이지 로드시 알람존재여부 확인
    $.ajax({
        url: "/egg/selectUnreadAlaramCount",
        type: "GET",
        beforeSend : function(xhr){	// 데이터 전송 전, 헤더에 csrf 값 설정
            xhr.setRequestHeader(header, token);
        },
        dataType: "text",
        success: function(res) {
            if(res == "true"){
                $("#alarmIconBtn").append("<span class='noti-icon-badge'></span>");
            }
        },
        error: function(error) {
            console.log(error);
            console.log("Error loading existedAlarmYN");
        }
    });
    
}) // /$function





// 하려다가 포기한 기능 - 알람 도착시 사이드 메뉴에 new 생성
// if(!inApprovalPage){
//     $('.side-nav span:contains("전자결재")').parent().append("<span class='badge bg-danger text-white float-end'>New</span>");
// }
// if(!inMailPage){
//     $('.side-nav span:contains("메일")').parent().append("<span class='badge bg-danger text-white float-end'>New</span>");
// }

// 하려다가 포기한 기능 - 사이드 메뉴 클릭시 new remove
// $('.side-nav span:contains("채팅")').on('click', function() {
// 	$(this).parent().find('.badge').remove();
// });
// $('.side-nav span:contains("전자결재")').on('click', function() {
// 	$(this).parent().find('.badge').remove();
// });
// $('.side-nav span:contains("메일")').on('click', function() {
// 	$(this).parent().find('.badge').remove();
// });