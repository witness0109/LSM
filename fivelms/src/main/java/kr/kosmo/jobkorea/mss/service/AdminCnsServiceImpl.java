package kr.kosmo.jobkorea.mss.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.mss.dao.AdminCnsDao;
import kr.kosmo.jobkorea.mss.model.AdminCnsModel;
import kr.kosmo.jobkorea.mss.model.AdminLecModel;

@Service
public class AdminCnsServiceImpl implements AdminCnsService {

	@Autowired
	AdminCnsDao acDao;
	
	@Override
	public List<AdminLecModel> cnsList(Map<String, Object> paramMap) {
		List<AdminLecModel> cnsList = acDao.cnsList(paramMap);
		return cnsList;
	}

	@Override
	public int countlist(Map<String, Object> paramMap) {
		int result = acDao.countlist(paramMap);
		return result;
	}

	@Override
	public List<AdminLecModel> cnsUserList(Map<String, Object> paramMap) {
		List<AdminLecModel> cnsUserList = acDao.cnsUserList(paramMap);
		return cnsUserList;
	}

	@Override
	public int countUser(Map<String, Object> paramMap) {
		int result = acDao.countUser(paramMap);
		return result;
	}

	@Override
	public AdminCnsModel selectUser(Map<Object, String> paramMap) {
		AdminCnsModel adminCnsModel = acDao.selectUser(paramMap);
		return adminCnsModel;
	}

	@Override
	public int insertCnsUser(Map<String, Object> paramMap) {
		int result = acDao.inserCnsUser(paramMap);
		return result;
	}

	@Override
	public int updateCnsUser(Map<String, Object> paramMap) {
		int result = acDao.updateCnsUser(paramMap);
		return result;
	}

	@Override
	public int deleteClist(Map<String, Object> paramMap) {
		
		int result = acDao.deleteClist(paramMap);
		return result;
	}

}
