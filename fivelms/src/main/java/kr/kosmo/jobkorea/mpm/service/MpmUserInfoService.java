package kr.kosmo.jobkorea.mpm.service;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.mpm.model.MpmUserInfoModel;

public interface MpmUserInfoService {

	/** 유저정보 리스트 조회 */
	public List<MpmUserInfoModel> selectUserInfoList(Map<String, Object> paramMap) throws Exception;
	/** 유저정보 조회 */
	public List<MpmUserInfoModel> selectUserInfo(Map<String, Object> paramMap)throws Exception;
	/** 유저정보 저장 */
	public int insertUserInfo(MpmUserInfoModel paramModel)throws Exception;
	/** 유저정보 삭제 */
	public int deleteUserInfo(MpmUserInfoModel paramModel)throws Exception;
	/** 유저정보 업데이트 */
	public int updateUserInfo(MpmUserInfoModel paramModel)throws Exception;
	
}
