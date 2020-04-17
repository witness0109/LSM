package kr.kosmo.jobkorea.lsm.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.poi.util.SystemOutLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.kosmo.jobkorea.common.comnUtils.AESCryptoHelper;
import kr.kosmo.jobkorea.common.comnUtils.ComnUtil;
import kr.kosmo.jobkorea.common.comnUtils.FileUtil;
import kr.kosmo.jobkorea.common.comnUtils.FileUtilModel;
import kr.kosmo.jobkorea.lsm.model.LSMProgModel;
import kr.kosmo.jobkorea.lsm.model.LsmStuCodModel;
import kr.kosmo.jobkorea.lsm.model.taskFileModel;
import kr.kosmo.jobkorea.lsm.dao.LSMBoardDao;
import kr.kosmo.jobkorea.lsm.dao.LSMProgressDao;
import kr.kosmo.jobkorea.lsm.model.taskInfoModel;

@Service
public class LSMProgressServiceImpl implements LSMProgressService {

	// Root path for file upload
	@Value("${fileUpload.rootPath}")
	private String rootPath;

	// comment path for file upload
	@Value("${fileUpload.bbsPath}")
	private String bbsPath;

	@Autowired
	private LSMProgressDao lsmprogDao;

	
	public List<Map<String, Object>> SelectAllList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return lsmprogDao.SelectAllList(paramMap);
	}

	
	public LSMProgModel SelectDetail(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return lsmprogDao.SelectDetail(paramMap);
	}

	
	public int cntAll(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return lsmprogDao.cntAll(paramMap);
	}


	@Override
	public int updateLecProg(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return lsmprogDao.updateLecProg(paramMap);
		
	}

	
	
}
