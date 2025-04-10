<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="/community/res/css/skin/bbs/style.css">    
<script src="/community/res/js/skin/bbs/script.js" defer></script>
<c:set var="nowMills" value="<%=System.currentTimeMillis() %>" />

<c:if test="${not empty message }">
   <script>
     alert("${message}");
   </script>
</c:if>

<c:if test="${badmin.lgrade > 0 }">
   <sec:authorize access="!isAuthenticated()">
     <script>
       alert("회원전용 게시판 입니다. 로그인 하세요.");
       location.href="/community";
     </script>
   </sec:authorize>
   <c:if test="${badmin.lgrade > user.grade }">
      <script>
        alert("이 게시판을 볼 권한이 없습니다.");
        location.href="/community";
      </script>   
   </c:if>
</c:if>
<div class="container pt-5">
    <h1 class="text-center">자유게시판</h1>
    <p class="text-center mb-5 pb-5">jsp + servlet으로 디자인 할 자유 게시판입니다.</p>

    <!-- design list -->
    <div class="search-box">
        <form name="search-form" method="get" class="d-flex justify-content-center">
            <div class="select-box">
               <div class="selected">--검색선택-- <i class="ri-arrow-down-s-line"></i> </div>
               <ul class="options">
                  <li data-value="author">이름검색</li>
                  <li data-value="title">제목검색</li>
                  <li data-value="content">내용검색</li>
               </ul>
            </div>    
            <input type="search" class="search-input" placeholder="검색...">
            <input type="hidden" id="option" name="option">
            <button type="submit" class="btn-search">검색</button>
            <button type="reset" class="btn-search" id="reset">초기화</button>
        </form>
    </div>    
    <div class="d-flex justify-content-between pb-2">
        <div class="init-text d-flex">
            <div class="all-text"><i class="ri-file-list-line"></i> 총 글수<span>123</span>건</div>
            <div class="now-text">현재 페이지<span>1/12</span></div>
        </div>
        <div class="sortting">
            <span>페이지당 목록</span>
            <select class="list-ct">
               <option value="10">10</option>
               <option value="20">20</option>
               <option value="30">30</option>
            </select>
        </div>
    </div>
    <table class="list-table">
        <colgroup>
           <col width="5%">
           <col>
           <col width="10%">
           <col width="10%">
           <col width="10%">
        </colgroup>
        <thead>
           <tr>
              <th>번호</th>
              <th>제목</th>
              <th>글쓴이</th>
              <th>날짜</th>
              <th>조회수</th>
           </tr>
        </thead>   
        <tbody>
           <!-- 루프 -->
           <c:forEach var="list" items="${lists }" varStatus="status">
            <c:set var="difMill" value="${nowMills - list.wdate.time }" />
           <tr>
             <td class="text-center">${list.id }</td>
             <td>
             <c:choose>
              <c:when test="${badmin.vgrade > user.grade }">
                 ${list.title } 
              </c:when>
              <c:otherwise>
                 <!-- 비밀글 처리를 위한 조건 -->
                 <c:choose>
                    <c:when test="${list.sec == 0 }">
                       <a href="board/view?id=${list.id }">${list.title }</a>
                    </c:when>
                    <c:otherwise>
                       <i class="ri-lock-fill"></i> 
                       <a href="board/view?id=${list.id }">${list.title } </a>
                     </c:otherwise>
                  </c:choose>          
              </c:otherwise>
             </c:choose>                  
             </td>
             <td class="text-center">${list.writer }</td>
             <td class="text-center">
                <c:choose>
                   <c:when test="${difMill < 86400000 }"><%-- 24시간 이내 --%>
                      <fmt:formatDate value="${list.wdate }" pattern="HH:mm" />
                   </c:when>
                   <c:otherwise>
                      <fmt:formatDate value="${list.wdate }" pattern="yyyy.MM.dd" />
                   </c:otherwise>
                </c:choose>               
             </td>
             <td class="text-center">${list.hit }</td>
           </tr> 
           </c:forEach>
          <!-- /루프-->
        </tbody> 
    </table>
    <div class="d-flex justify-content-end mt-4">
        <c:if test="${badmin.rgrade <= user.grade || badmin.rgrade == 0}">
           <a href="board/write?bid=${badmin.id }" class="btn">글쓰기</a>
        </c:if>   
    </div>
    <ul class="paging">
       <li><a href="#" class="first"><i class="ri-arrow-left-double-line"></i></a></li> 
       <li><a href="#" class="prev"><i class="ri-arrow-left-s-line"></i></a></li>
       <li><a href="#" class="act">1</a></li>
       <li><a href="#">2</a></li>
       <li><a href="#">3</a></li>
       <li><a href="#">4</a></li>
       <li><a href="#">5</a></li>
       <li><a href="#" class="next"><i class="ri-arrow-right-s-line"></i></a></li> 
       <li><a href="#" class="last"><i class="ri-arrow-right-double-line"></i></a></li>
    </ul>
    <!-- / design list-->
</div>
<script>
$(function(){
	$('.pss').click(function(e){
	   e.preventDefault();
	   const pss = prompt("비밀번호를 입력하세요.");
	   const id = $(this).data("id");
	   $.post("listpass", { id , pss }, function(rs){
		  if(rs == 1){
			  location.href="view?id="+id;
		  } 
	   });
	});
});
</script>
