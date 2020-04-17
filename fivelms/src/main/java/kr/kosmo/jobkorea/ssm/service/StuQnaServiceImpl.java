package kr.kosmo.jobkorea.ssm.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.kosmo.jobkorea.common.comnUtils.FileUtilCho;
import kr.kosmo.jobkorea.ssm.dao.StuQnaDao;

@Service
public class StuQnaServiceImpl implements StuQnaService {

	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	@Autowired
	StuQnaDao stuQnaDao;
	
	@Override
	public List<Map<String, Object>> qnaList(Map<String, Object> paramMap) {
		
		return stuQnaDao.qnaList(paramMap);
	}

	@Override
	public Map<String, Object> selectQna(Map<String, Object> paramMap) {
		stuQnaDao.selectQnaCountup(paramMap);
		System.out.println("카운트증가");
		return stuQnaDao.selectQna(paramMap);
	}

	@Override
	public List<Map<String, Object>> selectQnaList(Map<String, Object> paramMap) {
		
		return stuQnaDao.selectQnaList(paramMap);
	}

	@Override
	public int getTotalCnt(Map<String, Object> paramMap) {
		
		return stuQnaDao.getTotalCnt(paramMap);
	}

	@Override
	public void insertQna(Map<String, Object> paramMap) {
		stuQnaDao.insertQna(paramMap);
		
	}

	@Override
	public void updateQna(Map<String, Object> paramMap) {
		stuQnaDao.updateQna(paramMap);
		
	}

	@Override
	public List<Map<String, Object>> getListReply(Map<String, Object> paramMap) {
		
		return stuQnaDao.getListReply(paramMap);
	}

	@Override
	public void insertReply(Map<String, Object> paramMap) {
		stuQnaDao.insertReply(paramMap);
		
	}

	@Override
	public void insertReply2(Map<String, Object> paramMap) {
		stuQnaDao.insertReply2(paramMap);
		
	}

	@Override
	public void updateQnaFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

		
		// D:\\FileRepository\\ 밑에 F200330 이런식으로 폴더생성하기위해 가져옴.
		String dirPath = stuQnaDao.getDirectory();
		paramMap.put("dirPath", dirPath);
		
		// 파일 저장
		String itemFilePath = dirPath+ File.separator;
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, "D:\\FileRepository", itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles();
		logger.info("------- file 정보::  " + fileInfo );
		// 데이터 저장
		try {
				
				paramMap.put("fileInfo", fileInfo);
				logger.info("------- paramMap ::  " + paramMap );
				stuQnaDao.updateQna(paramMap);
				//cmntBbsDao.saveCmntBbsAtmtFil(paramMap);
			
		} catch(Exception e) {
			// 파일 삭제
			fileUtil.deleteFiles(fileInfo);
			throw e;
		}
		
		
	}

	@Override
	public void insertQnaFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

	
		// D:\\FileRepository\\ 밑에 F200330 이런식으로 폴더생성하기위해 가져옴.
		String dirPath = stuQnaDao.getDirectory();
		paramMap.put("dirPath", dirPath);
		
		// 파일 저장
		String itemFilePath = dirPath+ File.separator;
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, "D:\\FileRepository", itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles();
		
		// 데이터 저장
		try {
				
				paramMap.put("fileInfo", fileInfo);
				stuQnaDao.insertQna(paramMap);
				//cmntBbsDao.saveCmntBbsAtmtFil(paramMap);
			
		} catch(Exception e) {
			// 파일 삭제
			fileUtil.deleteFiles(fileInfo);
			throw e;
		}
		
		
	}

	@Override
	public void deleteQna(Map<String, Object> paramMap) {
		stuQnaDao.deleteQna(paramMap);
		
	}

}
