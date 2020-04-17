<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="divEmpty">
	<div class="hiddenData">
				<span id="data">${data} </span>
				<span id = "result"> ${result }</span>
				<span id = "resultMsg"> ${resultMsg }</span>
				<span id="totalCntLsmStu">${totalCntLsmStu}</span> 
						</div>
						<table class="col">
							<thead>
								<tr>
											<th scope="col">순번</th>
											<th scope="col">강의명</th>
											<th scope="col" style="display:none">강의번호</th>
											<th scope="col">학생ID</th>
											<th scope="col">파일</th>
											<th scope="col">등록시간</th>
											<th scope="col">비고</th>
	
								</tr>
							</thead>
							<tbody id="LsmStuList">
							<c:if test="${totalCntLsmStu eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>

							<c:forEach items="${listStuCodModel}" var="list">
								<tr>
									<td>${totalCntLsmStu - nRow }</td>
									<td>${list.lec_nm }</td>
									<td style="display:none">${list.lec_seq}</td>
									<td>${list.enr_user}</td>
									<td><a href="javascript:fDownloadLsmStuFil('${list.task_seq}','${list.lec_seq}');">${list.lgc_fil_nm}</a></td>
									<td>${list.enr_date}</td>
									<td>
<%-- 									 <a class="btnType3 color1" href="javascript:fPopModalLsmCod('${list.   }','${list.   }');"><span>수정</span></a>  --%>
									 </td>
								</tr>
								<c:set var="nRow" value="${nRow + 1}" />
							</c:forEach>
							</tbody>
						</table>

</div>