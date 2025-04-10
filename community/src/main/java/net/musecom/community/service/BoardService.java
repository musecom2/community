package net.musecom.community.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.musecom.community.dto.BoardDto;
import net.musecom.community.mapper.BoardMapper;

@Service
public class BoardService {
  
	@Autowired
	private BoardMapper bMapper;
	
	public List<BoardDto> getAllList(int bbsid){
		return bMapper.allList(bbsid);
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
	
	public BoardDto getBoardByPass(int id, String password) {
		Map<String, Object> params = new HashMap<>();
		params.put("id", id);
		params.put("password", password);
		return bMapper.getBoardByPassword(params);
	}
	
}
