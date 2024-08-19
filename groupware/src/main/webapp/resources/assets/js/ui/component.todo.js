!function(t) {
    "use strict";

    function o() {
        this.$body = t("body"),
        this.$todoContainer = t("#todo-container"),
        this.$todoMessage = t("#todo-message"),
        this.$todoRemaining = t("#todo-remaining"),
        this.$todoTotal = t("#todo-total"),
        this.$archiveBtn = t("#btn-archive"),
        this.$todoDonechk = ".todo-done",
        this.$todoList = t("#todo-list"),
        this.$todoForm = t("#todo-form"),
        this.$todoInput = t("#todo-input-text"),
        this.$todoBtn = t("#todo-btn-submit"),
        this.$emplId = t("#todo-emplinfo").val(),
        this.$todoData = [],
        this.$todoCompletedData = [],
        this.$todoUnCompletedData = []
    }


	o.prototype.markTodo = function(todoId, complete) {		
		var self = this;
	    var todoYn = complete ? 'CHECKED' : 'UNCHECKED';
	
	    t.each(self.$todoData, function(index, item) {
	        if (item.id == todoId) {
	            item.done = complete;
	            
	            // AJAX 요청으로 서버에 상태 업데이트 요청
	            t.ajax({
	                url: '/api/todos/update',
	                method: 'POST',
	                beforeSend : function(xhr){ // 데이터 전송 전 , 헤더에 csrf 값 설정
                		xhr.setRequestHeader(header , token);
           			},
	                contentType: 'application/json',
	                data: JSON.stringify({cnNo: todoId, todoYn: todoYn}),
	                success: function(response) {
	                    console.log('Todo status updated successfully.');
	                    self.generate();  // 상태 업데이트 후 목록 갱신
	                },
	                error: function(err) {
	                    console.error('Error updating todo status', err);
	                }
	            });
	
	            return false; 
	        }
	    });
    },

	o.prototype.archives = function () {
	    var self = this;
	    self.$todoCompletedData = [];
	
	    // 필터링하여 체크된 항목만 별도로 저장
	    t.each(self.$todoData, function(index, todoItem) {
	        if (todoItem.done) {
	            self.$todoCompletedData.push(todoItem);
	        }
	    });
	
	    // 남아있는 항목들만으로 $todoData 갱신
	    self.$todoData = t.grep(self.$todoData, function(todoItem) {
	        return !todoItem.done;
	    });
	
	    // 서버에 삭제 요청
	    t.ajax({
	        url: '/api/todos/delete',
	        method: 'get',
	        beforeSend : function(xhr){ // 데이터 전송 전 , 헤더에 csrf 값 설정
        		xhr.setRequestHeader(header , token);
   			},
	        success: function(response) {
	            console.log('Delete Success!!!');
	            self.generate();  // 삭제 후 목록 갱신
	        },
	        error: function(err) {
	            console.error('Error deleting archived todos', err);
	        }
	    });
    },






    o.prototype.fetchTodos = function (emplId) {
        var self = this;
        t.ajax({
            url: '/api/todos',
            method: 'GET',
            data: { emplId: emplId },
            success: function (data) {
                console.log("Fetched todos: ", data);  // Fetch 확인용 로그
                self.$todoData = data.map(function (item) {
                    return item.contents.map(function (content) {
                        return {
                            id: content.cnNo,
                            text: content.todoCn,
                            done: content.todoYn === 'CHECKED'
                        };
                    });
                }).flat();
                self.generate();
            },
            error: function (err) {
                console.error('Error fetching todos', err);
            }
        });
    };

    o.prototype.generate = function () {
        console.log("Generating todo list...");  // Generate 확인용 로그
        this.$todoList.html("");  // 기존 리스트 초기화
        var remaining = 0;
        for (var i = 0; i < this.$todoData.length; i++) {
            var item = this.$todoData[i];
            if (item.done) {
                this.$todoList.prepend('<li class="list-group-item border-0 ps-0"><div class="form-check mb-0"><input type="checkbox" class="form-check-input todo-done" id="' + item.id + '" checked><label class="form-check-label" for="' + item.id + '"><s>' + item.text + '</s></label></div></li>');
            } else {
                remaining++;
                this.$todoList.prepend('<li class="list-group-item border-0 ps-0"><div class="form-check mb-0"><input type="checkbox" class="form-check-input todo-done" id="' + item.id + '"><label class="form-check-label" for="' + item.id + '">' + item.text + '</label></div></li>');
            }
        }
        this.$todoTotal.text(this.$todoData.length);
        this.$todoRemaining.text(remaining);
    };

    o.prototype.addTodo = function (inputVal) {
        var self = this;
        var todoRequest = {
            emplId: self.$emplId,  // 실제 사용할 직원 ID로 수정 필요
            todoCn: inputVal,
            todoYn: 'UNCHECKED'  // 초기 상태
        };
        t.ajax({
            url: '/api/todos',
            method: 'POST',
            beforeSend : function(xhr){ // 데이터 전송 전 , 헤더에 csrf 값 설정
                xhr.setRequestHeader(header , token);
            },
            contentType: 'application/json',
            data: JSON.stringify(todoRequest),
            success: function (res) {
            	if(res == "OK"){
	                console.log("Added todo");  // Add 확인용 로그
	                self.fetchTodos(todoRequest.emplId);  // 새로운 할 일을 추가한 후 목록 갱신
            	}else{
            		alert("처리 에러, 다시 시도해주세요!");
            	}
            },
            error: function (err) {
                console.error('Error adding todo', err);
            }
        });
    };

    o.prototype.init = function () {
        var self = this;
        var emplId = self.$emplId;  // 원하는 직원 ID로 수정
        this.fetchTodos(emplId);  // 초기화 시 할 일 데이터를 가져옴
        this.$archiveBtn.on("click", function (e) {
            e.preventDefault();
            self.archives();
        });

     $(document).on("change", this.$todoDonechk, function () {
        if (this.checked){
         	self.markTodo($(this).attr("id"), true);
         }else{
	         self.markTodo($(this).attr("id"), false);
         }
        
        self.generate();
      });


        this.$todoForm.on("submit", function (e) {
            e.preventDefault();
            var inputVal = self.$todoInput.val();
            if (!inputVal) {
                self.$todoInput.focus();
                return false;
            }
            self.addTodo(inputVal);  // 새로운 할 일 추가
            self.$todoForm.removeClass("was-validated");
            self.$todoInput.val("");  // 입력 필드 초기화
            return true;
        });
    };

    t.TodoApp = new o();
    t.TodoApp.Constructor = o;

    t(function() {
        t.TodoApp.init();
    });

}(window.jQuery);
