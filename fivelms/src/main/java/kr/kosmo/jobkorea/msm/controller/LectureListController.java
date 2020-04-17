package kr.kosmo.jobkorea.msm.controller;

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
@RequestMapping("/msm")
public class LectureListController {

	@Autowired
	LecturerService lecturerService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	// 강의목록 조회 화면 접속
	@RequestMapping("/lectureList.do")
	public String lectureList(Model model) throws Exception {
		
		return "msm/lectureList";
	}
	
	// 강의 목록 조회 리스트 조회
	@RequestMapping("/lectListAct.do")
	@ResponseBody
	public Map<String, Object> lectListAct(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".lectListAct");
		logger.info("   - paramMap : " + paramMap);
		
		// 서비스 호출
		System.out.println("진행확인1");
				List<LectureListModel> lectList = lecturerService.lectList(paramMap);
				Map<String, Object> resultMap = new HashMap<String, Object>();
				resultMap.put("lectList", lectList);
				System.out.println("진행확인2");
				logger.info("+ End " + className + ".lectListAct");

		
	return resultMap;	
	}
	
	// 강의 목록 조회 리스트 조회
		@RequestMapping("/lectPeopleInfo.do")
		@ResponseBody
		public Map<String, Object> lectPeopleInfo(Model model, @RequestParam Map<String, Object> paramMap,
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

			logger.info("+ Start " + className + ".lectPeopleInfo");
			logger.info("   - paramMap : " + paramMap);
			
			// 서비스 호출
			System.out.println("진행확인1");
					List<LectureListModel> lectPeopleInfo = lecturerService.lectPeopleInfo(paramMap);
					Map<String, Object> resultMap = new HashMap<String, Object>();
					resultMap.put("lectPeopleInfo", lectPeopleInfo);
					System.out.println("진행확인2");
					logger.info("+ End " + className + ".lectPeopleInfo");

			
		return resultMap;	
		}
}
