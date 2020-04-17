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

import kr.kosmo.jobkorea.lsm.model.LSMProgModel;
import kr.kosmo.jobkorea.lsm.service.LSMProgressService;

@Controller
@RequestMapping("/lsm/")
public class LSMProgController {

	   // Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());

	   // Get class name for logger
	   private final String className = this.getClass().toString();
	   
	   @Autowired
	   LSMProgressService LsmprogService;

	   
	   //과제관리리스트 조회
	   @RequestMapping("progress.do")
	   public String UploadHF(Model result, @RequestParam Map<String, String> paramMap, HttpServletRequest request,
			   HttpServletResponse response, HttpSession session) throws Exception{
		   
			logger.info("+ Start " + className + ".initProgCod");
			logger.info("   - paramMap : " + paramMap);
			logger.info(" ** 로그인확인 : " + session.getAttribute("loginId") + "  **");
			logger.info("+ End " + className + ".initProgCod");
		   
		   return "lsm/prog/LsmProgList";
	   }
	   
	 //리스트 조회
	   @RequestMapping("LsmProgList.do")
	   @ResponseBody
	   public Map<String, Object> ShowProgList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			   HttpServletResponse response, HttpSession session) throws Exception{
	   
			logger.info("+ Start " + className + ".LsmProgList");
					
			// 로그인한 강사(id) 담당 강의 목록 뽑기
			logger.info(" ** 로그인확인 : " + session.getAttribute("loginId") + "  **");
			String loginId = (String)session.getAttribute("loginId");
			paramMap.put("LoginId", loginId);
			logger.info("   - paramMap : " + paramMap);
			
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
			int pageIndex = (currentPage -1)*pageSize;
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			 logger.info(" 중간   - paramMap : " + paramMap);
			
			List<Map<String, Object>> LsmLectureList = LsmprogService.SelectAllList(paramMap);		   
		 // logger.info("** 목록확인 : " + LsmLectureList + " ** ");
				
		
			int totalCnt = LsmprogService.cntAll(paramMap);
			
			
		   Map<String, Object> resultMap = new HashMap<String, Object>();
		   
		   resultMap.put("LsmLectureList", LsmLectureList);
		   resultMap.put("totalCnt", totalCnt);
		   
			logger.info("+ End " + className + ".LsmProgList");
		   return resultMap;
	   }
	   
	   
	   @RequestMapping("selectProgDetail.do")
	   @ResponseBody
	   public Map<String, Object> ShowProgDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			   HttpServletResponse response, HttpSession session) throws Exception{
		   logger.info("+ Start " + className + ".LsmProgDetail");
		   logger.info("   - paramMap : " + paramMap);
		   
		   LSMProgModel LsmProgDetail = LsmprogService.SelectDetail(paramMap);
		   
		   Map<String, Object> resultMap = new HashMap<String, Object>();
		   
		   resultMap.put("LsmProgDetail", LsmProgDetail);
		   logger.info(LsmProgDetail);
		   logger.info("+ End " + className + ".LsmProgDetail");
		   return resultMap;
	   }
	   
	   @RequestMapping("updateProg.do")
	   @ResponseBody
	   public Map<String, Object> updateProgDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			   HttpServletResponse response, HttpSession session) throws Exception{
		   
		   logger.info("+ Start " + className + ".LsmProgUpdate");
		   logger.info("   - paramMap : " + paramMap);
		   
		   LsmprogService.updateLecProg(paramMap);
		   String resultMsg="Success";
		   
		   Map<String, Object> resultMap = new HashMap<String, Object>();
		   resultMap.put("resultMsg", resultMsg);
		   
		   logger.info("+ End " + className + ".LsmProgUpdate");
		   return resultMap;
	   }
	   
}