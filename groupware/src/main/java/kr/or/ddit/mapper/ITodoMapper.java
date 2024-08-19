package kr.or.ddit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.AddTodoVO;
import kr.or.ddit.vo.TodoContentVO;
import kr.or.ddit.vo.TodoVO;

public interface ITodoMapper {
	public List<TodoVO> getTodos(@Param(value = "emplId") String emplId);
	public int addTodo(AddTodoVO addTodoVO);
	public int updateTodo(TodoContentVO todoContentVO);
	public int deleteTodo();
	public List<Integer> checkedSelect();
	public void deleteTodoList(Integer integer);
}
