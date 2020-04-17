package kr.kosmo.jobkorea.lsm.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class SurveyResultModel {
	
	private int lec_seq;
	private String sv_seq;
	private String lec_nm;
	private int sv_score;
	private String sv_comment;
	private String enr_user;
	private String enr_date;
	private String upd_user;
	private Date upd_date;
	
	public SurveyResultModel(){
		
	}

	public SurveyResultModel(int lec_seq, String sv_seq, String lec_nm, int sv_score, String sv_comment,
			String enr_user, String enr_date, String upd_user, Date upd_date) {
		
		this.lec_seq = lec_seq;
		this.sv_seq = sv_seq;
		this.lec_nm = lec_nm;
		this.sv_score = sv_score;
		this.sv_comment = sv_comment;
		this.enr_user = enr_user;
		this.enr_date = enr_date;
		this.upd_user = upd_user;
		this.upd_date = upd_date;
	}

	public int getLec_seq() {
		return lec_seq;
	}

	public void setLec_seq(int lec_seq) {
		this.lec_seq = lec_seq;
	}

	public String getSv_seq() {
		return sv_seq;
	}

	public void setSv_seq(String sv_seq) {
		this.sv_seq = sv_seq;
	}

	public String getLec_nm() {
		return lec_nm;
	}

	public void setLec_nm(String lec_nm) {
		this.lec_nm = lec_nm;
	}

	public int getSv_score() {
		return sv_score;
	}

	public void setSv_score(int sv_score) {
		this.sv_score = sv_score;
	}

	public String getSv_comment() {
		return sv_comment;
	}

	public void setSv_comment(String sv_comment) {
		this.sv_comment = sv_comment;
	}

	public String getEnr_user() {
		return enr_user;
	}

	public void setEnr_user(String enr_user) {
		this.enr_user = enr_user;
		
	}

	public String getEnr_date() {
		return enr_date;
	}

	public void setEnr_date(String enr_date) {
		this.enr_date = enr_date;
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String Resultstr = "";
		
		try{
			Date date = format.parse(enr_date);
			SimpleDateFormat resultFormat = new SimpleDateFormat("yyyy-MM-dd");
			Resultstr = resultFormat.format(date);
		}catch(ParseException e){
			e.printStackTrace();
		}
		
		this.enr_date = Resultstr;
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

	@Override
	public String toString() {
		return "SurveyResultModel [lec_seq=" + lec_seq + ", sv_seq=" + sv_seq + ", lec_nm=" + lec_nm + ", sv_score="
				+ sv_score + ", sv_comment=" + sv_comment + ", enr_user=" + enr_user + ", enr_date=" + enr_date
				+ ", upd_user=" + upd_user + ", upd_date=" + upd_date + "]";
	}
	
	
	
	
}
