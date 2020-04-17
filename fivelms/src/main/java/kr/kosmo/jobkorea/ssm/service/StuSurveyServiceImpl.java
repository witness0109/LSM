package kr.kosmo.jobkorea.ssm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.ssm.dao.StuSurveyDao;

@Service
public class StuSurveyServiceImpl implements StuSurveyService {

	@Autowired
	StuSurveyDao stuSurveyDao;
	
	@Override
	public List<Map<String, Object>> getLecList(Map<String, Object> paramMap) {
		
		return stuSurveyDao.getLecList(paramMap);
	}

	@Override
	public List<Map<String, Object>> getSurveyList(Map<String, Object> paramMap) {
		
		return stuSurveyDao.getSurveyList(paramMap);
	}

	@Override
	public void savesurvey(Map<String, Object> paramMap) {
		
		stuSurveyDao.saveSurvey(paramMap);
		
	}

}
