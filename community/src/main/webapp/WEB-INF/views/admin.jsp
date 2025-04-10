<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<link rel="stylesheet" href="res/css/jquery-ui.min.css" />
<script src="res/js/jquery-ui.min.js"></script>
<div class="row main">
  <table class="table table-striped table-hover comtable">
     <thead>
       <tr>
         <th>번호</th>
         <th>커뮤니티이름</th>
         <th>스킨</th>
         <th>비밀글</th>
         <th>카테고리</th>
         <th>목록크기</th>
         <th>페이지크기</th>
         <th>보기권한</th>
         <th>쓰기권한</th>
         <th>파일</th>
         <th>답글</th>
         <th>코멘트</th>
         <th></th>
       </tr>
     </thead>
     <tbody>
       <c:forEach var="list" items="${lists }">
       <tr>
          <td><a href="#">${list.id }</a></td>
          <td>
             <input type="text" name="btitle" id="btitle_${list.id }" class='btitle' value="${list.btitle }">
          </td>
          <td>
             <select name="skin" id="skin_${list.id }">
                <option value="bbs">게시판형</option>
                <option value="gallery">갤러리형</option>
                <option value="article">기사형</option>
                <option value="blog">블로그형</option>
                <option value="diary">다이어리</option>
             </select>
          </td>
          <td>
              <select name="sec" id="sec_${list.id }">
                 <option value="0">사용안함</option>
                 <option value="1">사용함</option>
              </select>
          </td>
          <td>
            <select name="category" id="category_${list.id }">
               <option value="0">사용안함</option>
               <option value="1">사용함</option>
            </select>
            <c:if test="${list.category == 1 }">
            <br />
            <a href="javascript:void(0)" data-toggle="modal" data-target="#cate-${list.id }">카테고리관리</a>
            <!-- 카테고리 모달창 -->
            <div class="modal" id="cate-${list.id }">
               <div class="modal-dialog">
                   <div class="modal-content" style="padding:30;">
                       <div class="modal-body">
                           <form>
                              <input type="hidden" name="bid" id="bid" value="${list.id }">
                              <div class="input-group mb-3">
                                  <input type="text" name="categoryText" id="categoryText" class='form-control'
                                         placeholder="카테고리 이름" style="max-width:100%" />
                                         
                                   <div class="input-group-append">
                                       <button class="btn btn-danger" type="reset">취소</button>
                                       <button class="btn btn-primary addCate" type="button">등록</button>
                                   </div>      
                              </div>
                           </form>
                           <ul class="sortable" id="categoryList_${list.id }">
                           <c:if test="${not empty list.boardCategory }">
                           <form name="edtForm" action="" id="edtform_${list.id }" method="post">   
                              <c:forEach items="${list.boardCategory }" var="clist">
                                 <li class="row my-2">
                                    <div class="col-9 d-flex align-items-center">
                                      <i class="ri-expand-vertical-s-line"></i>
                                      <input type="text" name="categorytext[]" value="${clist.categoryText }"
                                             class="form-control clist">
                                      <input type="hidden" name="id[]" value="${clist.id }" />      
                                    </div>
                                    <div class="col-3">
                                       <button type="button" data-delid="${clist.id }" class="categoryDel btn btn-danger btn-sm">삭제</button>
                                    </div>
                                 </li>
                              </c:forEach>     
                           </c:if>
                           </ul>
                       </div>
                       <div class="modal-footer">
                       <c:if test="${not empty list.boardCategory }">
                           <button type="button" data-bid="${list.id }" class="categoryEdit btn btn-warning">수정</button> 
                           </form>
                        </c:if>   
                          <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                       </div> 
                   </div> 
               </div>
            </div>
            </c:if>
          </td>
          <td>
             <input type="text" name="listcount" class="count" id="listcount_${list.id }" value="${list.listcount }" />
          </td>
          <td>
             <input type="text" name="pagecount" class="count" id="pagecount_${list.id }" value="${list.pagecount }" />
          </td>
          <td>
             <select name="lgrade" id="lgrade_${list.id }">
                <option value="0">허용</option>
                <option value="1">회원(1)</option>
                <option value="2">회원(2)</option>
                <option value="3">회원(3)</option>
                <option value="99">관리자</option>
             </select>
          </td>
          <td>
             <select name="rgrade" id="rgrade_${list.id }">
                <option value="0">허용</option>
                <option value="1">회원(1)</option>
                <option value="2">회원(2)</option>
                <option value="3">회원(3)</option>
                <option value="99">관리자</option>
             </select>
          </td>
          <td>
             <select name="upload" id="upload_${list.id }">
                <option value="0">비허용</option>
                <option value="1">허용</option>
             </select>
             <!-- 업로드 허용이면 파일 새부설정 출력 -->
             <c:if test="${list.upload == 1}">
               <br />
               <a href="javascript:void(0)" data-toggle="modal" data-target="#upload-${list.id }">업로드설정</a>
             </c:if>
            <!-- 업로드 설정 모달창 -->
            <div class="modal" tabindex="-1" id="upload-${list.id }">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title">파일업로드 설정</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body p-5">
			        <form id="edtform-${list.id }" method="post">
			        <p class="text-danger">*단위: M(메가바이트)</p>
			        <label class="mt-2">파일최대크기</label>
			        <input type="hidden" name="bid"  value="${list.id }" />
			        <div class="input-group mb-3">
			           <input type="text" name="filesize"
			                  class="form-control" 
			                  placeholder="파일최대크기(단위:M)" value="${list.filesize }"/>
			                  
			        </div>
			        
			        <label class="mt-2">전체 파일최대크기</label>
			        <div class="input-group mb-3">
			           <input type="text" name="filesize" class="form-control" 
			                  placeholder="파일최대크기(단위:M)" value="${list.allfilesize }"/>
			                  
			        </div>
			        <label class="mt-2">확장자제한</label>
			        
			        <div class="input-group mb-3">
		                <label class="mr-4">
		                   <input type="radio" 
		                          name="filechar" 
		                          class="filechar" 
		                          value="0"
		                   <c:if test="${list.filechar == 0 }">checked</c:if>
		                   > 업로드모두 허용</label>
		                <label><input 
		                          type="radio" 
		                          name="filechar" 
		                          class="filechar" 
		                          value="1"
		                          <c:if test="${list.filechar == 1 }">checked</c:if>
		                          > 이미지전용</label>
	                </div>
	                
	                <div class="thumbnail">
	                   <label class="mt-2">기본 썸네일크기</label>
	                   <input type="text" name="thimgsize" value="${list.thimgsize }">
	                </div>
			        </form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			        <button type="button" class="btn btn-primary">Save changes</button>
			      </div>
			    </div>
			  </div>
             </div>
            
          </td>
          <td>
             <select name="regrade" id="regrade_${list.id }">
                <option value="-1">비허용</option>
                <option value="0">허용</option>
                <option value="1">회원(1)</option>
                <option value="2">회원(2)</option>
                <option value="3">회원(3)</option>
                <option value="99">관리자</option>
             </select>
          </td>
          <td>
             <select name="cgrade" id="cgrade_${list.id }">
                <option value="-1">비허용</option>
                <option value="0">허용</option>
                <option value="1">회원(1)</option>
                <option value="2">회원(2)</option>
                <option value="3">회원(3)</option>
                <option value="99">관리자</option>
             </select>
          </td>
          <td>
             <button type="button" data-id="${list.id }" class="edit btn btn-warning">수정</button>
          <c:if test="${not empty lists && list.id != 1 }">   
             <button type="button" data-id="${list.id }" class="del btn btn-danger">삭제</button>
          </c:if>   
          </td>
       </tr>  
       <input type="hidden" id="fgrade_${list.id }" value="${list.fgrade }" />  
       <input type="hidden" id="fdgrade_${list.id }" value="${list.fdgrade }" />  
       <input type="hidden" id="filesize_${list.id }" value="${list.filesize }" />  
       <input type="hidden" id="allfilesize_${list.id }" value="${list.allfilesize }" />  
       <input type="hidden" id="thimgsize_${list.id }" value="${list.thimgsize }" />  
       <input type="hidden" id="filechar_${list.id }" value="${list.filechar }" />     
       </c:forEach>
     </tbody>
  </table>
  <div class="my-4 text-right w-100">
      <button class="btn btn-primary comcreate" data-toggle="modal" data-target="#mkcom">커뮤니티 등록</button>
  </div>
