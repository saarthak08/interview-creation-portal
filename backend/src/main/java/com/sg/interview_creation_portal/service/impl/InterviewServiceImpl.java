package com.sg.interview_creation_portal.service.impl;

import com.sg.interview_creation_portal.config.DateTimeFormat;
import com.sg.interview_creation_portal.data.builder.InterviewBuilder;
import com.sg.interview_creation_portal.data.dto.InterviewDTO;
import com.sg.interview_creation_portal.data.entity.Interview;
import com.sg.interview_creation_portal.data.entity.Interviewee;
import com.sg.interview_creation_portal.data.entity.Interviewer;
import com.sg.interview_creation_portal.exception.model.ExceptionType;
import com.sg.interview_creation_portal.exception.model.GenericException;
import com.sg.interview_creation_portal.repository.InterviewRepository;
import com.sg.interview_creation_portal.repository.IntervieweeRepository;
import com.sg.interview_creation_portal.service.FileStorageService;
import com.sg.interview_creation_portal.service.InterviewService;
import com.sg.interview_creation_portal.service.IntervieweeService;
import com.sg.interview_creation_portal.service.InterviewerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class InterviewServiceImpl implements InterviewService {

    private final InterviewerService interviewerService;
    private final IntervieweeService intervieweeService;
    private final FileStorageService fileStorageService;
    private final IntervieweeRepository intervieweeRepository;
    private final InterviewRepository interviewRepository;

    @Autowired
    public InterviewServiceImpl(InterviewerService interviewerService, IntervieweeService intervieweeService, FileStorageService fileStorageService, IntervieweeRepository intervieweeRepository, InterviewRepository interviewRepository) {
        this.interviewerService = interviewerService;
        this.intervieweeService = intervieweeService;
        this.fileStorageService = fileStorageService;
        this.intervieweeRepository = intervieweeRepository;
        this.interviewRepository = interviewRepository;
    }

    @Override
    public void scheduleInterview(InterviewDTO interviewDTO) throws GenericException {
        Interviewee interviewee = intervieweeService.getInterviewee(interviewDTO.getIntervieweeId());
        Interviewer interviewer = interviewerService.getInterviewer(interviewDTO.getInterviewerId());
        SimpleDateFormat dateFormat = new SimpleDateFormat(DateTimeFormat.dateFormat);
        Date startDate = new Date(interviewDTO.getEndTiming());
        String startDateString = dateFormat.format(startDate);
        List<Interview> interviews = interviewRepository.findByDateAndInterviewer(startDateString, interviewer);
        if (interviews == null || interviews.isEmpty()) {
            Interview interview = InterviewBuilder.anInterview()
                    .setDate(startDateString)
                    .setStartTiming(interviewDTO.getStartTiming())
                    .setEndTiming(interviewDTO.getEndTiming())
                    .setInterviewee(interviewee)
                    .setInterviewer(interviewer)
                    .setId(interviewDTO.getId())
                    .build();
            interviewRepository.save(interview);
        } else {
            if (checkInterviewAvailability(interviews, interviewDTO.getStartTiming(), interviewDTO.getEndTiming())) {
                Interview interview = InterviewBuilder.anInterview()
                        .setDate(startDateString)
                        .setStartTiming(interviewDTO.getStartTiming())
                        .setEndTiming(interviewDTO.getEndTiming())
                        .setInterviewee(interviewee)
                        .setInterviewer(interviewer)
                        .setId(interviewDTO.getId())
                        .build();
                interviewRepository.save(interview);
            } else {
                throw new GenericException("Interview can't be booked because interviewer slot is full for given timing", ExceptionType.ALREADY_PRESENT);
            }
        }
    }

    @Override
    public boolean checkAvailability(InterviewDTO interviewDTO) throws GenericException {
        Interviewee interviewee = intervieweeService.getInterviewee(interviewDTO.getIntervieweeId());
        Interviewer interviewer = interviewerService.getInterviewer(interviewDTO.getInterviewerId());
        SimpleDateFormat dateFormat = new SimpleDateFormat(DateTimeFormat.dateFormat);
        Date startDate = new Date(interviewDTO.getEndTiming());
        String startDateString = dateFormat.format(startDate);
        List<Interview> interviews = interviewRepository.findByDateAndInterviewer(startDateString, interviewer);
        if (interviews == null || interviews.isEmpty()) {
            return true;
        } else {
            return checkInterviewAvailability(interviews, interviewDTO.getStartTiming(), interviewDTO.getEndTiming());
        }
    }


    private boolean checkInterviewAvailability(List<Interview> interviews, Long startTiming, Long endTiming) {
        SimpleDateFormat timeFormat = new SimpleDateFormat(DateTimeFormat.timeFormat);
        Date startTime = new Date(startTiming);
        String interviewStartTimeString = timeFormat.format(startTime);

        Date endTime = new Date(endTiming);
        String interviewEndTimeString = timeFormat.format(endTime);
        System.out.println(interviewStartTimeString);
        System.out.println(interviewEndTimeString);
        for (Interview interview : interviews) {
            startTime = new Date(interview.getStartTiming());
            String startTimeString = timeFormat.format(startTime);
            endTime = new Date(interview.getEndTiming());
            String endTimeString = timeFormat.format(endTime);
            System.out.println(startTimeString);
            System.out.println(endTimeString);
            final int hourDifference = Integer.parseInt(endTimeString.substring(0, 2)) - Integer.parseInt(interviewStartTimeString.substring(0, 2));
            if ((hourDifference == 1)) {
                return false;
            }
            if ((hourDifference == 2)
                    && (Integer.parseInt(endTimeString.substring(3)) - Integer.parseInt(startTimeString.substring(3))) != 0) {
                return false;
            }
        }
        return true;
    }

    @Override
    public void modifyInterview(InterviewDTO interviewDTO) throws GenericException {
        if (interviewDTO.getId() != null) {
            Interview oldInterview = getInterview(interviewDTO.getId());
            scheduleInterview(interviewDTO);
        } else {
            throw new GenericException("id is required for modification", ExceptionType.BAD_REQUEST);
        }
    }

    @Override
    public Interview getInterview(Long id) throws GenericException {
        Optional<Interview> interview = interviewRepository.findById(id);
        if (interview.isEmpty()) {
            throw new GenericException("Interview not found", ExceptionType.NOT_FOUND_EXCEPTION);
        }
        return interview.get();
    }

    @Override
    public List<Interview> getAllInterviews() {
        return interviewRepository.findAll();
    }
}
