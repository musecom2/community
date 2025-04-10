<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
$(function(){
//아이디 중복 체크
$("#userid").on("blur", function(){
	let userid = $(this).val();
	if(userid.length > 2){
		$.ajax({
			url: "checkUserId",
			type: "GET",
			data: { userid : userid},
			success: function(res){
				if(res !== "available") {
					alert("이미 사용중인 아이디 입니다.");
					return;
				}
			}
		})
	}
});

//폼검증
function validateForm(){
	const userid=$("#userid").val();
	const email = $("#email").val();
	const name = $("#name").val();
	const password = $("#password").val();
	const repassword = $("#repassword").val();

	if(userid.length < 3) {
		alert("아이디는 3자 이상으로 하세요.");
		return false;
	}
	if(email.length < 5 || email.indexOf("@") === -1){
		alert("유효한 이메일을 입력하세요.");
		return false;
	}
	if(name.length < 2) {
		alert("이름은 2자 이상 입력하세요.");
		return false;
	}
	if(password.length<3) {
		alert("비밀번호는 3자 이상으로 하세요.");
		return false;		
	}
    if(password !== repassword){
    	alert("비밀번호가 일치하지 않습니다.");
    	return false;
    }
    return true;
}

  $("#signup").submit(function(e){
	  if(!validateForm()){
		  e.preventDefault();
	  }
  });

});

</script>

		<div class="container">
			<div class="register">
				<div class="panel-heading">
	               <div class="panel-title text-center">
	               		<h1 class="font-weight-bold dodum">SP BOARD</h1>
	               		<hr />
	               	</div>
	            </div> 
				<div class="main-login main-center">
					<form class="form-horizontal" id="signup" method="post">
						<!-- 아이디 -->
						<div class="form-group mb-4">
							<label for="name" class="cols-sm-2 control-label">아이디</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<div class="input-group-prepend">
									   <span class="input-group-text">
									     <i class="fa fa-user fa" aria-hidden="true"></i>
									   </span>									   
									</div>
									<input type="text" class="form-control" name="userid" id="userid"  placeholder="아이디..."/>
								</div>
							</div>
						</div>

						<div class="form-group mb-4">
							<label for="email" class="cols-sm-2 control-label">이메일</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<div class="input-group-prepend">
									   <span class="input-group-text"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
									</div>   
									<input type="text" class="form-control" name="email" id="email"  placeholder="이메일..."/>
								</div>
							</div>
						</div>

						<div class="form-group mb-4">
							<label for="username" class="cols-sm-2 control-label">이름</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<div class="input-group-prepend">
									   <span class="input-group-text">
									       <i class="fa fa-users fa" aria-hidden="true"></i>
									   </span>
									</div>   
									<input type="text" class="form-control" name="name" id="name"  placeholder="이름..."/>
								</div>
							</div>
						</div>

						<div class="form-group mb-4">
							<label for="password" class="cols-sm-2 control-label">비밀번호</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<div class="input-group-prepend">
									   <span class="input-group-text"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
									</div>
									<input type="password" class="form-control" name="password" id="password"  placeholder="비밀번호..."/>
								</div>
							</div>
						</div>

						<div class="form-group mb-4">
							<label for="confirm" class="cols-sm-2 control-label">비밀번호 확인</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<div class="input-group-prepend">
									   <span class="input-group-text"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
									</div>
									<input type="password" class="form-control" name="repassword" id="repassword"  placeholder="비밀번호 확인..."/>
								</div>
							</div>
						</div>

						<div class="form-group ">
							<button type="submit" class="btn btn-primary btn-lg btn-block login-button">회 원 가 입</button>
						</div>
						<div class="login-register">
				            <a href="login">Login</a>
				         </div>
					</form>
				</div>
			</div>
		</div>
