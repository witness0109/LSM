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
import kr.kosmo.jobkorea.lsm.model.LsmStuCodModel;
import kr.kosmo.jobkorea.lsm.model.taskFileModel;
import kr.kosmo.jobkorea.lsm.dao.LSMBoardDao;
import kr.kosmo.jobkorea.lsm.model.taskInfoModel;

@Service
public class LSMBoardServiceImpl implements LSMBoardService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	// Root path for file upload
	@Value("${fileUpload.rootPath}")
	private String rootPath;

	// comment path for file upload
	@Value("${fileUpload.bbsPath}")
	private String bbsPath;

	@Autowired
	private LSMBoardDao lsmBoardDao;

	
	//전체 리스트 
	public List<Map<String,Object>> selectLsmBoardList(Map<String, Object> paramMap) {

		List<Map<String,Object>> lsmBoardList = lsmBoardDao.selectLsmBoardList(paramMap);

		return lsmBoardList;
	}

	public int countListLsmCod(Map<String, Object> paramMap) throws Exception {

		int totalCount = lsmBoardDao.countListLsmCod(paramMap);

		return totalCount;
	}

	// 단건조회
	public Map<String,Object> selectLsmCod(Map<String, Object> paramMap) throws Exception {

		Map<String,Object> lsmCodModel = lsmBoardDao.selectLsmCod(paramMap);

		// 첨부파일 조회
		List<Map<String,Object>> listLsmFileModel = listLsmFil(paramMap);
		
		System.out.println("단건 조회");
		System.out.println(paramMap);
		System.out.println(lsmCodModel);
		System.out.println(listLsmFileModel);
		
		Map<String, Object> resultMap = new HashMap<String,Object>();
		
		resultMap.put("lsmCodModel", lsmCodModel);
		resultMap.put("listLsmFileModel", listLsmFileModel);

		return resultMap;
	}

	// 처음 생성
	public int insertLsmCod(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;

		int ret = 0;

		// task_seq , lec_seq 발번
		String lec_seq = (String) paramMap.get("lec_seq");
		System.out.println(lec_seq + "   <---- 강의번호 확인중 ");

		// task_seq 발번
		String task_seq = lsmBoardDao.selectMaxNum(paramMap);
		System.out.println(task_seq + "   <---- task _seq 확인중");
		

		// 파일저장
		String itemFilePath = bbsPath + File.separator + lec_seq + File.separator + task_seq;
		FileUtil lsmUtil = new FileUtil(multipartHttpServletRequest, rootPath, itemFilePath);
		List<FileUtilModel> listFileUtilModel = lsmUtil.uploadFiles();
		
		System.out.println(listFileUtilModel);
		

		// 데이터저장
		try {

			ret = lsmBoardDao.insertLsmCod(paramMap); // 저장

			for (FileUtilModel fileUtilModel : listFileUtilModel) {

				System.out.println(lec_seq + " 강의번호 확인중 ");

				paramMap.put("lec_seq", lec_seq);
				// 논리파일명
				paramMap.put("lgc_fil_nm", fileUtilModel.getLgc_fil_nm());
				// 물리파일명
				paramMap.put("psc_fil_nm", fileUtilModel.getPsc_fil_nm());
				// 사이즈
				paramMap.put("fil_siz", fileUtilModel.getFil_siz());
				// 확장자
				paramMap.put("fil_ets", fileUtilModel.getFil_ets());

				paramMap.put("task_seq", task_seq);
				
				ret = lsmBoardDao.saveLsmFil(paramMap);
				
				System.out.println(ret+ "   <---- save Lsm Fil 확인중");
				System.out.println(paramMap);

			}
		} catch (Exception e) {
			// 파일 삭제
			lsmUtil.deleteFiles(listFileUtilModel);
			throw e;
		}
		return ret;
	}

	// 강의번호 조회
	public List<Integer> selectLecSeq() throws Exception {

		List<Integer> lecSeqList = lsmBoardDao.selectLecSeq();

		return lecSeqList;
	}

	// 강의명 조회
	public List<String> selectLecNm() throws Exception {

		List<String> lecNmList = lsmBoardDao.selectLecNm();

		return lecNmList;
	}

	// 과제 삭제
	public int deleteLsmCod(Map<String, Object> paramMap) throws Exception {

		int ret = lsmBoardDao.deleteLsmCod(paramMap);

		return ret;
	}

	// 과제 수정
	public int updateLsmCod(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		int ret = 0;
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;

		// task_seq , lec_seq 발번
		String lec_seq = (String) paramMap.get("lec_seq");

		// task_seq 발번
		String task_seq = lsmBoardDao.selectMaxNum(paramMap);

		// 파일저장
		String itemFilePath = bbsPath + File.separator + lec_seq + File.separator + task_seq;
		FileUtil fileUtil = new FileUtil(multipartHttpServletRequest, rootPath, itemFilePath);
		List<FileUtilModel> listFileUtilModel = fileUtil.uploadFiles();

		// 데이터저장
		try {
			// 글 수정
			ret = lsmBoardDao.updateLsmCod(paramMap);

			for (FileUtilModel fileUtilModel : listFileUtilModel) {

				paramMap.put("lec_seq", lec_seq);
				// 논리파일명
				paramMap.put("lgc_fil_nm", fileUtilModel.getLgc_fil_nm());
				// 물리파일명
				paramMap.put("psc_fil_nm", fileUtilModel.getPsc_fil_nm());
				// 사이즈
				paramMap.put("fil_siz", fileUtilModel.getFil_siz());
				// 확장자
				paramMap.put("fil_ets", fileUtilModel.getFil_ets());

				paramMap.put("max_task_seq", task_seq);

				paramMap.put("fil_seq", paramMap.get("fil_seq"));
				
				System.out.println("수정단확인");

				// DB저장
				ret = lsmBoardDao.saveLsmFil(paramMap);
			}

			// 첨부파일 삭제
			String fil_seq = (String) paramMap.get("fil_seq");
			if (fil_seq != null && !"".equals(fil_seq)) {

				System.out.println("****************************" + fil_seq + " <--  fil_seq");

				List<String> listLsmSnm = new ArrayList<String>();

				StringTokenizer st = new StringTokenizer(fil_seq, ",");
				while (st.hasMoreTokens()) {
					listLsmSnm.add(st.nextToken());
				}

				System.out.println("****************************" + listLsmSnm + " <--  listLsmSnm");

				// 삭제대상 첨부파일 정보 조회
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("fil_seq", paramMap.get("fil_seq"));
				map.put("listLsmSnm", listLsmSnm);
				List<Map<String,Object>> listLsmFilModel = lsmBoardDao.listLsmFil(paramMap);

				// 파일 삭제 대상 설정
				List<FileUtilModel> listDeleteFile = new ArrayList<FileUtilModel>();
				for (Map<String,Object> lsmFilModel : listLsmFilModel) {

					FileUtilModel fileUtilModel = new FileUtilModel();
					fileUtilModel.setPsc_fil_nm((String)lsmFilModel.get("psc_fil_nm"));
					listDeleteFile.add(fileUtilModel);

				}
				paramMap.put("task_seq", task_seq);
				// DB삭제
				ret = lsmBoardDao.deleteLsmFil(map);

				// 파일삭제
				fileUtil.deleteFiles(listDeleteFile);

			}

		} catch (Exception e) {
			// 파일삭제
			fileUtil.deleteFiles(listFileUtilModel);
			throw e;
		}
		return ret;
	}

	/** 첨부 파일 저장 */
	public int saveLsmFil(Map<String, Object> paramMap) throws Exception {
		int ret = lsmBoardDao.saveLsmFil(paramMap);
		return ret;
	}

	/** 첨부 목록 조회 */
	public List<Map<String,Object>> listLsmFilModel(Map<String, Object> paramMap) throws Exception {
		List<Map<String,Object>> LsmFilModel = lsmBoardDao.listLsmFil(paramMap);
		return LsmFilModel;
	}

	public String selectMaxNum(Map<String, Object> paramMap) throws Exception {
		String ret = lsmBoardDao.selectMaxNum(paramMap);
		return ret;
	}

	/** 게시글 첨부 단건 조회 */
	public Map<String,Object> selectLsmFil(Map<String, Object> paramMap) throws Exception {
		Map<String,Object> listLsmFileModel = lsmBoardDao.selectLsmFil(paramMap);
		return listLsmFileModel;
	}

	/** 게시글 첨부 목록 조회 */
	public List<Map<String,Object>> listLsmFil(Map<String, Object> paramMap) throws Exception {
		List<Map<String,Object>> lsmFilModel = lsmBoardDao.listLsmFil(paramMap);
		System.out.println("------------------------------------------------" + lsmFilModel );
		return lsmFilModel;
	}

	/** 게시글 첨부 목록 수정 */
	public int updateLsmFile(Map<String, Object> paramMap) throws Exception {
		int ret = lsmBoardDao.updateLsmFil(paramMap);
		return ret;
	}

	/** 게시글 첨부 단건 삭제 */
	public int deleteLsmFil(Map<String, Object> paramMap) throws Exception {
		int ret = lsmBoardDao.deleteLsmCod(paramMap);
		return ret;
	}

	/** 과제 제출 목록  조회 */
	public List<Map<String,Object>> selectLsmStuList(Map<String, Object> paramMap) throws Exception {
		List<Map<String,Object>> lsmStuModel = lsmBoardDao.selectLsmStuList(paramMap);
		return lsmStuModel;
	}

	/** 과제 제출 목록 카운트 조회 */
	public int countLsmStuListCod(Map<String, Object> paramMap) throws Exception {

		int totalCount = lsmBoardDao.countLsmStuListCod(paramMap);

		return totalCount;
	}

	/** 과제 제출 파일 단건 조회 */
	public Map<String,Object> selectStuFil(Map<String, Object> paramMap) throws Exception {
		Map<String,Object> stuFilModel = lsmBoardDao.selectStuFil(paramMap);
		System.out.println("------------------------------------------------" + stuFilModel );
		return stuFilModel;
	}

}
