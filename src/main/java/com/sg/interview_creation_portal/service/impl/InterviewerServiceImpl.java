package com.sg.interview_creation_portal.service;

import com.sg.interview_creation_portal.entity.Interviewer;
import com.sg.interview_creation_portal.repository.InterviewerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class InterviewerService {

    private final InterviewerRepository interviewerRepository;

    @Autowired
    public InterviewerService(InterviewerRepository interviewerRepository) {
        this.interviewerRepository = interviewerRepository;
    }

    public List<Interviewer> getAllInterviewers() {
        return interviewerRepository.findAll();
    }

    public Interviewer getInterviewer(Long id) {
        Optional<Interviewer> interviewer = interviewerRepository.findById(id);
        if(interviewer==null) {
            throw new Exception("")
        }
    }
}
