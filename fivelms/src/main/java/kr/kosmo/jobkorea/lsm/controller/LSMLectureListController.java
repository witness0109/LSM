package kr.kosmo.jobkorea.lsm.controller;

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

import kr.kosmo.jobkorea.lsm.model.LectureListModel;
import kr.kosmo.jobkorea.lsm.service.LectureListService;

@Controller
@RequestMapping("/lec/")
public class LSMLectureListController {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	LectureListService lectureListService;
	
	@RequestMapping("lecList.do")
	public String lectureList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session, String resultMap) throws Exception {
	
		logger.info("+ Start " + className + ".selectList");
		
		paramMap.put("loginId", session.getAttribute("loginId"));
		
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;
		
		logger.info("   - paramMap : " + paramMap + " 123123123132 ");
		logger.info("+ End " + className + ".LecCod");
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 전체 목록 조회
		List<LectureListModel> listLectureModel = lectureListService.lecList(paramMap);
		paramMap.put("list", listLectureModel);
		model.addAttribute("list", listLectureModel);
		
		// 강의목록 카운트
		int totalCount = lectureListService.countlecList(paramMap);
		paramMap.put("totalCount", totalCount);
		
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("pageSize", pageSize);

		logger.info("+ End " + className + ".selectList");
		
		return "/lsm/lec/LsmLectureList";
	}
	
		/** 학생 조회 */
		@RequestMapping("selectlecDtl.do")
		
		public Map<String, Object> selectlecDtl(Model model, @RequestParam Map<String, Object> paramMap,
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
			logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@selectlecDtl");
			
			logger.info(paramMap);
			String result = "SUCCESS";
			String resultMsg = "";

			String loginId = (String) session.getAttribute("loginId");
			paramMap.put("loginId", loginId);
			
			List<Map<String, Object>> map = lectureListService.selectlecDtl(paramMap);
			Map<String, Object> resultMap = new HashMap<String, Object>();

			resultMap.put("map", map);
			resultMap.put("result", result);
			resultMap.put("resultMsg", resultMsg);
			
			logger.info("@@@@@@@@@@@@@@@@@@@@@END selectlecDtl");

			return resultMap;
		}

	
}	
