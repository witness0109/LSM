package kr.kosmo.jobkorea.lss.service;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.lss.model.LssLectureModel;

public interface LssService {

	List<LssLectureModel> pListAll(Map<String, Object> paramMap) throws Exception;

	int countPlist(Map<String, Object> paramMap)throws Exception;

	LssLectureModel selectPlist(Map<Object, String> paramMap);

	int updatePlist(Map<String, Object> paramMap);

}
