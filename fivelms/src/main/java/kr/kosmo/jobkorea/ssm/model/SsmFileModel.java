package kr.kosmo.jobkorea.ssm.model;

public class SsmFileModel {
	// 과제번호
	private String task_seq;
	// 논리파일명
	private String lgc_fil_nm;
	// 물리파일명
	private String psc_fil_nm;
	// 파일 사이즈
	private String fil_siz;
	// 파일 확장자
	private String fil_ets;

	public String getTask_seq() {
		return task_seq;
	}

	public void setTask_seq(String task_seq) {
		this.task_seq = task_seq;
	}

	public String getLgc_fil_nm() {
		return lgc_fil_nm;
	}

	public void setLgc_fil_nm(String lgc_fil_nm) {
		this.lgc_fil_nm = lgc_fil_nm;
	}

	public String getPsc_fil_nm() {
		return psc_fil_nm;
	}

	public void setPsc_fil_nm(String psc_fil_nm) {
		this.psc_fil_nm = psc_fil_nm;
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