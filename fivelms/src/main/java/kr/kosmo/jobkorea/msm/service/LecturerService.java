package kr.kosmo.jobkorea.msm.service;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.msm.model.LectureListModel;

public interface LecturerService {

	List<LectureListModel> lectList(Map<String, Object> paramMap)throws Exception;

	List<LectureListModel> lectPeopleInfo(Map<String, Object> paramMap) throws Exception;

	List<LectureListModel> classtListAct(Map<String, Object> paramMap)throws Exception;

	public int applyForClass(Map<String, Object> paramMap) throws Exception;

}
