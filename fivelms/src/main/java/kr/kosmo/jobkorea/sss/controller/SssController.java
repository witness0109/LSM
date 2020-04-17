package kr.kosmo.jobkorea.sss.controller;


import java.io.File;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kosmo.jobkorea.sss.model.NoticeKModel;
import kr.kosmo.jobkorea.sss.service.NoticeServiceK;



@Controller
@RequestMapping("/sss/")
public class SssController {

	// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());

		// Get class name for logger
		private final String className = this.getClass().toString();
		
		
		@Autowired
		NoticeServiceK noticeService;
		
		//학습자료 Home
		@RequestMapping("lectureDoc.do")
		public String lectureDoc(Model result, 
				@RequestParam Map<String, String> paramMap,
				 HttpServletRequest request,
				 HttpServletResponse response, 
				 HttpSession session) throws Exception{
			
			
			logger.info("=======================================Start lectureDataList.do");
			
			return "sss/ldd/lectureDataList";
		}
		
		
		
		@RequestMapping("/TestVueSearch.do")
		public String sssTest(){
			logger.info("=======================================Start TestVueSearch.do");
			
			logger.info("=======================================End TestVueSearch.do");
			return "/sss/vueTest";
		}
		
		@RequestMapping("/TestVueSearch2.do")
		@ResponseBody
		public Map<String,Object> sssTest( Model model ,
											@RequestParam Map<String,Object> paramMap,
											HttpServletRequest request,
											HttpServletResponse response, 
											HttpSession session) throws Exception{
			
			logger.info("=======================================Start TestVueSearch.do");

			logger.info("model : "+model.toString());
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
			int pageIndex = Integer.parseInt((String)paramMap.get("pageIndex"));	
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			logger.info("paramMap : "+paramMap);
			
			
			Map<String,Object> resultMap = new HashMap<String, Object>();
			List<NoticeKModel> list = noticeService.noticeList(paramMap);
			resultMap.put("list", list);
			
			//String list = "{ }";
			
			
			
			
			logger.info("++ resultMap :"+resultMap);
			logger.info("=======================================End TestVueSearch.do");
			return resultMap;
		}
		
		
		@RequestMapping("/studentNotice.do")
		public String document(){
			
			System.out.println("Vue Noticce.controller  in . .. .. . .. .. ");
			
			return "/sss/noticeListHome";
		}
		
	
		@RequestMapping("noticeList.do")
		@ResponseBody
		public Map<String,Object> noticeList(Model model, @RequestParam Map<String, Object> paramMap, 
								HttpServletRequest request,
								HttpServletResponse response, 
								HttpSession session) throws Exception {
			
			System.out.println("noticeList.do in ... ");

			logger.info("+ Start " + className + ".listComnGrpCod");
			logger.info("   - paramMap : " + paramMap);
			
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
			
			
			
			int pageIndex = (currentPage-1)*pageSize;		
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			// 공지사항 조회
			List<NoticeKModel> listNoticeModel = noticeService.noticeList(paramMap);
			
			
			Map<String,Object> resultMap = new HashMap<>();
			
			//공지사항 총수.
			int totalCount = noticeService.countListNotice(paramMap);
			
			resultMap.put("list", listNoticeModel);
			resultMap.put("totalCountList", totalCount);
			resultMap.put("pageSize", pageSize);
			resultMap.put("currentPageNoticeList",currentPage);
			
			logger.info(" \\\\\\\\\\\\\\\\"+ listNoticeModel.toString()); 
			
			return resultMap;
		}	
		
		
		@RequestMapping("downloadFile.do")
		public void downloadFile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
		
			logger.info("+ Start downloadQnaFile");
			logger.info("   - paramMap : " + paramMap);
			
			// 첨부파일 조회
			NoticeKModel selectOne = noticeService.selectNotice(paramMap);
			
		
			
			byte fileByte[] = FileUtils.readFileToByteArray(new File((String)selectOne.getFile_loc()));
			
			response.setContentType("application/octet-stream");
		    response.setContentLength(fileByte.length);
		    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode((String)selectOne.getFile_nm(),"UTF-8")+"\";");
		    response.setHeader("Content-Transfer-Encoding", "binary");
		    response.getOutputStream().write(fileByte);
		     
		    response.getOutputStream().flush();
		    response.getOutputStream().close();

			logger.info("+ End downloadQnaFile");
		}

		
		
}
