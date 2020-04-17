package kr.kosmo.jobkorea.sss.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kosmo.jobkorea.msm.model.LectureListModel;
import kr.kosmo.jobkorea.msm.service.LecturerService;

@Controller
@RequestMapping("/sss")
public class SignUpForClassController {

	@Autowired
	LecturerService lecturerService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("SignUpForClass.do")
	public String SignUpForClass(Model model) throws Exception {
		
		return "/sss/SignUpForClass";
	}
	
	// 강의 목록 조회 리스트 조회
		@RequestMapping("/classtListAct.do")
		@ResponseBody
		public Map<String, Object> classtListAct(Model model, @RequestParam Map<String, Object> paramMap,
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

			logger.info("+ Start " + className + ".classtListAct");
			logger.info("   - paramMap : " + paramMap);
			
			// 서비스 호출
			System.out.println("진행확인1");
					List<LectureListModel> classtListAct = lecturerService.classtListAct(paramMap);
					Map<String, Object> resultMap = new HashMap<String, Object>();
					resultMap.put("classtListAct", classtListAct);
					System.out.println("진행확인2");
					logger.info("+ End " + className + ".classtListAct");

			
		return resultMap;	
		}
	
		// 수강 등록
		@RequestMapping("/applyForClass.do")
		@ResponseBody
		public Map<String, Object> applyForClass(Model model, @RequestParam Map<String, Object> paramMap,
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

			String user_id = (String) session.getAttribute("loginId");
			paramMap.put("user_id", user_id);
			String result = "SUCCESS";
			String resultMsg = "수강신청이 완료되었습니다.";
			
			logger.info("+ Start " + className + ".applyForClass");
			logger.info("   - paramMap : " + paramMap);
			
			// 서비스 호출
			System.out.println("진행확인1");
			
			lecturerService.applyForClass(paramMap);
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("result", result);
			resultMap.put("resultMsg", resultMsg);
			System.out.println("진행확인2");
			
			logger.info("+ End " + className + ".applyForClass");

			
		return resultMap;	
		}
		
	
}
