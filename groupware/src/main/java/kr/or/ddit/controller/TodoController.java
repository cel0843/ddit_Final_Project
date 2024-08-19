package kr.or.ddit.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.ITodoService;
import kr.or.ddit.util.ServiceResult;
import kr.or.ddit.vo.AddTodoVO;
import kr.or.ddit.vo.CustomEmployeeVO;
import kr.or.ddit.vo.TodoContentVO;
//import kr.or.ddit.vo.TodoRequestVO;
import kr.or.ddit.vo.TodoVO;

@Controller
public class TodoController {

	@Inject
	private ITodoService service;
	
	@GetMapping("/api/todos")
	@ResponseBody
	public List<TodoVO> getTodos(HttpServletRequest request){
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();
		return service.getTodos(emplId);
	}
	
	@PostMapping("/api/todos")
    public ResponseEntity<ServiceResult> addTodo(@RequestBody AddTodoVO addTodoVO) {
        ServiceResult result = service.addTodo(addTodoVO);
        return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
    }
	
	@PostMapping("/api/todos/update")
	public ResponseEntity<ServiceResult> updateTodo(@RequestBody TodoContentVO todoContentVO) {
		ServiceResult result = service.updateTodo(todoContentVO);
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	
	@GetMapping("/api/todos/delete")
	public ResponseEntity<ServiceResult> deleteTodo() {
		
		List<Integer> test = service.checkedSelect();
		
		ServiceResult result = service.deleteTodo();
		
		for(int i =0; i<test.size(); i++) {
			service.deleteTodoList(test.get(i));
		}
		
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}

	
	
	
	
	
}
