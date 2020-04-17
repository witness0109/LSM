package kr.kosmo.jobkorea.sss.service;

import java.util.List;
import java.util.Map;

public interface SSSLecService {

	public List<Map<String, Object>>selectStuList(Map<String,Object> paramMap);
	
	public int LecDocTotalCnt (Map<String,Object>paramMap);
	
	public Map<String, Object> selectStuDetail(Map<String, Object>paramMap);
	
	public Map<String, Object> selectSssFile (Map<String,Object>paramMap);
}