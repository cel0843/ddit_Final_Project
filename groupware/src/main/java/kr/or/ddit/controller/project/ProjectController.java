package kr.or.ddit.controller.project;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.project.IProjectService;
import kr.or.ddit.service.project.IScheduleService;
import kr.or.ddit.vo.CustomEmployeeVO;
import kr.or.ddit.vo.ProjectPrtcpVO;
import kr.or.ddit.vo.ProjectScheduleVO;
import kr.or.ddit.vo.ProjectTaskVO;
import kr.or.ddit.vo.ProjectsVO;

@Controller
@RequestMapping("/project")
public class ProjectController {

	@Inject
	private IProjectService projectService;

	@Inject
	private IScheduleService scheduleService;

	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("/mainProjectPage")
	public String surveyForm(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		// 사용자 정보 
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();

		if (emplInfo == null) {
			return "redirect:/egg/login"; 
		}
		
		ProjectPrtcpVO projectPrtcpVO = new ProjectPrtcpVO();
		projectPrtcpVO.setEmplId(emplId);
		int status = projectService.updateDeadLine();

		// 마감 프로젝트 리스트
		List<ProjectsVO> projectDeadList = projectService.projectDeadList(projectPrtcpVO);

		// 사용자 프로젝트 리스트 조회
		List<ProjectsVO> projectList = projectService.projectList(projectPrtcpVO);

		

		// 클라이언트 제공 (뷰페이지 )
		if (projectList == null) {
			model.addAttribute("projectNo", 0);
		}

		if (projectDeadList == null) {
			model.addAttribute("projectNo", 0);
		}
		model.addAttribute("projectList", 		projectList);
		model.addAttribute("projectDeadList",	projectDeadList);

		return "egg/project/projectForm";
	}

	// 프로젝트 비동기 상태별 검색
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("/ajax/taskListByStatus")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getTaskListByStatus(HttpServletRequest request,
			@RequestParam("projNo") int projNo, @RequestParam("status") String status) {
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();

		List<ProjectTaskVO> taskList = projectService.getTaskListByProject(projNo, status, emplId);
		List<ProjectScheduleVO> scheduleList = scheduleService.scheduleList(projNo);
		
		Map<String, Object> response = new HashMap<>();

		response.put("taskList", taskList);
		response.put("scheduleList", scheduleList);

		return ResponseEntity.ok(response);
		
	}

	// 프로젝트 전체 업무 조회
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("/ajax/selectTaskList")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> selectTaskList(@RequestParam("projNo") int projNo,
			@RequestParam("page") int page, @RequestParam("size") int size,
			@RequestParam(value = "searchType", required = false) String searchType,
			@RequestParam(value = "searchWord", required = false) String searchWord) {

		int startRow = (page - 1) * size + 1;
		int endRow = page * size;

		Map<String, Object> params = new HashMap<>();
		params.put("projNo", 		projNo);
		params.put("startRow", 		startRow);
		params.put("endRow", 		endRow);
		params.put("searchType", 	searchType);
		params.put("searchWord", 	searchWord);

		List<Map<String, Object>> taskList = projectService.selectTaskList(params);
		int totalTasks = projectService.getTaskCount(params);

		Map<String, Object> response = new HashMap<>();
		response.put("taskList", taskList);
		response.put("totalTasks", totalTasks);
		response.put("totalPages", (int) Math.ceil((double) totalTasks / size));

		return ResponseEntity.ok(response);
	}

