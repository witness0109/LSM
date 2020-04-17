package kr.kosmo.jobkorea.lsm.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.lsm.model.LsmStuCodModel;
import kr.kosmo.jobkorea.lsm.model.taskFileModel;
import kr.kosmo.jobkorea.cmnt.model.CmntBbsAtmtFilModel;
import kr.kosmo.jobkorea.login.model.LgnInfoModel;
import kr.kosmo.jobkorea.login.model.UsrMnuAtrtModel;
import kr.kosmo.jobkorea.login.model.UsrMnuChildAtrtModel;
import kr.kosmo.jobkorea.lsm.model.taskInfoModel;

public interface LSMBoardDao {
	
	/**  강사들이 올린 리스트 조회  **/
	public  List<Map<String,Object>> selectLsmBoardList (Map<String, Object> paramMap);

	/* 목록 카운트 조회 */
	public int countListLsmCod(Map<String, Object> paramMap);

	/* 단건 조회 */
	public Map<String,Object> selectLsmCod(Map<String, Object> paramMap);

	/* 과제 등록 */
	public int insertLsmCod(Map<String, Object> paramMap);
	
	/* 과제등록시 강의번호 호출 */
	public List<Integer> selectLecSeq ();
	
	/* 과제등록시 강의명 호출 */
	public List<String> selectLecNm ();
	
	/* 과제 삭제*/
	public int deleteLsmCod(Map<String,Object>paramMap);

	/* 과제 수정*/
	public int updateLsmCod(Map<String, Object> paramMap);

	/** 첨부 파일 저장 */
	public int saveLsmFil(Map<String, Object> paramMap);

	/** 첨부 게시물 목록 조회 */
	public List<Map<String,Object>> listLsmFil(Map<String, Object> paramMap);
	
	/** 게시글 첨부 단건 조회 */
	public Map<String,Object> selectLsmFil(Map<String, Object>paramMap);
	
	/** 제출 첨부 단건 조회 */
	public Map<String,Object> selectStuFil(Map<String, Object>paramMap);
	
	/* 과제번호 조회 */
	public String selectMaxNum(Map<String, Object> paramMap);
	
	/** 게시글 첨부 수정 */
	public int updateLsmFil(Map<String, Object>paramMap);
	
	/** 게시글 첨부 파일 단건 삭제 */
	public int deleteLsmFil(Map<String, Object>paramMap);
	
	/** 과제 제출 학생 조회 */
	public List<Map<String,Object>> selectLsmStuList (Map<String, Object> paramMap);
	
	/** 과제 제출 목록 카운트 조회 */
	public int countLsmStuListCod(Map<String, Object> paramMap);
}
