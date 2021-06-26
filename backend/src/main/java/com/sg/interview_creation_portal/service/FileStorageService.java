package com.sg.interview_creation_portal.service;

import com.sg.interview_creation_portal.data.dto.UploadFileResponseDTO;
import com.sg.interview_creation_portal.exception.model.GenericException;
import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartFile;

public interface FileStorageService {
    UploadFileResponseDTO storeFile(MultipartFile file, Long id) throws GenericException;
    Resource loadFileAsResource(String fileName) throws GenericException;
}
