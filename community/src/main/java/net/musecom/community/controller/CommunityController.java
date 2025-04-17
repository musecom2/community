package net.musecom.community.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.github.pagehelper.PageInfo;

import net.musecom.community.dto.BoardAdminDto;
import net.musecom.community.dto.BoardCategory;
import net.musecom.community.dto.BoardDto;
import net.musecom.community.dto.FileDto;
import net.musecom.community.dto.Users;
import net.musecom.community.mapper.UsersMapper;
import net.musecom.community.service.BoardAdminService;
import net.musecom.community.service.BoardService;
import net.musecom.community.service.FileService;

@Controller
@RequestMapping("/board")
public class CommunityController {
   
	@Autowired
	private UsersMapper userMapper;
	
	@Autowired
	private BoardAdminService baService;
	
	@Autowired
	private FileService fileService;
	
	@Autowired
	private BoardService bService;
	
	
	@GetMapping("")
	public String boardList(
			@RequestParam(value="bid", defaultValue = "1") int bid, 
			@RequestParam(value="page", defaultValue="1") int page,
			@RequestParam(value="size", defaultValue="10") int size,
			@RequestParam(value="option", required=false) String option,
			@RequestParam(value="search", required=false) String search,
			Model model, 
			HttpServletRequest request) {
		
	
		//쓰레기 파일 삭제를 위한 경로 셋팅
		String uploadPath = request.getSession().getServletContext().getRealPath("/res/upload/"+bid);
        fileService.trashFile(uploadPath);
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        System.out.println("로그인 정보 : " + auth.getName());
        
        if(auth != null) {
        	Users user = userMapper.getUserForUserid(auth.getName());
        	model.addAttribute("user", user);
        }

		BoardAdminDto adto = baService.getSelectById(bid);
	    PageInfo<BoardDto> pageInfoDtos = bService.getAllList(bid, page, size, option, search);

	    // 각 게시글에 대표 이미지 셋팅
	    List<BoardDto> list = pageInfoDtos.getList();
	    for(BoardDto dto : list) {
	    	FileDto thumb = fileService.selectFirstImageByBid(dto.getId());
	    	if(thumb != null) {
	    		dto.setThumbImage(thumb.getNfilename());
	    	}
	    }
	     
		String skin = adto.getSkin();
		
		String skinPath = "/WEB-INF/views/board/"+skin+"/list.jsp";
		
		//redirect로 보낸 메시지 받기
		String message = (String) model.asMap().get("message");
		model.addAttribute("message", message);
		
		
        List<BoardAdminDto> baList = baService.getAllList();
       // System.out.println(baList.toString());
        model.addAttribute("baLists", baList);
		
		model.addAttribute("skinPath", skinPath );
		model.addAttribute("badmin", adto);   
		model.addAttribute("pageInfo", pageInfoDtos );

		return "board.list";
	}
	
	@GetMapping("/view")
	public String boardView(@RequestParam("id") long id, Model model) {
		
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        System.out.println("로그인 정보 : " + auth.getName());
        
        if(auth != null) {
        	Users user = userMapper.getUserForUserid(auth.getName());
        	model.addAttribute("user", user);
        }
		
        BoardDto dto = bService.getBoardById(id);
        BoardAdminDto adto = baService.getSelectById(dto.getBbsid());
		String skinPath = "/WEB-INF/views/board/"+adto.getSkin()+"/view.jsp";
		model.addAttribute("skinPath", skinPath );
		
        model.addAttribute("badmin", adto);
        model.addAttribute("bbs", dto);		
		
		return "board.list";
	}
	
	@PostMapping("/checkPass")
	@ResponseBody
	public String checkPassword(
			@RequestParam("id") int id, 
			@RequestParam("password") String password) {
		BoardDto bDto = bService.getBoardByPass(id, password);
		if(bDto == null) {
			return "failure";
		}else {
		    return "success";
		}    
	}
	
	@GetMapping("/write")
	public String boardWriteForm(@RequestParam("bid") int bbsid, Model model) {
		
		 Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        
	     if(auth != null) {
	        Users user = userMapper.getUserForUserid(auth.getName());
	        model.addAttribute("user", user);
	     }
	    List<BoardAdminDto> baList = baService.getAllList(); 
		BoardAdminDto adto = baService.getSelectById(bbsid);
		String skinPath = "/WEB-INF/views/board/"+adto.getSkin()+"/write.jsp";
		
		//카테고리가 사용가능 이면 카테고리를 검증
		List<BoardCategory> categories = new ArrayList<>();
		
		if(adto.getCategory() == 1) {
			categories = baService.getAllCategory(bbsid);
		}
		model.addAttribute("categories", categories);
		
		model.addAttribute("skinPath", skinPath );
		model.addAttribute("baLists", baList);
		model.addAttribute("badmin", adto);
		
		return "board.list";
	}
	
