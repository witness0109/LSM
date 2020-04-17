package kr.kosmo.jobkorea.mpm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.mpm.dao.MpmUserInfoDao;
import kr.kosmo.jobkorea.mpm.model.MpmMainUserInfoModel;
import kr.kosmo.jobkorea.mpm.model.MpmUserInfoModel;

@Service
public class MpmUserInfoServiceImpl implements MpmUserInfoService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	MpmUserInfoDao mpmDao;
	
	
	public List<MpmUserInfoModel> selectUserInfoList(Map<String, Object> paramMap) throws Exception {
	 List<MpmUserInfoModel> list  =	mpmDao.selectUserInfoList(paramMap);
		return list;
	}


	public int insertUserInfo(MpmUserInfoModel paramModel) throws Exception {
		int resultValue = 0;
		
	  resultValue = mpmDao.insertUserInfo(paramModel);
			
		return resultValue;
	}


	public List<MpmUserInfoModel> selectUserInfo(Map<String, Object> paramMap) throws Exception {
		
		List<MpmUserInfoModel> list  =	mpmDao.selectUserInfo(paramMap);
		
		return list;
	}


	public int deleteUserInfo(MpmUserInfoModel paramModel) throws Exception {
		int resultValue = 0;
		
		  resultValue = mpmDao.deleteUserInfo(paramModel);
				
			return resultValue;
	}


	public int updateUserInfo(MpmUserInfoModel paramModel) throws Exception {
		int resultValue = 0;
		
		  resultValue = mpmDao.updateUserInfo(paramModel);
				
			return resultValue;
	}

	
	
}
