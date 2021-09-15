package com.allured.yourRecipe.recipe.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.allured.yourRecipe.common.FileManager;
import com.allured.yourRecipe.recipe.dao.RecipeDAO;

@Service
public class RecipeBO {

	@Autowired
	private RecipeDAO recipeDAO;
	
	public int addRecipe(String userNickname, String title, MultipartFile imgUrl, String content) {
		FileManager fileManager = new FileManager();
		
		String filePath = fileManager.saveFile(userNickname, imgUrl);
		if(filePath == null) {
			return -1;
		}
		
		return recipeDAO.insertRecipe(userNickname, title, filePath, content);
	}
}