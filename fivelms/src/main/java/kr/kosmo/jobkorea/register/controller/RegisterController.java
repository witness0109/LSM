package kr.kosmo.jobkorea.register.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import kr.kosmo.jobkorea.register.MailSend;
import kr.kosmo.jobkorea.register.model.RegisterModel;
import kr.kosmo.jobkorea.register.service.RegisterService;
import kr.kosmo.jobkorea.register.service.RegisterServiceImpl;

@Controller
public class RegisterController {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	RegisterService registerService;

	// 회원가입
	@RequestMapping("/register.do")
	@ResponseBody
	public Map<String, Object> insertRegister(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".insertRegister");
		logger.info("   - paramMap : " + paramMap);

		String action = (String) paramMap.get("action");
		session.setAttribute("loginId", action);
		System.out.println("action : " + action);
		
		String result;
		String resultMsg;
		if ("I".equals(action)) {
			registerService.insertRegister(paramMap);
			result = "SUCCESS";
			resultMsg = "회원가입이 완료되었습니다.";
		} else {
			result = "FALSE";
			resultMsg = "회원가입이 실패하였습니다.";
			System.out.println("result가 뜨나? : " + result);
			System.out.println("resultMsg가 뜨나? : " + resultMsg);
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		logger.info("+ End " + className + ".initComnCod");

		return resultMap;

	}

	/* 아이디 찾기 (메일 전송) */
	@RequestMapping("/registerFindId.do")
	@ResponseBody
	public int selectRegisterFind(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		System.out.println("registerFind 호출");
		int flag = 0;

		String user_email = (String) paramMap.get("email");
		String loginId = (String) paramMap.get("loginId");

		if (paramMap.get("data-code").equals("I")) {
			RegisterModel rgmId = registerService.selectFindIdRegister(user_email);

			if (StringUtils.isEmpty(rgmId)) {
				flag = 1;
			} else {
				MailSend ms = new MailSend();
				String authNum = ms.RegisterFindIdEmailSend(user_email);
				flag = Integer.parseInt(authNum);
			}

		} else {
			flag = 1; // 가입한 아이디가 없음
		}
		return flag;
	}

	// 아이디 찾기 (아이디 뜨게)
	@RequestMapping("/findRegisterId.do")
	@ResponseBody
	public String selectFindIdRegister(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		String user_email = (String) paramMap.get("email");

		RegisterModel rgmId = registerService.selectFindIdRegister(user_email);

		String findId = rgmId.getLoginId();

		return findId;
	}

	// 비밀번호 찾기 (메일전송)
	@RequestMapping("/registerFindPwd.do")
	@ResponseBody
	public int selectRegisterFindPwd(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		int flag = 0;

		String user_email = (String) paramMap.get("email");
		String loginId = (String) paramMap.get("loginId");

		if (paramMap.get("data-code").equals("P")) {
			RegisterModel rgmParam = new RegisterModel();
			rgmParam.setUser_email(user_email);
			rgmParam.setLoginId(loginId);
			RegisterModel rgmPwd = registerService.selectFindPwdRegister(rgmParam);

			if (rgmPwd == null) {
				flag = 1;
			} else {
				MailSend ms = new MailSend();
				String authNum = ms.RegisterFindPwdEmailSend(user_email);
				flag = Integer.parseInt(authNum);
			}

		} else {
			flag = 1; // 가입한 아이디가 없음
		}
		return flag;

	}

	// 비밀번호 찾기 (비번 뜨게)
	@RequestMapping("/findRegisterPwd.do")
	@ResponseBody
	public String selectFindPwdRegister(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		String user_email = (String) paramMap.get("email");
		String loginId = (String) paramMap.get("loginId");

		RegisterModel rgmParam = new RegisterModel();
		rgmParam.setLoginId(loginId);
		rgmParam.setUser_email(user_email);
		System.out.println("비밀번호 찾기 loginId : " + loginId);
		System.out.println("비밀번호 찾기 email : " + user_email);

		RegisterModel rgmPwd = registerService.selectFindPwdRegister(rgmParam);

		String findPwd = rgmPwd.getPassword();

		return findPwd;
	}

	// 아이디 체크
	@RequestMapping("/registerIdCheck.do")
	@ResponseBody
	public Map<String, Object> selectIdCheck(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		String loginId = (String) paramMap.get("loginId");
		
		int count = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		
		count = registerService.selectIdCheck(loginId);
		map.put("cnt", count);
		
		return map;
		
		/*RegisterModel idParam = new RegisterModel();
		idParam.setLoginId(loginId);
		System.out.println("loginId가 찍힙니까? : " + loginId);

		RegisterModel rgmIdCheck = registerService.selectIdCheck(idParam);
		if(rgmIdCheck.equals(idParam)){
			
		}else{
			
		}
		System.out.println("idparam이 찍히니? : " + idParam);
		
		String checkId = rgmIdCheck.getLoginId();
		System.out.println("뜨나 ? : " + checkId);

		return idParam;
	}*/
	}
}
