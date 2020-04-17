package kr.kosmo.jobkorea.lsm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.lsm.dao.LectureListDao;
import kr.kosmo.jobkorea.lsm.model.LectureListModel;

@Service
public class LectureListServiceImpl implements LectureListService {

	@Autowired
	LectureListDao lectureListDao;

	/** 전체 목록 조회 */
	@Override
	public List<LectureListModel> lecList(Map<String, Object> paramMap) throws Exception {
		List<LectureListModel> lecList = lectureListDao.lecList(paramMap);
		return lecList;
	}

	/** 강의목록 카운트 */
	@Override
	public int countlecList(Map<String, Object> paramMap) throws Exception {
		int totalCount = lectureListDao.countlecList(paramMap);
		return totalCount;
	}

	/** 학생 조회 */
	@Override
	public List<Map<String, Object>> selectlecDtl(Map<String, Object> paramMap) throws Exception {
		
		return lectureListDao.selectlecDtl(paramMap);
	}
}
