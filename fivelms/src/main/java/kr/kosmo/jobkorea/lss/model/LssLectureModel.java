package kr.kosmo.jobkorea.lss.model;

import java.sql.Date;

public class LssLectureModel {
		//강의번호
		private String lec_seq;
		//강의명
		private String lec_nm;
		//강의등록일
		private Date lec_enr;
		//강의내용
		private String lec_contents;
		//강의목표
		private String lec_gl;
		//강의계획
		private String lec_pl;
		//강의시간
		private Date lec_tm;
		//강의시작일
		private Date lec_st;
		//강의종료일
		private Date lec_ed;
		//파일이름
		private String file_nm;
		//파일경로
		private String file_loc;
		//파일사이즈
		private String file_size;
		//등록자
		private String enr_user;
		//등록일자
		private Date enr_date;
		//수정자
		private String upd_user;
		//수정일자
		private Date upd_date;
		//강의실번호
		private String rm_seq;
		//강사명
		private String user_id;
		
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
		public Date getLec_enr() {
			return lec_enr;
		}
		public void setLec_enr(Date lec_enr) {
			this.lec_enr = lec_enr;
		}
		public String getLec_contents() {
			return lec_contents;
		}
		public void setLec_contents(String lec_contents) {
			this.lec_contents = lec_contents;
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
		public Date getLec_tm() {
			return lec_tm;
		}
		public void setLec_tm(Date lec_tm) {
			this.lec_tm = lec_tm;
		}
		public Date getLec_st() {
			return lec_st;
		}
		public void setLec_st(Date lec_st) {
			this.lec_st = lec_st;
		}
		public Date getLec_ed() {
			return lec_ed;
		}
		public void setLec_ed(Date lec_ed) {
			this.lec_ed = lec_ed;
		}
		public String getFile_nm() {
			return file_nm;
		}
		public void setFile_nm(String file_nm) {
			this.file_nm = file_nm;
		}
		public String getFile_loc() {
			return file_loc;
		}
		public void setFile_loc(String file_loc) {
			this.file_loc = file_loc;
		}
		public String getFile_size() {
			return file_size;
		}
		public void setFile_size(String file_size) {
			this.file_size = file_size;
		}
		public String getEnr_user() {
			return enr_user;
		}
		public void setEnr_user(String enr_user) {
			this.enr_user = enr_user;
		}
		public Date getEnr_date() {
			return enr_date;
		}
		public void setEnr_date(Date enr_date) {
			this.enr_date = enr_date;
		}
		public String getUpd_user() {
			return upd_user;
		}
		public void setUpd_user(String upd_user) {
			this.upd_user = upd_user;
		}
		public Date getUpd_date() {
			return upd_date;
		}
		public void setUpd_date(Date upd_date) {
			this.upd_date = upd_date;
		}
		public String getRm_seq() {
			return rm_seq;
		}
		public void setRm_seq(String rm_seq) {
			this.rm_seq = rm_seq;
		}
		public String getUser_id() {
			return user_id;
		}
		public void setUser_id(String user_id) {
			this.user_id = user_id;
		}
		
		
}
