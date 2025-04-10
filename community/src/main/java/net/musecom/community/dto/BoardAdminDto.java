package net.musecom.community.dto;

import java.util.List;

import lombok.Data;

@Data
public class BoardAdminDto {

	private int id;
	private String btitle;  //게시판 제목
	private String skin;  //게시판 모양-일반게시판, 갤러리, ...
	private byte category; //카테고리를 허용, 비허용
	private byte listcount; //목록의 크기 
	private byte pagecount;  //한 페이지에 보일 페이지 수
	private byte lgrade; //목록보기를 회원만, 일반허용
	private byte vgrade;  //게시물 보기를 허용, 회원제
	private byte rgrade; //게시물 쓰기를 ...
	private byte fgrade;  //파일업로드를 허용, 비허용
	private byte fdgrade;  //파일다운로드를 회원제, 비회원제
	private byte cgrade;  //댓글을 허용, 비허용
	private byte regrade;  //답글을 허용, 비허용
	private byte upload;   //파일 업로드 회원제, 비회원제
	private int filesize; //허용할 파일의 크기
	private int allfilesize; //허용할 총 파일크기
	private String thimgsize; //썸네일 크기 가로|세로 기본값은 150| 즉, 가로 150
	private byte filechar;  //0이면 이미지만업로드, 1이면 모든 업로드 허용	
	private byte sec;
	private List<BoardCategory> boardCategory;
	private int bbsCount; //게시판 갯수
}
