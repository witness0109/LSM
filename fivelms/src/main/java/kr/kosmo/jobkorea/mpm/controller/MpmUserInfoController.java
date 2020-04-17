package kr.kosmo.jobkorea.mpm.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.ResultMap;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;



import kr.kosmo.jobkorea.common.comnUtils.ComnCodUtil;
import kr.kosmo.jobkorea.common.comnUtils.FileUtil;
import kr.kosmo.jobkorea.common.comnUtils.FileUtilModel;
import kr.kosmo.jobkorea.login.model.LgnInfoModel;
import kr.kosmo.jobkorea.login.model.UsrMnuAtrtModel;
import kr.kosmo.jobkorea.login.service.LoginService;
import kr.kosmo.jobkorea.mpm.model.MpmUserInfoModel;
import kr.kosmo.jobkorea.mpm.model.MpmMainUserInfoModel;
import kr.kosmo.jobkorea.mpm.service.MpmUserInfoService;
import kr.kosmo.jobkorea.system.model.ComnCodUtilModel;
/**
* writer: 이승현
* 인원관리 프로세스
* 학생,강사 인원 관리 할수 있다 (등록,수정,삭제,조회)
**/
@Controller
@RequestMapping("/mpm")
public class MpmUserInfoController {

   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   @Autowired
   MpmUserInfoService mpmService;
   

   @RequestMapping("/studentInfoView.do")
   public String studentInfoView(Model model, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
	   
	   logger.info("+ Start studentInfoView.do");
	  Map<String, Object> resutlMap = new HashMap<String, Object>();
	// 학생 이므로 S로 셋
	  model.addAttribute("user_type", "S");
      
      return "/mpm/userInfoManage";// vue.js 방식은 /mpm/userInfoManageVue 로 수정
   }
   
   @RequestMapping("/teacherInfoView.do")
   public String teacherInfoView(Model model, HttpServletRequest request,
		   HttpServletResponse response, HttpSession session) throws Exception {
	   logger.info("+ Start teacherInfoView.do");
	   Map<String, Object> resutlMap = new HashMap<String, Object>();
	   
	   model.addAttribute("user_type", "T");
	   
	   return "/mpm/userInfoManage";
   }
   
   @RequestMapping("/openTchFace.do")
   public String teacherFaceView(Model model, HttpServletRequest request,
		   HttpServletResponse response, HttpSession session) throws Exception {
	   logger.info("+ Start teacherFaceView.do");
	   
	   
	   return "/mpm/myPictrView";
   }   
   
   
   
   
   @RequestMapping("/openUserInfoList.do") 
   @ResponseBody
   public Map<String, Object> openUserInfoList(Model result, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

	  
	   Map<String, Object> resutlMap = new HashMap<String, Object>();
	   
	   List<MpmUserInfoModel> userInfoList = selectUserInfoList(paramMap);
	   
	   
	      logger.info("+ Start openUserInfoList.do");
	      
	      resutlMap.put("userInfoList", userInfoList);
      return resutlMap;
   }
   
   //유저 리스트 조회
   // 학생 타입 : S
   // 강사 타입 : T
   public List<MpmUserInfoModel> selectUserInfoList(Map<String, Object> paramMap)throws Exception {

	   logger.info("selectUserInfoList paramMap:"+paramMap);
	   
	   List<MpmUserInfoModel> list = mpmService.selectUserInfoList(paramMap);   // 오피스 구분 코드 (M제외)
	      List<MpmUserInfoModel> studentList = new ArrayList<>();
	      
	      
	      for (int i = 0; i < list.size(); i++) {
			MpmUserInfoModel infoModel = list.get(i);
			//password 마스킹 처리
			if(infoModel.getPassword() != null && !"".equals(infoModel.getPassword())){
				infoModel.setPassword(toMasking(infoModel.getPassword()));
			}
			//상태코드 한글처리
			//infoModel.setStatus_yn(codeToGangle(infoModel.getStatus_yn()));
			
			studentList.add(infoModel);
	      }
	      logger.info("studentList :"+studentList);
	   
	   
	   return list;
   }
   
   @RequestMapping("/fileProcess.do")
   @ResponseBody
   public Map<String, Object> fileProcess(MultipartHttpServletRequest multi){
	   
	   logger.info("+ Start fileProcess.do");
	   Map<String, Object> resutlMap = new HashMap<String, Object>();
	   
	   
	   //String rootPath = System.getProperty("user.dir");
	   String savaDir = "D:/egov/workspace/fivelms/src/main/webapp/WEB-INF/resource/images/mpm";
	   logger.info("+ Start savaDir : "+ savaDir);
	   
	  FileUtil fileUtil = new FileUtil(multi,savaDir,"");
	  List<FileUtilModel> models = null;
	   
	   try {
		   models = fileUtil.uploadFiles();
	} catch (Exception e) {
		// TODO: handle exception
	}
	   if(models != null && models.size()>0){
		   FileUtilModel model = models.get(0);
		   resutlMap.put("fileNm", model.getLgc_fil_nm()) ;
		   resutlMap.put("filePath", savaDir) ;
	   }
	   
	   
	   return resutlMap;
   }
   
   
   @RequestMapping("/userInfoProcess.do")
   @ResponseBody
   public Map<String, Object> userInfoProcess(Model model,MpmMainUserInfoModel vo,HttpServletRequest request,
		   HttpServletResponse response, HttpSession session) throws Exception {
	   
	   logger.info("+ Start userInfoProcess.do");
	   logger.info(" vo "+vo);
	   String resultMsg = "";
	   String result = "";
	   Map<String, Object> resutlMap = new HashMap<String, Object>();
	   String loginId = (String) session.getAttribute("loginId");
	   logger.info(" session.getAttribute(loginID); "+session.getAttribute("loginId"));
	   int resultValue = 0;
	   List<MpmUserInfoModel> list = vo.getUserInfoList();
	   MpmUserInfoModel infoVo = vo.getUserInfo();
	   logger.info(" infoVo : "+infoVo);
	   
		if (list != null && list.size() > 0) {
			resutlMap = userInfoListProcess(list,session);
		} else if(infoVo != null && !"".equals(infoVo)){
			if (loginId != null && !"".equals(loginId)) {
				infoVo.setRegUserId(loginId);
			}
			String actMode = infoVo.getAct_mode();
			if (actMode != null && !"".equals(actMode)) {

				try {

					switch (actMode) {
					case "I":
						resultValue = insertUserInfo(infoVo);
						break;
					case "U":
						resultValue = updateUserInfo(infoVo);
						break;
					case "D":
						resultValue = deleteUserInfo(infoVo);
						break;
					default:
						break;
					}

					if (resultValue > 0) {
						resultMsg = "저장 되었습니다.";
						result = "SUCCESS";
					} else {
						resultMsg = "오류 발생 다시 시도해 주시기 바랍니다.";
					}

				} catch (Exception e) {
					resultMsg = e.getMessage();
				}

			}
			resutlMap.put("result", result);
			resutlMap.put("resultMsg", resultMsg);

		}
	   
	   
	   
	   return resutlMap;
   }
   
