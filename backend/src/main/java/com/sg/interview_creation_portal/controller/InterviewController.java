package com.sg.interview_creation_portal.controller;

import com.sg.interview_creation_portal.data.dto.InterviewDTO;
import com.sg.interview_creation_portal.exception.model.GenericException;
import com.sg.interview_creation_portal.service.InterviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/v1/interview")
public class InterviewController {

    private final InterviewService interviewService;

    @Autowired
    public InterviewController(InterviewService interviewService) {
        this.interviewService = interviewService;
    }

    @PostMapping("/")
    public ResponseEntity<?> addInterview(@RequestBody @Valid InterviewDTO interviewDTO) throws GenericException {
        interviewService.scheduleInterview(interviewDTO);
        return new ResponseEntity<>("Interview Added", HttpStatus.OK);
    }

    @GetMapping("/all")
    public ResponseEntity<?> getAllInterviews() {
        return new ResponseEntity<>(interviewService.getAllInterviews(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getInterview(@PathVariable Long id) throws GenericException {
        return new ResponseEntity<>(interviewService.getInterview(id), HttpStatus.OK);
    }

    @PutMapping("/")
    public ResponseEntity<?> modifyInterview(@RequestBody @Valid InterviewDTO interviewDTO) throws GenericException {
        interviewService.modifyInterview(interviewDTO);
        return new ResponseEntity<>("Interview Modified", HttpStatus.OK);
    }

    @PostMapping("/check")
    public ResponseEntity<?> checkInterviewAvailability(@RequestBody @Valid InterviewDTO interviewDTO) throws GenericException {
        return new ResponseEntity<>(interviewService.checkAvailability(interviewDTO), HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteInterview(@PathVariable Long id) throws GenericException {
        interviewService.deleteInterview(id);
        return new ResponseEntity<>("Interview Deleted",HttpStatus.OK);
    }
}
