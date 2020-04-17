package kr.kosmo.jobkorea.lss.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.lss.dao.LssDao;
import kr.kosmo.jobkorea.lss.model.LssLectureModel;

@Service
public class LssServiceImpl implements LssService{
	@Autowired
	LssDao lDao;
	@Override
	public List<LssLectureModel> pListAll(Map<String, Object> paramMap)throws Exception {
		List<LssLectureModel> pListAll = lDao.pListAll(paramMap);
		return pListAll;
	}
	@Override
	public int countPlist(Map<String, Object> paramMap)throws Exception {
		int totalCount = lDao.countPlist(paramMap);
		return totalCount;
	}
	@Override
	public LssLectureModel selectPlist(Map<Object, String> paramMap) {
		LssLectureModel lssLectureModel = lDao.selectPlist(paramMap);
		return lssLectureModel;
	}
	@Override
	public int updatePlist(Map<String, Object> paramMap) {
		
		int result = lDao.updatePlist(paramMap);
		
		return result;
	}

}
