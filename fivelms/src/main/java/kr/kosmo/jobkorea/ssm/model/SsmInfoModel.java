package kr.kosmo.jobkorea.ssm.model;

import java.sql.Date;

public class SsmInfoModel {
	   //과제번호
	   private String task_seq;
	   //강의번호
	   private String lec_seq;
	   //일련번호
	   private int task_no;
	   //제출시간
	   private Date task_tm;
	   //파일이름
	   private String task_file;
	   //등록자
	   private String enr_user;
	   //등록일자
	   private Date enr_date;
	   //수정자
	   private String upd_user;
	   //수정일자
	   private Date upd_date;
	   // 강의명
	   private String lec_nm;
	   // 과제명
	   private String task_nm;
	   


	   public String getTask_nm() {
	      return task_nm;
	   }

	   public void setTask_nm(String task_nm) {
	      this.task_nm = task_nm;
	   }

	   public String getTask_seq() {
	      return task_seq;
	   }

	   public void setTask_seq(String task_seq) {
	      this.task_seq = task_seq;
	   }

	   public String getLec_seq() {
	      return lec_seq;
	   }

	   public void setLec_seq(String lec_seq) {
	      this.lec_seq = lec_seq;
	   }

	   public int getTask_no() {
	      return task_no;
	   }

	   public void setTask_no(int task_no) {
	      this.task_no = task_no;
	   }

	   public Date getTask_tm() {
	      return task_tm;
	   }

	   public void setTask_tm(Date task_tm) {
	      this.task_tm = task_tm;
	   }

	   public String getTask_file() {
	      return task_file;
	   }

	   public void setTask_file(String task_file) {
	      this.task_file = task_file;
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

	   public String getLec_nm() {
	      return lec_nm;
	   }

	   public void setLec_nm(String lec_nm) {
	      this.lec_nm = lec_nm;
	   }
	   
	}