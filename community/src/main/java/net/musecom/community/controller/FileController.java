package net.musecom.community.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import net.musecom.community.dto.BoardAdminDto;
import net.musecom.community.dto.FileDto;
import net.musecom.community.service.BoardAdminService;
import net.musecom.community.service.FileService;
import net.musecom.community.util.UploadUtil;

@Controller
@RequestMapping("/file")
public class FileController {

	@Autowired
	private UploadUtil uploadUtil;
	
	@Autowired
	private BoardAdminService baService;
	
	@Autowired
	private FileService fileService;
	
	@PostMapping("/upload")
	@ResponseBody
	public ResponseEntity<?> uploadFilesAjax(
	   @RequestParam("files") List<MultipartFile> files,
	   @RequestParam("tempBid") long bid,
	   @RequestParam("bbsid") int bbsid,
	   @RequestParam("addFileSize") long addFileSize,
	   HttpServletRequest request
	){
		//관리자 보드 검색
		BoardAdminDto adto = baService.getSelectById(bbsid);
				
		int fileTypeCondition = adto.getFilechar();
		long fileSizeLimit = adto.getFilesize();
		long totalFileSizeLimit = adto.getAllfilesize();
		
		String uploadPath = request.getSession().getServletContext().getRealPath("/res/upload/"+bbsid);
		System.out.println(uploadPath);
		
		try {
			List<FileDto> uploadFiles = uploadUtil.uploadFiles(
					files, 
					uploadPath, 
					fileTypeCondition, 
					fileSizeLimit, 
					totalFileSizeLimit, 
					addFileSize
			);
			
			for(FileDto dto : uploadFiles) {
				dto.setBid(bid);
				fileService.insertFile(dto);
			}
			
			System.out.println(uploadFiles);
			return ResponseEntity.ok(uploadFiles);
			
		}catch(Exception e) {
			e.printStackTrace();
			return ResponseEntity.badRequest().body(e.getMessage());
		}
		
	}
	
	@PostMapping("/delete")
	@ResponseBody
	public String deleteFile(
		@RequestParam("filename") String filename,
		@RequestParam("bbsid") int bbsid,
		HttpServletRequest request
		){
		try {
				String deletePath = request.getSession().getServletContext().getRealPath("/res/upload/"+bbsid);
				File file = new File(deletePath, filename);
				
				boolean fileDeleted = false;
				//db 에서 파일 정보 가져옴
				FileDto fdto = fileService.selectFileByFileName(filename);
				
				if(file.exists()) {
					fileDeleted = file.delete();
				}
				//db 삭제 완료
				if(fdto != null) {
					fileService.deleteFile(fdto.getId());
				}
				
				return fileDeleted? "1" : "0";
		}catch(Exception e) {
			return "0";
		}
	}
}
