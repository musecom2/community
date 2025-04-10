<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

	<div class="panel panel-default p-4 mr-2">
	  	<div class="panel-body p-1">
	  	    <sec:authorize access="isAuthenticated()">
	  	       <sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_ADMIN')">
	  	          <h3 class="text-center">${user.username }님 </h3>
	  	          <div class="text-center">
	  	          <a href="#">my page</a>
	  	       </sec:authorize>
	  	       <sec:authorize access="hasRole('ROLE_ADMIN')">
	  	          | <a href="/community/admin">관리자모드</a> 
	  	       </sec:authorize>
	  	          </div> 
	  	       <p class="text-center"><a href="/community/logout">로그아웃</a></p>
	  	    </sec:authorize>
	  	    <sec:authorize access="!isAuthenticated()">
			 <form accept-charset="UTF-8" action="/community/login" method="post" role="form">
                    <fieldset>
			    	  	<div class="form-group">
			    		    <input class="form-control" placeholder="아이디" name="userid" type="text">
			    		</div>
			    		<div class="form-group">
			    			<input class="form-control" placeholder="비밀번호" name="userpass" type="password" value="">
			    		</div>
			    		<div class="checkbox">
			    	    	<label>
			    	    		<input name="remember" type="checkbox" value="ok"> 자동로그인
			    	    	</label>
			    	    </div>
			    		<input class="btn btn-lg btn-dark btn-block" type="submit" value="로그인">
			    		<sec:csrfInput />
			    	</fieldset>
			  </form>
			 </sec:authorize> 
 		 </div>
	</div>
	<ul class='list-group list-group-flush mt-5 mb-5'>
	  <c:forEach var="blist" items="${baLists}">
	   <li class="list-group-item d-flex justify-content-between align-items-center">
	      <a href="/community/board?bid=${blist.id }">${blist.btitle }</a> 
	      <span class="badge badge-primary badge-pill">${blist.bbsCount }</span>
	   </li>
	  </c:forEach>    	   
	</ul>