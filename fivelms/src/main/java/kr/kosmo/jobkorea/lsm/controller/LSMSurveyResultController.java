package kr.kosmo.jobkorea.lsm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kosmo.jobkorea.lsm.model.SurveyResultModel;
import kr.kosmo.jobkorea.lsm.service.SurveyResultService;

@Controller
@RequestMapping("/lsm/")
public class LSMSurveyResultController {

	@Autowired
	SurveyResultService surveyResultService;

	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	// 설문결과 조회
	@RequestMapping("surveyResult.do")
	public String selectSurvey(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		model.addAttribute("loginId", session.getAttribute("loginId"));
		
		String returnType = "/lsm/surveyResult";
		logger.info("+ Start " + className + ".initSurveyResult");
		logger.info(" - paramMap : " + paramMap);
		logger.info(" * 로그인 확인  " + session.getAttribute("loginId") + " * ");
		logger.info("+ End " + className + ".initSurveyResult");
		
		return returnType;
	}

	/* 설문결과 리스트 뿌려주기 */
	@RequestMapping("surveyList.do")
	
	public String selectSurveyList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".surveyList");
		logger.info(" - paramMap : " + paramMap);
		
		// 페이징 처리
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 세션값 로그인 아이디
		String Id = (String)session.getAttribute("loginId");
		paramMap.put("loginId", session.getAttribute("loginId"));
		
		// 서비스 호출(설문결과 조회)
		List<SurveyResultModel> surveylist = surveyResultService.selectSurveyList(paramMap);
//		System.out.println("리스트 나옵니까 : " + surveylist);
		model.addAttribute("surveylist", surveylist);
//		System.out.println("서비스 호출띠 : " + surveylist);
		logger.info("설문결과 목록 " + surveylist);
		
		// 목록 총 갯수 추출해서 보내주기
		int totalCnt = surveyResultService.countSurveyList(paramMap);
		model.addAttribute("totalCnt", totalCnt);
		
//		System.out.println("totalCnt 뽑히나요? : " + totalCnt);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage", currentPage);
		
		
		
		logger.info("+ End " + className + ".surveyList");
		
		return "/lsm/surveyCodList";

	}
	
	/*// 단건 조회
	@RequestMapping("surveyDetail.do")
	@ResponseBody
	public Map<String, Object> selectSurveyDetail(Model model, @RequestParam Map<String, Object> paramMap,	HttpServletRequest request,	HttpServletResponse response, 
				HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectSurveyDetail");
		logger.info("	- paramMap : " + paramMap);
		
		SurveyResultModel list = surveyResultService.selectSurveyDetail(paramMap);
		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);
		
		String result ="";
		
		// 선택된 목록 1건조회
		
		if(list != null){
			
			result = "SUCCESS";
		}else{
			result = "FAIL/ 불러오기실패!.";
		}
		
		Map<String, Object> resultMap = new HashMap<String,Object>();
		
		resultMap.put("loginId", loginId);
		resultMap.put("result", list);
		resultMap.put("resultMsg", result);
		resultMap.put("list", list);
		
		System.out.println("정보보보보보 : " + list);
		
		logger.info(list + "*******************");
		logger.info("+ End " + className + ".selectSurveyDetail");
		
		return resultMap;
	}
	*/

}
