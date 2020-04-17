package kr.kosmo.jobkorea.lsm.service;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.lsm.model.LSMProgModel;

public interface LSMProgressService {
	
	public List<Map<String, Object>> SelectAllList (Map<String,Object> paramMap);
	
	public  LSMProgModel SelectDetail(Map<String,Object> paramMap);
	
	public int cntAll(Map<String, Object>paramMap);
	
	public int updateLecProg(Map<String,Object>paramMap);

}
