package com.sg.interview_creation_portal.service;

import com.sg.interview_creation_portal.data.entity.Interviewer;
import com.sg.interview_creation_portal.exception.model.GenericException;

import java.util.List;

public interface InterviewerService {
    List<Interviewer> getAllInterviewers();

    Interviewer getInterviewer(Long id) throws GenericException;
}
