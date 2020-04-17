package kr.kosmo.jobkorea.lsm.model;

import java.util.Date;
import java.util.List;

import kr.kosmo.jobkorea.lsm.model.taskFileModel;

public class taskInfoModel {

	String task_seq;
	String lec_seq;
	String task_nm;
	String lec_nm;
	String enr_user;
	Date enr_date;
	String task_cont;
	Date upd_date;

	//첨부파일목록
	List<taskFileModel> listFilModel;

	//첨부파일 단건명 목록
	String lgc_fil_nm;
	
	
	public String getLgc_fil_nm() {
		return lgc_fil_nm;
	}

	public void setLgc_fil_nm(String lgc_fil_nm) {
		this.lgc_fil_nm = lgc_fil_nm;
	}

	public List<taskFileModel> getListFilModel() {
		return listFilModel;
	}

	public void setListFilModel(List<taskFileModel> listFilMode) {
		this.listFilModel = listFilMode;
	}

	public Date getUpd_date() {
		return upd_date;
	}

	public void setUpd_date(Date upd_date) {
		this.upd_date = upd_date;
	}

	public String getTask_cont() {
		return task_cont;
	}

	public void setTask_cont(String task_cont) {
		this.task_cont = task_cont;
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

	public String getTask_nm() {
		return task_nm;
	}

	public void setTask_nm(String task_nm) {
		this.task_nm = task_nm;
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


	public String getLec_nm() {
		return lec_nm;
	}

	public void setLec_nm(String lec_nm) {
		this.lec_nm = lec_nm;
	}

	
	
	
	
}
