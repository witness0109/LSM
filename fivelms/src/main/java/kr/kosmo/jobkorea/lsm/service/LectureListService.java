package kr.kosmo.jobkorea.lsm.service;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.lsm.model.LectureListModel;

public interface LectureListService {
	
	/** 전체 목록 조회 */
	public List<LectureListModel> lecList(Map<String, Object> paramMap) throws Exception;

	/** 건수 조회 */
	public int countlecList(Map<String, Object> paramMap) throws Exception;

	/** 학생 조회 */
	public List<Map<String, Object>> selectlecDtl(Map<String, Object> paramMap) throws Exception;

}
