package kr.kosmo.jobkorea.ssm.service;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.ssm.model.SsmInfoModel;
import kr.kosmo.jobkorea.ssm.model.SsmLectureModel;

public interface SsmService {

	/** 과제 제출 리스트 조회 */
	public List<SsmInfoModel> listTaskSend(Map<String, Object> paramMap) throws Exception;

	/** 과제제출 전체 총 건수 조회 */
	public int countListSsm(Map<String, Object> paramMap) throws Exception;

	/** 과제제출 단건 조회 */
	public SsmInfoModel selectTaskSend(Map<String, Object> paramMap) throws Exception;

	/** 과제제출 저장 */
	public int insertTaskSend(Map<String, Object> paramMap) throws Exception;

	/** 과제제출 수정 */
	public int updateTaskSend(Map<String, Object> paramMap) throws Exception;

	/** 과제제출 삭제 */
	public int deleteTaskSend(Map<String, Object> paramMap) throws Exception;

	/** 첨부파일 저장 */
	public int saveSsmFil(Map<String, Object> paramMap) throws Exception;

	/** 과제 상세 목록 조회 */
	public List<SsmInfoModel> taskSendDtl(Map<String, Object> paramMap) throws Exception;

	/* 수강목록 조회 */
	public List<SsmLectureModel> lectureList(Map<String, Object> paramMap);

	/* 수강목록 카운트 조회 페이징 */
	public int countLecList(Map<String, Object> paramMap);

	/* 수강목록 단건상세 조회 */
	public Map<String, Object> selectLecDet(Map<String, Object> paramMap);

}
