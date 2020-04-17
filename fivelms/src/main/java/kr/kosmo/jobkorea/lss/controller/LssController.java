package kr.kosmo.jobkorea.lss.controller;

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

import kr.kosmo.jobkorea.lss.model.LssLectureModel;
import kr.kosmo.jobkorea.lss.service.LssService;

@Controller
@RequestMapping("/lss/")
public class LssController {

	private final Logger logger = LogManager.getLogger(this.getClass()); // Set
																			// logger
	private final String className = this.getClass().toString(); // Get class
																	// name for
																	// logger

	@Autowired
	LssService lService;

	@RequestMapping("/plList.do")
	public String plList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		return "/lss/plList";
	}

	@RequestMapping("/pListAll.do")
	public String pListAll(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	logger.info("@@@@@@@@@@@@@@@@@@Start pListAll@@@@@@@@@@@@@@");
	logger.info("@@@@@@@@@@@@@@파라아아암"+paramMap);
	int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
	int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
	int pageIndex = (currentPage-1)*pageSize;
	
	paramMap.put("pageIndex", pageIndex);
	paramMap.put("pageSize", pageSize);
	
	String loginId = (String) session.getAttribute("loginId");
	paramMap.put("loginId", loginId);
	System.out.println("여기는@@@@@@@@@@@@@@@@@ = "+ loginId);
	
	List<LssLectureModel> pListAll = lService.pListAll(paramMap);
	
	int totalCount = lService.countPlist(paramMap);
	
	model.addAttribute("pListAll", pListAll);
	model.addAttribute("totalCntPlist", totalCount);
	model.addAttribute("currentPagePlist",currentPage);
	model.addAttribute("pageSize", pageSize);
	
	logger.info("@@@@@@@@@@@@@@@@@END pListAll@@@@@@@@@@@@@@@@@");
		return "/lss/plListAll";
	}

	@RequestMapping("selectPlist.do")
	@ResponseBody
	public Map<String, Object> selectPlist(Model model, @RequestParam Map<Object, String>paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session)throws Exception{
	logger.info("@@@@@@@@@@@@@@@@START selectPlist@@@@@@@@@@@@@@@");

	
	LssLectureModel lssLectureModel = lService.selectPlist(paramMap);
	
	Map<String, Object>resultMap = new HashMap<String, Object>();
	
	resultMap.put("plist", lssLectureModel);
	resultMap.put("result", "SUCCESS");
	
	System.out.println("여기는 정보오오오오오오오오"+ lssLectureModel);
	logger.info("++ resultMap : "+resultMap);
	logger.info("@@@@@@@@@@@@@@@@END selectPlist@@@@@@@@@@@@@@@");
		return resultMap;
	}
	
	@RequestMapping("savePlist.do")
	@ResponseBody
	public Map<String, Object> savePlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("@@@@@@@@@@@@@@@@@START savePlist@@@@@@@@@@@@@@@@@@");
		logger.info("++ paramMap : "+paramMap);
		String action = (String)paramMap.get("action");
		
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		if("U".equals(action)){
			lService.updatePlist(paramMap);
		}else{
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}
		Map<String, Object>resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("@@@@@@@@@@@@@@@@@END savePlist@@@@@@@@@@@@@@@@@@@@");
	
	return resultMap;
	}
	
	   @RequestMapping("lecDocument.do")
	   public String UploadHF(Model result, @RequestParam Map<String, String> paramMap, HttpServletRequest request,
			   HttpServletResponse response, HttpSession session) throws Exception{
		   
			logger.info("+ Start " + className + ".initLssCod");
			logger.info("   - paramMap : " + paramMap);
			
			logger.info("+ End " + className + ".initLssCod");
		   
		   return "lss/enr/EnrollLectureData";
	   }
	   
	   
	
	
}