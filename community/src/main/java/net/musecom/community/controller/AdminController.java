package net.musecom.community.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.musecom.community.dto.BoardAdminDto;
import net.musecom.community.dto.BoardCategory;
import net.musecom.community.dto.Users;
import net.musecom.community.mapper.UsersMapper;
import net.musecom.community.service.BoardAdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private UsersMapper userMapper;

	@Autowired
	private BoardAdminService baService;
	
	@GetMapping("")
	public String adminForm(Model model) {
		
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        System.out.println("로그인 정보 : " + auth.getName());
        
        if(auth != null) {
        	Users user = userMapper.getUserForUserid(auth.getName());
        	model.addAttribute("user", user);
        }
                
        List<BoardAdminDto> baList = baService.getAllList();
       // System.out.println(baList.toString());
        model.addAttribute("lists", baList);
        
		return "admin.admin";
	}
	
	@PostMapping("/create")
	public String createForm(@RequestParam("btitle") String btitle) {
		baService.insertBoardAdmin(btitle);
		return "redirect:/admin";
	}
	
	@PostMapping("/delete")
	@ResponseBody
	public String delBoardAdmin(@RequestParam("id") int id) {
		int rs = baService.delBoardAdmin(id);
		String result = rs > 0? "1" : "0";
		return result;
	}
	
	@PostMapping(value="/edtBoard", consumes="application/json")
	@ResponseBody
	public ResponseEntity<String> edtBoardAdmin(@RequestBody BoardAdminDto dto) {
	    System.out.println(dto.toString());
		try {
		    //업데이트
		    baService.editBoardAdmin(dto);
		    return ResponseEntity.ok("1");
		}catch(Exception e) {
		    e.printStackTrace();
		    return ResponseEntity.ok("0");
		}
	}
	
	@PostMapping(value="/addCategory", consumes="application/json")
	@ResponseBody
	public BoardCategory addCategory(@RequestBody BoardCategory boardCategory) {
		return baService.boardCategoryInsert(boardCategory);
	}
	
	@PostMapping("/delCategory")
    @ResponseBody
    public String deleteCategory(@RequestParam("id") int id) {
		int rs = baService.boardCategoryDelete(id);
		String result = rs > 0 ? "1": "0";
		return result;
	}
	
	@PostMapping("/edtCategory")
	@ResponseBody
	public String edtCategory(@RequestBody List<BoardCategory> boardCategories) {
		int rs = 0;
		try {
			for(BoardCategory category : boardCategories) {
				rs = baService.boardCategoryUpdate(category);
			}
		}catch(Exception e) {
			    rs = 0;
		}
		String result = rs > 0 ? "1": "0";
		return result;
	}
}
