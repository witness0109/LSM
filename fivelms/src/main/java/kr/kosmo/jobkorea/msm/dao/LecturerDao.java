package kr.kosmo.jobkorea.msm.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.msm.model.LectureListModel;

public interface LecturerDao {

	List<LectureListModel> lectList(Map<String, Object> paramMap);

	List<LectureListModel> lectPeopleInfo(Map<String, Object> paramMap);

	List<LectureListModel> classtListAct(Map<String, Object> paramMap);

	public int applyForClass(Map<String, Object> paramMap);

}
