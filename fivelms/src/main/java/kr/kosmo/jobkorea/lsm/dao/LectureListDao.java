package kr.kosmo.jobkorea.lsm.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.lsm.model.LectureListModel;

public interface LectureListDao {

	/** 전체 목록 조회 */
	public List<LectureListModel> lecList(Map<String, Object> paramMap);

	/** 강의목록 카운트 */
	public int countlecList(Map<String, Object> paramMap);

	/** 학생 조회 */
	public List<Map<String, Object>> selectlecDtl(Map<String, Object> paramMap);

}
