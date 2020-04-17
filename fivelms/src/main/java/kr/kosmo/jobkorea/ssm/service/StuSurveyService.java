package kr.kosmo.jobkorea.ssm.service;

import java.util.List;
import java.util.Map;

public interface StuSurveyService {

	List<Map<String, Object>> getLecList(Map<String, Object> paramMap);

	List<Map<String, Object>> getSurveyList(Map<String, Object> paramMap);

	void savesurvey(Map<String, Object> paramMap);

}
