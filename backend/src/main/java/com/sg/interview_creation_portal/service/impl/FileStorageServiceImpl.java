package com.sg.interview_creation_portal.service.impl;

import com.sg.interview_creation_portal.config.FileStorageProperties;
import com.sg.interview_creation_portal.data.dto.UploadFileResponseDTO;
import com.sg.interview_creation_portal.data.entity.Interviewee;
import com.sg.interview_creation_portal.exception.model.ExceptionType;
import com.sg.interview_creation_portal.exception.model.GenericException;
import com.sg.interview_creation_portal.service.FileStorageService;
import com.sg.interview_creation_portal.service.IntervieweeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@Service
public class FileStorageServiceImpl implements FileStorageService {

    private final Path fileStorageLocation;
    private final IntervieweeService intervieweeService;

    @Autowired
    public FileStorageServiceImpl(FileStorageProperties fileStorageProperties, IntervieweeService intervieweeService) throws GenericException {
        this.fileStorageLocation = Paths.get(fileStorageProperties.getUploadDir())
                .toAbsolutePath().normalize();
        this.intervieweeService = intervieweeService;

        try {
            Files.createDirectories(this.fileStorageLocation);
        } catch (Exception ex) {
            throw new GenericException("Could not create the directory where the uploaded files will be stored.", ExceptionType.FILE_STORAGE_EXCEPTION);
        }
    }

    @Override
    public UploadFileResponseDTO storeFile(MultipartFile file, Long id) throws GenericException {
        Interviewee interviewee = intervieweeService.getInterviewee(id);
        String fileName = StringUtils.cleanPath(file.getOriginalFilename());

        try {
            if (fileName.contains("..")) {
                throw new GenericException("Sorry! Filename contains invalid path sequence " + fileName, ExceptionType.FILE_STORAGE_EXCEPTION);
            }
            Path targetLocation = this.fileStorageLocation.resolve(fileName);
            Files.copy(file.getInputStream(), targetLocation, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException | GenericException ex) {
            throw new GenericException("Could not store file " + fileName + ". Please try again!", ExceptionType.FILE_STORAGE_EXCEPTION);
        }

        String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/api/v1/file/download/")
                .path(fileName)
                .toUriString();
        interviewee.setResumeURL(fileDownloadUri);
        intervieweeService.save(interviewee);
        return new UploadFileResponseDTO(fileName, fileDownloadUri,
                file.getContentType(), file.getSize());
    }

    @Override
    public Resource loadFileAsResource(String fileName) throws GenericException {
        try {
            Path filePath = this.fileStorageLocation.resolve(fileName).normalize();
            Resource resource = new UrlResource(filePath.toUri());
            if (resource.exists()) {
                return resource;
            } else {
                throw new GenericException("File not found " + fileName, ExceptionType.FILE_NOT_FOUND_EXCEPTION);
            }
        } catch (MalformedURLException | GenericException ex) {
            throw new GenericException("File not found " + fileName + ex.getMessage(), ExceptionType.FILE_NOT_FOUND_EXCEPTION);
        }
    }

}
