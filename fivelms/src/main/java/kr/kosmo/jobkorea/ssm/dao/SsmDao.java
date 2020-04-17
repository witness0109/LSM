package kr.kosmo.jobkorea.ssm.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.ssm.model.SsmInfoModel;
import kr.kosmo.jobkorea.ssm.model.SsmLectureModel;

public interface SsmDao {
	/* 메서드명이 쿼리문 ID가 됌. */

	/** 과제 제출 리스트 조회 */
	public List<SsmInfoModel> listTaskSend(Map<String, Object> paramMap);

	/** 과제제출 전체 총 건수 조회 */
	public int countListSsm(Map<String, Object> paramMap);

	/** 과제제출 단건 조회 */
	public SsmInfoModel selectTaskSend(Map<String, Object> paramMap);

	/** 과제제출 저장 */
	public int insertTaskSend(Map<String, Object> paramMap);

	/** 과제제출 수정 */
	public int updateTaskSend(Map<String, Object> paramMap);

	/** 과제제출 삭제 */
	public int deleteTaskSend(Map<String, Object> paramMap);

	/** 첨부파일 저장 */
	public int saveSsmFil(Map<String, Object> paramMap);

	/** 과제 상세 목록 조회 */
	public List<SsmInfoModel> taskSendDtl(Map<String, Object> paramMap);

	/** 과제번호 조회 */
	public String selectMaxNum(Map<String, Object> paramMap);

	/* 수강목록 조회 */
	public List<SsmLectureModel> lectureList(Map<String, Object> paramMap);

	/* 수강목록 카운트 조회 */
	public int countLecList(Map<String, Object> paramMap);

	/* 수강목록단건상세조회 */
	public Map<String, Object> selectLecDet(Map<String, Object> paramMap);

}
