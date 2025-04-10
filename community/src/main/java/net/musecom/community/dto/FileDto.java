package net.musecom.community.dto;

import lombok.Data;

@Data
public class FileDto {
   private long id;
   private long bid;  //게시판 번호
   private String ofilename;  //올릴때 파일이름
   private String nfilename;  //변경한 이름
   private String ext;  //파일의 확장자
   private long filesize; //파일의 크기
   private long addFileSize;
}
