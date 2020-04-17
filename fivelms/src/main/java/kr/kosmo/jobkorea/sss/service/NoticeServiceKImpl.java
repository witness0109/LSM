package kr.kosmo.jobkorea.sss.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.sss.dao.NoticeKDao;
import kr.kosmo.jobkorea.sss.model.NoticeKModel;



@Service
public class NoticeServiceKImpl implements NoticeServiceK {

	@Autowired
	NoticeKDao noticeDao;

	/** 공지사항 목록 조회 */
	@Override
	public List<NoticeKModel> noticeList(Map<String, Object> paramMap) throws Exception {
		
		System.out.println("searchkey , searchword : "+paramMap.get("searchkey")+", "+paramMap.get("searchword")
							+paramMap.toString());
		
		return noticeDao.noticeList(paramMap);
	}

	
	/** 공지사항 목록 카운트 조회 */
	@Override
	public int countListNotice(Map<String, Object> paramMap) throws Exception {
		
		return noticeDao.countListNotice(paramMap);
	}

	
	/** 공지사항 단건 조회 */
	@Override
	public NoticeKModel selectNotice(Map<String, Object> paramMap) throws Exception {
		
		return noticeDao.selectNotice(paramMap);
	}

	
	/** 공지사항 저장 */
	@Override
	public int insertNotice(Map<String, Object> paramMap) throws Exception {
		int ret = noticeDao.insertNotice(paramMap);
		return ret;
	}
	
	
	/** 공지사항 수정 */
	@Override
	public int updateNotice(Map<String, Object> paramMap) throws Exception {
		int ret= noticeDao.updateNotice(paramMap);
		return ret;
	}
	
	
	/** 공지사항 삭제 */
	@Override
	public int deleteNotice(Map<String, Object> paramMap) throws Exception {
		int ret = noticeDao.deleteNotice(paramMap);
		return ret;
	}

	/*@Override
	public int countNoticeList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}*/
	
	

}
