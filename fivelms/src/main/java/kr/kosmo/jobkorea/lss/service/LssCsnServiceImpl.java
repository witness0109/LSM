package kr.kosmo.jobkorea.lss.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.lss.dao.LssCnsDao;
@Service
public class LssCsnServiceImpl implements LssCnsService {

	@Autowired
	LssCnsDao lcDao;
	
	@Override
	public List<Map<String, Object>> lecList(Map<String, Object> paramMap) {
		
		return lcDao.lecList(paramMap);
	}

	@Override
	public List<Map<String, Object>> selectSList(Map<String, Object> paramMap) {
		return lcDao.selectSList(paramMap);
	}

	@Override
	public Map<String, Object> sListOne(Map<String, Object> paramMap) {
		return lcDao.sListOne(paramMap);
	}

	@Override
	public int updateCns(Map<String, Object> paramMap) {
		int result = lcDao.updateCns(paramMap);
		return result;
	}

}
