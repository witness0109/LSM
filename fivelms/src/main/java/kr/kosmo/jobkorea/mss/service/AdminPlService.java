package kr.kosmo.jobkorea.mss.service;

import java.util.List;
import java.util.Map;


import kr.kosmo.jobkorea.mss.model.AdminLecModel;
import kr.kosmo.jobkorea.mss.model.AdminRModel;

public interface AdminPlService {

	List<AdminLecModel> aPlist(Map<String, Object> paramMap)throws Exception;

	int countaPlist(Map<String, Object> paramMap)throws Exception;

	AdminLecModel selectaPlist(Map<Object, String> paramMap);

	int updateaPlist(Map<String, Object> paramMap);

	int deletePlist(Map<String, Object> paramMap);

	int inseraPlist(Map<String, Object> paramMap);

	List<Map<String,Object>> rList(Map<Object, String> paramMap);


}
