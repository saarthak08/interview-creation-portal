package com.sg.interview_creation_portal.controller;

import com.sg.interview_creation_portal.exception.model.GenericException;
import com.sg.interview_creation_portal.service.InterviewerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/interviewer")
public class InterviewerController {

    private final InterviewerService interviewerService;

    @Autowired
    public InterviewerController(InterviewerService interviewerService) {
        this.interviewerService = interviewerService;
    }

    @GetMapping("/all")
    public ResponseEntity<?> getInterviewers() {
        return new ResponseEntity<>(interviewerService.getAllInterviewers(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getInterviewer(@PathVariable Long id) throws GenericException {
        return new ResponseEntity<>(interviewerService.getInterviewer(id), HttpStatus.OK);
    }
}
