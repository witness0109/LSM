package kr.kosmo.jobkorea.lsm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.lsm.dao.SurveyResultDao;
import kr.kosmo.jobkorea.lsm.model.SurveyResultModel;

@Service
public class SurveyResultServiceImpl implements SurveyResultService {

	@Autowired
	private SurveyResultDao surveyResultDao;

	// 설문결과 리스트 조회
	public List<SurveyResultModel> selectSurveyList(Map<String, Object> paramMap) {
		return surveyResultDao.selectSurveyList(paramMap);
	}

	// 설문결과 총 갯수
	public int countSurveyList(Map<String, Object> paramMap) {
		int totalCount = surveyResultDao.countSurveyList(paramMap);

		return totalCount;
	}
	
	// 설문결과 단건 조회
	public SurveyResultModel selectSurveyDetail(Map<String, Object> paramMap) {
		return surveyResultDao.selectSurveyDetail(paramMap);
	}
	

}
