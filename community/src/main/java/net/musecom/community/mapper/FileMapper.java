package net.musecom.community.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import net.musecom.community.dto.FileDto;

@Mapper
public interface FileMapper {

	int insertFile(FileDto file);
	int updateFileByBid(@Param("bid") long bid, @Param("tempId") long tempId);  //임시로 등록된 bid를 게시판 bid로 업데이트
	int deleteFile(long id);
	List<FileDto> selectFileByBid(long bid);

	FileDto fileById(long id);
	FileDto fileByFileName(String fname);
}
