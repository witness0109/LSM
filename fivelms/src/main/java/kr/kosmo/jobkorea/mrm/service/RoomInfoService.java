package kr.kosmo.jobkorea.mrm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.kosmo.jobkorea.mrm.model.RoomInfoModel;

public interface RoomInfoService {

	List<RoomInfoModel> roomList(Map<String, Object> paramMap);
	
	// 강의실 저장
	public int insertRoomInfo(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;

	// 강의실 정보 수정
	public int reviseRoomInfo(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;

	// 페이지 카운트
	int RTotalCnt(Map<String, Object> paramMap);

	List<RoomInfoModel> itemListVue(Map<String, Object> paramMap);

	void itemUpdate(Map<String, Object> paramMap);

	void itemDeleteVue(Map<String, Object> paramMap);

	public int itemInsert(Map<String, Object> paramMap)throws Exception;

	void roomDelete(Map<String, Object> paramMap);

	RoomInfoModel simpleInfo(Map<String, Object> paramMap);

	// 장비목록 업데이트

	
	
	
	
}
