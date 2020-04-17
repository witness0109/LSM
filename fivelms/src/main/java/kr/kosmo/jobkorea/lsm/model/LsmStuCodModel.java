package kr.kosmo.jobkorea.lsm.model;

import java.util.Date;

public class LsmStuCodModel {

	String task_seq;
	String lec_seq;
	Date task_tm;
	String enr_user;
	Date enr_date;
	String upd_user;
	Date upd_date;

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

	public Date getTask_tm() {
		return task_tm;
	}

	public void setTask_tm(Date task_tm) {
		this.task_tm = task_tm;
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

}
