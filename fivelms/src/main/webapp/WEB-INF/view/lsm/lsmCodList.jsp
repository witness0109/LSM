<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
					<div class="divEmpty">
						<div class="hiddenData">
						<span id="totalCntLsmCod">${totalCntLsmCod}</span> 
						<span id="lecSeq">${lecSeq}</span> 
						<span id="lecNm">${lecNm}</span> 
						<span id="fil_seq">${fil_seq }</span>
						</div>
						<table class="col">
							<thead>
								<tr>
											<th scope="col">순번</th>
											<th scope="col">과제번호</th>
											<th scope="col" style="display:none">강의번호</th>
											<th scope="col">강의명</th>
											<th scope="col">과제명</th>
											<th scope="col">강사명</th>
											<th scope="col">등록시간</th>
											<th scope="col">비고</th>
	
								</tr>
							</thead>
							<tbody id="listLsmCod">
							<c:if test="${totalCntLsmCod eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:set var="nRow" value="${pageSize*(currentPageLsmCod-1)}" />
							<c:forEach items="${listLsmCodModel}" var="list">
								<tr>
									<td>${totalCntLsmCod - nRow}</td>
									<td>${list.task_seq}</td>
									<td style="display:none">${list.lec_seq}</td>
									<td><a href="javascript:fStuLsmCod('${list.task_seq}','${list.lec_seq}');">${list.lec_nm}</a></td>
									<td>${list.task_nm}</td>
									<td>${list.enr_user}</td>
									<td>${list.enr_date}</td>
									<td>
									 <a class="btnType3 color1" href="javascript:fPopModalLsmCod('${list.task_seq}','${list.lec_seq}');"><span>수정</span></a> 
									 </td>
								</tr>
								<c:set var="nRow" value="${nRow + 1}" />
							</c:forEach>
							</tbody>
						</table>
					</div>