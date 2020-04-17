package kr.kosmo.jobkorea.lss.dao;

import java.util.List;
import java.util.Map;

public interface LssCnsDao {

	List<Map<String, Object>> lecList(Map<String, Object> paramMap);

	List<Map<String, Object>> selectSList(Map<String, Object> paramMap);

	Map<String, Object> sListOne(Map<String, Object> paramMap);

	int updateCns(Map<String, Object> paramMap);

}
