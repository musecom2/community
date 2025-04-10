<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="/community/res/css/skin/bbs/style.css">    
<script src="/community/res/js/skin/bbs/script.js" defer></script>
<c:if test="${bbs.sec == 1 }">
   <sec:authorize access="isAuthenticated()">
	   <c:if test="${bbs.userid != user.userid && user.role != 'ADMIN' }">
	      <script>
	         let pass = prompt("비밀번호를 입력하세요.");
	         if(pass){
	        	 $.post("/checkPass", { id: ${param.id}, password: pass})
	        	  .done(function(res){
	        		 if(res != "success"){
	        			 location.href="/community/board?bid=${bbs.bbsid}";  				 
	        		 }
	        	 })
	        	 .fail(function(errorThrown){
	        		 location.href="/community/board?bid=${bbs.bbsid}";
	        	 });
	         }else{
	        	 location.href="/community/board?bid=${bbs.bbsid}";
	         }
	      </script>
	   </c:if>
   </sec:authorize> 
   <sec:authorize access="!isAuthenticated()">
 	      <script>
 	        const pass = prompt("비밀번호를 입력하세요.");
	         if(pass){
	        	 $.post("./checkPass", { id: ${param.id}, password: pass, ${_csrf.parameterName}:"${_csrf.token}"})
	        	  .done(function(res){
	        		 if(res != "success"){
	        			 location.href="/community/board?bid=${bbs.bbsid}";     				 
	        		 }
	        	 })
	        	 .fail(function(errorThrown){
	        		 location.href="/community/board?bid=${bbs.bbsid}";
	        	 });
	         }else{
	        	  location.href="/community/board?bid=${bbs.bbsid}";
	         }
	      </script>  
   </sec:authorize>
</c:if>
<div class="container pt-5">
    <h1 class="text-center">${badmin.btitle }</h1>
    <p class="text-center mb-5 pb-5">spring으로 제작한 커뮤니티</p>

    <!-- design list -->
    <div class="title py-15">
        ${bbs.title }
    </div>
    <div class="d-flex border-bottom">
        <div class="col-md-6">
           <label class="d-title py-10">등록자명</label>
           ${bbs.writer }
        </div>
        <div class="col-md-6">
           <label class="d-title py-10">등록일</label>
           ${bbs.wdate }
        </div>
    </div>
    <div class="d-flex border-bottom">
         <div class="col-md-6">
            <c:if test="${badmin.category > 0 }"> 
               <label class="d-title py-10">카테고리</label> 
               ${bbs.category }
            </c:if>   
        </div>
        
        <div class="col-md-6">
           <label class="d-title py-10">조회수</label>    
           ${bbs.hit }
        </div>
               
     </div>   
     <div class="content p-50 border-bottom">
         ${bbs.content }
     </div>

     <div class="d-flex justify-content-end pt-20">
        <a href="/community/board" class="btn">목록</a>
        <c:if test="${badmin.regrade <= user.grade }">
         <a href="/community/board/rewrite?id=${bbs.id }&bid=${bbs.bbsid}" class="btn ms-10">답글쓰기</a>
        </c:if>
        <a href="/community/board/edit?id=${bbs.id}&bid=${bbs.bbsid}&mode=edit" class="btn ms-10">수정</a>
        <a href="/community/board/del?id=${bbs.id }&bid=${bbs.bbsid}&mode=del" class="btn ms-10">삭제</a>
     </div>  
   </div>
