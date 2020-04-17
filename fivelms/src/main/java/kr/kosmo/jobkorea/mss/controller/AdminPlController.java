package kr.kosmo.jobkorea.mss.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import kr.kosmo.jobkorea.mss.model.AdminLecModel;
import kr.kosmo.jobkorea.mss.model.AdminRModel;
import kr.kosmo.jobkorea.mss.service.AdminPlService;

@Controller
@RequestMapping("/mss/")
public class AdminPlController {

	private final Logger logger = LogManager.getLogger(this.getClass());

	private final String className = this.getClass().toString();

	@Autowired
	AdminPlService aplService;

	@RequestMapping("/adminPl.do")
	public String adminPl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("@@@@@@@@@@@@@START adminPl@@@@@@@@@@@@@@@@@@@");
		logger.info("@@@@@@@@@@@@@END adminPl@@@@@@@@@@@@@@@@@@@@@");
		return "/mss/adminPl";
	}

	@RequestMapping("/aPlist.do")
	public String aPlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("@@@@@@@@@@@@@START aPlist@@@@@@@@@@@@@@@@@@@");
		logger.info("@@@@@@@@@@@@@파람입니당" + paramMap);

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);
		List<AdminLecModel> aPlist = aplService.aPlist(paramMap);

		int totalCount = aplService.countaPlist(paramMap);

		model.addAttribute("aPlist", aPlist);
		model.addAttribute("totalCntaPlist", totalCount);
		model.addAttribute("currentPageaPlist", currentPage);
		model.addAttribute("pageSize", pageSize);

		logger.info("@@@@@@@@@@@@@END aPlist@@@@@@@@@@@@@@@@@@@@@");

		return "/mss/adminPlist";
	}

	@RequestMapping("selectaPlist.do")
	@ResponseBody
	public Map<String, Object> selectaPlist(Model model, @RequestParam Map<Object, String> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("@@@@@@@@@@@@@@@@START selectPlist@@@@@@@@@@@@@@@");

		AdminLecModel adminlecModel = aplService.selectaPlist(paramMap);

		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);

		String inDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		paramMap.put("indate", inDate);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap.put("indate", inDate);
		resultMap.put("loginId", loginId);
		resultMap.put("plist", adminlecModel);
		resultMap.put("result", "SUCCESS");

		System.out.println("여기는 정보오오오오오오오오" + adminlecModel);
		logger.info("++ resultMap : " + resultMap);
		logger.info("@@@@@@@@@@@@@@@@END selectPlist@@@@@@@@@@@@@@@");

		return resultMap;
	}
	@RequestMapping("SelectBox.do")
	@ResponseBody
	public Map<String, Object> rList(Model model, @RequestParam Map<Object, String> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info(" + param + " + paramMap +"입니당");
		
		List<Map<String, Object>>rList = aplService.rList(paramMap);
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rList", rList);
		resultMap.put("result", "SUCCESS");
		logger.info("여기는 resultMap"+ rList);
		return resultMap;
	}
	@RequestMapping("saveaPlist.do")
	@ResponseBody
	public Map<String, Object> saveaPlist(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("@@@@@@@@@@@@@@@@@START savePlist@@@@@@@@@@@@@@@@@@");
		logger.info("++ paramMap : " + paramMap);
		
		String action = (String) paramMap.get("action");
		
		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);
		
		
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		if("I".equals(action)){
			aplService.inseraPlist(paramMap);
		}else if("U".equals(action)){ 
			aplService.updateaPlist(paramMap);
		} else {
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		logger.info("@@@@@@@@@@@@@@@@@END savePlist@@@@@@@@@@@@@@@@@@@@");

		return resultMap;
	}
	/*삭제*/
	@RequestMapping("deletePlist.do")
	@ResponseBody
	public Map<String, Object> deletePlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".deleteComnGrpCod");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";
		
		// 그룹코드 삭제
		aplService.deletePlist(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".deleteComnGrpCod");
		
		return resultMap;
	}
}