package kr.kosmo.jobkorea.register.model;

import java.sql.Date;

public class RegisterModel {
	private String loginId;
	private String password;
	private String name;
	private String user_type;
	private String user_email;
	private String user_addr;
	private String addr_detail;
	private String user_post;
	private Date user_joinDate;
	private String regUserId;
	private String authNum;
	
	public String getAuthNum() {
		return authNum;
	}
	public void setAuthNum(String authNum) {
		this.authNum = authNum;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUser_type() {
		return user_type;
	}
	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_addr() {
		return user_addr;
	}
	public void setUser_addr(String user_addr) {
		this.user_addr = user_addr;
	}
	public String getAddr_detail() {
		return addr_detail;
	}
	public void setAddr_detail(String addr_detail) {
		this.addr_detail = addr_detail;
	}
	public String getUser_post() {
		return user_post;
	}
	public void setUser_post(String user_post) {
		this.user_post = user_post;
	}
	public Date getUser_joinDate() {
		return user_joinDate;
	}
	public void setUser_joinDate(Date user_joinDate) {
		this.user_joinDate = user_joinDate;
	}
	public String getRegUserId() {
		return regUserId;
	}
	public void setRegUserId(String regUserId) {
		this.regUserId = regUserId;
	}
	@Override
	public String toString() {
		return "RegisterModel [loginId=" + loginId + ", password=" + password + ", name=" + name + ", user_type="
				+ user_type + ", user_email=" + user_email + ", user_addr=" + user_addr + ", addr_detail=" + addr_detail
				+ ", user_post=" + user_post + ", user_joinDate=" + user_joinDate + ", regUserId=" + regUserId + "]";
	}
	
	
	
}
