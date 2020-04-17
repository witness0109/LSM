package kr.kosmo.jobkorea.lct.dao;


import java.util.List;
import java.util.Map;

public interface LctQnaDao {

	public List<Map<String, Object>> qnaList(Map<String, Object> paramMap);

	public Map<String, Object> selectQna(Map<String, Object> paramMap);
	
	public List<Map<String, Object>> selectQnaList(Map<String, Object> paramMap);
	
	public int getTotalCnt(Map<String, Object> paramMap);

	public void insertQna(Map<String, Object> paramMap);

	public void selectQnaCountup(Map<String, Object> paramMap);

	public void updateQna(Map<String, Object> paramMap);

	public List<Map<String, Object>> getListReply(Map<String, Object> paramMap);

	public void insertReply(Map<String, Object> paramMap);

	public void insertReply2(Map<String, Object> paramMap);

	public String getDirectory();

	public void deleteQna(Map<String, Object> paramMap);
	
}
