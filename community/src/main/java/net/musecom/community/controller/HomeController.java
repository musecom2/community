package net.musecom.community.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import net.musecom.community.dto.BoardAdminDto;
import net.musecom.community.dto.Users;
import net.musecom.community.mapper.UsersMapper;
import net.musecom.community.service.BoardAdminService;

@Controller
public class HomeController {
	
	@Autowired
	private UsersMapper userMapper;
	
	@Autowired
	private BoardAdminService baService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        System.out.println("로그인 정보 : " + auth.getName());
        
        if(auth != null) {
        	Users user = userMapper.getUserForUserid(auth.getName());
        	model.addAttribute("user", user);
        }
        
        List<BoardAdminDto> baList = baService.getAllList();
       // System.out.println(baList.toString());
        model.addAttribute("baLists", baList);
        
		return "main.home";
	}
	
	
	@GetMapping("/login")
	public String loginForm(@RequestParam(value="error", required=false) String error, Model model) {
		if(error != null)  model.addAttribute("errorMessage", "아이디 또는 비밀번호가 틀렸습니다.");
        List<BoardAdminDto> baList = baService.getAllList();
       // System.out.println(baList.toString());
        model.addAttribute("baLists", baList);
		return "main.login";
	}
	
	@GetMapping("/register")
	public String RegisterForm(Model model) {
        List<BoardAdminDto> baList = baService.getAllList();
       // System.out.println(baList.toString());
        model.addAttribute("baLists", baList);
		return "main.register";
	}
	
	/** 이 부분은 직접 작업해 보세요 **/
	@PostMapping("/register")
	public String Register() {
		return "redirect: /";
	}
	
}
