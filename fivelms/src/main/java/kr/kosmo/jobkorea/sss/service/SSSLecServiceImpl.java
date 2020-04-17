package kr.kosmo.jobkorea.sss.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.sss.dao.SSSLecDao;




@Service
public class SSSLecServiceImpl implements SSSLecService {

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
	private SSSLecDao SssLecDao;
	
	//리스트 조회
	public List<Map<String, Object>> selectStuList(Map<String, Object> paramMap) {
		List<Map<String,Object>> list = SssLecDao.selectStuList(paramMap);
		return list;
	}
	
	//게시물개수
	public int LecDocTotalCnt(Map<String, Object> paramMap) {
		int ret = SssLecDao.LecDocTotalCnt(paramMap);
		return ret;
	}

	//단건 조회
	public Map<String, Object> selectStuDetail(Map<String, Object> paramMap) {
		return SssLecDao.selectStuDetail(paramMap);
	}

	//파일조회
	public Map<String, Object> selectSssFile(Map<String, Object> paramMap) {
		
		return SssLecDao.selectSssFile(paramMap);
	}

}