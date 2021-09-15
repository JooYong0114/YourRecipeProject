package com.allured.yourRecipe.recipe.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface RecipeDAO {

	public int insertRecipe(@Param("userNickname") String userNickname
			, @Param("title") String title
			, @Param("imgUrl") String imgUrl
			, @Param("content") String content);
}