package net.musecom.community.util;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import net.musecom.community.dto.FileDto;

public interface UploadUtil {
   List<FileDto> uploadFiles(
	  List<MultipartFile> files,
	  String uploadPath,
	  int fileTypeCondition, //0:이미지, 1:모든파일
	  long fileSizeLimit, //파일 하나의 용량 제한
	  long totalFileSizeLimit,  //총 파일의 용량 제한
	  long addFileSize  //현재까지 업로드된 용량을 더해서 보냄
   ) throws Exception;
}
