package kr.kosmo.jobkorea.register.service;

import java.util.Map;

import kr.kosmo.jobkorea.register.model.RegisterModel;

public interface RegisterService {
	
	/* 회원가입 */

	public int insertRegister(Map<String, Object> paramMap) throws Exception;
	
	/* 아이디 찾기 */
	
	public RegisterModel selectFindIdRegister(String user_email) throws Exception;
	
	/* 비밀번호 찾기 */
	
	public RegisterModel selectFindPwdRegister(RegisterModel rgmParam) throws Exception;
	
	/* 아이디 체크 */
	public int selectIdCheck(String loginId) throws Exception;

		
	
}
