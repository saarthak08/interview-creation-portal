package com.sg.interview_creation_portal.data.builder;

import com.sg.interview_creation_portal.data.entity.Interviewee;

public final class IntervieweeBuilder {
    private Long id;
    private String name;
    private String email;
    private String resumeURL;

    private IntervieweeBuilder() {
    }

    public static IntervieweeBuilder anInterviewee() {
        return new IntervieweeBuilder();
    }

    public IntervieweeBuilder setId(Long id) {
        this.id = id;
        return this;
    }

    public IntervieweeBuilder setName(String name) {
        this.name = name;
        return this;
    }

    public IntervieweeBuilder setEmail(String email) {
        this.email = email;
        return this;
    }

    public IntervieweeBuilder setResumeURL(String resumeURL) {
        this.resumeURL = resumeURL;
        return this;
    }

    public Interviewee build() {
        Interviewee interviewee = new Interviewee();
        interviewee.setId(id);
        interviewee.setName(name);
        interviewee.setEmail(email);
        interviewee.setResumeURL(resumeURL);
        return interviewee;
    }
}
