package kr.kosmo.jobkorea.register.service;

import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.common.comnUtils.AESCryptoHelper;
import kr.kosmo.jobkorea.common.comnUtils.ComnUtil;
import kr.kosmo.jobkorea.register.dao.RegisterDao;
import kr.kosmo.jobkorea.register.model.RegisterModel;

@Service
public class RegisterServiceImpl implements RegisterService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	@Autowired
	private RegisterDao registerDao;

	// 회원가입 유저
	public int insertRegister(Map<String, Object> paramMap) throws Exception {
		return registerDao.insertRegister(paramMap);
	}

	// 아이디 찾기
	public RegisterModel selectFindIdRegister(String user_email) throws Exception {

		return registerDao.selectFindIdRegister(user_email);
	}

	// 비밀번호 찾기

	public RegisterModel selectFindPwdRegister(RegisterModel rgmParam) throws Exception {
		return registerDao.selectFindPwdRegister(rgmParam);

	}
	
	// 아이디 체크
	public int selectIdCheck(String loginId) throws Exception{
		return registerDao.selectIdCheck(loginId);
	}

}
