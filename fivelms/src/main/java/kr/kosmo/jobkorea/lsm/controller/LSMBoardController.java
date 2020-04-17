package kr.kosmo.jobkorea.lsm.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kosmo.jobkorea.cmnt.model.CmntBbsAtmtFilModel;
import kr.kosmo.jobkorea.lsm.model.LsmStuCodModel;
import kr.kosmo.jobkorea.lsm.model.taskFileModel;
import kr.kosmo.jobkorea.lsm.model.taskInfoModel;
import kr.kosmo.jobkorea.lsm.service.LSMBoardService;

@Controller
@RequestMapping("/lsm/")
public class LSMBoardController {

	   // Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());

	   // Get class name for logger
	   private final String className = this.getClass().toString();
	
	   @Autowired
	   LSMBoardService lsmBoardService;
	   
		// Root path for file upload 
		@Value("${fileUpload.rootPath}")
		private String rootPath;
	   
	   //과제관리리스트 조회
	   @RequestMapping("lsmBoard.do")
	   public String UploadHF(Model result, @RequestParam Map<String, String> paramMap, HttpServletRequest request,
			   HttpServletResponse response, HttpSession session) throws Exception{
		   
			logger.info("+ Start " + className + ".initLsmCod");
			logger.info("   - paramMap : " + paramMap);
			logger.info(" ** 로그인확인 : " + session.getAttribute("loginId") + "  **");
			logger.info("+ End " + className + ".initLsmCod");
		   
		   return "lsm/EnrHomework";
	   }
	   
	   
	   
	   @RequestMapping("listLsmCod.do")
	   public String listLsmCod(Model model, @RequestParam Map <String, Object> paramMap, HttpServletRequest request,
			   HttpServletResponse response, HttpSession session) throws Exception{
			
		    logger.info("+ Start " + className + ".listLsmCod");
			logger.info("   - paramMap : " + paramMap);
			
			
			 String loginID = (String)session.getAttribute("loginId"); 
			 request.setAttribute("loginID", loginID);
			
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
			int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
					
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
		   
			//강의번호 목록 조회해서 넘기기
			List<Integer> lsmLecSeq = lsmBoardService.selectLecSeq();
			model.addAttribute("lecSeq", lsmLecSeq);
			logger.info("강의번호" + lsmLecSeq);
			
			//강의명 목록 조회해서 넘기기
			List<String> lsmLecNm = lsmBoardService.selectLecNm();
			model.addAttribute("lecNm", lsmLecNm);
			logger.info("강의명" + lsmLecNm);
			
		   // 목록 조회
		   List<Map<String,Object>> listLsmCodModel = lsmBoardService.selectLsmBoardList(paramMap);
		   model.addAttribute("listLsmCodModel",listLsmCodModel);
		   logger.info("목록" + listLsmCodModel);
		   
		   // 목록 카운트 조회
			int totalCount = lsmBoardService.countListLsmCod(paramMap);
			model.addAttribute("totalCntLsmCod", totalCount);
		   

			model.addAttribute("pageSize", pageSize);
			model.addAttribute("currentPageLsmCod",currentPage);
		   
		   logger.info("+ End " + className + ".listLsmCod");
		   
		   return "lsm/lsmCodList";
	   }
	   
	   
	   //단건조회
	   @RequestMapping("selectLsmCod.do")
	   @ResponseBody
	   public Map<String, Object> selectLsmCod (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			    HttpServletResponse response, HttpSession session) throws Exception{
		   
		   logger.info("+ Start " + className + ".selectLsmCod");
		   logger.info("   - paramMap : " + paramMap);
		   
		   String result = "Success";
		   String resultMsg = "조회되었습니다.";
		   
		   // 단건 조회
		   Map<String,Object> lsmModel = lsmBoardService.selectLsmCod(paramMap);
		   Map<String,Object> LsmFil = lsmBoardService.selectLsmFil(paramMap);
		   
		   Map<String,Object> resultMap = new HashMap<String, Object>();
		   
		   
			resultMap.put("result", result);
			resultMap.put("resultMsg", resultMsg);
			resultMap.put("lsmModel", lsmModel);
			resultMap.put("LsmFil", LsmFil);
			
			 logger.info("   - paramMap : " + paramMap);
			logger.info("+ End " + className + ".selectLsmCod");
		   return resultMap;
	   }
	   
