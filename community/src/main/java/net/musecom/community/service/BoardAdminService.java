package net.musecom.community.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.musecom.community.dto.BoardAdminDto;
import net.musecom.community.dto.BoardCategory;
import net.musecom.community.mapper.BoardAdminMapper;
import net.musecom.community.mapper.BoardCategoryMapper;

@Service
public class BoardAdminService {

	@Autowired
	private BoardAdminMapper baMapper;
	
	@Autowired
	private BoardCategoryMapper bcMapper;
	
	public int insertBoardAdmin(String btitle) {
		return baMapper.setBoardAdmin(btitle);
	}
	
	public int editBoardAdmin(BoardAdminDto bAdmin) {
		return baMapper.updateBoardAdmin(bAdmin);
	}
	
	public int delBoardAdmin(int id) {
		return baMapper.deleteBoardAdmin(id);
	}
	
	public BoardAdminDto getSelectById(int id) {
		return baMapper.getBoardAdmin(id);
	}
	
	public List<BoardAdminDto> getAllList(){
		List<BoardAdminDto> list = baMapper.allList();
		for(BoardAdminDto dto : list) {
			List<BoardCategory> categories = baMapper.allCategoryByBoardId(dto.getId());
		    dto.setBoardCategory(categories);
		}
		return list;
	}
	
	public List<BoardCategory> getAllCategory(int id){
		return baMapper.allCategoryByBoardId(id);
	}
	
	public int boardCategoryDelete(int categoryId) {
		return bcMapper.deleteCategory(categoryId);
	}
	
	public int boardCategoryUpdate(BoardCategory category) {
		return bcMapper.updateCategory(category);
	}
	
	public BoardCategory boardCategoryInsert(BoardCategory category) {
		 bcMapper.saveCategory(category);
		 return bcMapper.selectBoardCategoryById(category.getId());
	}
	
}
