package kr.kosmo.jobkorea.sss.service;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.sss.model.NoticeKModel;



public interface NoticeServiceK {
	/** 공지사항 목록 조회 */
	public List<NoticeKModel> noticeList(Map<String, Object> paramMap) throws Exception;
	
	/** 공지사항 목록 카운트 조회 */
	public int countListNotice(Map<String, Object> paramMap) throws Exception;
	
	/** 공지사항 단건 조회 */
	public NoticeKModel selectNotice(Map<String, Object> paramMap) throws Exception;
	
	/** 공지사항 저장 */
	public int insertNotice(Map<String, Object> paramMap) throws Exception;
	
	/** 공지사항 수정 */
	public int updateNotice(Map<String, Object> paramMap) throws Exception;
	
	/** 공지사항 삭제 */
	public int deleteNotice(Map<String, Object> paramMap) throws Exception;
	
	
	
	
	
	/** 사용가능한 모든 공통코드 조회 */
	/*public List<ComnCodUtilModel> listAllComnCode(Map<String, Object> paramMap) throws Exception;*/
}
