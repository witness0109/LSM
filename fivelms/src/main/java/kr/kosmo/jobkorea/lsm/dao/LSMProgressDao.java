package kr.kosmo.jobkorea.lsm.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.lsm.model.LSMProgModel;


public interface LSMProgressDao {

	public List<Map<String, Object>> SelectAllList (Map<String,Object> paramMap);
	
	public  LSMProgModel SelectDetail(Map<String,Object> paramMap);
	
	public Map<String,Object> SelectDetail1(Map<String, Object> paramMap);
	
	public int cntAll(Map<String, Object>paramMap);
	
	public int updateLecProg(Map<String,Object>paramMap);

}
