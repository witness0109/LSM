package kr.kosmo.jobkorea.lct.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.kosmo.jobkorea.common.comnUtils.FileUtilCho;
import kr.kosmo.jobkorea.lct.dao.LctQnaDao;

@Service
public class LctQnaServiceImpl implements LctQnaService {

	@Autowired
	LctQnaDao lctQnaDao;
	
	@Override
	public List<Map<String, Object>> qnaList(Map<String, Object> paramMap) {
		
		return lctQnaDao.qnaList(paramMap);
	}

	@Override
	public Map<String, Object> selectQna(Map<String, Object> paramMap) {
		lctQnaDao.selectQnaCountup(paramMap);
		System.out.println("카운트증가");
		return lctQnaDao.selectQna(paramMap);
	}

	@Override
	public List<Map<String, Object>> selectQnaList(Map<String, Object> paramMap) {
		
		return lctQnaDao.selectQnaList(paramMap);
	}

	@Override
	public int getTotalCnt(Map<String, Object> paramMap) {
		
		return lctQnaDao.getTotalCnt(paramMap);
	}

	@Override
	public void insertQna(Map<String, Object> paramMap) {
		lctQnaDao.insertQna(paramMap);
		
	}

	@Override
	public void updateQna(Map<String, Object> paramMap) {
		lctQnaDao.updateQna(paramMap);
		
	}

	@Override
	public List<Map<String, Object>> getListReply(Map<String, Object> paramMap) {
		
		return lctQnaDao.getListReply(paramMap);
	}

	@Override
	public void insertReply(Map<String, Object> paramMap) {
		lctQnaDao.insertReply(paramMap);
		
	}

	@Override
	public void insertReply2(Map<String, Object> paramMap) {
		lctQnaDao.insertReply2(paramMap);
		
	}

	@Override
	public void updateQnaFile(Map<String, Object> paramMap, HttpServletRequest request) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertQnaFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

	
		// D:\\FileRepository\\ 밑에 F200330 이런식으로 폴더생성하기위해 가져옴.
		String dirPath = lctQnaDao.getDirectory();
		paramMap.put("dirPath", dirPath);
		
		// 파일 저장
		String itemFilePath = dirPath+ File.separator;
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, "D:\\FileRepository", itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles();
		
		// 데이터 저장
		try {
				
				paramMap.put("fileInfo", fileInfo);
				lctQnaDao.insertQna(paramMap);
				//cmntBbsDao.saveCmntBbsAtmtFil(paramMap);
			
		} catch(Exception e) {
			// 파일 삭제
			fileUtil.deleteFiles(fileInfo);
			throw e;
		}
		
		
	}

	@Override
	public void deleteQna(Map<String, Object> paramMap) {
		System.out.println("실행?");
		lctQnaDao.deleteQna(paramMap);
		
	}

}

