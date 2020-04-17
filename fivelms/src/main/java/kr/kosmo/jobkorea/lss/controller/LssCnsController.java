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
import org.springframework.web.context.request.SessionScope;

import kr.kosmo.jobkorea.lss.service.LssCnsService;

@Controller
@RequestMapping("/lss/")
public class LssCnsController {
	 // Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());

	   // Get class name for logger
	   private final String className = this.getClass().toString();
	   
	   @Autowired
	   LssCnsService lcService;
	   
	   @RequestMapping("/cnsManage.do")
	   public String cnsManage(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			return "lss/cnsManage";
			
	   }
	   
	   @RequestMapping("lecList.do")
		@ResponseBody
		public Map<String,Object> lecList(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
				
		    logger.info("+ Start lecList");
		    logger.info("   - paramMap : " + paramMap);
			
		    String loginId = (String) session.getAttribute("loginId");
		    paramMap.put("loginId", loginId);
		    
		    List<Map<String, Object>> list = lcService.lecList(paramMap);
		    
		    
		    Map<String, Object> resultMap = new HashMap<>();
			
			resultMap.put("message", "성공염따빠끄");
			resultMap.put("list",list);
			
			logger.info("+ resultMap "+ resultMap);
			logger.info("+ End lecList");
		    
			return resultMap;
		}
	   
	   @RequestMapping("selectSList.do")
	   @ResponseBody
	   public Map<String,Object> selectSList(Model model, @RequestParam Map<String,Object>paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session)throws Exception{
		   logger.info("+ Start lecList");
		   logger.info("   - paramMap : " + paramMap);
		  
		   List<Map<String, Object>> sList = lcService.selectSList(paramMap);
		   
		   
		   Map<String, Object>resultMap = new HashMap<>();
		   resultMap.put("sList", sList);
		   
		   logger.info("+ resultMap "+ resultMap);
		   logger.info("+ End lecList");
		    
			return resultMap;
	   }
	   @RequestMapping("sListOne.do")
	   @ResponseBody
	   public Map<String,Object> sListOne(Model model, @RequestParam Map<String,Object>paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session)throws Exception{
		   logger.info("+ Start sListOne");
		   logger.info("+   - paramMap : " + paramMap);
		   
		  Map<String,Object> sListOne = lcService.sListOne(paramMap);
		   
		   Map<String, Object>resultMap = new HashMap<>();
		   resultMap.put("list", sListOne);
		   
		   
		   logger.info("+ resultMap "+resultMap);
		   logger.info("+ End sListOne");
		   
		   return resultMap;
	   }
	   @RequestMapping("updateCns.do")
	   @ResponseBody
	   public Map<String,Object> updateCns(Model model, @RequestParam Map<String,Object>paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session)throws Exception{
		   logger.info("+ Start updateCns");
		   logger.info("+   - paramMap : " + paramMap);
		   
		  lcService.updateCns(paramMap);
		   
		   Map<String, Object>resultMap = new HashMap<>();
		   resultMap.put("msg", "SUCCESS");
		   
		   
		   logger.info("+ resultMap "+resultMap);
		   logger.info("+ End updateCns");
		   
		   return resultMap;
	   }
	   
}
