package com.sg.interview_creation_portal.controller;

import com.sg.interview_creation_portal.exception.model.GenericException;
import com.sg.interview_creation_portal.service.IntervieweeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/interviewee")
public class IntervieweeController {

    private final IntervieweeService intervieweeService;

    @Autowired
    public IntervieweeController(IntervieweeService intervieweeService) {
        this.intervieweeService = intervieweeService;
    }

    @GetMapping("/all")
    public ResponseEntity<?> getInterviewees() {
        return new ResponseEntity<>(intervieweeService.getAllInterviewees(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getInterviewee(@PathVariable Long id) throws GenericException {
        return new ResponseEntity<>(intervieweeService.getInterviewee(id), HttpStatus.OK);
    }
}
