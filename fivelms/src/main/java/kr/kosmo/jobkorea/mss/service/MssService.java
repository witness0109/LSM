package kr.kosmo.jobkorea.mss.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;



public interface MssService {

	List<Map<String, Object>> getNoticeList(Map<String, Object> paramMap);

	int totalCountNotice(Map<String, Object> paramMap);
	
	//---------------------------------------------------------------

	public int countUp(String nt_seq);

	//----------------------------------------------------------------
	
	public List<Map<String, Object>> getListReply(Map<String, Object> paramMap);
	
	public void insertReply(Map<String, Object> paramMap);
	

	void deleteReplyOne(int no);

	//----------------------------------------------------------------
	
	public void updateNotice(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;

	public void insertNotice(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;

	void deleteNotice(Map<String, Object> paramMap,  HttpServletRequest request) throws Exception;

	Map<String, Object> selectNoticeOne(Map<String, Object> paramMap);

	
	
	
	
}
