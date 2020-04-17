package kr.kosmo.jobkorea.lss.controller;

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
import kr.kosmo.jobkorea.lss.dao.LSSEnrLecDao;
import kr.kosmo.jobkorea.lss.model.LSSEnrDocModel;
import kr.kosmo.jobkorea.lss.service.LSSEnrLecService;

@Controller
@RequestMapping("/enr/")
public class LSSEnrLecController {

	   // Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());

	   // Get class name for logger
	   private final String className = this.getClass().toString();
	
	   @Autowired
	   LSSEnrLecService LssEnrLecService;
	   
		// Root path for file upload 
		@Value("${fileUpload.rootPath}")
		private String rootPath;
	   
	   //학습자료관리 리스트 조회
	   @RequestMapping("lssBoard.do")
	   public String initLecDocList(Model result, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			   HttpServletResponse response, HttpSession session) throws Exception{
		   
			logger.info("+ Start " + className + ".initLssCod");
			
			paramMap.put("loginId", session.getAttribute("loginId")); // 제목
			//paramMap.put("userType", session.getAttribute("userType")); // 오피스 구분 // 코드
			//paramMap.put("reg_date", session.getAttribute("reg_date")); // 등록 일자
			
			logger.info("   - paramMap : " + paramMap);
		
			
			logger.info("+ End " + className + ".initLssCod");
		   
		   return "EnrollLectureData";
	   }
	   
	   /* 학습자료관리 리스트 뿌리기 */
		@RequestMapping("LecDocList.do")
		@ResponseBody
		public Map<String,Object> selectLecDocList(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
				
		    logger.info("+ Start " + className + ".LecDocList");
		    logger.info("   - paramMap : " + paramMap);
			
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage")); // 현재페이지 
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
			int pageIndex = (currentPage -1)*pageSize;
			
			// 사이즈는 int형으로, index는 2개로 만들어서 -> 다시 파람으로 만들어서 보낸다.
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			String Id =  (String)session.getAttribute("loginId");
			paramMap.put("loginId", session.getAttribute("loginId"));
			System.out.println(Id + "  session id 확인 ");
			
			List<Integer> lssLecSeq = LssEnrLecService.selectLecSeq(Id);
			logger.info("강의번호" + lssLecSeq);
			
			List<String> lssLecNm = LssEnrLecService.selectLecNm();
			logger.info("강의번호" + lssLecNm);
			logger.info(" 중간   - paramMap : " + paramMap);
			
			//서비스 호출
			List<Map<String,Object>> LecDocList = LssEnrLecService.selectLssList(paramMap);
			 logger.info(" 조회후  - paramMap : " + paramMap + "  " );
			
			//숫자 추출 보내기
			int totalCnt = LssEnrLecService.LecDocTotalCnt(paramMap);
	
			Map<String,Object> resultMap = new HashMap<String, Object>();
			
			resultMap.put("LecDocList", LecDocList);
			resultMap.put("totalCnt", totalCnt);
			resultMap.put("lecSeq", lssLecSeq);
			resultMap.put("lecNm", lssLecNm);
		    
			logger.info("+ End " + className + ".LecDocList");
		    
			return resultMap;
		}
		
		//등록, 수정, 삭제
		@RequestMapping("saveFile.do")
		@ResponseBody
		public Map<String,Object> insertLecDoc(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception{
			
			logger.info("+ Start " + className + ".saveLssCod");
			
			String action = (String)paramMap.get("action");
			String lec_seq = (String)paramMap.get("lec_seq");
			String resultMsg = "";
			
			paramMap.put("enr_user", session.getAttribute("loginId")); // 제목
			logger.info("   - paramMap : " + paramMap + "강의번호 : " + lec_seq + " 아이디확인: " + session.getAttribute("loginId") );
		
			if("I".equals(action)) {
				LssEnrLecService.insertLecDoc(paramMap, request);
				resultMsg = "Success";
				logger.info("---->"+resultMsg+"<---신규 생성 성공");
			}else if("U".equals(action)){
				logger.info( " 업데이트시 param값" + paramMap);
				LssEnrLecService.updateLecDoc(paramMap);
				resultMsg = "Success";
				logger.info("---->"+resultMsg+"<---업데이트 성공");
			}else if("D".equals(action)){
				
				LssEnrLecService.deleteLss(paramMap);
				resultMsg = "Success";
				logger.info("---->"+resultMsg+"<---삭제 성공");
				
			}else{
				
				resultMsg = " False ";
				logger.info("---->"+resultMsg+"<--- 실패");
				
			}
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("resultMsg", resultMsg);
			
			logger.info("+ End " + className + ".saveLssCod");
			
			return resultMap;
		}
		
		
		//단건조회
		@RequestMapping("selectDetailLss.do")
		@ResponseBody
		public Map<String, Object> selectDetailLss(Model model, @RequestParam Map<String, Object> paramMap,	HttpServletRequest request,	HttpServletResponse response, 
				HttpSession session) throws Exception { 

			logger.info("+ Start " + className );
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> list = LssEnrLecService.selectLssDetail(paramMap);
		
			logger.info(list + "!!!!!!!!!!!!!!!!!!");
			
			
			logger.info("=============== selectDetailLss End");

			return list;
		}
		

		

}