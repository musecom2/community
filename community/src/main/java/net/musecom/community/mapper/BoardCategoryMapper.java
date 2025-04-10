package net.musecom.community.mapper;

import org.apache.ibatis.annotations.Mapper;

import net.musecom.community.dto.BoardCategory;

@Mapper
public interface BoardCategoryMapper {
   int saveCategory(BoardCategory category);
   int deleteCategory(int id);
   int updateCategory(BoardCategory category);
   BoardCategory selectBoardCategoryById(int id);
}
