package kr.kosmo.jobkorea.sss.controller;

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

import kr.kosmo.jobkorea.sss.service.SSSLecService;

@Controller
@RequestMapping("/ldd/")
public class LectureDocController {

	
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	// Root path for file upload 
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Autowired
	SSSLecService SssLecService;
	
	
//	 리스트 뿌려
	@RequestMapping("SssList.do")
	@ResponseBody
	public Map<String, Object> selectSSSList(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
			logger.info("+ Start " + className + ".SssList");
		    logger.info("   - paramMap : " + paramMap);
			
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage")); // 현재페이지 
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
			int pageIndex = (currentPage -1)*pageSize;
			
			// 사이즈는 int형으로, index는 2개로 만들어서 -> 다시 파람으로 만들어서 보낸다.
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			List<Map<String,Object>> SssList = SssLecService.selectStuList(paramMap);
			
			int totalCnt = SssLecService.LecDocTotalCnt(paramMap);
		
			Map<String,Object> resultMap = new HashMap<String, Object>();
			resultMap.put("SssList", SssList);
			resultMap.put("totalCnt", totalCnt);
	
			
			logger.info("+ End " + className + ".SssList");
			
		return resultMap;
	}
	
	//단건 조회
	@RequestMapping("SssDetail.do")
	@ResponseBody
	public Map<String,Object> selectSSSDetail(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".SssDetail");
	    logger.info("   - paramMap : " + paramMap);
		
		Map<String,Object> detail = SssLecService.selectStuDetail(paramMap);
		logger.info("------------->" + detail);
		
		logger.info("+ End " + className + ".SssDetail");
		return detail;
	}
	
	//다운로드
	@RequestMapping("downloadFile.do")
	public void downloadFile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start Sss downloadaFile");
		logger.info("   - paramMap : " + paramMap);
		
		//첨부파일
		Map<String,Object> list = SssLecService.selectSssFile(paramMap);
		logger.info("------------------->"+list);
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(rootPath+(String)list.get("psc_fil_nm")));
		
		response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode((String)list.get("lgc_fil_nm"),"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
	     
	    response.getOutputStream().flush();
	    response.getOutputStream().close();
		
		
		logger.info("+ End " + className + ".SssFile");
		
		
	}
}
