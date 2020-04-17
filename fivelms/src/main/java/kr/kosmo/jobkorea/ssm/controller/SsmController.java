package kr.kosmo.jobkorea.ssm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kosmo.jobkorea.ssm.model.SsmInfoModel;
import kr.kosmo.jobkorea.ssm.model.SsmLectureModel;
import kr.kosmo.jobkorea.ssm.service.SsmService;

@Controller
@RequestMapping("/ssm/")
public class SsmController {
 
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	SsmService ssmService;

	@Value("${fileUpload.rootPath}")
	private String rootPath;

	@RequestMapping("lectureList.do")
	public String lectureList2(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		return "/ssm/lecture";
	}

	/** 과제 제출 초기 화면 */
	@RequestMapping("taskSend.do")
	public String taskSend(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		return "ssm/taskSend";
	}

	/** 과제 제출 리스트 */
	@RequestMapping("listTaskSend.do")
	public String listTaskSend(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재
																					// 페이지
																					// 번호
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); // 페이지
																			// 사이즈
		int pageIndex = (currentPage - 1) * pageSize; // 페이지 시작 row 번호

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		List<SsmInfoModel> listSsmInfoModel = ssmService.listTaskSend(paramMap);
		model.addAttribute("ssmInfoModel", listSsmInfoModel);

		// 과제 제출 전체 총 건수
		int totcnt = ssmService.countListSsm(paramMap);
		model.addAttribute("totcnt", totcnt);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageTaskSendList", currentPage);

		return "ssm/taskSend";
	}

	/** 과제 제출 단건 조회 */
	@RequestMapping("selectTaskSend.do")
	@ResponseBody
	public Map<String, Object> selectTaskSend(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";

		SsmInfoModel ssmInfomodel = ssmService.selectTaskSend(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("ssmInfoModel", ssmInfomodel);

		return resultMap;
	}

	/** 저장 */
	@RequestMapping("saveTaskSend.do")
	@ResponseBody
	public Map<String, Object> saveTaskSend(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		String action = (String) paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";

		// 사용자 정보 설정
		paramMap.put("fst_rgst_sst_id", session.getAttribute("usrSstId"));
		paramMap.put("fnl_mdfr_sst_id", session.getAttribute("usrSstId"));

		if ("I".equals(action)) {
			// 과제제출 저장
			ssmService.insertTaskSend(paramMap);
		} else if ("U".equals(action)) {
			// 과제제출 수정
			ssmService.updateTaskSend(paramMap);
		} else {
			result = "FALSE";
			resultMsg = "ERROR";
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		return resultMap;
	}

	/** 삭제 */
	@RequestMapping("deleteTaskSend.do")
	@ResponseBody
	public Map<String, Object> deleteTaskSend(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";

		// 삭제
		ssmService.deleteTaskSend(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		return resultMap;
	}

	/** 첨부파일 다운로드 */
	@RequestMapping("downloadSsmFil.do")
	public void downloadBbsAtmtFil(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

	}

	/** 과제 상세 목록 조회 */
	@RequestMapping("/taskSendDtl.do")
	public String taskSendDtl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		System.out.println("===================================> " + paramMap.toString());
		String result = "SUCCESS";
		String resultMsg = "조회 완료";

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		// 과제 상세 목록 조회 */
		List<SsmInfoModel> listSsmInfoModel = ssmService.taskSendDtl(paramMap);
		model.addAttribute("ssmInfoModel", listSsmInfoModel);
		model.addAttribute("result", result);
		model.addAttribute("resultMsg", resultMsg);

		// 과제 상세 총 건수 */
		int totcnt = ssmService.countListSsm(paramMap);
		model.addAttribute("totcnt", totcnt);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageTaskSendList", currentPage);

		// System.out.println("sdsadasdas이거는 모델"+listSsmInfoModel);

		return "/ssm/taskSendDtl";
	}

	/* 수강목록조회 */
	@RequestMapping("lectureListgo.do")
	public String lectureList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		/* 페이징 */
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재
																					// 페이지
																					// 번호

		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));// 페이지
																			// 사이즈
		int pageIndex = (currentPage - 1) * pageSize;// 페이지시작 row번호
		// 시작번호,페이지사이즈 가져옴
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		// 새션아이디
		String loginId = (String) session.getAttribute("loginId");
		System.out.println("여기는 새션아이디입니다.----------" + loginId);
		paramMap.put("loginId", loginId);

		// 강의목록조회
		List<SsmLectureModel> listSsmLecModel = ssmService.lectureList(paramMap);

		// 강의목록 카운트 조회
		int totalCount = ssmService.countLecList(paramMap);

		// 모달 통해서 가져오기
		model.addAttribute("lectureList", listSsmLecModel);
		model.addAttribute("totalCntlecList", totalCount);
		model.addAttribute("currentPagelectureList", currentPage);
		model.addAttribute("pageSize", pageSize);

		return "/ssm/lectureList";

	}

	/* 디테일 조회 */
	@RequestMapping("selectLecDet.do")
	@ResponseBody
	public Map<String, Object> selectLecDet(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@start selectLecDet");
		// 이녀석들은 결과 콜백 값에서 쓰이는 거다.
		logger.info(paramMap);
		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";

		Map<String, Object> map = ssmService.selectLecDet(paramMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("map", map);
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@END selectLecDet");
		return resultMap;
	}

	@RequestMapping("survey.do")
	public String survey(Model result, @RequestParam Map<String, String> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		/* Map<String, Object> resultMap = new HashMap<String, Object>(); */

		logger.info("=======================================Start survey.do");
		
		
		logger.info("=======================================END survey.do");

		return "/ssm/survey/surveyhome";
	}
	
	@RequestMapping("studentQna.do")
	public String studentQna(Model result, @RequestParam Map<String, String> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		/* Map<String, Object> resultMap = new HashMap<String, Object>(); */

		logger.info("=======================================Start studentQna.do");

		return "/ssm/qna/studentQnahome";
	}
}