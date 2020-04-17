package kr.kosmo.jobkorea.mss.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.mss.dao.AdminPlDao;
import kr.kosmo.jobkorea.mss.model.AdminLecModel;
import kr.kosmo.jobkorea.mss.model.AdminRModel;

@Service
public class AdminPlServiceImpl implements AdminPlService {
	
	@Autowired
	AdminPlDao aplDao;

	@Override
	public List<AdminLecModel> aPlist(Map<String, Object> paramMap) {
		List<AdminLecModel> aPlist = aplDao.aPlist(paramMap);
		return aPlist;
	}

	@Override
	public int countaPlist(Map<String, Object> paramMap) {
		int totalCount = aplDao.countaPlist(paramMap);
		return totalCount;
	}

	@Override
	public AdminLecModel selectaPlist(Map<Object, String> paramMap) {
		AdminLecModel adminlecModel = aplDao.selectaPlist(paramMap);
		return adminlecModel;
	}

	@Override
	public int updateaPlist(Map<String, Object> paramMap) {
		int result = aplDao.updateaPlist(paramMap);
		return result;
	}

	@Override
	public int deletePlist(Map<String, Object> paramMap) {
		int result = aplDao.deletePlist(paramMap);
		return result;
	}

	@Override
	public int inseraPlist(Map<String, Object> paramMap) {
		int result = aplDao.insertaPlist(paramMap);
		return result;
	}

	@Override
	public List<Map<String,Object>> rList(Map<Object, String> paramMap) {
		List<Map<String,Object>> rList = aplDao.rList(paramMap);
		return rList;
	}

	
}