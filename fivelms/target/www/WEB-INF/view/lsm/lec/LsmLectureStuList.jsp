<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!---------------------학생목록 불러오기 ----------------------------->
					<div class="divEmpty">
						<div class="hiddenData">
							<span id="totalCount">${totalCount}</span>
						</div>
						<table class="col">
							<thead>
								<tr>
									<th scope="col">학생명</th>
								</tr>
							</thead>
							<tbody id="lecListDtl">
								<c:if test="${totalCount eq 0}">
									<tr>
										<td colspan="1">학생목록이 존재하지 않습니다.</td>
									</tr>
								</c:if>
								<c:set var="nRow" value="${pageSize*(currentPage-1)}" />
								<c:forEach items="${list}" var="list">
									<tr>
										<td>${list.user_id}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>				
										
									