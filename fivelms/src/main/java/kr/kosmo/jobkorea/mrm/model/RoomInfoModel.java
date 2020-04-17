package kr.kosmo.jobkorea.mrm.model;

import java.util.Date;
import java.util.List;
import java.util.Map;

public class RoomInfoModel {

	// tb_room : 강의실
	private String rm_seq; //강의실 번호
	private String rm_name; //강의실명
	private int rm_pper; // 허용인원
	private String rm_size; //강의실 크기
	private String enr_user; // 강의실 등록자
	private Date enr_date; // 강의실 등록일
	private String upd_user; // 강의실 수정자
	private Date upd_date; // 강의실 수정일자
	private String rm_yon; //강의실 사용여부
	
	// room pic file
	private String lgc_rm_nm; //논리파일명
	private String psc_rm_nm; //물리파일명
	private String rmPic_size; // 파일 사이즈
	
	
	// tb_itm : 물품관리
	private String item_seq; //물품번호
	private String item_nm; //물품이름
	private int item_vol; //물품수량
	private String item_nt; //비고
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
	public int getRm_pper() {
		return rm_pper;
	}
	public void setRm_pper(int rm_pper) {
		this.rm_pper = rm_pper;
	}
	public String getRm_size() {
		return rm_size;
	}
	public void setRm_size(String rm_size) {
		this.rm_size = rm_size;
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
	public String getRm_yon() {
		return rm_yon;
	}
	public void setRm_yon(String rm_yon) {
		this.rm_yon = rm_yon;
	}
	public String getLgc_rm_nm() {
		return lgc_rm_nm;
	}
	public void setLgc_rm_nm(String lgc_rm_nm) {
		this.lgc_rm_nm = lgc_rm_nm;
	}
	public String getPsc_rm_nm() {
		return psc_rm_nm;
	}
	public void setPsc_rm_nm(String psc_rm_nm) {
		this.psc_rm_nm = psc_rm_nm;
	}
	public String getRmPic_size() {
		return rmPic_size;
	}
	public void setRmPic_size(String rmPic_size) {
		this.rmPic_size = rmPic_size;
	}
	public String getItem_seq() {
		return item_seq;
	}
	public void setItem_seq(String item_seq) {
		this.item_seq = item_seq;
	}
	public String getItem_nm() {
		return item_nm;
	}
	public void setItem_nm(String item_nm) {
		this.item_nm = item_nm;
	}
	public int getItem_vol() {
		return item_vol;
	}
	public void setItem_vol(int item_vol) {
		this.item_vol = item_vol;
	}
	public String getItem_nt() {
		return item_nt;
	}
	public void setItem_nt(String item_nt) {
		this.item_nt = item_nt;
	}
	@Override
	public String toString() {
		return "RoomInfoModel [rm_seq=" + rm_seq + ", rm_name=" + rm_name + ", rm_pper=" + rm_pper + ", rm_size="
				+ rm_size + ", enr_user=" + enr_user + ", enr_date=" + enr_date + ", upd_user=" + upd_user
				+ ", upd_date=" + upd_date + ", rm_yon=" + rm_yon + ", lgc_rm_nm=" + lgc_rm_nm + ", psc_rm_nm="
				+ psc_rm_nm + ", rmPic_size=" + rmPic_size + ", item_seq=" + item_seq + ", item_nm=" + item_nm
				+ ", item_vol=" + item_vol + ", item_nt=" + item_nt + "]";
	}
	
	
	
	
}
