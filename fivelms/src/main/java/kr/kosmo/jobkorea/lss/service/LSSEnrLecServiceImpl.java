package kr.kosmo.jobkorea.lss.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.kosmo.jobkorea.common.comnUtils.AESCryptoHelper;
import kr.kosmo.jobkorea.common.comnUtils.ComnUtil;
import kr.kosmo.jobkorea.common.comnUtils.FileUtil;
import kr.kosmo.jobkorea.common.comnUtils.FileUtilModel;
import kr.kosmo.jobkorea.lsm.model.LsmStuCodModel;
import kr.kosmo.jobkorea.lsm.model.taskFileModel;
import kr.kosmo.jobkorea.lsm.dao.LSMBoardDao;
import kr.kosmo.jobkorea.lsm.model.taskInfoModel;
import kr.kosmo.jobkorea.lss.dao.LSSEnrLecDao;
import kr.kosmo.jobkorea.lss.model.LSSEnrDocModel;

@Service
public class LSSEnrLecServiceImpl implements LSSEnrLecService {


	// Root path for file upload
	@Value("${fileUpload.rootPath}")
	private String rootPath;

	// comment path for file upload
	@Value("${fileUpload.bbsPath}")
	private String bbsPath;

	@Autowired
	LSSEnrLecDao lssEnrLecDao;
	
	//리스트조회
	public List<Map<String, Object>> selectLssList(Map<String, Object> paramMap) throws Exception{
		  

		return lssEnrLecDao.selectLssList(paramMap);

	}

	//전체 개수 조회
	public int LecDocTotalCnt(Map<String, Object> paramMap) throws Exception {

		int ret = lssEnrLecDao.LecDocTotalCnt(paramMap);
		
		return ret;
	}

	//생성
	public int insertLecDoc(Map<String, Object> paramMap,HttpServletRequest request) throws Exception {
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		int ret = 0; 
				
		String lec_seq = (String) paramMap.get("lec_seq");
		System.out.println(lec_seq + " < === 강의번호 확인중(serviceImpl) ");
		
		int ldo_seq = lssEnrLecDao.selectldoseq(paramMap);
		System.out.println(ldo_seq + " < === 학습자료번호 확인중(serviceImpl) ");
		
		//파일저장
		String itemFilePath = bbsPath + File.separator + lec_seq + File.separator + ldo_seq;
		FileUtil lssUtil = new FileUtil(multipartHttpServletRequest, rootPath, itemFilePath);
		List<FileUtilModel> listFileUtilModel = lssUtil.uploadFiles();
		
		try{
			
			ret = lssEnrLecDao.insertLecDoc(paramMap);
			
			for(FileUtilModel fileUtilModel : listFileUtilModel) {
				
				paramMap.put("lec_seq", lec_seq);
				// 논리파일명
				paramMap.put("lgc_fil_nm", fileUtilModel.getLgc_fil_nm());
				// 물리파일명
				paramMap.put("psc_fil_nm", fileUtilModel.getPsc_fil_nm());
				// 사이즈
				paramMap.put("fil_siz", fileUtilModel.getFil_siz());
				// 확장자
				paramMap.put("fil_ets", fileUtilModel.getFil_ets());

				paramMap.put("ldo_seq", ldo_seq);
				
				ret = lssEnrLecDao.saveLecDocFile(paramMap);
				
			}
			
		}catch(Exception e){
			
			lssUtil.deleteFiles(listFileUtilModel);
			throw e;
			
		}
		return ret;
	}


	public List<Integer> selectLecSeq(String LoginId) {
		List<Integer> lecSeqList = lssEnrLecDao.selectLecSeq(LoginId);
		return lecSeqList;
	}

	
	public List<String> selectLecNm() {
		List<String> lecSeqList = lssEnrLecDao.selectLecNm();
		return lecSeqList;
	}

	//단건조회
	public Map<String, Object> selectLssDetail(Map<String, Object> paramMap) {
		
		return lssEnrLecDao.selectLssDetail(paramMap);
	}

	//수정
	public void updateLecDoc(Map<String, Object> paramMap) {
			lssEnrLecDao.updateLecDoc(paramMap);
	}

	@Override
	public void deleteLss(Map<String, Object> paramMap) {
			lssEnrLecDao.deleteLss(paramMap);
		
	}

	//첨부파일 저장
	public int saveLecDocFile(Map<String, Object> paramMap ){
		int ret = lssEnrLecDao.saveLecDocFile(paramMap);
		return ret;
	}

	//최대값 조회
	public int selectldoseq(Map<String, Object> paramMap) {
		int ret = lssEnrLecDao.selectldoseq(paramMap);
		return ret;
	}



	
	
	
}
