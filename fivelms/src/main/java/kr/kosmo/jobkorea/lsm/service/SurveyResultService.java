package kr.kosmo.jobkorea.lsm.service;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.lsm.model.SurveyResultModel;

public interface SurveyResultService {
	
	/* 설문결과 전체 조회 */
	public List<SurveyResultModel> selectSurveyList(Map<String, Object> paramMap);
	
	/* 설문결과 전체 개수 */
	public int countSurveyList(Map<String, Object> paramMap);
	
	/* 설문결과 단건 조회 */
	public SurveyResultModel selectSurveyDetail(Map<String, Object> paramMap);
	
}
