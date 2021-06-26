package com.sg.interview_creation_portal.service.impl;

import com.sg.interview_creation_portal.data.entity.Interviewee;
import com.sg.interview_creation_portal.exception.model.ExceptionType;
import com.sg.interview_creation_portal.exception.model.GenericException;
import com.sg.interview_creation_portal.repository.IntervieweeRepository;
import com.sg.interview_creation_portal.service.IntervieweeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class IntervieweeServiceImpl implements IntervieweeService {

    private final IntervieweeRepository intervieweeRepository;

    @Autowired
    public IntervieweeServiceImpl(IntervieweeRepository intervieweeRepository) {
        this.intervieweeRepository = intervieweeRepository;
    }

    @Override
    public List<Interviewee> getAllInterviewees() {
        return intervieweeRepository.findAll();
    }

    @Override
    public Interviewee getInterviewee(Long id) throws GenericException {
        Optional<Interviewee> interviewee = intervieweeRepository.findById(id);
        if (interviewee.isEmpty()) {
            throw new GenericException("Interviewee Not Found!", ExceptionType.NOT_FOUND_EXCEPTION);
        }
        return interviewee.get();
    }

    @Override
    public void save(Interviewee interviewee) {
        intervieweeRepository.save(interviewee);
    }
}

