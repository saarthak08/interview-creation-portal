package com.sg.interview_creation_portal.service;

import com.sg.interview_creation_portal.data.entity.Interviewee;
import com.sg.interview_creation_portal.exception.model.GenericException;

import java.util.List;

public interface IntervieweeService {
    List<Interviewee> getAllInterviewees();

    Interviewee getInterviewee(Long id) throws GenericException;

    void save(Interviewee interviewee);
}
