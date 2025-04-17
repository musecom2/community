package net.musecom.community.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import net.musecom.community.dto.BoardDto;
import net.musecom.community.mapper.BoardMapper;

@Service
public class BoardService {
  
	@Autowired
	private BoardMapper bMapper;
	
	public PageInfo<BoardDto> getAllList(int bbsid, int page, int size, String option, String search){
		PageHelper.startPage(page, size);
		List<BoardDto> list = null;

		if(search != null) {
		  list = bMapper.getSearchList(bbsid, option , search);	
		}else {
		  list = bMapper.allList(bbsid);
		}
		return new PageInfo<>(list);
	}
	
	public BoardDto getBoardById(long id) {
		return bMapper.getBoardById(id);
	}
	
	public int insertBoard(BoardDto dto) {
		return bMapper.setBoard(dto);
	}
	
	public int updateBoard(BoardDto dto) {
		return bMapper.setUpdateBoard(dto);
	}
	
	public int deleteBoard(long id) {
		return bMapper.setDeleteBoard(id);
	}
	
	public BoardDto getBoardByPass(long id, String password) {
		Map<String, Object> params = new HashMap<>();
		params.put("id", id);
		params.put("password", password);
		return bMapper.getBoardByPassword(params);
	}
	
	public void updateRef(long id) {
		bMapper.updateRef(id);
	}
	
	public void updateStep(long ref, int step) {
		Map<String, Object> map = new HashMap<>();
		map.put("ref", ref);
		map.put("step", step);
		bMapper.updateStep(map);
	}
}
