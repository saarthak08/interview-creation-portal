package com.sg.interview_creation_portal.data.builder;

import com.sg.interview_creation_portal.data.entity.Interviewer;

public final class InterviewerBuilder {
    private Long id;
    private String name;
    private String email;
    private String employeeCode;

    private InterviewerBuilder() {
    }

    public static InterviewerBuilder anInterviewer() {
        return new InterviewerBuilder();
    }

    public InterviewerBuilder setId(Long id) {
        this.id = id;
        return this;
    }

    public InterviewerBuilder setName(String name) {
        this.name = name;
        return this;
    }

    public InterviewerBuilder setEmail(String email) {
        this.email = email;
        return this;
    }

    public InterviewerBuilder setEmployeeCode(String employeeCode) {
        this.employeeCode = employeeCode;
        return this;
    }

    public Interviewer build() {
        Interviewer interviewer = new Interviewer();
        interviewer.setId(id);
        interviewer.setName(name);
        interviewer.setEmail(email);
        interviewer.setEmployeeCode(employeeCode);
        return interviewer;
    }
}