	@PostMapping("/write")
	public String writeAction(
		   @RequestParam("bbsid") int bbsid,	
		   @RequestParam("writer") String writer,
		   @RequestParam("userid") String userid,
		   @RequestParam(value="password", required=false) String password,
		   @RequestParam("title") String title,
		   @RequestParam("content") String content,
		   @RequestParam(value="sec", defaultValue="0") byte sec,
		   @RequestParam(value="category", required=false) String category,
		   @RequestParam("tempBid") long tempBid,
		   @RequestParam(value="ref", defaultValue="0") long ref,
		   @RequestParam(value="step", defaultValue="0") int step,
		   @RequestParam(value="depth", defaultValue="0") int depth,
	       RedirectAttributes redirectAttributes) {
		
		   BoardDto dto = new BoardDto();
		   dto.setBbsid(bbsid);
		   dto.setWriter(writer);
		   dto.setUserid(userid);
		   dto.setPassword(password);
		   dto.setTitle(title);
		   dto.setContent(content);
		   dto.setSec(sec);
		   dto.setCategory(category);
		
		   if(ref == 0) {
			   //원글 - ref 업데이트
			   dto.setRef(0);
			   dto.setStep(0);
			   dto.setDepth(0);
		   }else {
			   //답변글 - 기존 답글중 step이 같거나 큰 글들을 하나씩 뒤로 밀어내기
			   bService.updateStep(ref, step + 1);
			   dto.setRef(ref);
			   dto.setStep(step + 1);
			   dto.setDepth(depth + 1);
		   }
		
		   int res = bService.insertBoard(dto);
		   //원글이면 ref 값을 id로 업데이트
		   long bid = dto.getId();
		   
		   if(res == 1 && ref == 0) {
		      bService.updateRef(bid);
		   }
		   
		   List<FileDto> files = fileService.selectFileList(tempBid);
		   for(FileDto f : files) {
			   f.setBid(bid);
			   fileService.updateFile(bid, tempBid);
		   }
		   
		   if(res == 1) {
			   redirectAttributes.addFlashAttribute("message", "등록되었습니다.");
		   }else {
			   redirectAttributes.addFlashAttribute("message", "문제가 발생해서 등록에 실패했습니다.");
		   }
		
		return "redirect:/board?bid="+bbsid;
	}
	
	@GetMapping("/edit")
	public String editForm(
			@RequestParam("id") long id, 
			@RequestParam("bid") int bid, 
			@RequestParam("mode") String mode,
            @RequestParam(value="password", required=false) String password,
			Model model) {
		
	    BoardDto dto = bService.getBoardById(id); 
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	        
	    List<BoardAdminDto> baList = baService.getAllList(); 
		BoardAdminDto adto = baService.getSelectById(bid);
		//1. 로그인한 상태의 자신글 , 2.관리자
		String skinPath = "/WEB-INF/views/board/"+adto.getSkin()+"/pass.jsp";	   
		
		if(auth != null) {
	        Users user = userMapper.getUserForUserid(auth.getName());
	        System.out.println(auth.getName());
	        model.addAttribute("user", user); 
	      
	        if(!"anonymousUser".equals(auth.getName())){
	            if(user.getRole().equals("ADMIN") || user.getUserid().equals(dto.getUserid())) {
	            	skinPath = "/WEB-INF/views/board/"+adto.getSkin()+"/edit.jsp";	  
	            }
	        }	
	     }
	   		
		if(password != null && !password.trim().isEmpty()) { //비밀번호를 썼을 때
		   BoardDto rs = bService.getBoardByPass(id, password);	//보드에서 비밀번호 검증
		   if(rs != null && !password.trim().isEmpty()) { //비밀번호가 맞으면
			   skinPath = "/WEB-INF/views/board/"+adto.getSkin()+"/edit.jsp";	  
		   }else { //틀리면 경고
			   System.out.println("비밀번호 틀림");
			   model.addAttribute("message", "비밀번호가 틀렸습니다.");
	       }
		}
		
		//카테고리가 사용가능 이면 카테고리를 검증
		List<BoardCategory> categories = new ArrayList<>();
		
		if(adto.getCategory() == 1) {
			categories = baService.getAllCategory(bid);
		}
		model.addAttribute("categories", categories);
		
		model.addAttribute("skinPath", skinPath );
		model.addAttribute("baLists", baList);
		model.addAttribute("badmin", adto);
		model.addAttribute("bbs", dto);
				
		return "board.list";
	}
	
