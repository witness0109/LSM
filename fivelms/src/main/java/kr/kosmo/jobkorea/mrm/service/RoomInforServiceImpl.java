package kr.kosmo.jobkorea.mrm.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.kosmo.jobkorea.common.comnUtils.FileUtil;
import kr.kosmo.jobkorea.common.comnUtils.FileUtilModel;
import kr.kosmo.jobkorea.mrm.dao.RoomInfoDao;
import kr.kosmo.jobkorea.mrm.model.RoomInfoModel;
import kr.kosmo.jobkorea.supportD.model.NoticeDModel;

@Service
public class RoomInforServiceImpl implements RoomInfoService{

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// Get class name for logger
	private final String className = this.getClass().toString();

	// Root path for file upload
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	// comment path for file upload
	@Value("${fileUpload.roomimage}")
	private String roomimage;
	
	@Autowired
	RoomInfoDao roomInfoDao;

	@Override
	public List<RoomInfoModel> roomList(Map<String, Object> paramMap) {
		List<RoomInfoModel> roomList = roomInfoDao.roomList(paramMap);
		return roomList;
	}
	
	// 게시글 저장
	@Override
	public int insertRoomInfo(Map<String, Object> paramMap, HttpServletRequest  request) throws Exception {
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

		int ret = 0;
		String action = (String) paramMap.get("action");
		// 파일 저장
		String itemFilePath = roomimage + File.separator;
		FileUtil fileUtil = new FileUtil(multipartHttpServletRequest, rootPath, itemFilePath);
		List<FileUtilModel> listFileUtilModel = fileUtil.uploadFiles();
		System.out.println("action imple : " + action);
		// 데이터 저장
		try {			
			for (FileUtilModel fileUtilModel : listFileUtilModel){
				
				//논리파일명
				paramMap.put("lgc_rm_nm", fileUtilModel.getLgc_fil_nm());
				//물리파일명
				//paramMap.put("psc_rm_nm",  rootPath + fileUtilModel.getPsc_fil_nm());
				paramMap.put("psc_rm_nm",  fileUtilModel.getPsc_fil_nm());
				//사이즈
				paramMap.put("rmPic_size", fileUtilModel.getFil_siz());
				
				if(action.equals("I")) {
				//DB에 저장
				ret = roomInfoDao.insertRoomInfo(paramMap); // 저장
				} else if (action.equals("U")) {
					
				ret = roomInfoDao.updateRoomInfo(paramMap); // 업데이트	
				}
			}  
			
			
		} catch(Exception e) {
			//파일 삭제
			fileUtil.deleteFiles(listFileUtilModel);
			throw e;
		}
		return ret;
	}

	@Override
	public int reviseRoomInfo(Map<String, Object> paramMap, HttpServletRequest request) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int RTotalCnt(Map<String, Object> paramMap) {
		int RTotalCnt = roomInfoDao.RTotalCnt(paramMap);
		return RTotalCnt;
	}

	@Override
	public List<RoomInfoModel> itemListVue(Map<String, Object> paramMap) {
		List<RoomInfoModel> itemListVue = roomInfoDao.itemListVue(paramMap);
		return itemListVue;
	}
	
	// 강의실 정보 삭제 ( Y->N)
	@Override
	public void roomDelete(Map<String, Object> paramMap) {
		roomInfoDao.roomDelete(paramMap);
		
	}
	
	// 장비 수정
	@Override
	public void itemUpdate(Map<String, Object> paramMap) {
		roomInfoDao.itemUpdate(paramMap);
	}

	// 장비 삭제
	@Override
	public void itemDeleteVue(Map<String, Object> paramMap) {
		roomInfoDao.itemDeleteVue(paramMap);
		
	}

	@Override
	public int itemInsert(Map<String, Object> paramMap) throws Exception {
		int result = 0;
		result = roomInfoDao.itemInsert(paramMap);
		return result;
	}

	@Override
	public RoomInfoModel simpleInfo(Map<String, Object> paramMap) {
		RoomInfoModel simpleInfo=roomInfoDao.simpleInfo(paramMap);
			return simpleInfo;
	}

	


	

}
