<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
					<div class="divEmpty">
						<div class="hiddenData">
							<span id="totcnt">${totcnt}</span>
						</div>
						<table class="col">
							<thead>
								<tr>
									<th scope="col">순번</th>
									<th scope="col">작성자</th>
									<th scope="col">작성일</th>
									<th scope="col">수정일자</th>
									<th scope="col">비고</th>
								</tr>
							</thead>
							<tbody id="tasksendDtl">
							<c:if test="${totcnt eq 0 }">
								<tr>
									<td colspan="6">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:set var="nRow" value="${pageSize*(currentPagetaskSendList-1)}" />
							<c:forEach items="${ssmInfoModel}" var="list">
								<tr>
                                	<td>${totcntTaskSendDtl - nRow}</td>
                                	<td>${list.enr_user}</td>
									<td>${list.enr_date}</td>									
									<td>${list.upd_date}</td>
									<td>
										<a class="btnType3 color1" href="javascript:fPopModalTaskSend('${list.task_seq}');"><span>수정</span></a>
 									</td> 
								</tr>
								<c:set var="nRow" value="${nRow + 1}" />
							</c:forEach>
							</tbody>
						</table>
						
					</div>
							