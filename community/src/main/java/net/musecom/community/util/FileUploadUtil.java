package net.musecom.community.util;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import net.musecom.community.dto.FileDto;

@Component
public class FileUploadUtil implements UploadUtil {

	@Override
	public List<FileDto> uploadFiles(
			List<MultipartFile> files, 
			String uploadPath, 
			int fileTypeCondition,
			long fileSizeLimit, 
			long totalFileSizeLimit,
			long addFileSize) throws Exception {

            List<FileDto> resultList = new ArrayList<>();
            long totalSize = 0;
            
            for(MultipartFile file: files) {
            	if(file.isEmpty()) continue;
            	
            	//1. 확장자체크
            	String ext =FilenameUtils.getExtension(file.getOriginalFilename()).toLowerCase();
            	if(fileTypeCondition == 0 && !isImage(ext)) {
            		throw new IllegalArgumentException("이미지만 업로드 가능합니다.");
            	}
            	            	
            	//2. 개별 사이즈 체크
            	long fileSize = file.getSize();
            	if(fileSize > fileSizeLimit) {
            		throw new IllegalArgumentException("파일 용량 제한을 초과했습니다.");
            	}
            	
            	//3. 토탈 사이즈 체크
            	fileSize += fileSize;
            	totalSize = addFileSize + fileSize; 
            	if(totalSize > totalFileSizeLimit) {
            	   throw new IllegalArgumentException("전체 업로드 용량을 초과했습니다. 더이상 업로드 할 수 없어요.");
            	}
            	
            	//4. 이름 변환
            	String uuid = UUID.randomUUID().toString();
            	String nFilename = uuid + "." + ext;
            	
            	//5. 업로드
            	File targetDir =new File(uploadPath);
            	if(!targetDir.exists()) targetDir.mkdirs();
            	
            	File destination = new File(targetDir, nFilename);
            	file.transferTo(destination);
            	
            	FileDto fdto = new FileDto();
            	fdto.setOfilename(file.getOriginalFilename());
            	fdto.setNfilename(nFilename);
            	fdto.setExt(ext);
            	fdto.setFilesize(fileSize);
            	fdto.setAddFileSize(addFileSize);
 
            	resultList.add(fdto);
            }        
		
		return resultList;
	}

	private boolean isImage(String ext) {
		return Arrays.asList("jpg", "jpeg", "png", "gif", "webp", "svg", "bmp").contains(ext);
	}
	
}
