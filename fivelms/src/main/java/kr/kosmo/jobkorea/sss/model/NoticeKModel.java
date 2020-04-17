package kr.kosmo.jobkorea.sss.model;



public class NoticeKModel {

	private String nt_seq;  // 고유번호
	private String nt_title; // 제목
	private String nt_contents; // 내용
	private String file_nm;//파일 이름
	private String file_size; //파일크기
	private String file_loc;  //파일 위치
	private int nt_cnt;        // 조회수
	private String enr_user;  // 등록자
	private String enr_date;     // 등록일
	private String upd_user;   //수정자
	private String upd_date;      //수정일
	
	
	public NoticeKModel() {
		super();
		// TODO Auto-generated constructor stub
	}


	public NoticeKModel(String nt_seq, String nt_title, String nt_contents, String file_nm, String file_size,
			String file_loc, int nt_cnt, String enr_user, String enr_date, String upd_user, String upd_date) {
		super();
		this.nt_seq = nt_seq;
		this.nt_title = nt_title;
		this.nt_contents = nt_contents;
		this.file_nm = file_nm;
		this.file_size = file_size;
		this.file_loc = file_loc;
		this.nt_cnt = nt_cnt;
		this.enr_user = enr_user;
		this.enr_date = enr_date;
		this.upd_user = upd_user;
		this.upd_date = upd_date;
	}


	public String getNt_seq() {
		return nt_seq;
	}


	public void setNt_seq(String nt_seq) {
		this.nt_seq = nt_seq;
	}


	public String getNt_title() {
		return nt_title;
	}


	public void setNt_title(String nt_title) {
		this.nt_title = nt_title;
	}


	public String getNt_contents() {
		return nt_contents;
	}


	public void setNt_contents(String nt_contents) {
		this.nt_contents = nt_contents;
	}


	public String getFile_nm() {
		return file_nm;
	}


	public void setFile_nm(String file_nm) {
		this.file_nm = file_nm;
	}


	public String getFile_size() {
		return file_size;
	}


	public void setFile_size(String file_size) {
		this.file_size = file_size;
	}


	public String getFile_loc() {
		return file_loc;
	}


	public void setFile_loc(String file_loc) {
		this.file_loc = file_loc;
	}


	public int getNt_cnt() {
		return nt_cnt;
	}


	public void setNt_cnt(int nt_cnt) {
		this.nt_cnt = nt_cnt;
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
	}


	public String getUpd_user() {
		return upd_user;
	}


	public void setUpd_user(String upd_user) {
		this.upd_user = upd_user;
	}


	public String getUpd_date() {
		return upd_date;
	}


	public void setUpd_date(String upd_date) {
		this.upd_date = upd_date;
	}


	@Override
	public String toString() {
		return "NoticeKModel [nt_seq=" + nt_seq + ", nt_title=" + nt_title + ", nt_contents=" + nt_contents
				+ ", file_nm=" + file_nm + ", file_size=" + file_size + ", file_loc=" + file_loc + ", nt_cnt=" + nt_cnt
				+ ", enr_user=" + enr_user + ", enr_date=" + enr_date + ", upd_user=" + upd_user + ", upd_date="
				+ upd_date + "]";
	}
	
	
	
	
	
	
	
	
}