   public Map<String, Object> userInfoListProcess(List<MpmUserInfoModel> list,HttpSession session) throws Exception {
	   
	   logger.info("+ Start userInfoListProcess.do");
	   logger.info(" list "+list);
	   String loginId = (String) session.getAttribute("loginId");
	   Map<String, Object> resutlMap = new HashMap<String, Object>();
	   String resultMsg = "";
	   String result = "";
	   
	   int resultValue = 0;
	   int totCnt = 0;
	   
	   
	   for (int i = 0; i < list.size(); i++) {
		MpmUserInfoModel userInfo = list.get(i);
		String actMode = userInfo.getAct_mode();
		
		if(loginId != null && !"".equals(loginId)){
			userInfo.setRegUserId(loginId);
		 }
		
		
		 if (actMode != null && !"".equals(actMode)) {
			   
			   try {
				   
				   switch (actMode) {
				   case "I": resultValue = insertUserInfo(userInfo);
				   break;
				   case "U": resultValue = updateUserInfo(userInfo);
				   break;
				   case "D": resultValue = deleteUserInfo(userInfo);
				   break;
				   default:
					   break;
				   }
				   
				   if(resultValue > 0){
					   resultMsg = "저장 되었습니다.";
					   result = "SUCCESS";
					   totCnt++;
				   }else{
					   resultMsg = actMode+"모드 작업 도중 오류 발생 다시 시도해 주시기 바랍니다.";	
				   }
				   
			   } catch (Exception e) {
				   resultMsg = e.getMessage();
			   }
			   
		   }
		
		   
	}
	   resutlMap.put("totCnt", totCnt);
	   resutlMap.put("result", result);
	   resutlMap.put("resultMsg", resultMsg);
	   
	   return resutlMap;
   }
   
   //@RequestBody 해결 안됨 
   //@RequestParam 해결 안됨 
   @RequestMapping("/selectUserInfo.do")
   @ResponseBody
   public Map<String, Object> selectUserInfo(Model model,@RequestParam Map<String, Object> paramMap,HttpServletRequest request,
		   HttpServletResponse response, HttpSession session) throws Exception {
	   
	   logger.info("+ Start selectUserInfo.do");
	   
	   logger.info(" paramMap "+paramMap);
	   String resultMsg = "";
	   String result = "";
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   
	   List<MpmUserInfoModel> list = mpmService.selectUserInfo(paramMap);
	   
	   logger.info("+ end list :"+list);
	   if(list.size()>0){
		   result = "SUCCESS";
	   }
	   
	   resultMap.put("result", result);
	   resultMap.put("list",list);
	   //resutlMap.put("resultMsg", resultMsg);
	   return resultMap;
   }
   
   public int updateUserInfo(MpmUserInfoModel vo) throws Exception {
	   int i = 0;
	   i = mpmService.updateUserInfo(vo);
	   return i;
   }
   public int deleteUserInfo(MpmUserInfoModel vo) throws Exception {
	   int i = 0;
	   i = mpmService.deleteUserInfo(vo);
	   return i;
   }
   public int insertUserInfo(MpmUserInfoModel vo) throws Exception {
	   int resultVal = 0;
		   resultVal = mpmService.insertUserInfo(vo);   
	   return resultVal;
   }
   
   
   
   
   
   
   /*
    * 마스킹 처리 
   */
   public String toMasking(String password){
	   
	   logger.info("toMasking	starat	:"+password);
	   
	   StringBuilder sb = new StringBuilder(password);
	   
	   String resultStr =  "";
	   if(sb != null && !"".equals(sb)){
		   int strLenth = sb.length();
		   
		   for (int i = 0; i < strLenth; i++) {
			   
			   if(i>=3){
				   sb.setCharAt(i, '*');
			   }
		}
	   }
	   resultStr = sb.toString();
	   logger.info("toMasking	end	:"+resultStr);
	   return resultStr;
   }
   
   
public String codeToGangle(String statusYn){
	   
	   logger.info("codeToGangle	starat	:"+statusYn);
	   
	   String resultStr =  "";
	   
	   if(statusYn != null && !"".equals(statusYn)){
		   if("Y".equals(statusYn)){
			   resultStr = "가입상태";
		   }else if("N".equals(statusYn)){
			   resultStr = "탈퇴상태";
		   }
	   }
	   logger.info("toUserTypeReplace	end	:"+resultStr);
	   return resultStr;
   }
   
}
