package com.sg.interview_creation_portal.data.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Interview {

    @Id
    @GeneratedValue
    private Long id;

    private Long Date;

    private String startTiming;

    private String endTiming;

    @ManyToOne
    @JoinColumn(name = "interviewee")
    private Interviewee interviewee;

    @ManyToOne
    @JoinColumn(name = "interviewer")
    private Interviewer interviewer;
}
