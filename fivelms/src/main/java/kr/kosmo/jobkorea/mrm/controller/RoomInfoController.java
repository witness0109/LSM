package kr.kosmo.jobkorea.mrm.controller;

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
import org.springframework.web.servlet.ModelAndView;

import kr.kosmo.jobkorea.mrm.model.RoomInfoModel;
import kr.kosmo.jobkorea.mrm.service.RoomInfoService;
import kr.kosmo.jobkorea.supportD.model.NoticeDModel;

@Controller
@RequestMapping("/mrm")
public class RoomInfoController {

	@Autowired
	RoomInfoService roomInfoService;

	// Root path for file upload
	@Value("${fileUpload.rootPath}")
	private String rootPath;

	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	// 강의실 리스트 화면 접속
	@RequestMapping("/roomInfoList.do")
	public String roomInfoList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ end " + className + ".roomInfoList");

		return "mrm/roomInfoList";
	}

	@RequestMapping("/roomListVue.do")
	@ResponseBody
	public Map<String, Object> roomListVue(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		
		logger.info("+ Start " + className + ".roomItemListVue");
		logger.info("   - paramMap : " + paramMap);
		
		// jsp페이지에서 넘어온 파람 값 정리 (페이징 처리를 위해 필요)
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;

		// 사이즈는 int형으로, index는 2개로 만들어서 -> 다시 파람으로 만들어서 보낸다.
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		// 서비스 호출
		List<RoomInfoModel> roomList = roomInfoService.roomList(paramMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("roomList", roomList);

		// 목록 숫자 추출하여 보내기
		int totalCnt = roomInfoService.RTotalCnt(paramMap);
		model.addAttribute("totalCnt", totalCnt);

		// System.out.println("자 컨트롤러에서 값을 가지고 jsp로 갑니다~ : " +
		// freeboardlist.size());type name = new type();
		
		logger.info("+ End " + className + ".roomItemListVue");

		return resultMap;
	}

	// 강의실 정보저장
	@RequestMapping("/roomInfoRegist.do")
	public String roomInfoRegist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".roomInfoRegist");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ End " + className + ".roomInfoRegist");

		return "mrm/roomInfoRegist";
	}

	@RequestMapping("/roomRegistAction.do")
	@ResponseBody
	public Map<String, Object> roomRegistAction(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		String enr_user = (String) session.getAttribute("loginId");
		paramMap.put("enr_user", enr_user);
		paramMap.put("upd_user", enr_user);
		logger.info("+ Start " + className + ".roomRegistAction");
		String rm_seq = (String) paramMap.get("rm_seq");
		String action = (String) paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";

	
			System.out.println("action : " + action);
			logger.info("   - paramMap : " + paramMap);
			
			
			roomInfoService.insertRoomInfo(paramMap, request); 

	
		
		System.out.println(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);


		logger.info("+ End " + className + ".roomRegistAction");

		return resultMap;
	}

	// 강의실 정보 삭제
	@RequestMapping("/roomListManageVue.do")
	@ResponseBody
	public Map<String, Object> deleteListVue(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		String upd_user = (String) session.getAttribute("loginId");
		logger.info("+ Start " + className + ".roomListManageVue");
		logger.info("   - paramMap : " + paramMap);

		String action = (String) paramMap.get("action");
		System.out.println("action : " + action);
		
		// 서비스 호출
		// 강의실 삭제
		
			paramMap.put("upd_user", upd_user);
			roomInfoService.roomDelete(paramMap);

	
//			// 수정하는 경우
//			paramMap.put("upd_user", upd_user);
//			roomInfoService.itemUpdate(paramMap);
//		

		Map<String, Object> resultMap = new HashMap<String, Object>();

		// System.out.println("자 컨트롤러에서 값을 가지고 jsp로 갑니다~ : " +
		// freeboardlist.size());
		logger.info("+ End " + className + ".roomListManageVue");

		return resultMap;
	}
	
	
	// 장비목록 조회
	@RequestMapping("/itemListVue.do")
	@ResponseBody
	public Map<String, Object> itemListVue(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".itemListVue");
		logger.info("   - paramMap : " + paramMap);

		// 서비스 호출
		List<RoomInfoModel> itemList = roomInfoService.itemListVue(paramMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("itemList", itemList);

		logger.info("+ End " + className + ".itemListVue");

		return resultMap;
	}

	// 장비 목록 저장 / 수정
	@RequestMapping("/itemManageVue.do")
	@ResponseBody
	public Map<String, Object> itemManageVue(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		String upd_user = (String) session.getAttribute("loginId");

		logger.info("+ Start " + className + ".itemManageVue");
		logger.info("   - paramMap : " + paramMap);

		// 서비스 호출
		// 신규로 넣는 경우
		String item_seq = (String) paramMap.get("item_seq");
		System.out.println("didi : " + item_seq);
		if (item_seq == null || " ".equals(item_seq) || item_seq.equals("undefined")) {
			paramMap.put("enr_user", upd_user);
			roomInfoService.itemInsert(paramMap);

		} else {
			// 수정하는 경우
			paramMap.put("upd_user", upd_user);
			roomInfoService.itemUpdate(paramMap);
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();

		// System.out.println("자 컨트롤러에서 값을 가지고 jsp로 갑니다~ : " +
		// freeboardlist.size());
		logger.info("+ End " + className + ".itemManageVue");

		return resultMap;
	}

	// 장비 목록 삭제
	@RequestMapping("/itemDeleteVue.do")
	@ResponseBody
	public Map<String, Object> itemDeleteVue(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		String upd_user = (String) session.getAttribute("loginId");
		paramMap.put("upd_user", upd_user);

		logger.info("+ Start " + className + ".itemDeleteVue");
		logger.info("   - paramMap : " + paramMap);

		// 서비스 호출
		roomInfoService.itemDeleteVue(paramMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		// System.out.println("자 컨트롤러에서 값을 가지고 jsp로 갑니다~ : " +
		// freeboardlist.size());
		logger.info("+ End " + className + ".itemDeleteVue");

		return resultMap;
	}

	@RequestMapping("/simpleInfo.do")
	@ResponseBody
	public Map<String, Object> simpleInfo(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		
		logger.info("+ Start " + className + ".simpleInfo");
		logger.info("   - paramMap : " + paramMap);
		
		String result="";
		
		// 서비스 호출
		RoomInfoModel simpleInfo = roomInfoService.simpleInfo(paramMap);
		
		if(simpleInfo != null) {
			
			result = "SUCCESS";  // 성공시 찍습니다. 
			
		}else {
			result = "FAIL / 불러오기에 실패했습니다.";  // null이면 실패입니다.
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", simpleInfo); // 리턴 값 해쉬에 담기 
		//resultMap.put("resultComments", comments);
		resultMap.put("resultMsg", result); // success 용어 담기 
		
		System.out.println("결과 글 찍어봅세 " + result);
		System.out.println("결과 글 찍어봅세 " + simpleInfo);
		
		logger.info("+ End " + className + ".simpleInfo");

		
		return resultMap;
	}
}
