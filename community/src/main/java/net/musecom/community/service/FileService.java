package net.musecom.community.service;

import java.io.File;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.musecom.community.dto.FileDto;
import net.musecom.community.mapper.FileMapper;

@Service
public class FileService {
   
   @Autowired
   FileMapper fileMapper;
   
   public int insertFile(FileDto fileDto) {
	   return fileMapper.insertFile(fileDto);
   }
   
   public int updateFile(long bid, long tempId) {
	   return fileMapper.updateFileByBid(bid, tempId);
   }
   
   public int deleteFile(long id) {
	   return fileMapper.deleteFile(id);
   }
   
   public void trashFile(String filePath) {
	 
	   File baseDir = new File(filePath);
	   if(!baseDir.exists()) return;
	   
	   //오늘 0시를 기준으로 
	   long todayZero = LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();
	   
	   File[] files = baseDir.listFiles();  //폴더를 열어서 파일 이름을 가져옴 (배열)
	   if(files == null) return;
	   
	   //1. db도 없고 파일만 있는 경우 삭제
	   for(File file: files ) {  
		   //파일 이름을 하나씩 점검하면서 db 가없으면 isTrash true, db 가 오늘 00시 이전이면  isTrash true
		   //그 이외에는 isTrash false
		   //isTrash가 true이면 파일 삭제, dto가 있으면 db도 삭제
		   String fname = file.getName();
		   FileDto dto = fileMapper.fileByFileName(fname);
		   boolean isTrash = false;
		   if(dto == null) {
			   isTrash = true;
		   }else {
			   long bid = dto.getBid();
			   if(String.valueOf(bid).matches("\\d{12,14}")&&bid < todayZero) {
				   isTrash = true;
			   }
		   }
		   
		   if(isTrash) {
			   boolean del = file.delete();
			   System.out.println(del?"[삭제됨]":"[삭제실패]"+", "+ fname);
			   if(dto != null) {
				   fileMapper.deleteFile(dto.getId());
			   }
		   }
	   }
	   
   }
   
   public List<FileDto> selectFileList(long bid){
	  return fileMapper.selectFileByBid(bid);
   }
   
   public FileDto selectFileById(long id) {
	   return fileMapper.fileById(id);
   }
   
   public FileDto selectFileByFileName(String filename) {
	   return fileMapper.fileByFileName(filename);
   }
   
   
}