	// 칸반보드 상태 변경
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping("/ajax/updateTaskStatus")
	@ResponseBody
	public ResponseEntity<String> updateTaskStatus(@RequestBody Map<String, Object> request) {
		int taskId = (int) request.get("taskId");
		String tkstCode = (String) request.get("tkstCode");
		String mdfcnYmd = (String) request.get("mdfcnYmd");
		projectService.updateTaskStatus(taskId, tkstCode, mdfcnYmd);

		return ResponseEntity.ok("작업상태 완료");
	}

	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping("/ajax/updateTaskDetail")
	@ResponseBody
	public ResponseEntity<String> updateTaskDetail(@RequestBody ProjectTaskVO projectTaskVO) {

		projectService.updateTaskDetail(projectTaskVO);

		return ResponseEntity.ok("success");
	}

	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("/ajax/selectTasksDay")
	@ResponseBody
	public ResponseEntity<List<Map<String, Object>>> selectTasksDay(HttpServletRequest request,
			@RequestParam("projNo") int projNo) {
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();

		ProjectTaskVO projectTaskVO = new ProjectTaskVO();
		projectTaskVO.setProjNo(projNo);

		projectTaskVO.setEmplId(emplId);

		List<Map<String, Object>> tasksDay = projectService.selectTasksDay(projectTaskVO);

		return ResponseEntity.ok(tasksDay);
	}

	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("/ajax/selectScheduleList")
	@ResponseBody
	public ResponseEntity<List<Map<String, Object>>> selectScheduleList(@RequestParam("projNo") int projNo) {
		
		List<Map<String, Object>> tasksDay = projectService.selectScheduleList(projNo);

		return ResponseEntity.ok(tasksDay);
	}

	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping("/ajax/insertSchedul")
	@ResponseBody
	public ResponseEntity<String> insertSchedul(@RequestBody ProjectScheduleVO schedule) {
		String result = "";
		int status = scheduleService.insertSchedul(schedule);
		if (status == 0) {
			result = "failed";
		} else {
			result = "success";
		}

		return ResponseEntity.ok(result);
	}

	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping("/ajax/updateSchedul")
	@ResponseBody
	public ResponseEntity<String> updateSchedul(@RequestBody ProjectScheduleVO schedule) {
		String result = "";
		int status = scheduleService.updateSchedul(schedule);
		
		if (status == 0) {
			result = "failed";
		} else {
			result = "success";
		}

		return ResponseEntity.ok(result);
	}

	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping("/ajax/updateDateSchedul")
	@ResponseBody
	public ResponseEntity<String> updateDateSchedul(@RequestBody ProjectScheduleVO schedule) {
		String result = "";
		int status = scheduleService.updateDateSchedul(schedule);
		if (status == 0) {
			result = "failed";
		} else {
			result = "success";
		}

		return ResponseEntity.ok(result);
	}

	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping("/ajax/deleteSchedul")
	@ResponseBody
	public ResponseEntity<String> deleteSchedul(@RequestBody Map<String, Object> request) {
		int projSchdlNo = (int) request.get("projschdlNo");
		try {
			scheduleService.deleteSchedul(projSchdlNo);
			return new ResponseEntity<>("삭제 성공", HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>("삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("/ajax/authCheck")
	@ResponseBody
	public ResponseEntity<ProjectPrtcpVO> authCheck(HttpServletRequest request, @RequestParam("projNo") int projNo) {
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		if (emplInfo == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
		}
		
		String emplId = emplInfo.getEmplId();
		ProjectPrtcpVO projectPrtcpVO = new ProjectPrtcpVO();
		projectPrtcpVO.setProjNo(projNo);
		projectPrtcpVO.setEmplId(emplId);
		
		ProjectPrtcpVO authPrtcp = projectService.authCheck(projectPrtcpVO);
		
		if (authPrtcp == null) {
	        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
	    }
		
		return ResponseEntity.ok(authPrtcp);
	}

	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("/ajax/selectTaskDetail")
	@ResponseBody
	public ResponseEntity<ProjectTaskVO> selectTaskDetail(@RequestParam("taskNo") int taskNo) {

		ProjectTaskVO projectTask = projectService.selectTaskDetail(taskNo);
	    if (projectTask == null) {
	        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
	    }
		
		return ResponseEntity.ok(projectTask);
	}

	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("/ajax/selectTaskGantChart")
	@ResponseBody
	public ResponseEntity<List<ProjectTaskVO>> selectTaskGantChart(@RequestParam("projNo") int projNo) {

        List<ProjectTaskVO> totalTaskList = projectService.selectTaskGantChart(projNo);
        if (totalTaskList == null || totalTaskList.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }

		return ResponseEntity.ok(totalTaskList);
	}

	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("/ajax/projPrtcpList")
	@ResponseBody
	public ResponseEntity<List<Map<String, Object>>> projPrtcpList(@RequestParam("projNo") int projNo) {
        if (projNo < 0) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }

        ProjectPrtcpVO projectPrtcpVO = new ProjectPrtcpVO();
        projectPrtcpVO.setProjNo(projNo);

        List<Map<String, Object>> projPrtcpList = projectService.projPrtcpList(projectPrtcpVO);
        if (projPrtcpList == null || projPrtcpList.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }

        return ResponseEntity.ok(projPrtcpList);
	}

	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping("/ajax/insertTask")
	@ResponseBody
	public ResponseEntity<String> insertTask(HttpServletRequest request, @RequestBody ProjectTaskVO projectTaskVO) {
		
        if (projectTaskVO == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid task data");
        }
		
		int status = projectService.insertTask(projectTaskVO);
		
        if (status == 0) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("failed");
        }

        return ResponseEntity.ok("success");

	}

}
