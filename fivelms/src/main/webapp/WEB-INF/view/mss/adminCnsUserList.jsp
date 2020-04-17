<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
					<div class="divEmpty">
						<div class="hiddenData">
							  <span id="totalCntlist">${totalCntlist}</span>
						</div>
						<table class="col">
							<thead>
								<tr>
									<th scope="col">과정명</th>
									<th scope="col">이름</th>
									<th scope="col">주소</th>
									<th scope="col">이메일</th>
									<th scope="col">비고</th>
								</tr>
							</thead>
							<tbody id="cnsUserDtlList">
							<c:if test="${totalCntlist eq 0 }">
								<tr>
									<td colspan="12">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:set var="nRow" value="${pageSize*(currentPagelist-1)}" />
							<c:forEach items="${userList}" var="list">
								<tr>
									<td>${list.lec_nm}</td>
									<td><a href="javascript:fPopModalUserList('${list.loginID }','${list.lec_nm }')">${list.loginID}</a></td>
									<td>${list.user_addr}</td>
									<td>${list.user_email}</td>
									<c:choose>
										<c:when test="${list.cns_cstee eq '' || list.cns_cstee eq null}">
											<td>
											<a class="btnType blue" href="javascript:fPopModalUserList('${list.loginID }','${list.lec_nm }');"	name="modal"><span>상담등록</span></a>
											</td>
										</c:when>
										<c:otherwise>
											<td>
											<a href="javascript:fPopModalUserList('${list.cns_seq }','${list.loginID }','${list.lec_nm }');" name="modal" style="color: red;">상담 완료!</a>
											</td>
										</c:otherwise>
									</c:choose>
								</tr>
								<c:set var="nRow" value="${nRow + 1}" />
							</c:forEach>
							</tbody>
						</table>
					</div>