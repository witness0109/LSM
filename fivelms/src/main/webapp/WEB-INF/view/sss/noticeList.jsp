<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ftm" uri="http://java.sun.com/jsp/jstl/fmt" %>
					
					<div class="divEmpty">
						<div class="hiddenData">
							<span id="totalCountList">${totalCountList}</span>
						</div>
						<table class="col">
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">작성일</th>
									<th scope="col">파일</th>
									<th scope="col">조회수</th>
								</tr>
							</thead>
							<tbody id="listNotice">
							<c:if test="${totalList eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:set var="nRow" value="${pageSize*(currentPageNoticeList-1)+1}" />
							<c:forEach items="${noticeListModel}" var="list">
								<tr>
								<!--  -->
									<td>${nRow}</td>
									<td><a href="javascript:fSelectNotice('${list.nt_title}' ,'${list.enr_user}', 
															'${list.nt_cnt}', '${list.nt_contents}',
															'<ftm:formatDate value="${list.enr_date}" pattern="YYYY-MM-dd"/>',
															'${list.file_nm}'
															,'${list.file_size}')">${list.nt_title}</a></td>
									<td>${list.enr_user}</td>
									<td><ftm:formatDate value="${list.enr_date}" pattern="YYYY-MM-dd"/></td>
									<td>${list.file_nm}</td>
									<td>${list.nt_cnt}</td>
								</tr>
								<c:set var="nRow" value="${nRow + 1}" />
							</c:forEach>
							</tbody>
						</table>
					</div>
							