</div>

<!-- 커뮤니티 등록 모달 -->
          <div class="modal" tabindex="-1" id="mkcom">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h3 class="modal-title">커뮤니티 등록</h3>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body p-5">
			        <form id="mkcomForm" action="./admin/create" method="post">
			        <label class="mt-2">커뮤니티이름</label>
			        <div class="input-group mb-3">
			           <input type="text" name="btitle"
			                  class="form-control" 
			                  placeholder="커뮤니티이름"/>
			        </div>
			        <div class="text-center">
			           <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			           <button type="reset" class="btn btn-warning">취소</button>
			           <button type="submit" class="btn btn-primary">등록</button>
			        </div>        
			        </form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			        
			      </div>
			    </div>
			  </div>
             </div>

<script>
$(function(){
	<c:forEach var="list" items="${lists }">
	  $("#skin_${list.id}").val('${list.skin}').trigger('change');
	  $("#category_${list.id}").val("${list.category}").trigger('change');
      $("#lgrade_${list.id}").val("${list.lgrade}").trigger('change');
      $("#rgrade_${list.id}").val("${list.rgrade}").trigger('change');
      $("#upload_${list.id}").val("${list.upload}").trigger('change');
      $("#regrade_${list.id}").val("${list.regrade}").trigger('change');
      $("#cgrade_${list.id}").val("${list.cgrade}").trigger('change');
      $("#sec_${list.id}").val("${list.sec}").trigger('change');
	</c:forEach>
	
	$(".del").click(function(){
		if(confirm("정말로 삭제하시겠습니까? 삭제하면 복구가 불가능 합니다.")){
		   const delid = $(this).data("id");
		   $.post("admin/delete?${_csrf.parameterName}=${_csrf.token}&id="+delid, function(data){
				  if(data){
					  alert("삭제되었습니다.");
					  location.reload(true);
				  }else{
					  alert("문제가 발생했습니다.");
			      } 
		   });
		}
	});
	
	$(".edit").click(function(){
		const id = $(this).data("id");
		const btitle = $("#btitle_"+id).val();
		const skin = $("#skin_"+id).val();
		const category = $("#category_"+id).val();
		const listcount = $("#listcount_"+id).val();
		const pagecount = $("#pagecount_"+id).val();
		const lgrade = $("#lgrade_"+id).val();
		const rgrade = $("#rgrade_"+id).val();
		const upload = $("#upload_"+id).val();
		const regrade = $("#regrade_"+id).val();
		const cgrade = $("#cgrade_"+id).val();
		const fgrade = $("#fgrade_"+id).val();
		const fdgrade = $("#fdgrade_"+id).val();
		const filesize = $("#filesize_"+id).val();
		const allfilesize = $("#allfilesize_"+id).val();
		const thimgsize = $("#thimgsize_"+id).val();
		const filechar = $("#filechar_"+id).val();
		const sec = $("#sec_"+id).val();
			
			
		$.ajax({
			url: "admin/edtBoard",
			method: "post",
			contentType: 'application/json; charset=UTF-8',
			headers: { "X-CSRF-TOKEN": "${_csrf.token}"},
			data: JSON.stringify({
				id,btitle,skin,category,listcount,pagecount,lgrade,rgrade,upload,regrade,cgrade,
				fgrade, fdgrade, filesize, allfilesize, thimgsize, filechar, sec
			}),
			success: function(rs){
				if(rs == 1){
					alert("수정이 완료 되었습니다.");
					location.reload(true);
				}else{
					alert("문제가 발생했습니다.");
				}
			},
			error: function(error){
				alert("문제가 발생했습니다. " + error);
			}
		})
	});

	//sortable
    $("[id^='categoryList']").sortable({
    	items: "li"
    });
		
	//카테고리 등록
	$(".addCate").click(function(){
		const form = $(this).closest("form");
	    const bid = form.find("#bid").val();
	    const categoryText = form.find("#categoryText").val();
	    const data = { bid, categoryText };
	    $.ajax({
	    	type: "POST",
	    	contentType: "application/json;charset=utf-8",
	    	url: "admin/addCategory",
	    	headers: { "X-CSRF-TOKEN": "${_csrf.token}"},
	    	data: JSON.stringify(data),
	    	success: function(dto){
	    	  if(dto && dto.id != ""){
	    		  alert("카테고리가 등록되었습니다.");
	    		  let ct = '<li class="row my-2">' +
                           '<div class="col-9">' +
                           '<input type="text" name="categorytext[]" value="'+dto.categoryText+'"'+
                           'class="form-control clist">'+
                           '</div>'+
                           '<div class="col-3">'+
                           '<button type="button" data-delid="'+dto.id+'" class="categoryDel btn btn-danger btn-sm">삭제</button>'+
                           '</div>'+
                           '</li>';
                  $('#categoryList_'+bid).append(ct);
	    	  }else{
	    		  alert("문제가 발생했습니다.");
	    	  }	
	    	},
	    	error: function(error){
	    		alert("문제가 발생했습니다." + error);
	    	}
	    });
	});
	
	//카테고리 삭제
	$(document).on("click", ".categoryDel", function(){
		const delid = $(this).data("delid");
		if(confirm("정말로 삭제하시겠습니까?")){
		   if(delid){
			   const li = $(this).closest("li");
			   $.post("admin/delCategory?${_csrf.parameterName}=${_csrf.token}&id="+delid, function(data){
				  if(data){alert("삭제되었습니다.");}else{alert("문제가 발생했습니다.");} 
			   });
			   li.remove(); 
		   }else{
			   alert("문제가 발생했습니다.");
		   }	
		}
	});
	
	//카테고리 수정
	$('.categoryEdit').click(function(){
		const bid = $(this).data("bid");
		let formData = [];
		let categoryText, id;
		//.sortable로 변경된 순서를 li 루프를 돌리면서 순서값으로 등록
		$("ul.sortable#categoryList_"+bid+' li').each(function(index){
			categoryText = $(this).find("input[name='categorytext[]']").val();
			id = $(this).find("input[name='id[]']").val();
			formData.push({
				id,
				bid,
				categoryText,
				categoryNum : index + 1
			});
		});
		
		$.ajax({
			type:"POST",
			url:"admin/edtCategory",
	    	contentType: "application/json;charset=utf-8",
	    	headers: { "X-CSRF-TOKEN": "${_csrf.token}"},
	    	data: JSON.stringify(formData),
	    	success: function(data){
	    		if(data == 1){
	    			alert("카테고리가 수정되었습니다.");
	    		}else{
	    			alert("문제가 발생했습니다.");
	    		}
	    	},
	    	error: function(error){
	    		alert("에러가 발생했습니다." + error);
	    	}
		});
		
 	});
	
	/*
    $('.filechar').each(function(){

    	if($(this).val() == 1 && $(this).is(':checked')){
    
    	}
    })
	*/
});
</script>