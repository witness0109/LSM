package kr.kosmo.jobkorea.mrm.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.kosmo.jobkorea.mrm.model.RoomInfoModel;

public interface RoomInfoDao {

	List<RoomInfoModel> roomList(Map<String, Object> paramMap);

	// 강의실 정보 저장
	public int insertRoomInfo(Map<String, Object> paramMap);

	// 강의실 정보 수정
	public int reviseRoomInfo(Map<String, Object> paramMap, HttpServletRequest request);

	int RTotalCnt(Map<String, Object> paramMap);

	List<RoomInfoModel> itemListVue(Map<String, Object> paramMap);

	void itemUpdate(Map<String, Object> paramMap);

	void itemDeleteVue(Map<String, Object> paramMap);
	
	public int itemInsert(Map<String, Object> paramMap);

	void roomDelete(Map<String, Object> paramMap);
	// 강의실 정보 업데이트
	public int updateRoomInfo(Map<String, Object> paramMap);

	RoomInfoModel simpleInfo(Map<String, Object> paramMap);

}
