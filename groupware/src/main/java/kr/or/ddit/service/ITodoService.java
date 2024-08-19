package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.util.ServiceResult;
import kr.or.ddit.vo.AddTodoVO;
import kr.or.ddit.vo.TodoContentVO;
import kr.or.ddit.vo.TodoVO;

public interface ITodoService {
	public List<TodoVO> getTodos(String emplId);
	public ServiceResult addTodo(AddTodoVO addTodoVO);
	public ServiceResult updateTodo(TodoContentVO todoContentVO);
	public ServiceResult deleteTodo();
	public List<Integer> checkedSelect();
	public void deleteTodoList(Integer integer);
}
