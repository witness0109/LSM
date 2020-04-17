package kr.kosmo.jobkorea.mss.service;

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
import kr.kosmo.jobkorea.mss.dao.MssNoticeDao;




@Service
public class MssServiceImpl implements MssService {
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	MssNoticeDao mssNoticeDao;
	
	@Override
	public List<Map<String, Object>> getNoticeList(Map<String, Object> paramMap) {
		
		return mssNoticeDao.getNoticeList(paramMap);
	}

	@Override
	public int totalCountNotice(Map<String, Object> paramMap) {
		
		return mssNoticeDao.totalCountNotice(paramMap);
	}

	@Override
	public int countUp(String nt_seq) {
		mssNoticeDao.countUp(nt_seq);
			
		return mssNoticeDao.getNoticeCnt(nt_seq);
	}

	


	@Override
	public List<Map<String, Object>> getListReply(Map<String, Object> paramMap) {
		
		return mssNoticeDao.getListReply(paramMap);
	}

	@Override
	public void insertReply(Map<String, Object> paramMap) {
		mssNoticeDao.insertReply(paramMap);
		
	}



	@Override
	public void updateNotice(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

		
		// D:\\FileRepository\\ 밑에 F200330 이런식으로 폴더생성하기위해 가져옴.
		String dirPath = mssNoticeDao.getDirectory();
		paramMap.put("dirPath", dirPath);
		
		// 파일 저장
		String itemFilePath = dirPath+ File.separator;
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, "D:\\FileRepository", itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles();
		
		// 데이터 저장
		try {
				
				paramMap.put("fileInfo", fileInfo);
				mssNoticeDao.updateNotice(paramMap);
				//cmntBbsDao.saveCmntBbsAtmtFil(paramMap);
			
		} catch(Exception e) {
			// 파일 삭제
			fileUtil.deleteFiles(fileInfo);
			throw e;
		}
	}

	@Override
	public void insertNotice(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

		
		// D:\\FileRepository\\ 밑에 F200330 이런식으로 폴더생성하기위해 가져옴.
		String dirPath = mssNoticeDao.getDirectory();
		paramMap.put("dirPath", dirPath);
		
		// 파일 저장
		String itemFilePath = dirPath+ File.separator;
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, "D:\\FileRepository", itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles();
		
		// 데이터 저장
		try {
				
				paramMap.put("fileInfo", fileInfo);
				mssNoticeDao.insertNotice(paramMap);
				//cmntBbsDao.saveCmntBbsAtmtFil(paramMap);
			
		} catch(Exception e) {
			// 파일 삭제
			fileUtil.deleteFiles(fileInfo);
			throw e;
		}
	
	}

	@Override
	public void deleteReplyOne(int no) {
		mssNoticeDao.deleteReplyOne(no);
	}

	@Override
	public void deleteNotice(Map<String, Object> paramMap , HttpServletRequest request) throws Exception {
		
		String dirPath = mssNoticeDao.getDirectory();
		paramMap.put("dirPath", dirPath);
		
		// 파일 저장
		String itemFilePath = dirPath+ File.separator;
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, "D:\\FileRepository", itemFilePath);
		fileUtil.deleteFiles(paramMap);
		
		mssNoticeDao.deleteNotice(paramMap);
		
		
	}

	@Override
	public Map<String, Object> selectNoticeOne(Map<String, Object> paramMap) {
		
		return mssNoticeDao.selectNoticeOne(paramMap);
	}

	
	
}
