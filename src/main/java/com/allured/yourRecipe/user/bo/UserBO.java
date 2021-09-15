package com.allured.yourRecipe.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.allured.yourRecipe.common.EncryptUtils;
import com.allured.yourRecipe.user.dao.UserDAO;
import com.allured.yourRecipe.user.model.User;

@Service
public class UserBO {
	@Autowired
	private UserDAO userDAO;
	
	public int addUser(String loginId, String password, String nickname, String email) {
		String encryptPassword = EncryptUtils.md5(password);
		return userDAO.insertUser(loginId, encryptPassword, nickname, email);
	}
	
	public User loginUser(String loginId, String password) {
		String encryptPassword = EncryptUtils.md5(password);
		return userDAO.selectUser(loginId, encryptPassword);
	}
	
	public boolean idDuplicateCheck(String loginId) {
		if(userDAO.selectUserById(loginId) == 0) {
			return false;
		}
		else {
			return true;
		}
	}
	
	public boolean nicknameDuplicateCheck(String nickname) {
		if(userDAO.selectUserByNickname(nickname) == 0) {
			return false;
		}
		else {
			return true;
		}
	}
}