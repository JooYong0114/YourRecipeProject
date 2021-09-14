package com.allured.yourRecipe.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserController {

	@GetMapping("/signin_view")
	public String signin_view() {
		return "user/signin";
	}
	
	@GetMapping("/signup_view")
	public String signup_view() {
		return "user/signup";
	}
}