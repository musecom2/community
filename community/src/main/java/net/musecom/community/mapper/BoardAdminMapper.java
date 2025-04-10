package net.musecom.community.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import net.musecom.community.dto.BoardAdminDto;
import net.musecom.community.dto.BoardCategory;

@Mapper
public interface BoardAdminMapper {
   
	int setBoardAdmin(String btitle);
	int updateBoardAdmin(BoardAdminDto dto);
	int deleteBoardAdmin(int id);
	BoardAdminDto getBoardAdmin(int id);
	List<BoardAdminDto> allList();
	List<BoardCategory> allCategoryByBoardId(int id);
	int updateBoardFileAdmin(BoardAdminDto dto);
}
