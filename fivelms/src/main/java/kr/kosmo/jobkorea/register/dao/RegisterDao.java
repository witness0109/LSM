package kr.kosmo.jobkorea.register.dao;


import java.util.Map;

import kr.kosmo.jobkorea.register.model.RegisterModel;

public interface RegisterDao {
	
	// 회원 가입 유저
	public int insertRegister(Map<String, Object> paramMap);
	
	// 아이디 찾기
	public RegisterModel selectFindIdRegister(String user_email);
	
	// 비밀번호 찾기

	public RegisterModel selectFindPwdRegister(RegisterModel rgmParam);

	// 아이디 체크
	
	public int selectIdCheck(String loginId);
}