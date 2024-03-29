package kr.kosmo.jobkorea.ssm.controller;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kosmo.jobkorea.ssm.service.StuQnaService;

@Controller
@RequestMapping("/stuQna/")
public class SsmStudentQnaController {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	StuQnaService stuQnaService;
	
	
	@RequestMapping("qnaList.do")
	@ResponseBody
	public  Map<String,Object> qnaList(Model model, 
								@RequestParam Map<String, Object> paramMap, 
								HttpServletRequest request,
								HttpServletResponse response, 
								HttpSession session) throws Exception {

		logger.info("+ Start " + className );
		logger.info("   - paramMap : " + paramMap);
		logger.info("들어옴 " + session.getAttribute("loginId"));
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage")); // 현재페이지 
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int pageIndex = (currentPage -1)*pageSize;
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		logger.info("-------------------- currentPage, pageSize , page Index  \n"+
								currentPage +pageSize+pageIndex);
		List<Map<String,Object>> list=stuQnaService.qnaList(paramMap);
		
		logger.info("@@@@@@@@@@"+list.toString());
		int totalCnt = stuQnaService.getTotalCnt(paramMap);
		logger.info("%%%%%%%%%%%%%%%%%totalCnt : "+totalCnt);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("list", list);
		resultMap.put("totalCnt",totalCnt);
		
		//mav.addObject("test","test");
		resultMap.put("abc", "abc");
		logger.info("--------------------  qnaList  End ");
		
		return resultMap;
	}
	
	@RequestMapping("selectQna.do")
	@ResponseBody
	public  Map<String,Object> selectQna(Model model, 
								@RequestParam Map<String, Object> paramMap, 
								HttpServletRequest request,
								HttpServletResponse response, 
								HttpSession session) throws Exception {

		logger.info("+ Start " + className );
		logger.info("   - paramMap : " + paramMap);
		
		///조회수증가는 service에서한다잉.
		Map<String,Object> list=stuQnaService.selectQna(paramMap);
		
		
		
		
		logger.info("@@@@@@@@@@"+list.toString());
			
		

		logger.info("--------------------  selectQna  End ");
		
		return list;
	}
	
	@RequestMapping("selectQnaList.do")
	@ResponseBody
	public Map<String,Object> selectQnaList(Model model,
											@RequestParam Map<String, Object> paramMap, 
											HttpServletRequest request,
											HttpServletResponse response, 
											HttpSession session) throws Exception {
		
		logger.info("+ Start " + className );
		logger.info("   - paramMap : " + paramMap);
		/*logger.info("들어옴 " + session.getAttribute("userNm"));
		logger.info("들어옴1 " + session.getAttributeNames().nextElement());
		logger.info("들어옴 2" + session.getAttributeNames().nextElement());
		logger.info("들어옴 3" + session.getAttributeNames().nextElement());
		logger.info("들어옴 4" + session.getAttributeNames().nextElement());
		*/
		
	
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage")); // 현재페이지 
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int pageIndex = (currentPage -1)*pageSize;
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		List<Map<String,Object>> list = stuQnaService.selectQnaList(paramMap);
		logger.info("@@@@@@@@@@@@@@@"+list);
		
		int totalCnt = stuQnaService.getTotalCnt(paramMap);
		logger.info("%%%%%%%%%%%%%%%%%totalCnt : "+totalCnt);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("list", list);
		resultMap.put("totalCnt",totalCnt);
		
		
		logger.info("+ end selectQnaList");
		
		return resultMap;
	}
	
	
	@RequestMapping("saveStuQna.do")
	@ResponseBody
	public Map<String,Object> saveStuQna(Model model,
											@RequestParam Map<String, Object> paramMap, 
											HttpServletRequest request,
											HttpServletResponse response, 
											HttpSession session) throws Exception {
		
		logger.info("+ Start  saveStuQna " );
		logger.info("   - paramMap : " + paramMap);
		
		String action =(String)paramMap.get("action");
		String resultMsg="";
		
		/*수정자*/		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		if("I".equals(action)) {
			stuQnaService.insertQna(paramMap);
			resultMsg = "SUCCESS";
			logger.info(resultMsg+"성공이요~");
		}else if("U".equals(action)) {
			stuQnaService.updateQna(paramMap);
			resultMsg = "UPDATE";
			logger.info(resultMsg+"성공이요~");
			
		}else if("D".equals(action)) {
			
			resultMsg = "DELETE";
			logger.info(resultMsg+"성공이요~");
		}else {
			resultMsg ="FALSE / 등록에 실패했습니다.";
		}
		
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultMsg",resultMsg);
		
		
		
		
		logger.info("+ end saveStuQna" + resultMap);
		
		return resultMap;
	}
	
