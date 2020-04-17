package kr.kosmo.jobkorea.mss.dao;

import java.util.List;
import java.util.Map;

public interface MssNoticeDao {

	List<Map<String, Object>> getNoticeList(Map<String, Object> paramMap);

	int totalCountNotice(Map<String, Object> paramMap);

	void countUp(String nt_seq);

	int getNoticeCnt(String nt_seq);

	List<Map<String, Object>> getListReply(Map<String, Object> paramMap);

	void insertReply(Map<String, Object> paramMap);

	void deleteReplyOne(int no);

	String getDirectory();

	void insertNotice(Map<String, Object> paramMap);

	void updateNotice(Map<String, Object> paramMap);

	void deleteNotice(Map<String, Object> paramMap);

	Map<String, Object> selectNoticeOne(Map<String, Object> paramMap);

}
