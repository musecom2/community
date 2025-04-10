<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   
<style>
.passbox{
  margin:50px auto;
  width:400px;
  padding:50px;
  background:#ededed;
  border:1px solid #ddd;
  border-radius:10px;
}
</style> 
<div class="passbox">
   <p class="text-center text-danger">비밀번호를 입력해 주세요.</p>
   
   <c:choose>
      <c:when test="${param.mode eq 'edit' }">
         <form name="passform" action="community/board/edit" method="post">
      </c:when>
      <c:otherwise>
         <form name="passform" action="community/board/delete" method="post">
      </c:otherwise>
   </c:choose>
   <input type="password" name="password" class="form-control">
   <input type="hidden" name="id" value="${param.id }" />
   <input type="hidden" name="bid" value="${param.bid }" />
   <div class="mt-3 text-center">
      <a href="view?id=${param.id }" class="btn btn-dark mr-2">취 소</a>
      <button type="submit" class="btn btn-dark ml-2">수 정</button>
   </div>
   </form>
</div>