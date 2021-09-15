package com.allured.yourRecipe.recipe;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.allured.yourRecipe.recipe.bo.RecipeBO;

@RestController
@RequestMapping("/recipe")
public class RecipeRestController {

	@Autowired
	private RecipeBO recipeBO;
	
	@PostMapping("/write")
	public Map<String, String> recipeWrite(@RequestParam("title") String title
			, @RequestParam("file") MultipartFile file
			, @RequestParam("content") String content
			, HttpServletRequest request) {
		
		HttpSession hs = request.getSession();
		String userNickname = (String)hs.getAttribute("userNickname");
		
		int addCount = recipeBO.addRecipe(userNickname, title, file, content);
		
		Map<String, String> result = new HashMap<>();
		
		if(addCount == 1) {
			result.put("result", "success");
		}
		else {
			result.put("result", "fail");
		}
		return result;
	}
}