package kr.kosmo.jobkorea.lss.model;

import java.util.Date;
import java.util.List;

import kr.kosmo.jobkorea.lsm.model.taskFileModel;

public class LSSEnrDocModel {

	String lec_seq;
	int ldo_seq;
	String lec_title;
	String enr_user;
	String ldo_cont;
	Date enr_date;
	Date upd_date;

	String lgc_fil_nm;
	String psc_fil_nml;
	String fil_siz;
	String fil_ets;

	public String getLec_seq() {
		return lec_seq;
	}

	public void setLec_seq(String lec_seq) {
		this.lec_seq = lec_seq;
	}

	public int getLdo_seq() {
		return ldo_seq;
	}

	public void setLdo_seq(int ldo_seq) {
		this.ldo_seq = ldo_seq;
	}

	public String getLec_title() {
		return lec_title;
	}

	public void setLec_title(String lec_title) {
		this.lec_title = lec_title;
	}

	public String getEnr_user() {
		return enr_user;
	}

	public void setEnr_user(String enr_user) {
		this.enr_user = enr_user;
	}

	public String getLdo_cont() {
		return ldo_cont;
	}

	public void setLdo_cont(String ldo_cont) {
		this.ldo_cont = ldo_cont;
	}

	public Date getEnr_date() {
		return enr_date;
	}

	public void setEnr_date(Date enr_date) {
		this.enr_date = enr_date;
	}

	public Date getUpd_date() {
		return upd_date;
	}

	public void setUpd_date(Date upd_date) {
		this.upd_date = upd_date;
	}

	public String getLgc_fil_nm() {
		return lgc_fil_nm;
	}

	public void setLgc_fil_nm(String lgc_fil_nm) {
		this.lgc_fil_nm = lgc_fil_nm;
	}

	public String getPsc_fil_nml() {
		return psc_fil_nml;
	}

	public void setPsc_fil_nml(String psc_fil_nml) {
		this.psc_fil_nml = psc_fil_nml;
	}

	public String getFil_siz() {
		return fil_siz;
	}

	public void setFil_siz(String fil_siz) {
		this.fil_siz = fil_siz;
	}

	public String getFil_ets() {
		return fil_ets;
	}

	public void setFil_ets(String fil_ets) {
		this.fil_ets = fil_ets;
	}

}