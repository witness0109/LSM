package kr.kosmo.jobkorea.ssm.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.kosmo.jobkorea.common.comnUtils.FileUtil;
import kr.kosmo.jobkorea.common.comnUtils.FileUtilModel;
import kr.kosmo.jobkorea.ssm.dao.SsmDao;
import kr.kosmo.jobkorea.ssm.model.SsmInfoModel;
import kr.kosmo.jobkorea.ssm.model.SsmLectureModel;

@Service
public class SsmServiceImpl implements SsmService {

	@Autowired
	SsmDao ssmDao;
	@Value("${fileUpload.rootPath}")
	private String rootPath;

	@Value("${fileUpload.bbsPath}")
	private String bbsPath;

	/** 과제제출 목록 조회 */
	@Override
	public List<SsmInfoModel> listTaskSend(Map<String, Object> paramMap) throws Exception {

		return ssmDao.listTaskSend(paramMap);
	}

	/** 과제제출 전체 총 건수 */
	@Override
	public int countListSsm(Map<String, Object> paramMap) throws Exception {

		return ssmDao.countListSsm(paramMap);
	}

	/** 과제제출 단건 조회 */
	@Override
	public SsmInfoModel selectTaskSend(Map<String, Object> paramMap) throws Exception {

		SsmInfoModel ssmInfoModel = ssmDao.selectTaskSend(paramMap);

		return ssmInfoModel;
	}

	/** 과제제출 저장 */
	@Override
	public int insertTaskSend(Map<String, Object> paramMap) throws Exception {

		int ret = ssmDao.insertTaskSend(paramMap);

		return ret;

	}

	/** 과제제출 수정 */
	@Override
	public int updateTaskSend(Map<String, Object> paramMap) throws Exception {

		int ret = ssmDao.updateTaskSend(paramMap);

		return ret;

	}

	/** 과제제출 삭제 */
	@Override
	public int deleteTaskSend(Map<String, Object> paramMap) throws Exception {

		int ret = ssmDao.deleteTaskSend(paramMap);

		return ret;
	}

	// 생성
	public int insertTaskSend(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;

		int ret = 0;

		// task_seq, lec_seq 발번
		String lec_seq = (String) paramMap.get("lec_seq");

		// task_seq 발번
		String task_seq = ssmDao.selectMaxNum(paramMap);

		// 파일저장
		String itemFilePath = bbsPath + File.separator + lec_seq + File.separator + task_seq;
		FileUtil ssmUtil = new FileUtil(multipartHttpServletRequest, rootPath, itemFilePath);
		List<FileUtilModel> listFileUtilModel = ssmUtil.uploadFiles();

		// 데이터저장
		try {

			ret = ssmDao.insertTaskSend(paramMap);

			for (FileUtilModel fileUtilModel : listFileUtilModel) {

				// 논리파일명
				paramMap.put("lec_seq", lec_seq);
				// 물리파일명
				paramMap.put("psc_fil_nm", fileUtilModel.getPsc_fil_nm());
				// 사이즈
				paramMap.put("fil_siz", fileUtilModel.getFil_siz());
				// 확장자
				paramMap.put("fil_ets", fileUtilModel.getFil_ets());

				paramMap.put("max_task_seq", task_seq);

				ret = ssmDao.saveSsmFil(paramMap);

			}
		} catch (Exception e) {

			ssmUtil.deleteFiles(listFileUtilModel);
			throw e;
		}
		return ret;
	}

	/** 첨부파일 저장 */
	public int saveSsmFil(Map<String, Object> paramMap) throws Exception {

		int ret = ssmDao.saveSsmFil(paramMap);

		return ret;
	}

	/** 과제 상세목록 조회 */
	public List<SsmInfoModel> taskSendDtl(Map<String, Object> paramMap) throws Exception {

		List<SsmInfoModel> taskSendDtl = ssmDao.taskSendDtl(paramMap);

		return taskSendDtl;
	}

	/* 수강 목록 조회 */
	@Override
	public List<SsmLectureModel> lectureList(Map<String, Object> paramMap) {
		List<SsmLectureModel> lectureList = ssmDao.lectureList(paramMap);
		return lectureList;
	}

	/* 수강목록 카운트 조회 */
	@Override
	public int countLecList(Map<String, Object> paramMap) {
		int totalCount = ssmDao.countLecList(paramMap);
		return totalCount;
	}
	/* 수강목록단건상세조회 */

	@Override
	public Map<String, Object> selectLecDet(Map<String, Object> paramMap) {
		return ssmDao.selectLecDet(paramMap);
	}

}
