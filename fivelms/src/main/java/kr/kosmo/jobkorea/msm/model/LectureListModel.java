package kr.kosmo.jobkorea.msm.model;

import java.util.Date;

public class LectureListModel {

	private String lec_seq; // 강의 번호
	private String lec_nm; // 강의명
	private String file_nm;// 회원 사진
	private String loginID; // 회원아이디
	private String name; // 회원이름
	private String user_email; //이메일
	private String rm_seq; // 강의실 번호 -> 강의실 이름으로 변경해봐야할듯
	private String rm_name; //강의실 이름
	private String lec_st; //강의시작일
	private String cnt; //수강인원 조회
	private String lec_gl; //강의 목표
	private String lec_pl; //강의 계획
	private String lec_contents; //강의 내용
	private String lec_enr; // 강의 등록일
	private String lec_ed; //강의 종료일	
	private String lec_yon; // 강의 수강여부
	public String getLec_seq() {
		return lec_seq;
	}
	public void setLec_seq(String lec_seq) {
		this.lec_seq = lec_seq;
	}
	public String getLec_nm() {
		return lec_nm;
	}
	public void setLec_nm(String lec_nm) {
		this.lec_nm = lec_nm;
	}
	public String getFile_nm() {
		return file_nm;
	}
	public void setFile_nm(String file_nm) {
		this.file_nm = file_nm;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getRm_seq() {
		return rm_seq;
	}
	public void setRm_seq(String rm_seq) {
		this.rm_seq = rm_seq;
	}
	public String getRm_name() {
		return rm_name;
	}
	public void setRm_name(String rm_name) {
		this.rm_name = rm_name;
	}
	public String getLec_st() {
		return lec_st;
	}
	public void setLec_st(String lec_st) {
		this.lec_st = lec_st;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getLec_gl() {
		return lec_gl;
	}
	public void setLec_gl(String lec_gl) {
		this.lec_gl = lec_gl;
	}
	public String getLec_pl() {
		return lec_pl;
	}
	public void setLec_pl(String lec_pl) {
		this.lec_pl = lec_pl;
	}
	public String getLec_contents() {
		return lec_contents;
	}
	public void setLec_contents(String lec_contents) {
		this.lec_contents = lec_contents;
	}
	public String getLec_enr() {
		return lec_enr;
	}
	public void setLec_enr(String lec_enr) {
		this.lec_enr = lec_enr;
	}
	public String getLec_ed() {
		return lec_ed;
	}
	public void setLec_ed(String lec_ed) {
		this.lec_ed = lec_ed;
	}
	public String getLec_yon() {
		return lec_yon;
	}
	public void setLec_yon(String lec_yon) {
		this.lec_yon = lec_yon;
	}
	
	
	
	
}
