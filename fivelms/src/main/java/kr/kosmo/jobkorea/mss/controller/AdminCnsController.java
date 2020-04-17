package kr.kosmo.jobkorea.mss.controller;

import java.text.SimpleDateFormat;
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

import kr.kosmo.jobkorea.mss.model.AdminCnsModel;
import kr.kosmo.jobkorea.mss.model.AdminLecModel;
import kr.kosmo.jobkorea.mss.service.AdminCnsService;

@Controller
@RequestMapping("/mss/")
public class AdminCnsController {
	private final Logger logger = LogManager.getLogger(this.getClass());

	private final String className = this.getClass().toString();

	@Autowired
	AdminCnsService acService;

	@RequestMapping("/cnsManage.do")
	public String adminPl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("@@@@@@@@@@@@@START cnsManage@@@@@@@@@@@@@@@@@@@");
		logger.info("@@@@@@@@@@@@@END cnsManage@@@@@@@@@@@@@@@@@@@@@");
		return "/mss/adminCns";
	}

	@RequestMapping("/cnsList.do")
	public String cnsList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("@@@@@@@@@@@@@START cnsList@@@@@@@@@@@@@@@@@@@");

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		List<AdminLecModel> cnsList = acService.cnsList(paramMap);

		int totalCount = acService.countlist(paramMap);

		model.addAttribute("cnsList", cnsList);
		model.addAttribute("totalCntlist", totalCount);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("pagesize", pageSize);

		logger.info("@@@@@@@@@@@@@END cnsList@@@@@@@@@@@@@@@@@@@@@");
		return "/mss/adminCnsList";
	}

	@RequestMapping("/cnsUserList.do")
	public String cnsUserlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("@@@@@@@@@@@@@@@@START cnsUserList.do @@@@@@@@@@@@@@@@");
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;
		

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		List<AdminLecModel> cnsUserList = acService.cnsUserList(paramMap);
		model.addAttribute("userList", cnsUserList);
		
		
		int totalCount = acService.countUser(paramMap);
		
		model.addAttribute("totalCntlist", totalCount);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("pagesize", pageSize);
		model.addAttribute("lecSeq", paramMap.get("lecSeq"));
		logger.info("@@@@@@@@@@@@@@@@cnsUserList.do END@@@@@@@@@@@@@@@@");
		return "/mss/adminCnsUserList";
	}
	
	@RequestMapping("selectUserList.do")
	@ResponseBody
	public Map<String, Object> selectUserList(Model model, @RequestParam Map<Object, String> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("@@@@@@@@@@@@@@@@@@@@@@@selectUserList.do START @@@@@@@@@@@@@@@@");
		
		AdminCnsModel adminCnsModel = acService.selectUser(paramMap);
		
		String inDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		paramMap.put("indate", inDate);
		
		String lecSeq = (String) paramMap.get("lec_seq");
		paramMap.put("lecSeq", lecSeq);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("indate", inDate);
		resultMap.put("cnsList", adminCnsModel);
		resultMap.put("result", "SUCCESS");
		logger.info("@@@@@@@@@@@@@@@@@@@@@@@selectUserList.do END @@@@@@@@@@@@@@@@");
		return resultMap;
	}
	
	@RequestMapping("saveUserList.do")
	@ResponseBody
	public Map<String, Object> saveUserList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("@@@@@@@@@@@@@@@@@@@@ saveUserList START @@@@@@@@@@@@@@@");
		logger.info("@@@@@@@@@@@@@@@@@@@@PARAMMAP @@@@@@@@@@@@@@@"+paramMap);		
		String action = (String)paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "저장되었습니다.";
		
		if("I".equals(action)){
			acService.insertCnsUser(paramMap);
		}else if("U".equals(action)){
			acService.updateCnsUser(paramMap);
		}else{
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("@@@@@@@@@@@@@@@@@@@@ saveUserList END @@@@@@@@@@@@@@@");
		return resultMap;
	}
	@RequestMapping("deleteClist.do")
	@ResponseBody
	public Map<String, Object> deleteClist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".deleteClist");
		logger.info("   - paramMap : " + paramMap);
		
		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";
		
		acService.deleteClist(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".deleteComnGrpCod");
		
		return resultMap;
	}
}