package kr.kosmo.jobkorea.sss.dao;

import java.util.List;
import java.util.Map;

public interface SSSLecDao{

	public List<Map<String, Object>>selectStuList(Map<String,Object> paramMap);
	
	public int LecDocTotalCnt (Map<String,Object>paramMap);
	
	public Map<String, Object> selectStuDetail(Map<String, Object>paramMap);

	public Map<String, Object> selectSssFile (Map<String,Object>paramMap);
}
