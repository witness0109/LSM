package kr.kosmo.jobkorea.lsm.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.lsm.model.SurveyResultModel;


public interface SurveyResultDao {
	
	/* 설문결과 전체조회 */
	List<SurveyResultModel> selectSurveyList(Map<String, Object> paramMap);

	/* 설문결과 전체 개수 조회 */
	int countSurveyList(Map<String, Object> paramMap);
	
	/* 설문결과 단건 조회 */
	SurveyResultModel selectSurveyDetail(Map<String, Object> paramMap);
	
}
