package kr.or.ddit.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ITodoMapper;
import kr.or.ddit.service.ITodoService;
import kr.or.ddit.util.ServiceResult;
import kr.or.ddit.vo.AddTodoVO;
import kr.or.ddit.vo.TodoContentVO;
import kr.or.ddit.vo.TodoVO;

@Service
public class TodoServiceImpl implements ITodoService{

	@Inject
	private ITodoMapper mapper;
	@Override
	public List<TodoVO> getTodos(String emplId) {
		return mapper.getTodos(emplId);
	}
	@Override
	public ServiceResult addTodo(AddTodoVO addTodoVO) {
		ServiceResult result = null;
		int cnt = mapper.addTodo(addTodoVO);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}
	@Override
	public ServiceResult updateTodo(TodoContentVO todoContentVO) {
		ServiceResult result = null;
		int cnt = mapper.updateTodo(todoContentVO);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}
	@Override
	public ServiceResult deleteTodo() {
		ServiceResult result = null;
		int cnt = mapper.deleteTodo();
		if(cnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}
	@Override
	public List<Integer> checkedSelect() {
		return mapper.checkedSelect();
	}
	@Override
	public void deleteTodoList(Integer integer) {
		mapper.deleteTodoList(integer);
	}


}
