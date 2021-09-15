package com.allured.yourRecipe.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.allured.yourRecipe.user.bo.UserBO;
import com.allured.yourRecipe.user.model.User;

@RestController
@RequestMapping("/user")
public class UserRestController {
	@Autowired
	private UserBO userBO;
	
	@PostMapping("/sign_up")
	public Map<String, String> signUp(@RequestParam("loginId") String loginId
			, @RequestParam("password") String password
			, @RequestParam("nickname") String nickname
			, @RequestParam("email") String email) {
		
		int userCount = userBO.addUser(loginId, password, nickname, email);
		
		Map<String, String> result = new HashMap<>();
		
		if(userCount == 1) {
			result.put("result", "success");
		}
		else {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	@PostMapping("/sign_in")
	public Map<String, String> SignIn(@RequestParam("loginId") String loginId
			, @RequestParam("password") String password
			, HttpServletRequest request) {
		
		User user = userBO.loginUser(loginId, password);
		
		Map<String, String> result = new HashMap<>();
		
		if(user != null) {
			HttpSession hs = request.getSession();
			hs.setAttribute("userId", user.getId());
			hs.setAttribute("userNickname", user.getNickname());
			hs.setAttribute("userprofileImg", user.getProfileImgUrl());
			
			result.put("result", "success");
		}
		else {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	@GetMapping("/id_duplicate_check")
	public Map<String, Boolean> idDuplicateCheck(@RequestParam("loginId") String loginId) {
		
		Map<String, Boolean> result = new HashMap<>();
		
		if(userBO.idDuplicateCheck(loginId) == true) {
			result.put("result", true);
		}
		else {
			result.put("result", false);
		}
		
		return result;
	}
	
	@GetMapping("/nickname_duplicate_check")
	public Map<String, Boolean> nicknameDuplicateCheck(@RequestParam("nickname") String nickname) {

		Map<String, Boolean> result = new HashMap<>();
		
		if(userBO.nicknameDuplicateCheck(nickname) == true) {
			result.put("result", true);
		}
		else {
			result.put("result", false);
		}
		
		return result;
	}
}