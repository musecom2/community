<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    <form action="./login" id="loginForm" method="post">
       <table>
          <tr>
             <td>아이디 :</td>
             <td>
                <input type="text" name="userid" class="form-control" id="userid" placeholder="아이디" />
             </td>
          </tr>
          <tr>
             <td>비밀번호 :</td>
             <td>
                <input type="password" name="userpass" class="form-control" id="userpass" placeholder="비밀번호" />
             </td>
          </tr>
          <tr>
             <td colspan="2">
               <div class="text-right mb-2">
                  <label><input type="checkbox" name="ok" value="ok"> 자동 로그인</label>
               </div>
               <div class="text-center">
                   <sec:csrfInput />
                   <input type="submit" value=" 로 그 인 " />
               </div>
             </td>
          </tr>
       </table>
    </form>