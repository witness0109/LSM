package kr.kosmo.jobkorea.mpm.model;

import java.util.List;

public class MpmMainUserInfoModel {
	
	private List<MpmUserInfoModel> userInfoList;
	
	private MpmUserInfoModel userInfo;
	
	private String loginID;
	
	private String password;
	
	private String name;
	
	private String user_type;
	
	private String user_email;
	
	private String user_addr;
	
	private String addr_detail;
	
	private String user_post;
	
	private String user_joinDate;
	
	private String status_yn;
	
	private String regUserId;
	
	private String act_mode;
	
	
	
	
	public String getAct_mode() {
		return act_mode;
	}
	public void setAct_mode(String act_mode) {
		this.act_mode = act_mode;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
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
	public String getUser_joinDate() {
		return user_joinDate;
	}
	public void setUser_joinDate(String user_joinDate) {
		this.user_joinDate = user_joinDate;
	}
	public String getStatus_yn() {
		return status_yn;
	}
	public void setStatus_yn(String status_yn) {
		this.status_yn = status_yn;
	}
	public String getRegUserId() {
		return regUserId;
	}
	public void setRegUserId(String regUserId) {
		this.regUserId = regUserId;
	}
	public List<MpmUserInfoModel> getUserInfoList() {
		return userInfoList;
	}
	public void setUserInfoList(List<MpmUserInfoModel> userInfoList) {
		this.userInfoList = userInfoList;
	}
	public MpmUserInfoModel getUserInfo() {
		return userInfo;
	}
	public void setUserInfo(MpmUserInfoModel userInfo) {
		this.userInfo = userInfo;
	}
	@Override
	public String toString() {
		return "MpmMainUserInfoModel [userInfoList=" + userInfoList + ", userInfo=" + userInfo + ", loginID=" + loginID
				+ ", password=" + password + ", name=" + name + ", user_type=" + user_type + ", user_email="
				+ user_email + ", user_addr=" + user_addr + ", addr_detail=" + addr_detail + ", user_post=" + user_post
				+ ", user_joinDate=" + user_joinDate + ", status_yn=" + status_yn + ", regUserId=" + regUserId
				+ ", act_mode=" + act_mode + "]";
	}
	
	
}
