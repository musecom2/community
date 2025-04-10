document.addEventListener("DOMContentLoaded", function(){
    const selectBox = document.querySelector(".select-box");
    const selected = document.querySelector(".selected");
    const optionItems = document.querySelectorAll(".options li");
    const arrows = document.querySelector(".selected i");

    //초기화 버튼
    const resetBtn = document.getElementById("reset");

    //클릭하면 보이기 or 숨기기
    selected.addEventListener("click", ()=>{
        selectBox.classList.toggle("active");
        if(selectBox.classList.contains("active")){
           arrows.classList.replace("ri-arrow-down-s-line", "ri-arrow-up-s-line");
        }else{
           arrows.classList.replace("ri-arrow-up-s-line", "ri-arrow-down-s-line");
        }
    });

    //바깥영역을 클릭했을 때도 닫히게
    document.addEventListener("click", (e)=>{
        if(!selectBox.contains(e.target)){
           selectBox.classList.remove('active');
           arrows.classList.replace("ri-arrow-up-s-line", "ri-arrow-down-s-line");
        }
    });

    //옵션을 클릭할 때 (options가 닫히고 arrows가 원상복구되고 옵션의 텍스트가 selected에 출력됨)
    optionItems.forEach(opt => {
       opt.addEventListener("click", function(){
          const selectedValue = this.getAttribute("data-value");
          document.getElementById("option").value=selectedValue;
          selected.textContent = this.textContent;
          selectBox.classList.remove('active');
          arrows.classList.replace("ri-arrow-up-s-line", "ri-arrow-down-s-line");         
       });
    });

    //초기화 이벤트
    resetBtn.addEventListener("click", function(){
       selected.innerHTML = '--검색선택-- <i class="ri-arrow-down-s-line"></i>';
       document.getElementById("option").value = "";
       selectBox.classList.remove('active');
    });
});