	   //저장
	   @RequestMapping("saveLsmCod.do")
	   @ResponseBody
	   public Map<String, Object> saveLsmCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			    HttpServletResponse response, HttpSession session) throws Exception {
		   
		   logger.info("+ Start " + className + ".saveLsmCod");
		   
			
			String action = (String)paramMap.get("action");
			String result = "Success";
			String resultMsg = "저장 되었습니다.";
			
			logger.info(action);
			logger.info("   - paramMap : " + paramMap);
					
			//과제 등록
			//paramMap.put("fst_rgst_sst_id", session.getAttribute("usrSstId"));
			//paramMap.put("fnl_mdfr_sst_id", session.getAttribute("usrSstId"));
			
			if("I".equals(action)){
				//신규저장
				lsmBoardService.insertLsmCod(paramMap, request);
				logger.info(request);
				
			} else if ("U".equals(action)){ 
				//수정저장
				lsmBoardService.updateLsmCod(paramMap, request);;
			
				
			} else  {
				result = "False";
				resultMsg = "알수 없는 요청이래유";
			}
		    
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("result", result);
			resultMap.put("resultMsg", resultMsg);
			
			logger.info("+ End " + className + ".saveLsmCod");	
			
			return resultMap;
	   }
		
		@RequestMapping("deleteLsmCod.do")
		@ResponseBody
		public Map<String, Object> deleteLsmCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".deleteLsmCod");
			logger.info("   - paramMap : " + paramMap);

			String result = "Success";
			String resultMsg = "삭제 되었습니다.";
			
			// 그룹코드 삭제
			lsmBoardService.deleteLsmCod(paramMap);
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("result", result);
			resultMap.put("resultMsg", resultMsg);
			
			logger.info("+ End " + className + ".deleteLsmCod");
			
			return resultMap;
		}
		
		
		/*  첨부파일 다운로드 */
		@RequestMapping("downloadLsmFil.do")
		public void downloadLsmFil(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
		
			logger.info("+ Start " + className + ".downloadLsmFil");
			logger.info("   - paramMap : " + paramMap);
			
			// 첨부파일 조회
			Map<String,Object> lsmFilModel = lsmBoardService.selectLsmFil(paramMap);
			
			byte fileByte[] = FileUtils.readFileToByteArray(new File(rootPath+(String)lsmFilModel.get("psc_fil_nm")));
			
			response.setContentType("application/octet-stream");
		    response.setContentLength(fileByte.length);
		    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode((String)lsmFilModel.get("lgc_fil_nm"),"UTF-8")+"\";");
		    response.setHeader("Content-Transfer-Encoding", "binary");
		    response.getOutputStream().write(fileByte);
		     
		    response.getOutputStream().flush();
		    response.getOutputStream().close();

			logger.info("+ End " + className + ".downloadLsmFil");
		}
		
		@RequestMapping("downloadLsmStuFil.do")
		public void downloadStuFil(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
		
			logger.info("+ Start " + className + ".downloadLsmFil");
			logger.info("   - paramMap : " + paramMap);
			
			// 첨부파일 조회
			Map<String,Object> lsmFilModel = lsmBoardService.selectStuFil(paramMap);
			
			byte fileByte[] = FileUtils.readFileToByteArray(new File(rootPath+(String)lsmFilModel.get("psc_fil_nm")));
			
			response.setContentType("application/octet-stream");
		    response.setContentLength(fileByte.length);
		    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode((String)lsmFilModel.get("lgc_fil_nm"),"UTF-8")+"\";");
		    response.setHeader("Content-Transfer-Encoding", "binary");
		    response.getOutputStream().write(fileByte);
		     
		    response.getOutputStream().flush();
		    response.getOutputStream().close();

			logger.info("+ End " + className + ".downloadLsmFil");
		}
		
		/*  과제 제출 학생 조회  */
		@RequestMapping("LsmStuCod.do")
		public  String selectStuLsmList (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".LsmStuCod");
			
			logger.info("   - paramMap : " + paramMap + "  ");
			
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
			int pageIndex = (currentPage-1)*pageSize;		 // 페이지 시작 row 번호	
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			//과제 제출 목록 조회
			List<Map<String,Object>> listStuCodModel = lsmBoardService.selectLsmStuList(paramMap);
			model.addAttribute("listStuCodModel",listStuCodModel);
			
			logger.info("   - paramMap : " + paramMap + "2 ");
			
			//해당 과제 제출 목록 카운트 조회
			int totalCount = lsmBoardService.countLsmStuListCod(paramMap);
			model.addAttribute("totalCntLsmStu", totalCount);
			
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("currentPageStuCod",currentPage);
			
			String result = "Success";
			String resultMsg = "조회되었습니다.";
			
			model.addAttribute("result", result);
			model.addAttribute("resultMsg", resultMsg);
		    
			logger.info("   - paramMap : " + paramMap + " 3 ");
			logger.info("+ End " + className + ".LsmStuCod");
			

			return "lsm/LsmStuList";
		}
		
		
		// 강의목록 초기화면 
		@RequestMapping("lecture.do")
		public String lecture(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".lecture");
			
			paramMap.put("loginId", session.getAttribute("loginId")); // 제목

			
			logger.info("   - paramMap : " + paramMap);
		
			
			logger.info("+ End " + className + ".lecture");
			
			
			return "lsm/lec/LsmLecture";
		}
		

}