	@RequestMapping("getListReply.do")
	@ResponseBody
	public Map<String,Object> getListReply(Model model,
											@RequestParam Map<String, Object> paramMap, 
											HttpServletRequest request,
											HttpServletResponse response, 
											HttpSession session) throws Exception {
		logger.info("+ Start  getListReply " );
		logger.info("   - paramMap : " + paramMap);
		
		
		
		 
		List<Map<String,Object>> list = stuQnaService.getListReply(paramMap); 
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("list", list);
		
		logger.info("+ end getListReply" + resultMap);
		
		return resultMap;
	}
	
	@RequestMapping("insertReply.do")
	@ResponseBody
	public Map<String,Object> insertReply(Model model,
											@RequestParam Map<String, Object> paramMap, 
											HttpServletRequest request,
											HttpServletResponse response, 
											HttpSession session) throws Exception {
		logger.info("+ Start  insertReply " );
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String msg="";
		if(action.equals("0") || action.equals("") ){
			logger.info("action : "+action);
			stuQnaService.insertReply(paramMap); 
		    msg="성공";
		}else{
			logger.info("action : "+action);
			stuQnaService.insertReply2(paramMap); 
			msg="성공";
		}
		 
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("msg", msg);
		logger.info("+ end insertReply" + resultMap);
		
		return resultMap;
	}
	
	@RequestMapping("saveFileTest.do")
	@ResponseBody
	public Map<String, Object> saveFileTest(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start saveFileTest");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		// 사용자 정보 설정
		//paramMap.put("ofc_id", session.getAttribute("ofcId"));
		//paramMap.put("usr_sst_id", session.getAttribute("usrSstId"));
		//paramMap.put("fst_rgst_sst_id", session.getAttribute("usrSstId"));
		//paramMap.put("fnl_mdfr_sst_id", session.getAttribute("usrSstId"));
		/*수정자*/
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		
		if ("I".equals(action)) {
			//CmntBbsService.insertCmntBbs(paramMap, request); // 게시글 신규 저장 
			logger.info("  action  :  " + action);
			stuQnaService.insertQnaFile(paramMap,request);
		} else if("U".equals(action)) {
			//CmntBbsService.updateCmntBbs(paramMap, request); // 게시글 수정 저장
			logger.info("  action  :  " + action);
			stuQnaService.updateQnaFile(paramMap,request);
			resultMsg = "수정 되었습니다.";
		} else {
			logger.info("  action  :  " + action);
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End saveFileTest");
		
		return resultMap;
	}
	
	@RequestMapping("downloadQnaFile.do")
	public void downloadQnaFile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		logger.info("+ Start downloadQnaFile");
		logger.info("   - paramMap : " + paramMap);
		
		// 첨부파일 조회
		
		
		Map<String,Object> list=stuQnaService.selectQna(paramMap);
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File((String)list.get("file_loc")));
		
		response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode((String)list.get("file_nm"),"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
	     
	    response.getOutputStream().flush();
	    response.getOutputStream().close();

		logger.info("+ End downloadQnaFile");
	}
	
	@RequestMapping("deleteQna.do")
	@ResponseBody
	public Map<String,Object> deleteQna(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		logger.info("+ Start deleteQna");
		logger.info("   - paramMap : " + paramMap);
		
		stuQnaService.deleteQna(paramMap);
		String msg="삭제 성공";
		Map<String,Object> resultMap = new HashMap<>();
		resultMap.put("msg", msg);
									
		logger.info("+ End deleteQna");
		
		return resultMap;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
