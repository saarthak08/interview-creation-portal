package com.sg.interview_creation_portal.service.impl;

import com.sg.interview_creation_portal.data.entity.Interviewer;
import com.sg.interview_creation_portal.exception.model.ExceptionType;
import com.sg.interview_creation_portal.exception.model.GenericException;
import com.sg.interview_creation_portal.repository.InterviewerRepository;
import com.sg.interview_creation_portal.service.InterviewerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class InterviewerServiceImpl implements InterviewerService {

    private final InterviewerRepository interviewerRepository;

    @Autowired
    public InterviewerServiceImpl(InterviewerRepository interviewerRepository) {
        this.interviewerRepository = interviewerRepository;
    }

    @Override
    public List<Interviewer> getAllInterviewers() {
        return interviewerRepository.findAll();
    }

    @Override
    public Interviewer getInterviewer(Long id) throws GenericException {
        Optional<Interviewer> interviewer = interviewerRepository.findById(id);
        if (interviewer.isEmpty()) {
            throw new GenericException("Interviewer Not Found!", ExceptionType.NOT_FOUND_EXCEPTION);
        }
        return interviewer.get();
    }
}
