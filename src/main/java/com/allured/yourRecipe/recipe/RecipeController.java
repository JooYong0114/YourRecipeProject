package com.allured.yourRecipe.recipe;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/recipe")
public class RecipeController {

	@GetMapping("/main_view")
	public String mainView() {
		return "recipe/main";
	}
	
	@GetMapping("/write_view")
	public String recipeWriteView() {
		return "recipe/myRecipeWrite";
	}
 }
