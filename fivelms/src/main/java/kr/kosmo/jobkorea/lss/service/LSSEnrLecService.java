package kr.kosmo.jobkorea.lss.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.kosmo.jobkorea.cmnt.model.CmntBbsAtmtFilModel;
import kr.kosmo.jobkorea.lsm.model.LsmStuCodModel;
import kr.kosmo.jobkorea.lsm.model.taskFileModel;
import kr.kosmo.jobkorea.lsm.model.taskInfoModel;
import kr.kosmo.jobkorea.lss.model.LSSEnrDocModel;

public interface LSSEnrLecService {

		//리스트 조회
		public List<Map<String,Object>> selectLssList(Map<String, Object> paramMap) throws Exception;
	
		//전체 개수 조회
		public int LecDocTotalCnt(Map<String, Object> paramMap) throws Exception;
		
		//게시판 등록
		public int insertLecDoc(Map<String, Object>paramMap, HttpServletRequest request) throws Exception;
		
		//파일 저장
		public int saveLecDocFile(Map<String, Object>paramMap) throws Exception;
		
		//등록시 강의번호 호출
		public List<Integer> selectLecSeq(String LoginId);
		
		//등록시 강의명 호출
		public List<String> selectLecNm();
		
		//단건조회
		public Map<String, Object> selectLssDetail(Map<String, Object> paramMap) throws Exception;
		
		//수정
		public void updateLecDoc(Map<String, Object> paramMap) throws Exception;
		
		//삭제
		public void deleteLss(Map<String, Object>paramMap) throws Exception;
		
		//최대값조회
		public int selectldoseq(Map<String, Object>paramMap) throws Exception;
}