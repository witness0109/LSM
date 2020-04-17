package kr.kosmo.jobkorea.lsm.model;

import java.util.Date;
import java.util.List;

import kr.kosmo.jobkorea.lsm.model.taskFileModel;

public class LSMProgModel {

	String lec_seq, lec_nm, lec_contents, lec_gl, lec_pl, rm_seq, user_id;
	Date lec_enr, lec_tm, lec_st, lec_ed, enr_date, upd_date;

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

	public Date getLec_enr() {
		return lec_enr;
	}

	public void setLec_enr(Date lec_enr) {
		this.lec_enr = lec_enr;
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

}
