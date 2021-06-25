package com.sg.interview_creation_portal.data.builder;

import com.sg.interview_creation_portal.data.entity.Interview;
import com.sg.interview_creation_portal.data.entity.Interviewee;
import com.sg.interview_creation_portal.data.entity.Interviewer;

public final class InterviewBuilder {
    private Long id;
    private Long Date;
    private String startTiming;
    private String endTiming;
    private Interviewee interviewee;
    private Interviewer interviewer;

    private InterviewBuilder() {
    }

    public static InterviewBuilder anInterview() {
        return new InterviewBuilder();
    }

    public InterviewBuilder setId(Long id) {
        this.id = id;
        return this;
    }

    public InterviewBuilder setDate(Long Date) {
        this.Date = Date;
        return this;
    }

    public InterviewBuilder setStartTiming(String startTiming) {
        this.startTiming = startTiming;
        return this;
    }

    public InterviewBuilder setEndTiming(String endTiming) {
        this.endTiming = endTiming;
        return this;
    }

    public InterviewBuilder setInterviewee(Interviewee interviewee) {
        this.interviewee = interviewee;
        return this;
    }

    public InterviewBuilder setInterviewer(Interviewer interviewer) {
        this.interviewer = interviewer;
        return this;
    }

    public Interview build() {
        Interview interview = new Interview();
        interview.setId(id);
        interview.setDate(Date);
        interview.setStartTiming(startTiming);
        interview.setEndTiming(endTiming);
        interview.setInterviewee(interviewee);
        interview.setInterviewer(interviewer);
        return interview;
    }
}