	@PostMapping("/edit")
	public String editAction(
			   @RequestParam("id") long id,
			   @RequestParam("writer") String writer,
			   @RequestParam(value="password", required=false) String password,
			   @RequestParam("title") String title,
			   @RequestParam("content") String content,
			   @RequestParam(value="sec", defaultValue="0") byte sec,
			   @RequestParam("category") String category,
			   @RequestParam("tempBid") long tempBid,
		       RedirectAttributes redirectAttributes		
	) {
		
		System.out.println("아이디 : " + id);
		
		BoardDto dto = bService.getBoardById(id);
		dto.setId(id);
		dto.setWriter(writer);
		dto.setPassword(password);
		dto.setTitle(title);
		dto.setContent(content);
		dto.setSec(sec);
		dto.setCategory(category);
		
		int res = bService.updateBoard(dto);
		
		List<FileDto> files = fileService.selectFileList(tempBid);
		for(FileDto f : files) {
		    f.setBid(id);
			fileService.updateFile(id, tempBid);
		}
		   
		if(res == 1) {
			redirectAttributes.addFlashAttribute("message", "수정했습니다.");
		}else {
		    redirectAttributes.addFlashAttribute("message", "문제가 발생해서 등록에 실패했습니다.");
		}
		
		return "redirect:/board/view?id="+id;
	}
	
	@GetMapping("/del")
	public String delForm(
		@RequestParam("id") long id, 
		@RequestParam("bid") int bid, 
		@RequestParam("mode") String mode,
		@RequestParam(value="password", required=false) String password,
		Model model) {
    
    boolean delcode = false;
    BoardDto dto = bService.getBoardById(id); 
	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        
    //List<BoardAdminDto> baList = baService.getAllList(); 
	BoardAdminDto adto = baService.getSelectById(bid);

	//1. 로그인한 상태의 자신글 , 2.관리자
	String skinPath = "/WEB-INF/views/board/"+adto.getSkin()+"/pass.jsp";	   
	
	if(auth != null) {
        Users user = userMapper.getUserForUserid(auth.getName());
        System.out.println(auth.getName());
        model.addAttribute("user", user); 
        if(!"anonymousUser".equals(auth.getName())){
            if(user.getRole().equals("ADMIN") || user.getUserid().equals(dto.getUserid())) {
            	delcode = true;
            	model.addAttribute("delcode", delcode);
            }else {
            	model.addAttribute("비밀번호가 틀렸습니다.");
            }
        }	
     }
	
	model.addAttribute("skinPath", skinPath );
	model.addAttribute("id", id);
	model.addAttribute("bid", bid);
	model.addAttribute("mode", mode);
			
	return "board.list";
	}
	
	@PostMapping("delok")
	public String deleteOk(
		 @RequestParam("id") long id, 
		 @RequestParam("bid") int bid, 
		 @RequestParam("mode") String mode,
		 @RequestParam(value="password", required=false) String password,
		 Model model,	
		 RedirectAttributes redirectAttributes
    ) {
		BoardDto dto = bService.getBoardById(id);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Users user = userMapper.getUserForUserid(auth.getName());
		boolean canDelete = false;
		
		if(user != null && ("ADMIN".equals(user.getRole()) || 
		   user.getUserid().equals(dto.getUserid()))) {
		
		  canDelete = true;	
			
		}else if(password != null && !password.trim().isEmpty()) {
		  BoardDto chk = bService.getBoardByPass(id, password);
		  if(chk != null) canDelete = true;
		}
		
		if(!canDelete) {
			redirectAttributes.addFlashAttribute("message", "비밀번호가 틀렸거나 삭제 권한이 없습니다.");
			return "redirect:/board/view?id="+id;
		}
				
		//다 통과되었으면 삭제
		//1.파일삭제  2.보드삭제
		fileService.deleteFileByBid(id);  
		int res = bService.deleteBoard(id);
		
		if(res == 1) {
			redirectAttributes.addFlashAttribute("message", "삭제되었습니다.");
		}else {
			redirectAttributes.addFlashAttribute("message", "삭제하는데 문제가 발생했습니다.");
		}
		
		return "redirect:/board?bid="+bid;
	}
}
