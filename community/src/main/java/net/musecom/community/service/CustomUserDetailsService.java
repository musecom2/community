package net.musecom.community.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import net.musecom.community.dto.Users;
import net.musecom.community.mapper.UsersMapper;

@Service
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private UsersMapper usersMapper;
		
	@Override
	public UserDetails loadUserByUsername(String userid) throws UsernameNotFoundException {
        
		System.out.println("회원이름 : " + userid);
		Users users = usersMapper.getUserForUserid(userid);	    
                
        if(users == null) {
        	throw new UsernameNotFoundException("회원정보가 없습니다.");
        }
        
        List<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority("ROLE_" + users.getRole()));
        
		return new User(users.getUserid(), users.getUserpass(), authorities);
	}

}
