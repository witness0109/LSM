package kr.kosmo.jobkorea.ssm.dao;

import java.util.List;
import java.util.Map;

public interface StuSurveyDao {

	List<Map<String, Object>> getLecList(Map<String, Object> paramMap);

	List<Map<String, Object>> getSurveyList(Map<String, Object> paramMap);

	void saveSurvey(Map<String, Object> paramMap);

}
