/******** signup 폼검증 *****************/
document.getElementById("myform").addEventListener("submit", function(event){
    let isValid = true;
    //아이디 검증 (영문, 숫자 조합 3자 이상 6자이하)
    const userid = document.getElementById("userid").value;
    const useridReg = /^[a-zA-Z0-9]{3,6}$/;
    if(!useridReg.test(userid)){
       //검증실패
       document.getElementById("useridError").classList.add("input-error");
       document.getElementById("useridError").textContent = "error:아이디는 영문,숫자 조합으로 3~6자여야 합니다.";
       isValid = false;
    }else{
        document.getElementById("useridError").classList.remove("input-error"); 
       document.getElementById("useridError").textContent = "영문,숫자 조합 3~6자";
    }



    if(!isValid){
       event.preventDefault();
    }   
});
