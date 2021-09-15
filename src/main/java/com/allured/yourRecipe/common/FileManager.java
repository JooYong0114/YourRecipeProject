package com.allured.yourRecipe.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

public class FileManager {

	private final String FILE_UPLOAD_PATH = "C:\\Users\\이주용\\Desktop\\recipeImageUpload\\images/";
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public String saveFile(String userNickname,
			MultipartFile file) {
		
		String directoryName = userNickname + "_" + System.currentTimeMillis() + "/";
		
		String filePath = FILE_UPLOAD_PATH + directoryName;
		
		File directory = new File(filePath);
		
		if(directory.mkdir() == false) {
			logger.error("[FileManger saveFile] 디렉토리 생성 실패");
			return null;
		}
		
		byte[] bytes;
		try {
			bytes = file.getBytes();
			Path path = Paths.get(filePath + file.getOriginalFilename());
			Files.write(path, bytes);
		} catch (IOException e) {
			logger.error("[FileManger saveFile] 파일 생성 실패");
			e.printStackTrace();
		}
		
		return "/images/" + directoryName + file.getOriginalFilename();
	}
	
	public void removeFile(String filePath) {
		String realFilePath = FILE_UPLOAD_PATH + filePath.replace("/images/", "");
		
		// 파일 지우기
		Path path = Paths.get(realFilePath);
		// 해당 파일이 있는지 확인
		if(Files.exists(path)) {
			try {
				Files.delete(path);
			} catch (IOException e) {
				logger.error("[FileManager saveFile] file delete fail");
				e.printStackTrace();
			}
		}
		// 디렉토리 지우기
		path = path.getParent();
		
		if(Files.exists(path)) {
			try {
				Files.delete(path);
			} catch (IOException e) {
				logger.error("[FileManager saveFile] directory delete fail");
				e.printStackTrace();
			}
		}
	}
}