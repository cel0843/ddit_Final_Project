package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class TodoVO {
    private int todoId;
    private String emplId;
    private List<TodoContentVO> contents;
}
