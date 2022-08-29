package com.ezenplate.www.handler;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.tika.Tika;
import org.joda.time.LocalDate;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.ezenplate.www.domain.FileVO;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

@Slf4j
@Component
public class FileHandler {
	private final String UP_DIR =  "/Users/olivia/Desktop/Cs/_java/git-work/Ezenplate/uploaded/";

	public List<FileVO> getFileList(MultipartFile[] files) {
		LocalDate date = LocalDate.now();
		String today = date.toString();
		today = today.replace("-", File.separator);
		File folder = new File(UP_DIR, today);
		if (!folder.exists()) {
			folder.mkdirs();
		}

		List<FileVO> fileList = new ArrayList<FileVO>();
		for (MultipartFile file : files) {
			FileVO fvo = new FileVO();
			fvo.setSaveDir(today);
			fvo.setFileSize(file.getSize());

			String originalFileName = file.getOriginalFilename();
			String onlyFileName = originalFileName.substring(originalFileName.lastIndexOf("/") + 1);
			fvo.setFileName(onlyFileName);

			UUID uuid = UUID.randomUUID();
			fvo.setUuid(uuid.toString());

			String FullFileName = uuid.toString() + "_" + onlyFileName;
			File storeFile = new File(folder, FullFileName);

			try {
				file.transferTo(storeFile);
				if (isImageFile(storeFile)) {
					fvo.setFileType(1);
					File thumbNail = new File(folder, uuid.toString() + "_th_" + onlyFileName);
					Thumbnails.of(storeFile).size(100, 100).toFile(thumbNail);
				}
			} catch (Exception e) {
				log.debug(">>> File 물리디스크 저장 실패");
				e.printStackTrace();
			}
			fileList.add(fvo);
		}
		return fileList;
	}

	private boolean isImageFile(File storeFile) throws IOException {
		String mimeType = new Tika().detect(storeFile);
		return mimeType.startsWith("image") ? true : false;
	}
}
