package com.sg.interview_creation_portal.service;

import com.sg.interview_creation_portal.data.dto.InterviewDTO;
import com.sg.interview_creation_portal.data.entity.Interview;
import com.sg.interview_creation_portal.exception.model.GenericException;
import lombok.SneakyThrows;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface InterviewService {
    void scheduleInterview(InterviewDTO interviewDTO) throws GenericException;

    @SneakyThrows
    boolean checkAvailability(InterviewDTO interviewDTO) throws GenericException;

    void modifyInterview(InterviewDTO interviewDTO) throws GenericException;

    Interview getInterview(Long id) throws GenericException;

    List<Interview> getAllInterviews();
}
