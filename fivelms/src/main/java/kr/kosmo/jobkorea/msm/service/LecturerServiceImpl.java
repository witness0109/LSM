package kr.kosmo.jobkorea.msm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.common.comnUtils.FileUtilModel;
import kr.kosmo.jobkorea.msm.dao.LecturerDao;
import kr.kosmo.jobkorea.msm.model.LectureListModel;

@Service
public class LecturerServiceImpl implements LecturerService{

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// Get class name for logger
	private final String className = this.getClass().toString();

	
	@Autowired
	LecturerDao lecturerDao;
	
	@Override
	public List<LectureListModel> lectList(Map<String, Object> paramMap) {
		System.out.println("임플확인1");
		 List<LectureListModel> lectList = lecturerDao.lectList(paramMap);
		 System.out.println("임플확인2");
		return lectList;
	}

	@Override
	public List<LectureListModel> lectPeopleInfo(Map<String, Object> paramMap) throws Exception {
		System.out.println("임플확인1");
		 List<LectureListModel> lectPeopleInfo = lecturerDao.lectPeopleInfo(paramMap);
		 System.out.println("임플확인2");
		return lectPeopleInfo;
	}

	@Override
	public List<LectureListModel> classtListAct(Map<String, Object> paramMap) throws Exception {
		System.out.println("임플확인1");
		 List<LectureListModel> classtListAct = lecturerDao.classtListAct(paramMap);
		 System.out.println("임플확인2");
		return classtListAct;
	}

	@Override
	public int applyForClass(Map<String, Object> paramMap) throws Exception {
		int ret = 0;
		try {	
				ret = lecturerDao.applyForClass(paramMap); 
		} catch(Exception e) {
			throw e;
		}
		return ret;
	}

}
